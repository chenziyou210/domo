import 'package:alog/alog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:hjnzb/pages/my_mine/mine_active/mine_active_sub_view.dart';

import 'mine_active_logic.dart';
import 'mine_active_state.dart';

/// @description:
/// @author
/// @date: 2022-06-01 17:38:40
class MineActivePage extends StatelessWidget {
  final MineActiveLogic logic = Get.put(MineActiveLogic());
  final MineActiveState state = Get.find<MineActiveLogic>().state;

  MineActivePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MineActiveLogic>(
        init: logic,
        builder: (c) {
          return Scaffold(
            appBar: DefaultAppBar(
              centerTitle: true,
              title: c.state.activeData.length == 0
                  ? Text(
                      "活动",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
                  : TabBar(
                      isScrollable: true,
                      indicatorColor: Colors.transparent,
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: w_bold),
                      unselectedLabelStyle: TextStyle(
                          color: AppMainColors.whiteColor70, fontSize: 16),
                      controller: c.state.tabController,
                      onTap: (index) {
                        Alog.i(index);
                      },
                      tabs: logic.state.activeData.map((e) {
                        return CustomText(e.name ?? "");
                      }).toList(),
                    ),
            ),
            body: c.state.activeData.length == 0
                ? EmptyView(emptyType: EmptyType.noData)
                : TabBarView(
                    controller: c.state.tabController,
                    children: c.state.activeData
                        .map((e) => MineActiveSubPage(
                              list: e.activityList,
                            ))
                        .toList(),
                  ),
          );
        });
  }
}
