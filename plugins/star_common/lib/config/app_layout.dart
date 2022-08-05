import 'package:flutter/cupertino.dart';
import 'package:star_common/common/app_common_widget.dart';
import '../i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'dart:ui';


AppInternational get intl => AppInternational.current;

class AppLayout {
  // 安全区高度
  static double safeBarHeight =  MediaQueryData.fromWindow(window).padding.bottom;
  // 状态栏高度
  static double statusBarHeight =  MediaQueryData.fromWindow(window).padding.top;
  // 页面边距
  static double pageSpace = 16.dp;
  // 卡片间距
  static double cardSpace = 12.dp;
  // 白色18/16/14/12号Text
  static Widget textWhite18(String text) => _buildText(text, 18.sp, AppMainColors.whiteColor100);
  static Widget textWhite16(String text) => _buildText(text, 16.sp, AppMainColors.whiteColor100);
  static Widget textWhite14(String text) => _buildText(text, 14.sp, AppMainColors.whiteColor100);
  static Widget textWhite12(String text) => _buildText(text, 12.sp, AppMainColors.whiteColor100);
  // 70%白色16/14/12/10号Text
  static Widget text70White16(String text) => _buildText(text, 16.sp, AppMainColors.whiteColor70);
  static Widget text70White14(String text) => _buildText(text, 14.sp, AppMainColors.whiteColor70);
  static Widget text70White12(String text) => _buildText(text, 12.sp, AppMainColors.whiteColor70);
  static Widget text70White10(String text) => _buildText(text, 10.sp, AppMainColors.whiteColor70);
  // 40%白色14/12号Text
  static Widget text40White14(String text) => _buildText(text, 14.sp, AppMainColors.whiteColor40);
  static Widget text40White12(String text) => _buildText(text, 12.sp, AppMainColors.whiteColor40);

  static Widget appBarTitle(String text) => Text(
      text,
      style: TextStyle(
        color: AppMainColors.whiteColor100,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      )
  );

  static Widget _buildText(String text, double font, Color textColor){
    return Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: font,
        )
    );
  }

  static FontWeight boldFont = FontWeight.w500;
}