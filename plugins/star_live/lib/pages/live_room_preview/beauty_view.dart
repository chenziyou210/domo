/*
 *  Copyright (C), 2015-2021
 *  FileName: beauty_view
 *  Author: Tonight丶相拥
 *  Date: 2021/12/11
 *  Description: 
 **/

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/storage.dart';
import 'package:star_live/agora_rtc/agora_rtc.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';
import 'package:star_common/i18n/i18n.dart';

class BeautyView extends GetView<BeautyModel> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var intl = AppInternational.of(context);
    List<String> lst = [intl.low, intl.normal, intl.high];
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 21, 23, 35),
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomText(
            "${intl.lighteningContrastLevel}",
            fontSize: 14.dp,
            fontWeight: w_400,
            color: Colors.white,
          ),
          SizedBox(height: 8),
          Row(
              children: lst.map((e) {
            int index = lst.indexOf(e);
            return Obx(() {
              bool isAtIndex = index == controller.index.value;
              return Container(
                      height: 27.dp,
                      constraints: BoxConstraints(minWidth: 39.dp),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      margin: EdgeInsets.only(right: 8),
                      child: [
                        CustomText("$e",
                            fontSize: 12.dp,
                            fontWeight: w_400,
                            color: Colors.white)
                      ].column(mainAxisAlignment: MainAxisAlignment.center),
                      decoration: BoxDecoration(
                          border: isAtIndex
                              ? null
                              : Border.all(color: Colors.white),
                          gradient: isAtIndex
                              ? LinearGradient(
                                  colors: AppColors.buttonGradientColors)
                              : null,
                          borderRadius: BorderRadius.circular(13.5.dp)))
                  .gestureDetector(onTap: () {
                if (index != controller.index.value) {
                  controller._onChangeValue(index: index);
                }
              });
            });
          }).toList()),
          SizedBox(height: 16),
          CustomText(
            "${intl.lighteningLevel}",
            fontSize: 14.dp,
            fontWeight: w_400,
            color: Colors.white,
          ),
          SizedBox(height: 8),
          Obx(() {
            return CupertinoSlider(
                value: controller.lighteningLevel.value,
                thumbColor: Colors.white,
                activeColor: Colors.blue,
                onChanged: (value) {
                  controller._onChangeValue(lighteningLevel: value);
                });
          }).sizedBox(width: double.infinity),
          SizedBox(height: 16),
          CustomText(
            "${intl.smoothnessLevel}",
            fontSize: 14.dp,
            fontWeight: w_400,
            color: Colors.white,
          ),
          SizedBox(height: 8),
          Obx(() {
            return CupertinoSlider(
                value: controller.smoothnessLevel.value,
                thumbColor: Colors.white,
                activeColor: Colors.blue,
                onChanged: (value) {
                  controller._onChangeValue(smoothnessLevel: value);
                });
          }).sizedBox(width: double.infinity),
          SizedBox(height: 16),
          CustomText(
            "${intl.rednessLevel}",
            fontSize: 14.dp,
            fontWeight: w_400,
            color: Colors.white,
          ),
          SizedBox(height: 8),
          Obx(() {
            return CupertinoSlider(
                value: controller.rednessLevel.value,
                thumbColor: Colors.white,
                activeColor: Colors.blue,
                onChanged: (value) {
                  controller._onChangeValue(rednessLevel: value);
                });
          }).sizedBox(width: double.infinity)
        ]));
  }
}

class BeautyModel {
  BeautyModel._();
  late RxDouble lighteningLevel;
  late RxDouble smoothnessLevel;
  late RxDouble rednessLevel;
  late RxInt index;
  String get _beautyKey => "hjnBeautyConfigKey";

  factory BeautyModel.initialize() {
    var self = BeautyModel._();
    String data = StorageService.to.getString(self._beautyKey);
    Map<String, dynamic> json = {};
    if (data.isNotEmpty) {
      json = jsonDecode(data);
    }

    int l = json["lighteningContrastLevel"] ?? 1;
    double lighteningLevel = json["lighteningLevel"] ?? 0.7;
    double rednessLevel = json["rednessLevel"] ?? 0.1;
    double smoothnessLevel = json["smoothnessLevel"] ?? 0.5;
    return self
      ..lighteningLevel = lighteningLevel.obs
      ..rednessLevel = rednessLevel.obs
      ..smoothnessLevel = smoothnessLevel.obs
      ..index = l.obs;
  }

  void _onChangeValue(
      {double? lighteningLevel,
      double? smoothnessLevel,
      double? rednessLevel,
      int? index}) {
    if (lighteningLevel != null) {
      this.lighteningLevel.value = lighteningLevel;
    }
    if (rednessLevel != null) {
      this.rednessLevel.value = rednessLevel;
    }
    if (smoothnessLevel != null) {
      this.smoothnessLevel.value = smoothnessLevel;
    }
    if (index != null) {
      this.index.value = index;
    }
    this.setEffect();
  }

  /// 设置效果
  void setEffect() {
    AgoraRtc.rtc.setBeauty(
        lighteningLevel: lighteningLevel.value,
        smoothnessLevel: smoothnessLevel.value,
        rednessLevel: rednessLevel.value,
        index: index.value);
    StorageService.to.setString(_beautyKey, _toJson());
  }

  String _toJson() {
    Map<String, dynamic> dic = {};
    dic["lighteningContrastLevel"] = this.index.value;
    dic["lighteningLevel"] = this.lighteningLevel.value;
    dic["rednessLevel"] = this.rednessLevel.value;
    dic["smoothnessLevel"] = this.smoothnessLevel.value;
    return jsonEncode(dic);
  }
  // lighteningContrastLevel: LighteningContrastLevel.Normal,
  // lighteningLevel: 0.7,
  // smoothnessLevel: 0.5,
  // rednessLevel: 0.1
}
