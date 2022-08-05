import 'dart:ui';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:hjnzb/business/homepage/widget/homepage_widget.dart';
import 'package:star_common/common/app_common_widget.dart';

import 'nerby_alert_model.dart';

class NearbyAlertState {
  NearbyAlertState() {
    ///Initialize variables
  }

  //我的地区是否点选
  RxBool   currentCity = false.obs;
  //所有地区 选择
  RxString tapCity = "不限".obs;
  //性格选择
  RxString currentGenter = "女生".obs;

  RxInt  currentCityIndex = 3.obs;

  List genders = ["不限", "女生", "男生"];

  List citys = [
    "不限", "海外", "北京", "上海",
    "重庆", "天津", "贵州", "福建",
    "广东", "海南", "台湾", "四川",
    "湖北", "山东", "湖南", "陕西",
    "云南", "内蒙古", "广西", "西藏",
    "宁夏", "江西", "安徽", "江苏",
    "浙江", "青海", "河北", "山西",
    "甘肃", "吉林", "辽宁", "黑龙江",
    "河南", "新疆", "香港", "澳门",
  ];


  Color gameTextColorNomal = AppMainColors.whiteColor70;
  Color gameTextColorSeleted = AppMainColors.mainColor;
  Color gameBgColorNomal = AppMainColors.whiteColor6;
  Color gameBgColorSeleted = AppMainColors.mainColor20;
  Color gameBorderColorNomal = AppMainColors.transparent;

  /*  值获取   */
  Color getBgroudColor(bool seleted) {
    return seleted ? gameBgColorSeleted : gameBgColorNomal;
  }

  Color getTextColor(bool seleted) {
    return seleted ? gameTextColorSeleted : gameTextColorNomal;
  }

  Color getBorderColor(bool seleted) {
    return seleted ? gameBgColorSeleted : gameBorderColorNomal;
  }
}
