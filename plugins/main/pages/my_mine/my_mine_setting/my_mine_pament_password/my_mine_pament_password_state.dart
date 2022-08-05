import 'dart:async';

import 'package:flutter/material.dart';
import 'package:star_common/manager/app_manager.dart';

/// @description:
/// @author
/// @date: 2022-06-02 12:37:31
class MyMinePamentPasswordState {
  ///旧密码
  // late TextEditingController oldController = TextEditingController();
  late TextEditingController pas1controller = TextEditingController();
  late TextEditingController pas2controller = TextEditingController();

  ///手机号码
  // late TextEditingController mobileController = TextEditingController();
  late TextEditingController codeController = TextEditingController();

  late bool show = false;
  Map<String, dynamic> codes = {};

  ///是否有提现密码 0:否 1:是
  int flag = AppManager.getInstance<AppUser>().withdrawPasswordFlag ?? 0;

  ///倒计时文字
  String text = "点击发送";
  Timer? timer;
  int countdownTime = 0;
  MyMinePamentPasswordState() {
    ///Initialize variables
  }
}
