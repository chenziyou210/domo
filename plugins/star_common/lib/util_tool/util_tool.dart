/*
 *  Copyright (C), 2015-2021
 *  FileName: util_tool
 *  Author: Tonight丶相拥
 *  Date: 2021/8/2
 *  Description: 
 **/

library utiltool;

import 'package:star_common/i18n/i18n.dart';
import 'dart:convert';
import 'dart:core';
import 'dart:typed_data';

part 'datetime_extension.dart';
part 'int_extension.dart';

///根据日期，返回星座
String getConstellation(DateTime birthday, AppInternational intl) {
  final String capricorn = intl.capricorn; //Capricorn 摩羯座（12月22日～1月20日）
  final String aquarius = intl.aquarius; //Aquarius 水瓶座（1月21日～2月19日）
  final String pisces = intl.pisces; //Pisces 双鱼座（2月20日～3月20日）
  final String aries = intl.aries; //3月21日～4月20日
  final String taurus = intl.taurus; //4月21～5月21日
  final String gemini = intl.gemini; //5月22日～6月21日
  final String cancer = intl.cancer; //Cancer 巨蟹座（6月22日～7月22日）
  final String leo = intl.leo; //Leo 狮子座（7月23日～8月23日）
  final String virgo = intl.virgo; //Virgo 处女座（8月24日～9月23日）
  final String libra = intl.libra; //Libra 天秤座（9月24日～10月23日）
  final String scorpio = intl.scorpio; //Scorpio 天蝎座（10月24日～11月22日）
  final String sagittarius = intl.sagittarius; //Sagittarius 射手座（11月23日～12月21日）

  int month = birthday.month;
  int day = birthday.day;
  String constellation = '';

  switch (month) {
    case DateTime.january:
      constellation = day < 21 ? capricorn : aquarius;
      break;
    case DateTime.february:
      constellation = day < 20 ? aquarius : pisces;
      break;
    case DateTime.march:
      constellation = day < 21 ? pisces : aries;
      break;
    case DateTime.april:
      constellation = day < 21 ? aries : taurus;
      break;
    case DateTime.may:
      constellation = day < 22 ? taurus : gemini;
      break;
    case DateTime.june:
      constellation = day < 22 ? gemini : cancer;
      break;
    case DateTime.july:
      constellation = day < 23 ? cancer : leo;
      break;
    case DateTime.august:
      constellation = day < 24 ? leo : virgo;
      break;
    case DateTime.september:
      constellation = day < 24 ? virgo : libra;
      break;
    case DateTime.october:
      constellation = day < 24 ? libra : scorpio;
      break;
    case DateTime.november:
      constellation = day < 23 ? scorpio : sagittarius;
      break;
    case DateTime.december:
      constellation = day < 22 ? sagittarius : capricorn;
      break;
  }

  return constellation;
}
