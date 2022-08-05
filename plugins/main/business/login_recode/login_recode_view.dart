import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:video_player/video_player.dart';
import 'login_recode_logic.dart';

class Login_recodePage extends StatelessWidget {
  final logic = Get.put(Login_recodeLogic());
  final state = Get.find<Login_recodeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        //视频
        // Positioned.fill(child: VideoPlayer(state.videoController)),
        //背景层
        Container(color: Colors.black.withOpacity(0.6)),
        //内容主体
        Container(
          margin: EdgeInsets.symmetric(horizontal: 32.dp),
          // color: Colors.blueGrey,
          child: Stack(
            children: [
              //此层用作点击键盘整体上移 包括按钮 配UI需求
              Scaffold(
                backgroundColor: Colors.transparent,
                resizeToAvoidBottomInset: true,
                body: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //返回箭头
                        state.isChangeAccount == true
                            ? GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => Get.back(),
                            child: Image.asset(R.backIconWhite, width: 20.dp,
                              height: 20.dp,
                              fit: BoxFit.cover,)

                        ).paddingOnly(top: 56.dp)
                            : SizedBox(),
                        //间距
                        SizedBox(
                            height: state.isChangeAccount == true ? 50.dp : 125
                                .dp),
                        //标题
                        CustomText(
                          state.isChangeAccount == true ? "切换账号" : "欢迎登录",
                          style: TextStyle(fontWeight: w_600,
                              fontSize: 24.sp,
                              color: Colors.white),
                        ),
                        //间距
                        SizedBox(height: 60.dp),
                        ItemView(
                          leftWidget: CustomText(
                            "国家与地区",
                            style: TextStyle(
                                fontWeight: w_400,
                                fontSize: 16.dp,
                                color: Colors.white),
                          ),
                          rightWidget: Obx(() {
                            return RichText(
                                text: TextSpan(
                                  //区号
                                    text: "（+${state.areaModel.value.tel}）",
                                    style: TextStyle(
                                        fontWeight: w_400,
                                        fontSize: 16.dp,
                                        color: Colors.white),
                                    children: [
                                      //国家
                                      TextSpan(text: "${state.areaModel.value
                                          .name} ",),
                                      //箭头
                                      WidgetSpan(child: Image.asset(
                                        R.comArrowRight,
                                        width: 16.dp, height: 16.dp,
                                        fit: BoxFit.cover,
                                      ))
                                    ])
                            );
                          }),
                        ).inkWell(onTap: () {
                          //国家地区值变更
                          logic.pushToAearPage();
                        }),
                        //账号
                        ItemView(
                          showTextField: true,
                          hitText: intl.pleaseEnterPhoneNumber,
                          editingController: state.accountEditing,
                          focusNode: state.accountNode,
                          prefixIcon: Image.asset(R.loginPhone),

                        ),
                        //密码
                        ItemView(
                            showTextField: true,
                            hitText: intl.pleaseEnterVerificationCode,
                            editingController: state.verifyCodeEditing,
                            focusNode: state.verifyCodeNode,
                            prefixIcon: Image.asset(R.loginCode),
                            //验证码获取
                            rightWidget: Obx(() {
                              return Container(
                                width: 72.dp,
                                height: 32.dp,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: state.countDownBgColor(),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(16.dp))
                                ),
                                child: CustomText(
                                  state.countDownString(),
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: state.countDownTextColor(),
                                      fontWeight: w_400),
                                ).inkWell(onTap: () {
                                  //倒计时
                                  logic.smsSendRequest();
                                }),
                              );
                            })
                        ),
                        //间距
                        SizedBox(height: 48.dp),
                        //登录按钮
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //绑定过手机的话 不展示游客登录
                            state.isBindPhone() == false
                                ? Container(
                              height: 40.dp,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.dp),
                                color: AppMainColors.adornColor.withOpacity(
                                    0.2),
                                border: Border.all(
                                    color: AppMainColors.adornColor),
                              ),
                              child: CustomText(intl.guestLogin,
                                  fontSize: 16.sp,
                                  fontWeight: w_400,
                                  color: AppMainColors.adornColor),
                            ).inkWell(onTap: () async {
                              //游客登录
                              logic.loginMethWithType(0);

                            }).expanded()
                                : SizedBox(),
                            //间距
                            SizedBox(width: state.isBindPhone() ? 0 : 25.dp),

                            Obx(() {
                              return Container(
                                height: 40.dp,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.dp),
                                    gradient: LinearGradient(
                                        colors: state.canLogin.value
                                            ? AppMainColors.commonBtnGradient
                                            : AppMainColors
                                            .commonInactiveGradient)),
                                child: CustomText(intl.logIn,
                                    fontSize: 16.sp,
                                    fontWeight: w_400,
                                    color: Colors.white),
                              );
                            }).inkWell(onTap: () {
                              //账号登录
                              logic.loginMethWithType(1);

                            }).expanded()
                          ],
                        )

                      ],
                    )
                ),
              ),

            ],
          ),
        ),

      ],
    );
  }
}

Widget ItemView({
  Widget? leftWidget,
  Widget? rightWidget,
  Widget? prefixIcon,
  bool? showTextField,
  TextEditingController? editingController,
  FocusNode? focusNode,
  String? hitText,
}) {
  final state = Get
      .find<Login_recodeLogic>()
      .state;

  return SizedBox(
    height: 55.dp,
    child: Stack(
      alignment: Alignment.centerLeft,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          //交叉轴的布局方式，对于column来说就是水平方向的布局方式
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leftWidget ?? SizedBox(),

            showTextField == true
                ? CustomTextField(
              iconMaxHeight: 24.dp,
              iconMaxWidth: 24.dp,
              keyboardType: TextInputType.phone,
              contentPadding: EdgeInsets.symmetric(vertical: 16.dp),
              controller: editingController ?? TextEditingController(),
              node: focusNode ?? FocusNode(),
              inputFormatter: [FilteringTextInputFormatter.digitsOnly],
              hintText: hitText ?? "",
              hintTextStyle: state.hintStyle,
              style: state.textStyle,
              prefixIcon: prefixIcon ?? SizedBox(),
              fillColor: Colors.white,
              textAlignVertical: TextAlignVertical.top,
            ).sampleVisibleEnsure(state.verifyCodeNode).expanded()
                : SizedBox(),
            //间距
            SizedBox(width: 10),
            rightWidget ?? SizedBox(),

          ],
        ),
        CustomDivider(color: AppMainColors.separaLineColor6).position(
            bottom: 0, left: 0, right: 0),
      ],
    ),
  );
}
