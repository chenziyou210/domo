import 'package:alog/alog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';
import 'package:star_common/http/cache.dart';
import 'package:star_common/manager/app_manager.dart';
import 'package:star_common/common/common_widget/custom_gradientbutton/custom_gradientbutton.dart';

import 'my_mine_pament_password_logic.dart';
import 'my_mine_pament_password_state.dart';

/// @description:
/// @author
/// @date: 2022-06-02 12:37:31
class MyMinePamentPasswordPage extends StatelessWidget {
  final MyMinePamentPasswordLogic logic = Get.put(MyMinePamentPasswordLogic());
  final MyMinePamentPasswordState state =
      Get.find<MyMinePamentPasswordLogic>().state;

  MyMinePamentPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        centerTitle: true,
        title: Text(
          state.flag == 0 ? '设置支付密码' : '修改支付密码',
          style: TextStyle(color: Colors.white, fontSize: 18.sp),
        ),
      ),
      body: SafeArea(
        child: GetBuilder<MyMinePamentPasswordLogic>(
          init: logic,
          global: false,
          builder: (controller) {
            return _body(context);
          },
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 44.dp,
          color: Color.fromRGBO(255, 255, 255, 0.06),
          child: Row(
            children: [
              Text(
                "您已经绑定了手机号",
                style: TextStyle(color: AppMainColors.adornColor, fontSize: 14.sp),
              ),
              Spacer(),
              Text(
                AppManager.getInstance<AppUser>().phone!,
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.7), fontSize: 14.sp),
              )
            ],
          ).marginOnly(left: 16.dp, right: 16.dp),
        ),
        _item("验证码", "请输入验证码", false, state.codeController, 6, obscureText: false),
        _item("支付密码", "请输入6位纯数字密码", true, state.pas1controller, 6),
        _item("确认密码", "请再次输入密码", true, state.pas2controller, 6),
        _but(context),
      ],
    );
  }

  /// lenght 输入框位数
  Widget _item(String name, String hide, bool isHide,
      TextEditingController controller, int lenght, {obscureText = true}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.dp),
      height: 55.dp,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                name,
                style: TextStyle(color: AppMainColors.whiteColor100, fontSize: 16.sp),
              ),
              SizedBox(
                width: 18.dp,
              ),
              Expanded(
                child: TextField(
                  obscuringCharacter: '*',
                  obscureText: obscureText,
                  onChanged: ((value) {
                    logic.getColroState();
                  }),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(lenght),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  controller: controller,
                  style: TextStyle(
                      color: AppMainColors.whiteColor100, fontSize: 16.sp),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hide,
                      hintStyle: TextStyle(color: AppMainColors.whiteColor20)),
                ),
              ),
              Offstage(
                offstage: isHide,
                child: Container(
                  alignment: Alignment(0, 0),
                  width: 72.dp,
                  height: 32.dp,
                  child: Text(
                    logic.state.text,
                    style: TextStyle(
                        color: state.countdownTime == 0
                            ? AppMainColors.mainColor
                            : Colors.white,
                        fontSize: 12.sp),
                  ),
                  decoration: BoxDecoration(
                      color: state.countdownTime == 0
                          ? Color.fromRGBO(255, 30, 175, 0.2)
                          : Color.fromRGBO(255, 255, 255, 0.2),
                      borderRadius: BorderRadius.all(Radius.circular(16.dp))),
                ).gestureDetector(onTap: () {
                  logic.countdownTap();
                }),
              )
            ],
          ).expanded(),
          Container(
            width: double.infinity,
            height: 1.dp,
            color: AppMainColors.whiteColor6,
          ),
        ],
      ),
    );
  }

  Widget _but(BuildContext context) {
    return Container(
      height: 40.dp,
      margin:
          EdgeInsets.only(left: 18.dp, right: 18.dp, top: 42.dp, bottom: 8.dp),
      width: double.infinity,
      child: GradientButton(
        allowTap: state.show,
        child: Text(
          '确认',
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
        onPressed: () {
          if (state.show) logic.requestChangePasswod(context);
        },
      ),
    );
  }
}
