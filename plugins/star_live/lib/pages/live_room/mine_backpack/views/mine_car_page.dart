import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_common/lottie/lottie_view.dart';
import 'package:svgaplayer_flutter/parser.dart';
import 'package:svgaplayer_flutter/player.dart';
import 'package:star_common/generated/car_list_entity.dart';
import '../mine_backpack_logic.dart';
import 'mine_car_buy.dart';

class MineCarPage extends StatelessWidget {
  MineCarPage({Key? key}) : super(key: key);

  final logic = Get.find<MineBackpackLogic>();
  final state = Get.find<MineBackpackLogic>().state;

  @override
  Widget build(BuildContext context) {
    state.carContext = context;
    return SafeArea(
      child: Stack(
        children: [
          Positioned.fill(child: _buildCarBody(context)),
          Positioned(child: _buildCarDisplay(), bottom: 0, left: 0, right: 0, top: 0),
        ],
      ),
    );
  }

  Widget _buildCarBody(BuildContext context) {
    return Obx(() {
      return SmartRefresher(
        enablePullDown: true,
        header: LottieHeader(),
        footer: LottieFooter(),
        onRefresh: () {
          logic.loadCarList(false);
        },
        controller: state.carRefreshController,
        child: ListView.builder(
          itemCount: state.carList.length,
          itemBuilder: (context, index) {
            final model = state.carList[index];
            return Container(
              padding: EdgeInsets.symmetric(horizontal: AppLayout.pageSpace),
              height: 88.dp,
              child: Row(
                children: [
                  _buildItemCar(model),
                  _buildItemCarContent(model),
                ],
              ),
            );
          },
        ),
      );
    });
  }

  Widget _buildItemCar(CarListEntity model) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ExtendedImage.network(model.carStaticUrl, height: 56.dp, width: 56.dp,),
        Container(
          width: 56.dp,
          height: 56.dp,
          decoration: BoxDecoration(
            color: AppMainColors.separaLineColor6,
            borderRadius: BorderRadius.circular(8.dp),
            border: Border.all(
              color: AppMainColors.separaLineColor10,
              width: 1.dp,
            ),
          ),
          child: Image.asset(R.previewButton).cupertinoButton(
            onTap: () => logic.play(model),
          ),
        ),
      ],
    );
  }

  Widget _buildItemCarContent(CarListEntity model) {
    String text = '';
    if (model.carBuyState == 1 || model.carBuyState == 2){
      text = "${model.validityPeriod}过期";
    }else{
      if (model.type == 1) {
        text = "原价: ${model.monthPrice} 钻/月";
      }else{
        text = "LV${model.freeLevelMinimum}座驾,到达等级后可赠送";
      }
    }
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: AppLayout.pageSpace),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppLayout.textWhite16("${model.carName}"),
                  SizedBox(height: 8.dp),
                  AppLayout.text40White12(text),
                ],
              ).expanded(),
              _buildButton(model),
            ],
          ),
        ).expanded(),
        Container(height: 1.dp, color: AppMainColors.separaLineColor4,),
      ],
    ).expanded();
  }

  Widget _buildButton(CarListEntity model) {
    final text = logic.getButtonText(model);
    List<Color> bgColor = [Color(0x0FFFFFFF), Color(0x0FFFFFFF)];
    Color textColor = AppMainColors.whiteColor70;
    Color borderColor = AppMainColors.separaLineColor10;
    // 使用
    if (model.carBuyState == 1) {
      bgColor = [Color(0x33FF1EAF), Color(0x33FF1EAF)];
      textColor = AppMainColors.mainColor;
    }
    // 购买
    if (model.carBuyState == 0 && model.type == 1) {
      textColor = AppMainColors.whiteColor100;
      borderColor = Colors.transparent;
      bgColor = AppMainColors.commonBtnGradient;
    }
    return GestureDetector(
      child: Container(
        width: 68.dp,
        height: 32.dp,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.dp),
          gradient: LinearGradient(
            colors: bgColor
          ),
          border: Border.all(
            color: borderColor,
            width: 1.dp,
          )
        ),
        child: Text(text, style: TextStyle(fontSize: 14.sp, color: textColor)),
      ),
      onTap: () {
        if (model.carBuyState == 0) {
          // 点击购买
          if (model.type == 1) {
            _showBuyCar(model);
          }
          // 点击特权获取
          if (model.type == 2) {
            logic.pushLevelPrivilege();
          }
        }
        // 点击使用
        if (model.carBuyState == 1) {
          logic.useCar(model.id,model.carGifUrl);
        }
        // 用户自己购买坐骑点击使用中
        if (model.carBuyState == 2) {
          if (model.type == 1) {
            _showBuyCar(model);
          }
        }
      },
    );
  }

  void _showBuyCar(CarListEntity model) {
    customShowModalBottomSheet(
      context: state.context,
      builder: (_) => MineCarBuy(model),
      backgroundColor: Colors.transparent,
      enableDrag: false,
      fixedOffsetHeight: 362.dp,
    );
  }

  Widget _buildCarDisplay() {
    return GetBuilder<MineBackpackLogic>(
      init: logic,
      builder: (logic) {
        return Offstage(
          offstage: !state.isAnimation,
          child: state.isAnimation ? SVGASampleScreen() : Container(),
        );
      },
    );
  }
  
}

class SVGASampleScreen extends StatefulWidget {
  const SVGASampleScreen({Key? key}) : super(key: key);

  @override
  _SVGASampleScreenState createState() => _SVGASampleScreenState();
}

class _SVGASampleScreenState extends State<SVGASampleScreen> with SingleTickerProviderStateMixin {
  late SVGAAnimationController animationController;
  final logic = Get.find<MineBackpackLogic>();
  final state = Get.find<MineBackpackLogic>().state;

  @override
  void initState() {
    this.animationController = SVGAAnimationController(vsync: this);
    this.loadAnimation();
    super.initState();
  }

  @override
  void dispose() {
    this.animationController.dispose();
    super.dispose();
  }

  void loadAnimation() async {
    final videoItem = await SVGAParser.shared.decodeFromURL(state.gifUrl);
    this.animationController.videoItem = videoItem;
    this
        .animationController
        .forward()
        .whenComplete(() {
      this.animationController.videoItem = null;
      print('_________我播放完了');
      logic.playComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: SVGAImage(this.animationController),
    );
  }
}
