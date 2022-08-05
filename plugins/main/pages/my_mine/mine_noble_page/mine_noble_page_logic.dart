// ignore_for_file: deprecated_member_use

import 'package:alog/alog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/manager/app_manager.dart';
import 'package:star_common/manager/user/user_balance_logic.dart';
import 'package:star_common/manager/user/user_info.dart';
import 'mine_noble_page_state.dart';

/// @description:
/// @author
/// @date: 2022-06-12 17:44:45
class MineNoblePageLogic extends GetxController
    with SingleGetTickerProviderMixin, Toast {
  final state = MineNoblePageState();
  @override
  void onInit() {
    tabs = _tabs;
    state.tabController = TabController(length: tabs.length, vsync: this);
    super.onInit();
  }

  //已经开通的贵族等级
  int openType = AppManager.getInstance<AppUser>().nobleLevel!;
  List<MineNobleTabsData> tabs = [];
  List<MineNobleTabsData> get _tabs => state.tabs();
  List<MineNobleData> get nobleDatas => state.nobleDatas();
  seledetd(int index) {
    for (var i = 0; i < tabs.length; i++) {
      tabs[i].isSeledet = i == index ? true : false;
    }
    update();
  }

  void openNobles(int type) {
    HttpChannel.channel.nobleOpenOrRenew(type)
      ..then((value) {
        value.finalize(
            wrapper: WrapperModel(),
            failure: (e) => showToast(e),
            success: (data) {
              Alog.e(data);
              if (data != null) {
                if (this.openType == type) {
                  showToast("续费成功");
                } else {
                  showToast("开通成功");
                }
                state.expireTime = data["expireTime"];
                setOpentype(type);
                //刷新余额
                Get.find<UserBalanceLonic>().userBalanceData();
                Get.find<UserInfoLogic>().updateAppUser();
              }
            });
      });
  }

  //获取用户贵族等级
  void getUserNobleLevel() {
    HttpChannel.channel.userNobleLevel()
      ..then((value) {
        value.finalize(
            wrapper: WrapperModel(),
            failure: (e) => showToast(e),
            success: (data) {
              if (data != null) {
                setOpentype(int.parse("${data["type"]}"));
                state.expireTime = data["expireTime"];
              }
            });
      });
  }

  setOpentype(int openType) {
    this.openType = openType;
    AppManager.getInstance<AppUser>().chargeNobleLevel(openType);
    update();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getUserNobleLevel();
  }
}
