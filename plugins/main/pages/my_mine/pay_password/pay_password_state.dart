import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:star_common/common/app_common_widget.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';

/// @description:
/// @author
/// @date: 2022-06-17 18:28:35
class PayPasswordState {
  // PayPasswordState() {
  //   ///Initialize variables
  // }
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final defaultPinTheme = PinTheme(
      width: 40,
      height: 40,
      textStyle: TextStyle(color: Colors.white, fontSize: 20.sp),
      decoration: BoxDecoration(
        color: AppMainColors.whiteColor6,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppMainColors.whiteColor10),
      ));
}
