import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @description:
/// @author
/// @date: 2022-06-01 17:38:40
class MineActiveState {
  MineActiveState() {}
  int seletedIndex = 0;

  late final TabController tabController;

  ///活动列表
  List<MineActiveData> activeData = [];
}

class MineActiveData {
  String? name;
  List<MineActiveList>? activityList;

  MineActiveData({this.name, this.activityList});

  MineActiveData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['activityList'] != null) {
      activityList = <MineActiveList>[];
      json['activityList'].forEach((v) {
        activityList!.add(new MineActiveList.fromJson(v));
      });
    }
  }
}

class MineActiveList {
  int? id;
  String? activityImage;
  String? activityContent;
  String? activityLinkAddress;
  bool? isForever;

  MineActiveList(
      {this.id,
      this.activityImage,
      this.activityContent,
      this.activityLinkAddress,
      this.isForever});

  MineActiveList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    activityImage = json['activityImage'];
    activityContent = json['activityContent'];
    activityLinkAddress = json['activityLinkAddress'];
    isForever = (json['isForever'] is bool)
        ? json['isForever']
        : ((json['isForever'] is int) ? json['isForever'] == 1 : false);
  }
}
