import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/cache.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/manager/app_manager.dart';
import 'package:star_common/manager/user/user_info.dart';
import 'package:star_common/router/router_config.dart';
import '../../choose_area_code/area_code_model.dart';
import 'mine_phone_approve_state.dart';

class MinePhoneApproveLogic extends GetxController with Toast {
  final MinePhoneApproveState state = MinePhoneApproveState();
  late Timer _timer;

  void codeEvent() {
    final phoneText = state.phoneTEC.text;
    if (phoneText.isEmpty) {
      showToast("请输入手机号");
      return;
    }
    int count = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      count = count - 1;
      state.codeText.value = '$count S';
      state.codeStatus.value = false;
      if (count <= 0) {
        state.codeText.value = '点击发送';
        state.codeStatus.value = true;
        timer.cancel();
      }
    });
    _smsSend();
  }

  void approveEvent(BuildContext context) {

    final phoneText = state.phoneTEC.text;
    final codeText = state.codeTEC.text;
    if (phoneText.isEmpty) {
      showToast("请输入手机号");
      return;
    }
    if (codeText.isEmpty) {
      showToast("请输入验证码");
      return;
    }
    _bindPhone(context);
  }

  void updateApproveStatus() {
    if (state.phoneTEC.text.isNotEmpty && state.codeTEC.text.isNotEmpty) {
      state.approveStatus.value = true;
    } else {
      state.approveStatus.value = false;
    }
  }

  void pushCityListPage(context) {
    // Navigator.of(context).pushNamed(AppRoutes.CityListPage).then((value) => {
    //   if (value != null && value is AreaCodeModel)
    //     {state.area.value = value}
    // });
    Get.toNamed(AppRoutes.CityListPage)?.then((value) => {
      if (value != null && value is AreaCodeModel)
        {state.area.value = value}
    });
  }

  void _smsSend() {
    show();
    HttpChannel.channel.smsSend(phone: state.phoneTEC.text, countryCode: state.area.value.tel).then((value) {
      dismiss();
      value.finalize(
          wrapper: WrapperModel(),
          failure: (e) => showToast(e),
          success: (data) {
            /// 方便测试暂时添加
            // showToast('验证码:${data['code']}');
          });
    });
  }

  void _bindPhone(BuildContext context) {
    final phone = state.phoneTEC.text;
    final verifyCode = state.codeTEC.text;
    show();
    HttpChannel.channel
        .bindPhone(phone: phone, verifyCode: verifyCode)
        .then((value) {
      dismiss();
      value.finalize(
          wrapper: WrapperModel(),
          failure: (e) => showToast(e),
          success: (data) {
            showToast('认证成功');
            state.phone.value = phone;
            state.phoneTEC.text = '';
            state.codeTEC.text = '';
            AppCacheManager.cache.setisGuest(false);
            AppManager.getInstance<AppUser>().userUpdatePhone(phone);
            Get.find<UserInfoLogic>().updateAppUser();
            Future.delayed(Duration(milliseconds: 500), () {
              dismiss();
              Get.back();
            });
          });
    });
  }

  void pushBindPhone(BuildContext context) {
    Get.toNamed(AppRoutes.minePhoneBindPage);
  }
}
