import 'package:flutter/material.dart';
import 'package:star_common/common/app_common_widget.dart';

import '../common/colors.dart';

final ThemeData themeData = ThemeData(
  primaryColor:AppMainColors.backgroudColor ,
  splashColor:AppMainColors.backgroudColor , // 取消水波纹效果
  highlightColor: AppMainColors.backgroudColor,
  textTheme: const TextTheme(
    bodyText2: TextStyle(
      // color: AppMainColors.unactive, // 文字颜色
    ),
  ),
  /// 首页滚动细线
  appBarTheme: const AppBarTheme(
    backgroundColor: AppMainColors.backgroudColor,
    elevation: 0,
  ),

  indicatorColor: AppMainColors.backgroudColor,
  tabBarTheme: const TabBarTheme(
    unselectedLabelColor: AppMainColors.whiteColor40,
    indicatorSize: TabBarIndicatorSize.label,
    labelStyle: TextStyle(
      fontSize: 15,
    ),
    labelPadding: EdgeInsets.symmetric(horizontal: 12),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppMainColors.backgroudColor,
    selectedItemColor: AppMainColors.mainColor,
    unselectedItemColor: AppMainColors.whiteColor40,
    selectedLabelStyle: TextStyle(
      fontSize: 12,
    ),
  ),
  scaffoldBackgroundColor: AppMainColors.backgroudColor,
);