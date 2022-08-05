import 'dart:async';
import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mqtt/mqtt_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:im_flutter_sdk/im_flutter_sdk.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/storage.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/generated/banner_entity.dart';
import 'package:star_common/http/cache.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/manager/app_manager.dart';
import 'package:star_common/manager/user/user_info.dart';
import 'package:star_common/router/router_config.dart';
import 'package:video_player/video_player.dart';
import '../../pages/choose_area_code/area_code_model.dart';
import '../../pages/message/message_logic.dart';
import '../../pages/tab/tabbar_control/tabbar_control_logic.dart';
import '../homepage/home_list_views/homepage_logic.dart';
import '../homepage/live_mainview/live_mainview_logic.dart';
import 'login_recode_state.dart';
import 'dart:io';
import 'package:hjnzb/pages/message/message_logic.dart';
import '../../business/homepage/home_list_views/homepage_logic.dart';

class Login_recodeLogic extends GetxController with Toast{
  final Login_recodeState state = Login_recodeState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //获取get传值
    state.isChangeAccount = Get.arguments ?? false;

    print("是否切换跳入 ： ${state.isChangeAccount}");

    //播放初始化
    // state.videoController = VideoPlayerController.asset(R.assetsVideoLogInVideo)..initialize();
    // state.videoController.play();
    // state.videoController.setLooping(true);

