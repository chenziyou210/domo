import 'package:alog/alog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/util_tool/color_tool.dart';
import 'package:pinput/pinput.dart';

import 'pay_password_logic.dart';
import 'pay_password_state.dart';

/// @description:
/// @author
/// @date: 2022-06-17 18:28:35
/// 支付密码
class PayPasswordPage extends StatelessWidget {
  final PayPasswordLogic logic = Get.put(PayPasswordLogic());
  final PayPasswordState state = Get.find<PayPasswordLogic>().state;

  PayPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(state.focusNode);
    return GetBuilder(
        init: logic,
        global: false,
        builder: (c) {
          return Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  height: 250,
                ),
                conten(context),
              ],
            ),
          );
        });
  }

  Widget conten(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(16.dp),
        padding: EdgeInsets.all(16.dp),
        decoration: BoxDecoration(
          color: AppMainColors.string2Color("2A4155"),
          border: Border.all(color: AppMainColors.whiteColor15),
          borderRadius: BorderRadius.circular(12.dp),
        ),
        height: 198.dp,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                "请输入您的支付密码",
                style: TextStyle(
                    color: AppMainColors.whiteColor100,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                payPwd(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buts("取消").inkWell(onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  Get.back();
                }),
                Spacer(),
                _buts("确定").inkWell(onTap: () {
                  if (logic.state.pinController.text.length == 6) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    Get.back(result: logic.state.pinController.text);
                  } else {
                    logic.toast("请输入6位密码");
                  }
                }),
              ],
            ),
          ],
        ));
  }

  Widget payPwd() {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Pinput(
          length: 6,
          obscuringCharacter: "●",
          obscureText: true,
          closeKeyboardWhenCompleted: false,
          controller: logic.state.pinController,
          focusNode: logic.state.focusNode,
          defaultPinTheme: logic.state.defaultPinTheme,
          focusedPinTheme: logic.state.defaultPinTheme.copyWith(
              textStyle: TextStyle(
                  color: Color.fromRGBO(50, 197, 255, 1), fontSize: 15.sp),
              //输入时的效果
              decoration: logic.state.defaultPinTheme.decoration!.copyWith(
                border: Border.all(color: Color.fromRGBO(50, 197, 255, 1)),
              )),
          submittedPinTheme: logic.state.defaultPinTheme.copyWith(
              textStyle: TextStyle(
                  color: Color.fromRGBO(50, 197, 255, 1), fontSize: 15.sp),
              //输出时的效果
              decoration: logic.state.defaultPinTheme.decoration!.copyWith(
                border: Border.all(color: Color.fromRGBO(50, 197, 255, 1)),
              )),
          onCompleted: (value) {
            //输入完成
            Get.back(result: value);
          },
        ));
  }

  Widget _buts(String value) {
    return Container(
      height: 40.dp,
      width: 130.dp,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: value == "取消"
            ? AppMainColors.whiteColor20
            : AppMainColors.string2Color("FF1EAF"),
        borderRadius: BorderRadius.circular(25.dp),
      ),
      child: Text(
        value,
        style: TextStyle(color: Colors.white, fontSize: 16.sp),
      ),
    );
  }

  static show(Function(dynamic) onValue) {
    Get.bottomSheet(PayPasswordPage(),
            barrierColor: Colors.transparent, isScrollControlled: true)
        .then((value) {
      if (value != null) {
        onValue(value);
      }
    });
  }
}
