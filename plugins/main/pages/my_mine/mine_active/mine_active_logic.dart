import 'package:alog/alog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/http_channel.dart';

import 'mine_active_state.dart';

/// @description:
/// @author
/// @date: 2022-06-01 17:38:40
class MineActiveLogic extends GetxController
    with SingleGetTickerProviderMixin, Toast {
  final state = MineActiveState();

  @override
  void onInit() {
    activityNet();
    super.onInit();
  }

  //活动
  activityNet() {
    HttpChannel.channel.appActivity().then((value) => value.finalize(
        wrapper: WrapperModel(),
        failure: (e) => showToast(e),
        success: (data) {
          if (data != null && data is List) {
            state.activeData =
                data.map((e) => MineActiveData.fromJson(e)).toList();
          }
          state.tabController = TabController(
              initialIndex: 0, length: state.activeData.length, vsync: this);
          state.tabController.animateTo(0);
          update();
        }));
  }
}