    state.accountEditing.addListener(() {
      checkCanLogin();
    });
    state.verifyCodeEditing.addListener(() {
      checkCanLogin();
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

    state.videoController.pause();
    state.videoController.dispose();

    state.accountEditing.dispose();
    state.verifyCodeEditing.dispose();

    timeCancel();
  }


  ///*======  逻辑处理   ========*/
  // 停止计时
  timeCancel() {
    if (state.timer != null) {
      state.timer!.cancel();
      state.timer = null;
    }
  }

  //登录按钮高亮
  checkCanLogin() {
    if (state.accountEditing.text.trim().isNotEmpty &&
        state.verifyCodeEditing.text.trim().isNotEmpty)
      return state.setCanLogin(true);
    else
      return state.setCanLogin(false);
  }

  //倒计时
  startCountdownTimer() {
    state.timer = Timer.periodic(Duration(seconds: 1), (timer) {
      state.countdown.value --;
      if(state.countdown.value < 0){
        state.countdown.value = 60;
        timeCancel();
      }
      print("计数  ${timer.tick}");
    });
  }

  Future<String> deviceDetails() async {
    final storage = new FlutterSecureStorage();
    String? identifier = await storage.read(key: "deviceIdentifier");
    if (identifier?.isEmpty ?? true) {
      identifier = generateRandomString(16);
      final DeviceInfoPlugin deviceInfoPlugin =  DeviceInfoPlugin();
      try {
        if (Platform.isAndroid) {
          var build = await deviceInfoPlugin.androidInfo;
          if (build.androidId?.isNotEmpty ?? false) {
            identifier = build.androidId ?? '';
          }
          //UUID for Android
        } else if (Platform.isIOS) {
          var data = await deviceInfoPlugin.iosInfo;
          if (data.identifierForVendor?.isNotEmpty ?? false) {
            identifier = data.identifierForVendor ?? '';
          }
        }
      } on PlatformException {
        print('Failed to get platform version');
      }
      // Create storage
      if (identifier?.isNotEmpty ?? false) {
        // Put value
        await storage.write(key: "deviceIdentifier", value: identifier);
      }
    }
    return identifier!;
  }

  String generateRandomString(int length) {
    final _random = Random();
    const _availableChars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final randomString = List.generate(length,
            (index) => _availableChars[_random.nextInt(_availableChars.length)])
        .join();
    return randomString;
  }

  //取消绑定Mqtt
   userInfoUnbind() {
    AppManager.getInstance<AppUser>().logOut();
    try {
      // true: 是否解除deviceToken绑定。
      EMClient.getInstance.logout(true);
    } on EMError catch (e) {
      // print('操作失败，原因是: $e');
    }
    // await trtcLogOut();
    // await trtcVoiceRoomLogOut();
    final logic = Get.isRegistered<TabbarControlLogic>();
    if (logic) {
      Get.find<TabbarControlLogic>().removeSystemMsgListener();
      Get.find<TabbarControlLogic>().removeUserMsgListener();
    }
  }

  //重新绑定Mqtt
   userInfoBind(AppUser user) {
    Get.find<UserInfoLogic>().updateAppUser(user: user);
    MqttManager.instance.connect(
        AppManager.getInstance<GlobalSettingModel>().viewModel.mqtt_ip,
        user.userId);
    final logic = Get.isRegistered<TabbarControlLogic>();
    if (logic) {
      Get.find<TabbarControlLogic>().addSystemMsgListener();
      Get.find<TabbarControlLogic>().addUserMsgListener();
    }
  }

   userInfoReport() {
    HttpChannel.channel.userInfoReport();
  }

   setLoginSuccessInfo(Map<String,dynamic> data){
     userInfoUnbind();
     userInfoReport();
     StorageService.to.setString("token", data["token"]);
     AppCacheManager.cache.setisGuest(true);
     var user = AppManager.getInstance<AppUser>();
     user.fromJson(data, false);
     userInfoBind(user);
     dismiss();
   }

   /*========= 跳转 ============*/

  pushToAearPage(){
    Get.toNamed(AppRoutes.CityListPage)?.then((value) => {
      if(value != null && value is AreaCodeModel ){
        state.areaModel.value = value
      }

    });
  }

  loginOrOutSetting() async {
    if (Get.isRegistered<MessageLogic>()) {
      final messageLogic = Get.find<MessageLogic>();
      messageLogic.loadMessageUnreadNum();
    }

    final tabLogic = Get.isRegistered<TabbarControlLogic>();
    if (tabLogic) {
      Get.find<TabbarControlLogic>().addSystemMsgListener();
      Get.find<TabbarControlLogic>().addUserMsgListener();
    }

    var result = await HttpChannel.channel
        .homeBanner(1)
        .then((value) => value.finalize<WrapperModel>(wrapper: WrapperModel()));
    List lst = result.object ?? [];
    lst = lst.map((e) => BannerEntity.fromJson(e)).toList();
    if (lst.length > 0) {
      StorageService.to.setString("homeBanner", lst[0].pic!);
    }

    if (Get.isRegistered<MessageLogic>()) {
      Get.find<MessageLogic>().loadMessageUnreadNum();
    }

    if(Get.isRegistered<LiveMainViewPageLogic>()){
      final mainViewLogic  = Get.find<LiveMainViewPageLogic>();
      //清空存储的首页列表项
      mainViewLogic.state.listMap = {};
    }
    final pageLogic = Get.find<HomepageLogic>();
    //清空列表数据匹配项
    pageLogic.state.homeListMap = {};
    //整体重新push 移除之前所有
    Get.offAllNamed(AppRoutes.tab);

  }


///*===========  请求  ===========*/
  //获取验证码
   smsSendRequest() {
    String phone = state.accountEditing.text.replaceAll(" ", "");
    //正在读秒不进行发送
     if (state.countDownString() == GetCode){
       show();
       HttpChannel.channel.smsSend(
           phone: phone,
           countryCode: state.areaModel.value.tel
       ).then((value) {
         dismiss();
         value.finalize(
             wrapper: WrapperModel(),
             failure: (e) => showToast(e),
             success: (data) {
               //开始倒计时
               startCountdownTimer();

             });
       });
     }
  }

  /// tapIndex
  /// 0. 游客登录 1,账号登录
  loginMethWithType(int tapIndex) async {
    late var value;
    switch (tapIndex){
      case 0: value = await guestLoginRequest(); break;
      case 1: {
        if(state.canLogin.value){
          value = await logInRequest();
        }
      }  break;
    }
    if(value){
      loginOrOutSetting();
    }
  }

  //游客登录
  Future<bool> guestLoginRequest() async {
    Completer<bool> completer = Completer();
    show();
    String identification = await deviceDetails();
    HttpChannel.channel
        .guestlogin(identification)
        .then((value) => value.finalize(
        wrapper: WrapperModel(),
        failure: (e) {
          showToast(e);
          completer.complete(false);
        },
        success: (data) {
          print("登录数据 ： $data");
          setLoginSuccessInfo(data);
          completer.complete(true);
          // dismiss();
          // StorageService.to.setString("token", data["token"]);
          // AppCacheManager.cache.setisGuest(true);
          // userInfoReport();
          // var user = AppManager.getInstance<AppUser>();
          // user.fromJson(data, false);
          // MqttManager.instance.connect(
          //     AppManager.getInstance<GlobalSettingModel>()
          //         .viewModel
          //         .mqtt_ip,
          //     user.userId);
          // Get.find<UserInfoLogic>().updateAppUser(user: user);
          // completer.complete(true);
        }));
    return completer.future;
  }

  //账号登录
  Future<bool> logInRequest(){

    String account = state.accountEditing.text.replaceAll(" ", "");
    String code = state.verifyCodeEditing.text.replaceAll(" ", "");
    int device = Platform.isIOS ? 1 : 0;
    String type = ""; //firebase注册令牌 目前传空

    Completer<bool> completer = Completer();
    show();
    HttpChannel.channel.logIn(
      account,
      code,
      device,
      type: type,
    ).then((value) => value.finalize(
        wrapper: WrapperModel(),
        failure: (e) {
          showToast(e);
          completer.complete(false);
        },
        success: (data) {
          print("登录数据 ： $data");
          setLoginSuccessInfo(data);
          completer.complete(true);
        }));
    return completer.future;
  }

}

