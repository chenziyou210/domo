import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ContributionListState {
  late PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  var titles = [
    intl.dailyList,
    intl.weeklyList,
    intl.monthlyList,
    intl.overallList
  ];
  RxInt _tabIndex = 0.obs;
  RxInt get tabIndex => _tabIndex;
  RxList<ContributeDataEntity> _contributeData = <ContributeDataEntity>[].obs;
  RxList<ContributeDataEntity> get contributeData => _contributeData;

  ContributionListState() {
    ///Initialize variables
  }
  var userId = "";


  void setFollowOrFans(int value) {
    _tabIndex.value = value;
    pageController.jumpToPage(value);
  }

  void setData(List<ContributeDataEntity> value) {
    _contributeData.value = value;
  }
}

class ContributeDataEntity {
  // bool? attention;
  String? header;
  int? heat;
  int? rank;
  String? userId;
  String? username;
  int? isInvisible;

  ContributeDataEntity.fromJson(Map<String, dynamic> json) {
    // attention = json['attention'];
    header = json['header'];
    heat = json['heat'];
    rank = json['rank'];
    userId = json['userId'].toString();
    username = json['username'];
    isInvisible = json['isInvisible'];
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}
