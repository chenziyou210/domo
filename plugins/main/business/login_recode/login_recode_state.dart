import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/manager/app_manager.dart';
import 'package:video_player/video_player.dart';

import '../../pages/choose_area_code/area_code_model.dart';

const String GetCode = "点击获取";

class Login_recodeState {
  Login_recodeState() {
    ///Initialize variables
  }

  //验证码倒计时
  Timer? timer;
  RxBool canLogin = false.obs;
  RxInt countdown = 60.obs;
  //视频
  late VideoPlayerController videoController;

  // 账号
  final TextEditingController accountEditing = TextEditingController();
  final FocusNode accountNode = FocusNode();

  // 验证码
  final TextEditingController verifyCodeEditing = TextEditingController();
  final FocusNode verifyCodeNode = FocusNode();

  //是否切换账号点击跳转
  late bool isChangeAccount = false;

  /*============    区域选择   ============   */
  late Rx<AreaCodeModel> areaModel = AreaCodeModel(name: "中国", tel: "86").obs;

  /* ===========   状态设置 ============ */

  setCanLogin(bool value) => canLogin.value = value;

  // 默认样式
  final TextStyle hintStyle = TextStyle(
      fontSize: 16.sp, fontWeight: w_400, color: AppMainColors.whiteColor40);

  // 点击样式
  final TextStyle textStyle = TextStyle(
      fontSize: 16.sp, fontWeight: w_400, color: AppMainColors.whiteColor100);

   //倒计时字段
   String countDownString(){
     var key = "";
     if (countdown.value == 60){
       key = GetCode;
     }else{
       key = "${countdown.value}s";
     }
     return key;
   }

   Color countDownBgColor(){
     var key = AppMainColors.mainColor20;
     if (countDownString() == GetCode){
       key = AppMainColors.mainColor20;
     }else{
       key = AppMainColors.whiteColor20;
     }
     return key;
   }

  Color countDownTextColor(){
    var key = AppMainColors.mainColor;
    if (countDownString() == GetCode){
      key = AppMainColors.mainColor;
    }else{
      key = AppMainColors.whiteColor100;
    }
    return key;
  }

  bool isBindPhone(){
    var key = AppManager.getInstance<AppUser>().phone ?? "";
    bool isBind = key.length  > 0;
    return isBind;
  }

}
