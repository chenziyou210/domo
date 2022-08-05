/*
 *  Copyright (C), 2015-2021
 *  FileName: register_new_logic
 *  Author: Tonight丶相拥
 *  Date: 2021/12/6
 *  Description: 
 **/

import 'package:get/get.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:uuid/uuid.dart';

class RegisterNewLogic extends GetxController with Toast {
  final _RegisterNewState state = _RegisterNewState();

  /// 密码可见不可见
  void toggleSecurityLock() {
    state._toggleSecurityLock();
  }

  /// 设置UID
  void setUid(String uid) {
    state._setUid(uid);
  }

  /// 发送验证码
  void sendCode({required String account, required String verifyCode}) {
    show();
    HttpChannel.channel
        .securityCodeImage(
            account: account, uid: state._uid, verifyCode: verifyCode)
        .then((value) => value.finalize(
            wrapper: WrapperModel(),
            failure: (e) => showToast(e),
            success: (_) {
              dismiss();
            }));
  }

  /// 注册
  Future<bool> register(
      {required String account,
      required String password,
      required String rePassword,
      required String verifyCode}) async {
    show();
    var result = await HttpChannel.channel
        .register(
            account: account,
            password: password,
            rePassword: rePassword,
            code: verifyCode,
            deviceCode: "")
        .then((value) => value.finalize<WrapperModel>(
            wrapper: WrapperModel(),
            failure: (e) => showToast(e),
            success: (_) {
              dismiss();
            }));

    return result.isSuccess;
  }
}

class _RegisterNewState {
  /// 是否显示
  RxBool _isShow = true.obs;
  RxBool get isShow => _isShow;

  /// 请求图片使用的UID
  String _uid = "";

  /// 显示、影藏
  void _toggleSecurityLock() {
    _isShow.value = !_isShow.value;
  }

  /// 设置UID
  void _setUid(String uid) {
    var result = Uuid.isValidUUID(fromString: uid);
    if (result) _uid = uid;
  }
}
