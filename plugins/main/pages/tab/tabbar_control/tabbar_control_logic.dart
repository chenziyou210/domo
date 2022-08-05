import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mqtt/mqtt_manager.dart';
import 'package:flutter_mqtt/status/system.dart';
import 'package:flutter_mqtt/status/user.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:star_common/http/config.dart';
import 'package:star_common/http/domain_manager.dart';
import 'package:star_common/manager/app_manager.dart';
import 'package:star_common/manager/user/user_balance_logic.dart';
import 'package:star_common/manager/user/user_info.dart';
import 'package:star_live/pages/dialog/app_upgrade_dialog.dart';
import 'package:star_live/pages/live_room/live_room_new_logic.dart';

import '../../../business/homepage/home_list_views/homepage_logic.dart';
import '../../../business/homepage/models/homepage_model.dart';
import '../../message/message_logic.dart';
import 'tabbar_control_state.dart';

class TabbarControlLogic extends GetxController {
  final TabbarControlState state = TabbarControlState();

  final SystemStatus systemStatus =
      MqttManager.instance.getStatus<SystemStatus>()!;
  final UserStatus userStatus = MqttManager.instance.getStatus<UserStatus>()!;

  toggleBottomType(int index) {
    state.tabIndex = index;
    state.pageController.jumpToPage(index);
    update();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    addSystemMsgListener();
    addUserMsgListener();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    removeSystemMsgListener();
    removeUserMsgListener();
  }


//=========================
  /// 系统消息-有新公告
  void EventRefreshMsg(dynamic payload) {
    print("MqttManager payload::: $payload");
    final messageLogic = Get.find<MessageLogic>();
    messageLogic.loadMessageUnreadNum();
    messageLogic.loadMessageSystemList();
    // imModel.setJoinMessage(payload);
  }


  /// 系统消息-中奖公告
  void winningNoticeMsg(dynamic payload) {
    print("MqttManager payload111111::: $payload");

    var bool = Get.isRegistered<LiveRoomNewLogic>();
    if (bool) {
      final liveRoomLogic = Get.find<LiveRoomNewLogic>();
      liveRoomLogic.winningNoticeMsg(payload);
    }

  }

  // /// 系统消息-主播排行榜变动
  // void EventAnchorRankChange(dynamic payload) {
  //   print("MqttManager payload::: $payload");
  //   HomeRankingInfo data = new HomeRankingInfo();
  //   data.userId = payload["uId"];
  //   data.username = payload["uName"];
  //   data.heat = payload["heat"];
  //   if (Get.isRegistered<HomepageLogic>()) {
  //     final logic = Get.find<HomepageLogic>();
  //     logic.updateHomeRank(data);
  //   }
  // }

  ///监听系统消息
  void addSystemMsgListener() {
    systemStatus.subLiveStream();
    systemStatus.subLiveMerchantStream(mqttChannelNo);
    systemStatus.setListener(EventRefreshMsg, SystemKey.announce);
     systemStatus.setListener(winningNoticeMsg, SystemKey.surroundWatch);
  }

  ///Mqtt关闭链接
  void removeSystemMsgListener() {
    systemStatus.unsubLiveStream();
    systemStatus.unsubLiveMerchantStream(mqttChannelNo);
    systemStatus.removeListener(EventRefreshMsg, SystemKey.announce);
    systemStatus.removeListener(winningNoticeMsg, SystemKey.surroundWatch);
  }

//=========================
  //用户消息监听
  void addUserMsgListener() {
    userStatus
        .subLiveStream(AppManager.getInstance<AppUser>().userId.toString());
    userStatus.setListener(EventUserLevelChange, UserKey.rank);
    userStatus.setListener(EventUserAmountChange, UserKey.amount);
    userStatus.setListener(EventDiamondChange, UserKey.coin);
    userStatus.setListener(EventGlobalBanChange, UserKey.globalForbidChat);
    userStatus.setListener(EventMoneyChange, UserKey.newMsg);
    userStatus.setListener(EventUserLevelCarChange, UserKey.levelCar);
  }

  ///Mqtt关闭链接
  void removeUserMsgListener() {
    userStatus
        .unsubLiveStream(AppManager.getInstance<AppUser>().userId.toString());
    userStatus.removeListener(EventUserLevelChange, UserKey.rank);
    userStatus.removeListener(EventUserAmountChange, UserKey.amount);
    userStatus.removeListener(EventDiamondChange, UserKey.coin);
    userStatus.removeListener(EventGlobalBanChange, UserKey.globalForbidChat);
    userStatus.removeListener(EventMoneyChange, UserKey.newMsg);
    userStatus.removeListener(EventUserLevelCarChange, UserKey.levelCar);
  }

// 用户等级变更
  void EventUserLevelChange(dynamic payload) {
    print("MqttManager payload1111::: $payload");
    AppManager.getInstance<AppUser>().upDataRank(payload["uRank"]);
    final userInfoLogic = Get.find<UserInfoLogic>();
    userInfoLogic.updateAppUser();

    var bool = Get.isRegistered<LiveRoomNewLogic>();
    if (bool) {
      final liveRoomLogic = Get.find<LiveRoomNewLogic>();
      liveRoomLogic.leveLupgrade(payload);
    }
  }

  // 用户获得礼物座驾
  void EventUserLevelCarChange(dynamic payload) {
    print("MqttManager payload1111::: $payload");
    showUpgradeDialog(payload["carUrl"], payload["uRank"], payload["carName"],
        payload["carId"], payload["carGifUrl"]);
  }

// 用户金额余额变更
  void EventUserAmountChange(dynamic payload) {
    print("MqttManager payload::: $payload");
    Get.find<UserBalanceLonic>().userBalanceData();
  }

  // 用户钻石余额变更
  void EventDiamondChange(dynamic payload) {
    print("MqttManager payload::: $payload");
    Get.find<UserBalanceLonic>().userBalanceData();
  }

  // 用户全局禁言
  void EventGlobalBanChange(dynamic payload) {
    print("MqttManager payload::: $payload");
    bool isMute = payload["bool"];
    AppManager.getInstance<AppUser>().upDataMute(isMute ? 1 : 0);
  }

// 用户充值/提现消息
  void EventMoneyChange(dynamic payload) {
    print("MqttManager payload::: $payload");
    Get.find<UserBalanceLonic>().userBalanceData();
  }

  void showUpgradeDialog(
      String carUrl, int level, String carName, int carId, String carSvgaUrl) {
    SmartDialog.show(
      builder: (BuildContext context) {
        return AppUpGradeDialog(carUrl, level, carName, carId, carSvgaUrl);
      },
    );
  }
}
