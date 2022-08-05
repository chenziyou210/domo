/*
 *  Copyright (C), 2015-2021
 *  FileName: cache
 *  Author: Tonight丶相拥
 *  Date: 2021/3/15
 *  Description: 
 **/

import 'dart:async';
import 'dart:io';
import 'package:httpplugin/httpplugin.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:star_common/common/storage.dart';

class AppCacheManager with CacheBase {
  static AppCacheManager? _cache;
  static AppCacheManager get cache => _cache ?? _getInstance();
  AppCacheManager._();
  // 获取单例
  static AppCacheManager _getInstance() {
    _cache = AppCacheManager._();
    return _cache!;
  }

  // 用户token
  final String _userToken = "hjn_user_token";
  final String charity = "anchor_charity";

  final String _isGuestlogin = "guest_login";

  // app 语言
  final String _appLanguage = "app_language";
  // ------------------设置------------------------
  // 是否开启应用锁
  final String _isLockOpen = "_isLockOpen";
  // 是否开启震动
  final String _isShakeOpen = "_isShakeOpen";
  // 是否开启礼物特效
  final String _isGiftOpen = "_isGiftOpen";
  // 是否驾驶特效
  final String _isDriveOpen = "_isDriveOpen";

  // 是否开启入场隐身
  final String _isAdmissionStealthOpen = "_isAdmissionStealthOpen";
  // 是否开启榜单隐身
  final String _isListStealthOpen = "_isListStealthOpen";

  // ------------------投注,预设倍数------------------------
  final String _presetMultiplier = "_presetMultiplier";
// ------------------投注,设置的预设倍数------------------------
  final String _setMultiplier = "_setMultiplier";
  final String _setBetCoin = "_setBetCoin";
  final String _setTimeBetCoin = "_setTimeBetCoin";
  final String _setTimeCountBetCoin = "_setTimeCountBetCoin";
  final String _setRememberResetBetCoin = "_setRememberResetBetCoin";

  /// 设置预设倍数
  void setMultiplier(String value) {
    StorageService.to.setString(_setMultiplier, value);
  }

  ///获取设置的预设倍数
  String? getMultiplier() {
    return StorageService.to.getString(_setMultiplier);
  }
  /// 设置预设倍数
  void setBetCoin(String id, String value) {
    StorageService.to.setString('${_setBetCoin}_${id}', value);
  }
  /// 设置预设倍数
  void setTimeBetCoin(String id, String value) {
    StorageService.to.setString('${_setTimeBetCoin}_${id}', value);
  }
 /// 设置预设倍数
  void setTimeCountBetCoin(String id, String value) {
    StorageService.to.setString('${_setTimeCountBetCoin}_${id}', value);
  }
/// 设置预设倍数
  void setRememberGameResult() {
    StorageService.to.setString('${_setRememberResetBetCoin}', "true");
  }

  bool isRememberGameResult() {
    return StorageService.to.getString('${_setRememberResetBetCoin}') == 'true';
  }

 /// 设置预设倍数
  void clearBetCoin(String id) {
    StorageService.to.remove('${_setBetCoin}_${id}');
    StorageService.to.remove('${_setTimeBetCoin}_${id}');
    StorageService.to.remove('${_setTimeCountBetCoin}_${id}');
    StorageService.to.remove('${_setRememberResetBetCoin}');
  }

  ///获取设置的预设倍数
  String? getBetCoin(String id) {
    return StorageService.to.getString('${_setBetCoin}_${id}');
  }

  ///获取设置的预设倍数
  String? getTimeBetCoin(String id) {
    return StorageService.to.getString('${_setTimeBetCoin}_${id}');
  }

  ///获取设置的预设倍数
  String? getTimeCountBetCoin(String id) {
    return StorageService.to.getString('${_setTimeCountBetCoin}_${id}');
  }

  /// 预设倍数
  void setPresetMul(List<String> value) async {
    StorageService.to.setList(_presetMultiplier, value);
  }

  /// 获取预设倍数
  List<String> getPresetMul() {
    List<dynamic>? list = StorageService.to.getList(_presetMultiplier);
    if ((list.length) > 0) {
      List<String> items = [];
      list.forEach((element) {
        items.add("$element");
      });
      return items;
    } else {
      return [];
    }
  }

  /// 删除预设倍数
  void removePresetMul() {
    StorageService.to.remove(_presetMultiplier);
  }

  // 是否开启应用锁
  void setisLockOpen(bool value) async {
    StorageService.to.setBool(_isLockOpen, value);
    // _storage.write(_isLockOpen, value);
  }

  bool? getisLockOpen() {
    return StorageService.to.getBool(_isLockOpen);
  }

  // 是否开启震动
  void setisShakeOpen(bool value) async {
    StorageService.to.setBool(_isShakeOpen, value);
  }

