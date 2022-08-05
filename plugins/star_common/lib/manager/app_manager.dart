/*
 *  Copyright (C), 2015-2021
 *  FileName: app_manager
 *  Author: Tonight丶相拥
 *  Date: 2021/10/16
 *  Description: 
 **/

library appmanager;

import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/storage.dart';
import 'package:star_common/generated/share_app_link_entity.dart';
import 'package:star_common/base/app_base.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/config.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/generated/im_room_account.dart';
import 'package:star_common/generated/upgrade_entity.dart';
import 'dart:math' as math;
import 'package:star_common/manager/user/user_info.dart';

part 'user/user.dart';
// part 'chats.dart';
part 'global_setting_model.dart';
part 'game_manager.dart';

class AppManager {
  AppManager._();

  static AppUser _user = AppUser._();
  // static ChatsListViewModel _chats = ChatsListViewModel._();
  static GlobalSettingModel _setting = GlobalSettingModel._();
  static Game _game = Game._();

  static T getInstance<T>() {
    String type = T.toString();
    T? t;
    if (type == (AppUser).toString()) {
      t = _user as T;
      // }else if (type == (ChatsListViewModel).toString()) {
      //   t = _chats as T;
    } else if (type == (GlobalSettingModel).toString()) {
      t = _setting as T;
    } else if (type == (Game).toString()) t = _game as T;
    if (t == null) {
      throw ("type T is null");
    }
    return t;
  }
}
