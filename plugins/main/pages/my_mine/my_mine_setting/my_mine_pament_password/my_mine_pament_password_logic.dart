import 'dart:async';

import 'package:alog/alog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/cache.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/manager/app_manager.dart';

import 'my_mine_pament_password_state.dart';

/// @description:
/// @author
/// @date: 2022-06-02 12:37:31
class MyMinePamentPasswordLogic extends GetxController with Toast {
  final state = MyMinePamentPasswordState();

  getColroState() {
    state.show = (state.pas1controller.text.length == 6 &&
        state.pas2controller.text.length == 6 &&
        state.codeController.text.length == 6);
    update();
  }

  requestChangePasswod(BuildContext context) {
    String passwod1 = state.pas1controller.text;
    String passwod2 = state.pas2controller.text;

    if (passwod1 != passwod2) {
      showToast("两次输入密码不一致");
      return;
    }
    if (passwod1.isEmpty || passwod2.isEmpty) {
      showToast("密码不能输入空");
      return;
    }
    if (state.codeController.text.length != 6) {
      showToast("请输入6位数验证码");
      return;
    }

    if (state.show &&
        state.codeController.text.length == 6 &&
        passwod1.length == 6) {
      HttpChannel.channel
          .setWithdrawPassword(
              newPassword: state.pas1controller.text,
              newPasswordConfirm: state.pas2controller.text,
              phone: AppManager.getInstance<AppUser>().phone!,
              verifyCode: state.codeController.text)
          .then((value) => value.finalize(
              wrapper: WrapperModel(),
              failure: (e) => showToast(e),
              success: (data) {
                if (data == null) {
                   // Navigator.of(context).pop(1);
                  Get.back(result: 1);
                  AppManager.getInstance<AppUser>()
                      .chargeUserWithdrawPasswordFlag(1);
                }
              }));
    }
  }

  //倒计时
  countdownTap() {
    if (state.countdownTime == 0) {
      state.countdownTime = 60;
      startCountdownTimer();
      HttpChannel.channel
          .smsSend(phone: AppManager.getInstance<AppUser>().phone!)
          .then((value) => value.finalize(
              wrapper: WrapperModel(),
              failure: (e) => showToast(e),
              success: (data) {
                if (data != null) {
                  state.codes = data;
                }
              }));
    }
  }

  void startCountdownTimer() {
    state.timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (state.countdownTime < 1) {
        state.text = "点击发送";
        timerCancel();
      } else {
        state.countdownTime = state.countdownTime - 1;
        state.text = "${state.countdownTime}S";
      }
      update();
    });
  }

  ///取消倒计时
  timerCancel() {
    if (state.timer != null) {
      state.timer!.cancel();
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    timerCancel();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (AppCacheManager.cache.getisGuest() == true) {
      //游客
      showToast("您还是游客,请先认证手机号!");
    }
  }
}
