/*
 *  Copyright (C), 2015-2021
 *  FileName: color_tool
 *  Author: Tonight丶相拥
 *  Date: 2021/9/27
 *  Description: 
 **/

// static const String TextBasicColorHexString = '111111';
// static const String TextWeakColorHexString = '999999';
// static const String BorderColorHexString = 'ededed';
// static const String GapColorHexString = 'ededed';
// static const String ThemeColorHexString = '006fff';
// static const String WightColorHexString = 'ffffff';
// static const String RedColor = 'FA5151';

import 'package:flutter/material.dart' show Color;

//   static const String TextBasicColorHexString = '111111';
//   static const String TextWeakColorHexString = '999999';
//   static const String BorderColorHexString = 'ededed';
//   static const String GapColorHexString = 'ededed';
//   static const String ThemeColorHexString = '006fff';
//   static const String WightColorHexString = 'ffffff';
//   static const String RedColor = 'FA5151';
class HexColor extends Color {
  static String get _textBasicColor => "111111";
  static String get _textWeakColor => "999999";
  static String get _borderColor => "ededed";
  static String get _gapColor => "ededed";
  static String get _themeColor => "006fff";
  static String get _wightColor => "ffffff";
  static String get _redColor => "FA5151";

  HexColor({required String hexColor})
      : super(int.parse(hexColor, radix: 16));

  HexColor.textBasicColor(): super(int.parse(_textBasicColor, radix: 16));
  HexColor.textWeakColor(): super(int.parse(_textWeakColor, radix: 16));
  HexColor.borderColor(): super(int.parse(_borderColor, radix: 16));
  HexColor.gapColor(): super(int.parse(_gapColor, radix: 16));
  HexColor.themeColor(): super(int.parse(_themeColor, radix: 16));
  HexColor.wightColor(): super(int.parse(_wightColor, radix: 16));
  HexColor.redColor(): super(int.parse(_redColor, radix: 16));
}




/// Color(int.parse(hexString, radix: 16)).withAlpha(255)