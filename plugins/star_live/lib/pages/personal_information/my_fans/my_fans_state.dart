import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @description:
/// @author
/// @date: 2022-05-25 18:52:49
class MyFansState {
  late PageController pageController;
  late RefreshController refreshController = RefreshController();
  var titles = ['关注', '粉丝'];
  late var listData = [];
  var folowOrFans = true; // 0 关注  1 粉丝
  var page = 1; // 0 关注  1 粉丝
  var totalNum = 0; //总数
  var userId = "";
  MyFansState() {}
}
