/*
 *  Copyright (C), 2015-2021
 *  FileName: local_model
 *  Author: Tonight丶相拥
 *  Date: 2021/7/14
 *  Description: 
 **/

import 'package:flutter/material.dart';
import 'package:star_common/http/cache.dart';
import 'i18n.dart';

class LocalModel extends ChangeNotifier {
  LocalModel._();
  static LocalModel? _local;
  static LocalModel get local => _local ?? _getInstance();

  static LocalModel _getInstance(){
    _local = LocalModel._();
    var value = AppCacheManager.cache.getAppLanguage();
    _local!.changeLocal(value ?? 1, needSet: false);
    return _local!;
  }

  //  static const localeNameList = ['auto', '中文', 'English'];
  final _localeValueList = ['', 'zh', 'en'];

  // //
  // static const kLocaleIndex = 'kLocaleIndex';

  int _localeIndex = 1;
  int get localeIndex => _localeIndex;

  Locale? get locale {
    if (_localeIndex > 0) {
      var value = _localeValueList[_localeIndex].split("-");
      return Locale(value[0], value.length == 2 ? value[1] : '');
    }
    // 跟随系统
    return null;
  }

  // LocaleModel() {
  //   _localeIndex = StorageManager.sharedPreferences.getInt(kLocaleIndex) ?? 1;
  // }

  /// 更改语言
  void changeLocal(int index, {bool needSet: true}) {
    _localeIndex = index;
    notifyListeners();
    if (needSet)
      AppCacheManager.cache.setAppLanguage(index);
  }

  // switchLocale(int index) {
  //   _localeIndex = index;
  //   notifyListeners();
  //   StorageManager.sharedPreferences.setInt(kLocaleIndex, index);
  // }

  static String localeName(context) {
    switch (local._localeIndex) {
      case 0:
        return AppInternational.of(context).autoBySystem;
      case 1:
        return '中文';
      case 2:
        return 'English';
      default:
        return '';
    }
  }
}