  bool? getiShakeOpen() {
    return StorageService.to.getBool(_isShakeOpen);
  }

  // 是否开启入场隐身
  void setisAdmissionStealthOpen(bool value) async {
    StorageService.to.setBool(_isAdmissionStealthOpen, value);
  }

  bool? getisAdmissionStealthOpen() {
    return StorageService.to.getBool(_isAdmissionStealthOpen);
  }

  // 是否开启榜单隐身
  void setisListStealthOpen(bool value) async {
    StorageService.to.setBool(_isListStealthOpen, value);
  }

  bool? getisListStealthOpen() {
    return StorageService.to.getBool(_isListStealthOpen);
  }

  // 是否开启礼物特效
  void setisGiftOpen(bool value) async {
    StorageService.to.setBool(_isGiftOpen, value);
  }

  bool? getiGiftOpen() {
    return StorageService.to.getBool(_isGiftOpen, defaultValue: false);
  }

// 是否开启礼物特效
  void setisDriveOpen(bool value) async {
    StorageService.to.setBool(_isDriveOpen, value);
  }

  bool? getiDriveOpen() {
    return StorageService.to.getBool(_isDriveOpen, defaultValue: false);
  }

  // 设置token
  void setUserToken(String token) async {
    StorageService.to.setString(_isGiftOpen, token);
  }

  String? getUserToken() {
    return StorageService.to.getString(_userToken);
  }

  void setCharityPosition(int pos) async {
    StorageService.to.setInt(charity, pos);
  }

  int? getCharityPosition() {
    return StorageService.to.getInt(charity);
  }

  // 设置token
  void setisGuest(bool isguest) async {
    StorageService.to.setBool(_isGuestlogin, isguest);
  }

  bool? getisGuest() {
    bool? value;
    try {
      value = StorageService.to.getBool(_isGuestlogin);
    } catch (_) {
      value = false;
    }
    return value;
  }

  /// 设置语言
  void setAppLanguage(int index) async {
    StorageService.to.setInt(_appLanguage, index);
  }

  /// 获取app 语言设置
  int? getAppLanguage() {
    int? value;
    try {
      value = StorageService.to.getInt(_appLanguage);
    } catch (_) {}
    return value;
  }

  @override
  String getValueForKey(String key) {
    // TODO: implement getValueForKey
    return "";
  }

  @override
  void setValueForKey(String key, String value) {
    // TODO: implement setValueForKey
  }

  /// 加载缓存大小
  Future<_CacheEntity> loadCacheSize() async {
    /// 获取临时文件路径
    Directory tempDir = await getTemporaryDirectory();

    /// 获取临时文件的大小
    double size = await _getSize(tempDir);

    /// 返回临时文件大小格式转换
    return renderSize(size);
  }

  /// 递归获取所有文件
  Future<double> _getSize(FileSystemEntity file) async {
    if (file is File) {
      int length = await file.length();
      return length.toDouble();
    } else if (file is Directory) {
      if (file.path.endsWith("libCachedImageData")) {
        return 0;
      }

      /// 文件路径下面的所有文件
      final Iterator<FileSystemEntity> children = file.listSync().iterator;
      double total = 0;
      while (children.moveNext()) {
        FileSystemEntity entity = children.current;

        /// 递归获取
        total += await _getSize(entity);
      }
      return total;
    }
    return 0;
  }

  /// 计算文件大小
  _CacheEntity renderSize(double? size) {
    List<String> unit = ["B", "K", "M", "G"];
    if (size == null) {
      return _CacheEntity(cacheSize: 0, unit: unit[0]);
    } else {
      int index = 0;
      while (size! > 1024) {
        index++;
        size = size / 1024;
      }

      /// 保留两位小数
      double value = (size * 100).ceil() / 100;

      /// 返回模型
      return _CacheEntity(unit: unit[index], cacheSize: value);
    }
  }

  /// 清除缓存
  Future<Null> clearCache() async {
    Directory tempDir = await getTemporaryDirectory();
    await _delDir(tempDir);
  }

  /// 递归删除文件
  Future<Null> _delDir(FileSystemEntity file) async {
    if (file is Directory) {
      if (file.path.endsWith("libCachedImageData")) {
        return;
      }

      /// 获取文件路径下所有文件
      Iterator<FileSystemEntity> iterator = file.listSync().iterator;
      while (iterator.moveNext()) {
        FileSystemEntity entity = iterator.current;

        /// 递归删除
        await _delDir(entity);
      }
    }
    try {
      /// 删除文件夹
      await file.delete();
    } catch (e) {
      print("delete error $e");
    }
  }
}

class _CacheEntity {
  _CacheEntity({this.cacheSize: 0, this.unit: "B"});

  /// 缓存大小
  final double cacheSize;

  /// 缓存大小单位
  final String unit;
}
