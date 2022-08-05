import 'package:flutter/material.dart';

/// @description:
/// @author
/// @date: 2022-06-16 16:30:33
class RoomGuardianNotesState {
  RoomGuardianNotesState() {
    ///Initialize variables
  }

  ScrollController controller = ScrollController();
  bool isScroll = false;
  String title1 = "什么是守护";
  String conten1 = "守护是粉丝和主播亲密关系的象征，也是主播在直播平台的人气象征之一";

  String title2 = "守护类型";
  String conten2 = "守护分为三种类型，分别是周守护、月守护、真爱年守护，其有效期分别为7日、30日、360日";

  String title3 = "守护特权";
  String conten3 = "开通守护后，即可在该主播直播间享受相应的守护特权，不同类型的守护身份，享受特权不同，具体如下：";

  String title4 = "荣耀守护";

  String conten4 = """1 1.每周为主播贡献钻石最高的守护，将成为荣耀守护，
  在直播间守护列表页面中榜单显示头像，即便不在房间
  内也会一直显示
2.荣耀守护每周一，0点刷新""";

  String title5 = "其他说明";
  String conten5 = """1.各个守护一旦开通，无法取消
2.每人可以为不同的主播开守护，没有数量限制。主播
也可以有多个守护，同样没有数量限制
3.为主播开通守护，主播将获得开通钻石100%的奖励，同时您也获得等价的等级成长经验""";

  var week = [
    GuardianNote(
        title: "开通：",
        conten: "您可以通过消耗999钻石成为主播周守护身份，其中999钻将全部赠送给主播，同时您可以获得等价的等级成长经验")
  ];
  var monthly = [
    GuardianNote(
        title: "开通：",
        conten: "您可以通过消耗3333钻石成为主播月守护身份，其中3333钻将全部赠送给主播，同时您可以获得等价的等级成长经验"),
    GuardianNote(
        title: "续费：",
        conten:
            "如果当前为该主播月守护，此时续费我们将提供8折优惠，续费价格为2666，续费的2666钻将全部赠送给主播，同时您可以获得等价的等级成长经验")
  ];
  var yearly = [
    GuardianNote(
        title: "开通：",
        conten: "您可以通过消耗33333钻石成为主播真爱年守护身份其中33333钻将全部赠送给主播，同时您可以获得等价的等级成长经验"),
    GuardianNote(
        title: "续费：",
        conten:
            "如果当前为该主播月守护，此时续费我们将提供8折优惠，续费价格为26666，续费的26666钻将全部赠送给主播，同时您可以获得等价的等级成长经验")
  ];
}

class GuardianNote {
  String? title;
  String? conten;

  GuardianNote({this.title, this.conten});
}
