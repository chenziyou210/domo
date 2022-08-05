/*
 *  Copyright (C), 2015-2021
 *  FileName: toast
 *  Author: Tonight丶相拥
 *  Date: 2021/7/13
 *  Description: 
 **/



import 'package:easy_loading/easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:star_common/common/app_common_widget.dart';

mixin Toast {

  /// 显示加载框
  Future<void> show([String status = "loading..."]){ ///请求中
    return EasyLoading.show(status: status, maskType: EasyLoadingMaskType.clear);
  }

  /// 显示toast
  Future<void> showToast(String status, {Duration? duration,
    EasyLoadingToastPosition? toastPosition, EasyLoadingMaskType? maskType,
    bool? dismissOnTap}) {
    return EasyLoading.showToast(status, duration: duration,
        toastPosition: EasyLoadingToastPosition.center, maskType: EasyLoadingMaskType.none,
        dismissOnTap: dismissOnTap);
  }

  /// 显示完成
  Future<void> dismiss(){
    return EasyLoading.dismiss();
  }

  /// 显示消息
  Future<void> showInfo(String status){
    return EasyLoading.showInfo(status);
  }

  void showStyledToast({
    required BuildContext context,
    String? content,
    Color color = Colors.amber,
    BoxDecoration? decoration,
    anim = StyledToastAnimation.slideFromBottom,
    pos = StyledToastPosition.center,
    int seconds = 3,
    Curve? curve,
    Widget? widget,
    Curve? reverseCurve,
    double? width,
    double? height,
  }) {
    showToastWidget(
      widget ??
          Wrap(children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(children: [
                Container(
                  padding: EdgeInsets.all(9.dp),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0x731B1C21),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.dp),
                    ),
                    border: const Border.fromBorderSide(
                      BorderSide(color: Color(0xFF2FE3EB), width: 1),
                    ),
                  ),
                  child: Text(
                    content ?? " ",
                    style: TextStyle(
                      fontSize: 16.dp,
                      color: Colors.amber,
                    ),
                  ),
                ),
              ]),
            ])
      ]),
      context: context,
      animation: anim,
      position: pos,
      curve: curve,
      reverseCurve: reverseCurve,
      duration: Duration(seconds: seconds),
    );
  }

}
class StyledToastPos{
  static pos(Alignment align, {double offset = 0.0}) => StyledToastPosition(align: align, offset: offset);
}
