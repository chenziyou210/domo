import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/generated/living_audience_entity.dart';
import 'audience_online_logic.dart';
import 'online_cell.dart';

class UserOnlinePage extends StatelessWidget {
  UserOnlinePage(this.controller, this.type);
  final AudienceOnlineLogic controller;
  final int type;

  @override
  Widget build(BuildContext context) {
    return RefreshWidget(
        // onLoading: (c) async{
        //   await controller.loadMore();
        //   if (controller.hasMoreData) {
        //     c.loadComplete();
        //   }else {
        //     c.loadNoData();
        //   }
        // },
        enablePullDown: true,
        enablePullUp: false,
        onRefresh: (c) async {
          await controller.dataRefresh();
          c.refreshCompleted();
          c.resetNoData();
        },
        children: [
          Obx(() {
            List<LivingAudienceEntity> model;
            if (type == 1) {
              model = controller.state.nobleData;
            } else {
              model = controller.state.onlineData;
            }
            if (model.length == 0) {
              return SliverFillRemaining();
            }
            return SliverList(
                delegate: SliverChildBuilderDelegate((_, index) {
              return Column(children: [
                OnlineCell(model[index]),
                CustomDivider(
                  color: AppMainColors.whiteColor6,
                  indent: 72.dp,
                )
              ]);
            }, childCount: model.length));
          })
        ]);
  }
}
