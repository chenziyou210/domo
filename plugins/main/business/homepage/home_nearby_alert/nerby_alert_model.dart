
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:star_common/common/app_common_widget.dart';

class HomeNearAlertItemModel {
  // 命名函数
  HomeNearAlertItemModel({
    this.name,
    this.viewType,
    this.backgroudColor = AppMainColors.whiteColor6,
    this.textColor = AppMainColors.whiteColor70,
    this.borderColor = AppMainColors.transparent,
    // this.textColor = Colors.red,

    this.seletecd = false,
  });
  String? name;
  String? viewType;
  bool seletecd;
  Color backgroudColor;
  Color textColor;
  Color borderColor;

}
