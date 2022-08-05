import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_mqtt/mqtt_manager.dart';
import 'package:get/get.dart';
import 'package:hjnzb/pages/my_mine/mine_phone_approve/mine_phone_approve_view.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/common_widget/app_dialog.dart';
import 'package:star_common/common/storage.dart';
import 'package:star_common/http/cache.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/manager/app_manager.dart';
import 'package:im_flutter_sdk/im_flutter_sdk.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:star_common/router/router_config.dart';

import 'my_mine_aboutus/my_mine_aboutus_view.dart';
import 'my_mine_pament_password/my_mine_pament_password_view.dart';
import 'my_mine_setting_state.dart';
import 'my_mine_stealth/my_mine_stealth_view.dart';

/// @description:
/// @author
/// @date: 2022-05-25 11:30:29
class MyMineSettingLogic extends GetxController {
  final state = MyMineSettingState();

  void loginOut(BuildContext context,{bool? isChangeLogin}) {
    // try {
    //   // true: 是否解除deviceToken绑定。
    //   EMClient.getInstance.logout(true);
    // } on EMError catch (e) {
    //   print('操作失败，原因是: $e');
    // }
    // HttpChannel.channel.logOut();
    // EventBus.instance.removeAllListener();
    // AppManager.getInstance<AppUser>().logOut();
    // StorageService.to.setString("token", "");
    Get.toNamed(AppRoutes.logInNew,arguments:isChangeLogin);
    MqttManager.instance.disConnect();
  }

  void tokenLoginOut(BuildContext context) {
    try {
      // true: 是否解除deviceToken绑定。
      EMClient.getInstance.logout(true);
    } on EMError catch (e) {
      print('操作失败，原因是: $e');
    }
    MqttManager.instance.disConnect();
    EventBus.instance.removeAllListener();
    AppManager.getInstance<AppUser>().logOut();
    Get.toNamed(AppRoutes.logInNew);
  }

  void gotoChangePassword(BuildContext context) {
    if ((AppManager.getInstance<AppUser>().phone ?? "").isEmpty) {
      showDialog();
    } else {
      Get.to(() => MyMinePamentPasswordPage());
    }
  }

  showDialog() {
    Get.dialog(AppDialog(
      Text("设置支付密码需进行手机号认证,是否进行认证?",
          style: TextStyle(color: AppMainColors.whiteColor70, fontSize: 14)),
      cancelText: "取消",
      confirmText: "立即认证",
      confirm: () {
        Get.back();
        Get.to(() => MinePhoneApprovePage());
      },
    ));
  }
  
  String title() {
    if (AppManager.getInstance<AppUser>().withdrawPasswordFlag == 0) {
      return "立即设置";
    } else {
      return "修改密码";
    }
  }

  void gotoStealth(BuildContext context) {
    Get.to(() => MyMineStealthPage());
  }

  setisLockOpen(bool bool) {
    AppCacheManager.cache.setisLockOpen(bool);
  }

  setisGiftOpen(bool bool) {
    AppCacheManager.cache.setisGiftOpen(bool);
  }

  setisDriveOpen(bool bool) {
    AppCacheManager.cache.setisDriveOpen(bool);
  }

  void gotoAbouts(BuildContext context) {
    print('object');
    Get.to(() => MyMineAboutusPage());
  }

  void getPackageInfo() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      //APP名称
      // String appName = packageInfo.appName;
      //包名
      // String packageName = packageInfo.packageName;
      //版本名
      String version = packageInfo.version;
      //版本号
      // String buildNumber = packageInfo.buildNumber;
      state.version = version;
      update();
    });
  }
}
