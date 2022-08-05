import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/toast.dart';

import 'pay_password_state.dart';

/// @description:
/// @author
/// @date: 2022-06-17 18:28:35
class PayPasswordLogic extends GetxController with Toast {
  final state = PayPasswordState();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  toast(String text) {
    showToast(text);
  }
}
