import 'package:flutter/material.dart';

import 'package:star_common/manager/app_manager.dart';
import 'package:star_live/pages/live/live_home_data.dart';

class LiveMainViewState {
  LiveMainViewState() {
    ///Initialize variables
  }
  int currentIndex = 1;
  late TabController controller;
  bool enableOpenLiving = AppManager.getInstance<AppUser>().enableOpenLive;

  /// 获取当前类型试图
  // List <HomeTabDataEntity> tabItems = List.empty(growable: true);
  List<HomeTabDataEntity> tabItems = List.generate(4, (index) {
    var name, tabId;
    HomeTabDataEntity temp = HomeTabDataEntity();
    switch (index) {
      case 0:
        name = "关注";
        tabId = 1111;
        break;
      case 1:
        name = "推荐";
        tabId = 0;
        break;
      case 2:
        name = "游戏";
        tabId = 1;
        break;
      case 3:
        name = "附近";
        tabId = 2;
        break;
    }
    temp.name = name;
    temp.id = tabId;
    return temp;
  });

  Map<int, Widget> listMap = {};

  HomeTabDataEntity foucsItem() {
    HomeTabDataEntity tempModel = HomeTabDataEntity();
    tempModel.name = "关注";
    tempModel.id = 1111;
    return tempModel;
  }
}
