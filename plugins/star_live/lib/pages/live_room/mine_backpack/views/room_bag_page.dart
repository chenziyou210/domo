import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_common/lottie/lottie_view.dart';

import '../../../live/change_diamond_widget.dart';
import '../../live_room_new_logic.dart';
import '../../view/gift_card/gift_card.dart';
import '../mine_backpack_logic.dart';
import '../models/mine_bag_model.dart';

class RoomBagPage extends StatefulWidget {
  RoomBagPage(this.roomId);

  final String? roomId;

  final logic = Get.find<MineBackpackLogic>();

  @override
  createState() => _RoomBagPage();
}

class _RoomBagPage extends AppStateBase<RoomBagPage>
    with AutomaticKeepAliveClientMixin, Toast {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  final PageController _controller = PageController();
  ItemIndex _index = ItemIndex();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    widget.logic.loadPackageList();
    return SafeArea(
      child: SmartRefresher(
          enablePullDown: true,
          header: LottieHeader(),
          footer: LottieFooter(),
          onRefresh: () {
            widget.logic.loadPackageList();
          },
          controller: widget.logic.state.roomRefreshController,
          child: Obx(
            () {
              final length = widget.logic.state.bagList.length;
              return length <= 0
                  ? EmptyView(emptyType: EmptyType.noData, topOffset: 200.dp)
                  : Padding(
                      padding: EdgeInsets.only(top: 10.dp),
                      child: _body(length),
                    );
            },
          )),
    );
  }

  _body(int length) {
    final count = length % 8 != 0 ? (length ~/ 8 + 1) : length ~/ 8;
    return Stack(
      children: [
        Container(
          width: double.infinity,
          child: length == 0
              ? Container(
                  child: Center(
                    child: Text("", style: AppStyles.f14w400c255_255_255),
                  ),
                )
              : Column(
                  children: [
                    SizedBox(height: 6.dp),
                    Expanded(
                      child: PageView.builder(
                          clipBehavior: Clip.none,
                          itemCount: count,
                          itemBuilder: (_, int page) {
                            List<MineBagModel> data = (page + 1) * 8 > length
                                ? widget.logic.state.bagList
                                    .getRange(page * 8, length)
                                    .toList()
                                : widget.logic.state.bagList
                                    .getRange(page * 8, (page + 1) * 8)
                                    .toList();
                            return GridView.builder(
                              clipBehavior: Clip.none,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        mainAxisSpacing: 0.dp,
                                        crossAxisSpacing: 0.dp,
                                        mainAxisExtent: 105.dp,
                                    ),
                                itemBuilder: (_, index) {
                                  if (page == _index.page &&
                                      index == _index.index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0.5.dp,
                                              color: AppMainColors.textColor20),
                                          borderRadius:
                                              BorderRadius.circular(8.dp),
                                          color:
                                              AppMainColors.separaLineColor6),
                                      child: _buildItem(data[index], isSelect: true),
                                    );
                                  } else {
                                    return GestureDetector(
                                        child: _buildItem(data[index]),
                                        onTap: () {
                                          _index.setLocation(page, index);
                                          unFocus();
                                          setState(() {});
                                        });
                                  }
                                }, //physics: NeverScrollableScrollPhysics(),
                                itemCount: data.length);
                          },
                          controller: _controller),
                    ),
                    DotsIndicatorNormal(
                        controller: _controller,
                        unSelectColor: Colors.white,
                        onPageSelected: (index) {},
                        itemCount:
                            length % 8 != 0 ? (length ~/ 8 + 1) : length ~/ 8),
                    SizedBox(height: 20.dp),
                    Row(
                      children: [
                        SizedBox(
                          width: 16.dp,
                        ),
                        ChangeDiamondWidget(),
                        Spacer(),
                        _buildGiveBtn(),
                        SizedBox(width: 10.dp)
                      ],
                    ),
                    SizedBox(height: 20.dp)
                  ],
                ),
        ),
      ],
    );
  }

  Widget _buildItem(MineBagModel model, {isSelect = false}) {
    double size = isSelect ? 64.dp : 48.dp;
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Positioned(
          bottom: 49.dp,
          child: ExtendedImage.network(
            model.picUrl ?? '',
            enableLoadState: false,
            width: size,
            height: size,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 8.dp,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.dp),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppMainColors.whiteColor10,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8.dp),
                  color: AppMainColors.blackColor70,
                ),
                child: Text("${model.num ?? 0}个",
                    style:
                    TextStyle(color: AppMainColors.whiteColor100, fontSize: 8.sp)),
              ),
              AppLayout.textWhite12("${model.itemName ?? ''}"),
              AppLayout.text70White10(_getItemBottomText(model)),
            ],
          ),
        ),
      ],
    );
  }

  String _getItemBottomText(model) {
    if (model.itemTag == 3001) return '发弹幕使用';
    if (model.itemTag == 3002) return '可修改昵称';
    if (model.itemTag == 3003) return '贵族赠送';
    return '活动赠送';
  }

  // TAG_NAME.put("3001","喇叭");
  // TAG_NAME.put("3002","改名卡");
  // TAG_NAME.put("3003","贵族钻石");

  Widget _buildGiveBtn() {
    final model = widget.logic.state.bagList[_index.index];
    final txt =
        model.itemTag == 3001 ||model.itemTag == 3002||model.itemTag == 3003 ? '使用' : '赠送';
    return GestureDetector(
        onTap: () async {
          //TODO: Need to hanlde yet
          if (model.itemTag == 3002) {
            Get.back();
            widget.logic.editNickname(context);
          } else if (model.itemTag == 3003) {
            widget.logic.diamondCardUse(model);
            Get.back();
          } else if(model.itemTag == 3001){
            bool result= Get.isRegistered<LiveRoomNewLogic>();
            if(result){
              Get.back();
              final liveRoomLogic = Get.find<LiveRoomNewLogic>();
              liveRoomLogic.barrageSpeech();
            }
          }
          else if (model.itemTag! < 5000 && model.itemTag! > 4000) {
            widget.logic.sendGiftBag(model.itemTag!, widget.roomId, 1);
          }
        },
        child: Container(
          height: 28.dp,
          padding: EdgeInsets.symmetric(horizontal: 10.dp),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient:
                  const LinearGradient(colors: AppMainColors.commonBtnGradient),
              // color: AppColors.c252_103_250,
              borderRadius: BorderRadius.circular(16.dp)),
          child: Text(txt, style: AppStyles.f12w400white),
        ));
  }
}

class ItemIndex {
  int page = 0;
  int index = 0;

  void reset() {
    this.page = 0;
    this.index = 0;
  }

  bool isZero() {
    return page != -1 && index != -1;
  }

  void setLocation(int page, int index) {
    this.page = page;
    this.index = index;
  }
}
