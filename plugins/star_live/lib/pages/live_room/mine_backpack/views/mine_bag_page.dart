import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/common_widget/custom_gradientbutton/custom_gradientbutton.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_common/lottie/lottie_view.dart';
import '../mine_backpack_logic.dart';
import '../models/mine_bag_model.dart';

class MineBagPage extends StatelessWidget {
  final double topOffset;
  MineBagPage({this.topOffset: 0});

  final logic = Get.find<MineBackpackLogic>();
  final state = Get.find<MineBackpackLogic>().state;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        return SmartRefresher(
          enablePullDown: true,
          header: LottieHeader(),
          footer: LottieFooter(),
          onRefresh: () {
            logic.loadPackageList();
          },
          controller: state.bagRefreshController,
          child: state.bagList.length <= 0
              ? EmptyView(emptyType: EmptyType.noData, topOffset: topOffset)
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  padding: EdgeInsets.only(top: 10.dp),
                  itemCount: state.bagList.length,
                  itemBuilder: (context, index) {
                    final model = state.bagList[index];
                    return _buildItem(model, context);
                  },
                ),
        );
      }),
    );
  }

  Widget _buildItem(MineBagModel model, BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10.dp, 0, 10.dp),
      child: Column(
        children: [
          CachedNetworkImage(
            width: 46.dp,
            height: 46.dp,
            fit: BoxFit.cover,
            imageUrl: model.picUrl ?? '',
            placeholder: (context, string) {
              return Container(color: Color(0xFF1E1E1E),);
            },
            errorWidget: (context, url, error) {
              return Container(color: Color(0xFF1E1E1E),);
            },
          ),
          Container(
            width: 42.dp,
            height: 16.dp,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppMainColors.whiteColor10,
                width: 1.dp,
              ),
              borderRadius: BorderRadius.circular(8),
              color: AppMainColors.blackColor70,
            ),
            child: Text("${model.num ?? 0}个",
                style:
                    TextStyle(color: AppMainColors.whiteColor100, fontSize: 8)),
          ),
          SizedBox(height: 8.dp),
          AppLayout.text70White14("${model.itemName ?? ''}"),
          SizedBox().expanded(),
          model.itemTag == 3002
              ? GradientButton(
                  child: AppLayout.textWhite12('使用'),
                  onPressed: () => logic.editNickname(context),
                )
              : model.itemTag == 3003
                  ? GradientButton(
                      child: AppLayout.textWhite12('使用'),
                      onPressed: () => logic.diamondCardUse(model),
                    )
                  : AppLayout.text40White12('直播间使用')
        ],
      ),
    );
  }
}
