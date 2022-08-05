import 'package:flutter/cupertino.dart';
import 'package:star_common/app_images/r.dart';

class TabbarControlState {
  TabbarControlState() {
    ///Initialize variables
  }

  var pageController = PageController();

  ///默认
  List normalImgs = [
    R.homeUnselected,
    R.tab1Unselected,
    R.tab2Unselected,
    R.msgUnselected,
    R.mineUnselected
  ];

  /// 点选
  List seletedImgs = [
    R.homeSelected,
    R.tab1Selected,
    R.tab2Selected,
    R.msgSelected,
    R.mineSelected
  ];

  int tabIndex = 0;
  int unreadNum = 0;

  var lastPopTime = DateTime.now();

  String titleWithType(int type) {
    var title = "";
    switch (type) {
      case 0:
        title = "首页";
        break;
      case 1:
        title = "游戏";
        break;
      case 2:
        title = "充值";
        break;
      case 3:
        title = "消息";
        break;
      case 4:
        title = "我的";
        break;
    }
    return title;
  }
}
