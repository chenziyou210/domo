/*
 *  Copyright (C), 2015-2021
 *  FileName: live_room_new_logic
 *  Author: Tonight丶相拥
 *  Date: 2021/12/9
 *  Description:
 **/

import 'dart:async';

import 'package:event_bus/event_bus.dart' as bus;
import 'package:flutter/material.dart';
import 'package:flutter_mqtt/mqtt_manager.dart';
import 'package:flutter_mqtt/status/room.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart'
    show
        EventBus,
        IntExtension,
        enterRoomSuccess,
        freeTimeOut,
        gameTimeOut,
        liverOffline,
        verifyRoomSuccess;
import 'package:star_common/common/storage.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/generated/JoinRoomInfoEntity.dart';
import 'package:star_common/generated/LiveRoomInfoEntity.dart';
import 'package:star_common/generated/anchor_list_model_entity.dart';
import 'package:star_common/generated/gift_entity.dart';
import 'package:star_common/generated/living_audience_entity.dart';
import 'package:star_common/generated/sample_user_info_entity.dart';
import 'package:star_common/http/cache.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/manager/app_manager.dart';
import 'package:star_common/manager/user/user_balance_logic.dart';
import 'package:star_live/agora_rtc/agora_rtc.dart';
import 'package:star_live/pages/live_room/view/charge_view/first_charge.dart';
import 'package:star_live/pages/live_room/view/room_info_page/room_live_game/game_net_work.dart';
import 'package:star_live/pages/live_room/view/room_info_page/room_live_game/room_base_game/room_game_tools.dart';

import '../../common/user_info_operation.dart';
import '../live_room_preview/live_room_type.dart';
import 'live_room_chat_model.dart';
import 'live_room_enum.dart';
import 'view/room_info_page/room_live_game/room_base_game/room_base_game_logic.dart';
import 'view/room_info_page/room_live_game/room_base_game/room_base_game_state.dart';

bus.EventBus eventBus = bus.EventBus();

class LiveRoomNewLogic extends GetxController
    with Toast, WidgetsBindingObserver {
  LiveRoomNewLogic() {
    EventBus.instance.addListener(_enterRoomSuccess, name: enterRoomSuccess);
    EventBus.instance.addListener(_gameTimeOut, name: gameTimeOut);
    EventBus.instance.addListener(_liverOffline, name: liverOffline);
    WidgetsBinding.instance.addObserver(this);
  }

  Function(bool)? callShowChat;

  Function(dynamic)? callBackView;

  ///用户等级提升回调
  Function(dynamic)? danmuBackView;

  ///发送弹幕消息回调
  Function(dynamic)? gamebackBackView;

  ///游戏开奖回调
  Function(dynamic)? closeGameBackView;

  /// 主播关闭直播间，关掉所有的弹窗
  Timer? checkRechargeStatusTimer;

  bool todayHasClose = false;
  bool showPopUp = false;

  var roomStatus = MqttManager.instance.getStatus<RoomStatus>()!;

  late IMModel imModel;

  ///游戏倒计时时间
  RxInt lotteryCount = 60.obs;

  final Map gameMap = {
    1: R.gameYfk3,
    2: R.gameYflhc,
    3: R.gameYfkc,
    4: R.gameYxx,
    5: R.gameBrnn,
    6: R.gameSsc
  };

  @override
  void onInit() {
    super.onInit();
    StorageService.to.setString("giftEffect", "1");
  }

  ///游戏倒计时
  void startLotteryCountdown() {
    GameNetWork.shared.getGameTimestamp((s) {
      lotteryCount.value = 59 - s;
      lotteryTimer?.cancel();
      lotteryTimer = Timer.periodic(Duration(seconds: 1), (_) {
        if (lotteryCount.value <= 0) {
          startLotteryCountdown();
          AppCacheManager.cache.setRememberGameResult();
        }
        lotteryCount.value--;
      });
    });
  }

  ///开奖结果,游戏播报
  Widget gameResult() {
    return Obx(
          () => Offstage(
          offstage: state.isHideGameResult.value,
          child: RoomGameTools.roomGameNotification(state.gameResult.value)),
    ).marginOnly(left: 10, bottom: 50);
  }

  void setImModel(IMModel imModel) {
    this.imModel = imModel;
  }

  ///Mqtt消息处理
  void MqttMangerProcessing(String roomid) {
    roomStatus.subLiveStream(
        roomid, AppManager.getInstance<AppUser>().userId.toString());

    roomStatus.setListener(EventJoinRoom, RoomKey.joinRoom);
    roomStatus.setListener(giftMsg, RoomKey.gift);
    roomStatus.setListener(followMsg, RoomKey.follow);
    roomStatus.setListener(chargeMsg, RoomKey.charge);
    roomStatus.setListener(ForbidChatMsg, RoomKey.roomForbidChat);
    roomStatus.setListener(isAdminMsg, RoomKey.isAdmin);
    roomStatus.setListener(mirrorMsg, RoomKey.mirror);
    roomStatus.setListener(pauseMsg, RoomKey.pause);
    roomStatus.setListener(payWatchMsg, RoomKey.payWatch);
    roomStatus.setListener(EventleaveRoom, RoomKey.leaveRoom);
    roomStatus.setListener(openWatch, RoomKey.watch);
    roomStatus.setListener(LevelUp, RoomKey.rank);
    roomStatus.setListener(gameBet, RoomKey.gameBet);
    roomStatus.setListener(gameBetResult, RoomKey.gameBetResult);
    roomStatus.setListener(roomClosed, RoomKey.close);

    print("object   订阅消息");
  }

  ///Mqtt关闭链接
  void closePush(String roomid) async {
    ClearTimer();
    state.leaveChannel();
    roomStatus.unsubLiveStream(
        roomid, AppManager.getInstance<AppUser>().userId.toString());
    roomStatus.removeListener(EventJoinRoom, RoomKey.joinRoom);
    roomStatus.removeListener(giftMsg, RoomKey.gift);
    roomStatus.removeListener(followMsg, RoomKey.follow);
    roomStatus.removeListener(chargeMsg, RoomKey.charge);
    roomStatus.removeListener(ForbidChatMsg, RoomKey.roomForbidChat);
    roomStatus.removeListener(isAdminMsg, RoomKey.isAdmin);
    roomStatus.removeListener(mirrorMsg, RoomKey.mirror);
    roomStatus.removeListener(pauseMsg, RoomKey.pause);
    roomStatus.removeListener(payWatchMsg, RoomKey.payWatch);
    roomStatus.removeListener(EventleaveRoom, RoomKey.leaveRoom);
    roomStatus.removeListener(openWatch, RoomKey.watch);
    roomStatus.removeListener(gameBet, RoomKey.gameBet);
    roomStatus.removeListener(gameBetResult, RoomKey.gameBetResult);
    roomStatus.removeListener(roomClosed, RoomKey.close);
    print("object1111");

    ///有付费观看，刷新余额
    if (state.payWatchTime != 0) {
      Get.find<UserBalanceLonic>().userBalanceData();
    }
  }

  ///加入直播间
  void EventJoinRoom(dynamic payload) {
    print("MqttManager payload111::: $payload");
    state.setAudiences(state.audience.value + 1);
    imModel.setJoinMessage(payload);
    LivingAudienceEntity audienceEntity = new LivingAudienceEntity();
    audienceEntity.header = payload["uHead"];
    audienceEntity.userId = payload["uId"];
    audienceEntity.username = payload["uName"];
    audienceEntity.watchType = payload["uGuard"];
    if (payload["score"] == null) {
      audienceEntity.heat = 0;
    } else {
      audienceEntity.heat = payload["score"];
    }
    String numText =
        (DateTime.now().millisecondsSinceEpoch / 1000).toStringAsFixed(0);
    audienceEntity.joinTime = int.parse(numText);
    state.audiences.add(audienceEntity);
    state.sortAudiences();
  }

  ///赠送礼物
  void giftMsg(dynamic payload) {
    print("MqttManager payload222::: $payload");
    int heat = payload["gValue"];
    state.setFirepower(state.firepower.value + heat);
    imModel.setGiftMessage(payload);
    if (state.audiences.length > 1) {
      state.audiences.forEach((element) {
        if (element.userId.toString().trim() ==
            payload["uId"].toString().trim()) {
          element.heat = element.heat! + heat;
        }
      });
    }
    state.sortAudiences();
  }

  ///关注主播
  void followMsg(dynamic payload) {
    print("MqttManager payload333::: $payload");
    imModel.setfollowMessage(payload);
  }

  ///开始收费
  void chargeMsg(dynamic payload) {
    print("MqttManager payload444::: $payload");
    int feetype = payload["feeType"];
    if (feetype == 0) {
      state.setTrySecs(0);
      state.setFeeType(0);
      state.setPayWatchTime(0);
      state.setShowPayPopup(false);
      state.roomInfo.value.ticketAmount = 0;
      state.roomInfo.value.timeDeduction = 0;
      trySeetimer?.cancel();
    } else {
      state.setTrySecs(payload["trySecs"]);
      state.setFeeType(payload["feeType"]);
      state.roomInfo.value.ticketAmount = payload["ticket"];
      state.roomInfo.value.timeDeduction = payload["timeDe"];
      state.setPayWatchTime(0);
    }
  }

  ///用户直播间禁言
  void ForbidChatMsg(dynamic payload) {
    print("MqttManager payload555::: $payload");
    state.setBanFlag(payload["bool"]);
  }

  ///直播间镜像
  void mirrorMsg(dynamic payload) {
    print("MqttManager payload666::: $payload");
    //{bool: false, roomId: 123, roomUid: 130103115}
    var roomId = StorageService.to.getString("roomId");
    if (roomId.isNotEmpty && payload["roomId"] != null) {
      if (payload["roomId"].toString().trim() == roomId) {
        if (payload["bool"] != null) {
          if (payload["bool"].toString().toLowerCase() == "true") {
            //取反
            AgoraRtc.rtc.setMirror(false);
          } else {
            AgoraRtc.rtc.setMirror(true);
          }
        }
      }
    }
  }

  ///直播间暂停
  void pauseMsg(dynamic payload) {
    print("MqttManager payload777::: $payload");
    int roomstate = payload["roomState"];
    //1:直播 2:离线 3:禁用4.暂停
    if (roomstate == 4) {
      Get.find<LiveRoomNewLogic>().state.changePauseState(true);
    } else {
      Get.find<LiveRoomNewLogic>().state.changePauseState(false);
    }
  }

  ///直播间扣费消息
  void payWatchMsg(dynamic payload) {
    print("MqttManager payload888::: $payload");
    bool enoughMoney = payload["bool"];
    state.setEnoughMoney(enoughMoney);
    state.setTimeWatched(payload["timeWatched"]);
    Get.find<UserBalanceLonic>().state.userBalance.value.coinBalance =
        payload["uCoin"];
    if (!enoughMoney) {
      state.setShowPayPopup(true);
    }
  }

  ///用户管理员身份变更
  void isAdminMsg(dynamic payload) {
    print("MqttManager payload999::: $payload");
    if (payload["uId"].toString().trim() ==
        AppManager.getInstance<AppUser>().userId.toString().trim()) {
      bool admin = payload["bool"];
      admin ? state.setAdminFlag(1) : state.setAdminFlag(0);
    }
  }

  ///用户离开直播间
  void EventleaveRoom(dynamic payload) {
    print("MqttManager payload101010::: $payload");
    if (state.audience.value > 0) {
      state.setAudiences(state.audience.value - 1);
    }
    if (state.audiences.length > 0) {
      List<LivingAudienceEntity> audiencesList = [];
      state.audiences.forEach((element) {
        if (element.userId.toString().trim() !=
            payload["uId"].toString().trim()) {
          // state.audiences.remove(element);
          audiencesList.add(element);
        }
      });
      state._setAudiences(audiencesList, state.audience.value);
      state.sortAudiences();
    }
  }

  ///用户等级提升 显示个人
  void leveLupgrade(dynamic payload) {
    print("MqttManager payload111111::: $payload");
    if (!state.roomSplit.value) {
      callShowChat?.call(true);
      callBackView?.call(payload);
    }
  }

  ///系统中奖公告
  void winningNoticeMsg(dynamic payload) {
    print("MqttManager payload111111::: $payload");
    print("object${payload["gameBetResult"]}");
    state.roomglobalNotice =
        "            幸运之神降临,${payload["uName"]}在${payload["gameName"]}赢了${payload["gameBetResult"]}元";
    print("1111111111${state.roomglobalNotice}");
    state.globalNoticeRoomId = "${payload["roomId"]}";
    state.setglobalNotice(true);
  }

  ///用户开通守护
  void openWatch(dynamic payload) {
    print("MqttManager payload121212::: $payload");
    state.setWatchPower(state.watchPower.value + 1);
  }

  ///用户等级提升 显示全局
  void LevelUp(dynamic payload) {
    print("MqttManager payload131313::: $payload");
    imModel.setLevelUpMessage(payload);
  }

  ///直播间投注成功消息
  void gameBet(dynamic payload) {
    print("MqttManager payload141414::: $payload");
    imModel.setgameBetMessage(payload);
  }

  ///直播间中奖消息
  void gameBetResult(dynamic payload) {
    print("MqttManager payload151515::: $payload");
    imModel.setWinningPushMessage(payload);
    // try{
    //   (Get.find<RoomBaseGameLogic>().endGame());
    // }catch(e){
    //   print(e);
    // }
  }

  ///直播间关闭
  void roomClosed(dynamic payload) {
    if (payload["roomState"] == 1) {
      state.setLivingRoomState(LivingRoomState.linking);
    } else {
      closeGameBackView?.call(payload);
      if (state.roomSplit.value) {
        Future.delayed(Duration(milliseconds: 200), () {
          Get.back();
          state.roomSplit.value = false;
        });
      }
      state.setLivingRoomState(LivingRoomState.liverOffline);
    }
  }

  ///使用弹幕道具
  void barrageSpeech() {
    if (!state.roomSplit.value) {
      callShowChat?.call(true);
      danmuBackView?.call("danmu");
    }
  }

  void countdown(void Function() onSuccess) {
    if (todayHasClose) {
      return;
    }
    checkRechargeStatusTimer?.cancel();
    checkRechargeStatusTimer = null;
    checkRechargeStatusTimer = Timer(const Duration(seconds: 60), () {
      HttpChannel.channel.checkRecharge().then((value) => value.finalize(
        wrapper: WrapperModel(),
        success: (data) {
          Map dic = data ?? {};
          //0 是 1否
          if (dic['isFirstRecharge'] == 0) {
            return;
          } else if (dic['isFirstRecharge'] == 1) {
            onSuccess.call();
          }
        },
      ));
    });
  }


  String interception(String text,int length){
    if(text.length<length){
      return text;
    }else{
      return "${text.substring(0,length)}...";
    }
  }


  final _LiveRoomNewState state = _LiveRoomNewState();

  Timer? _timer;
  Timer? _freeTimer;

  Timer? roomTimer;
  Timer? bufferGiftTimer;
  Timer? trySeetimer;
  Timer? lotteryTimer;

  //清空timer
  void ClearTimer() {
    _timer?.cancel();
    _onlineTimer?.cancel();
    _freeTimer?.cancel();

    roomTimer?.cancel();
    bufferGiftTimer?.cancel();
    trySeetimer?.cancel();
    checkRechargeStatusTimer?.cancel();
    checkRechargeStatusTimer = null;
  }

  void _enterRoomSuccess(_) {
    var model = state.rooms[state._roomIndex.value];
    _timerCancel();
    if (LiveRoomType.timer.rawValue == model.roomType &&
        state._freeTimeCount.value <= 0) {
      _timer = Timer.periodic(Duration(seconds: 60), (_) {
        _timerLive(model.id!);
      });
    }
    state._enableRoom();
  }

  void _freeTimerInitialize(int count) async {
    int index = state._roomIndex.value;
    var model = state.rooms[index];
    if (_freeTimer != null) {
      _freeTimer!.cancel();
      _freeTimer = null;
    }
    if (count == 0) {
      EventBus.instance
          .notificationListener(name: freeTimeOut, parameter: model);
    } else {
      await state.payEnterRoom();
      state._initFreeCount(count);
      _freeTimer = Timer.periodic(Duration(seconds: 1), (timer) async {
        --count;
        if (count >= 0) {
          state._initFreeCount(count);
        } else if (count < 0) {
          return;
        }
        if (count == 0) {
          _freeTimer?.cancel();
          if (index != state.roomIndex.value) {
            state._initFreeCount(-1);
            return;
          }
          EventBus.instance
              .notificationListener(name: freeTimeOut, parameter: model);
          await state.leaveChannel();
          return;
        }
      });
    }
  }

  /// 支付费用
  void pay() {
    var model = state.rooms[state._roomIndex.value];
    _timerLive(model.id!, success: () {
      state._initFreeCount(-1);
      state.payEnterRoom();
    });
  }

  void _gameTimeOut(_) {
    runtimeGame();
  }

  void _timerCancel() {
    _timer?.cancel();
    _timer = null;
  }

  void closeRoom() {
    _timer?.cancel();
    _onlineTimer?.cancel();
    _freeTimer?.cancel();
  }

  void _liverOffline(_) {
    _timerCancel();
    state.setLivingRoomState(LivingRoomState.liverOffline);
  }

  /// 刷新礼物
  void getGiftData() {
    UserInfoOperation.getGiftList(success: (list) {
      state._setGifts(list);
    }, specialSuccess: (list) {
      state._setPrivilegeGifts(list);
    });
  }

  /// 关注
  void follow(String id) {
    HttpChannel.channel
        .favoriteInsert(id, StorageService.to.getString("roomId"))
      ..then((value) => value.finalize(
          wrapper: WrapperModel(),
          success: (_) {
            state.following();

            ///刷新关注
            // Get.find<HomepageLogic>().changeTabDataWithType(1111);
          }));
  }

  void following() {
    state.following();
  }

  void cancelFollowing() {
    state.cancelFollow();
  }

  void setCoins(int value) {
    state._setCoins(value);
  }

  /// 计时收费
  void _timerLive(String id, {void Function()? success}) {
    HttpChannel.channel.timerLiveRoom(id)
      ..then((value) => value.finalize(
          wrapper: WrapperModel(),
          failure: (e) {
            showToast(e);
            AgoraRtc.rtc.leaveChannel();
            state._disableRoom();
            state.setLivingRoomState(LivingRoomState.lackOfBalance);
          },
          success: (_) => success?.call()));
  }

  /// 取消关注
  void followCancel(String id) {
    HttpChannel.channel.favoriteCancel(id)
      ..then((value) => value.finalize(
          wrapper: WrapperModel(),
          success: (_) {
            state.cancelFollow();

            ///刷新关注
            // Get.find<HomepageLogic>().changeTabDataWithType(1111);
          }));
  }

  /// 获取信息
  /// 1:查粉丝信息 2:查主播信息
  Future<SampleUserInfoEntity> userInfo(String userId) async {
    show();
    return HttpChannel.channel.getLiveRoomUserInfo(userId).then((value) {
      WrapperModel wrapper = value.finalize(
          wrapper: WrapperModel(),
          failure: (e) => showToast(e),
          success: (data) {
            dismiss();
          });
      return SampleUserInfoEntity.fromJson(wrapper.object);
    });
  }

  Future<FirstChargeRewardEntity?> getFirstChargeReward() async {
    return HttpChannel.channel.getFirstChargeReward().then((value) {
      WrapperModel wrapper = value.finalize(
          wrapper: WrapperModel(),
          failure: (e) => showToast(e),
          success: (data) {
            // if(data != null && data['awardInfo'] != null){
            //
            // }
          });
      return FirstChargeRewardEntity.fromJson(wrapper.object);
    });
  }

  String? _roomId;

  ///  房间信息
  Future roomInfo({required String roomId}) {
    this._roomId = roomId;
    return _roomInfo(roomId);
  }

  Future _roomInfo(String roomId) {
    if (_roomId != roomId) return Future.value();
    return HttpChannel.channel.liveRoomInfo(roomId: roomId)
      ..then((value) => value.finalize(
          wrapper: WrapperModel(),
          success: (data) {
            if (data != null) {
              state._setRoomInfo(LiveRoomInfoEntity.fromJson(data));
              MqttMangerProcessing(state.roomInfo.value.roomId.toString());
              state.setFeeType(state.roomInfo.value.feeType ?? 0);
              gamebackBackView?.call(data);
            }
          },
          failure: (e) {
            // _roomInfo(roomId)
          }));
  }

  /// 游戏现状
  Future<void> runtimeGame() async {
    await HttpChannel.channel.runtimeGame().then((value) => value.finalize(
        wrapper: WrapperModel(),
        success: (data) {
          AppManager.getInstance<Game>().setCurrentData(data);
        }));
    return;
  }

  /// 加入房间
  Future<void> joinRoom(AnchorListModelEntity model, String prevRoomId) async {
    AgoraRtc.rtc.setMirror(true);
    ClearTimer();
    closePush(prevRoomId);

    print("object1111${model.id}  $prevRoomId");

    /// 上一个房间不为空: 退出直播间
    if (state._lastRoom != null) {
      await AgoraRtc.rtc.leaveChannel();
      HttpChannel.channel
          .audienceExitRoom(roomId: state._lastRoom!, follow: false);
      // HttpChannel.channel.changeRoom();
    }

    /// 上一个验证请求未完成：取消上一个验证请求
    if (state._cancelToken != null)
      HttpChannel.channel.cancelRequest(state._cancelToken!);
    show();

    /// 验证进入直播间
    await HttpChannel.channel
        .verifyLiveRoom(
            roomId: model.id!,
            prevRoomId: prevRoomId,
            cancelToken: (token) {
              state._cancelToken = token;
            })
        .then((value) {
      state._cancelToken = null;
      return value.finalize(
          wrapper: WrapperModel(),
          failure: (e) {
            showToast(e);
            state._disableRoom();
            state.setLivingRoomState(LivingRoomState.lackOfBalance);
          },
          success: (data) {
            dismiss();
            // var channelName = data["channelName"];
            // var token = data["channelToken"];
            // var uid = data["channelUid"];

            if (data != null) {
              if (data["banFlag"] == 1) {
                state.setBanFlag(true);
              } else {
                state.setBanFlag(false);
              }

              state.setAdminFlag(data["adminFlag"]);
              if (data["hasPayed"] == true) {
                state.setTrySecs(0);
                state.setPayWatchTime(2);
                print("trySecs111 ${data["trySecs"]}");
              } else {
                state.setGuard(data["guard"]);
                state.setTrySecs(data["trySecs"]);
                print("trySecs222 ${data["trySecs"]}");
              }

              state._setJoimRoomInfo(JoinRoomInfoEntity.fromJson(data));
              EventBus.instance.notificationListener(
                  parameter: data, name: verifyRoomSuccess);
              state._enterRoom(
                  channelName: state.joinroomInfo.value.channelName.toString(),
                  token: state.joinroomInfo.value.channelToken.toString(),
                  uid: state.joinroomInfo.value.channelUid ?? 0);
              if (LiveRoomType.timer.rawValue == model.roomType ||
                  LiveRoomType.ticket.rawValue == model.roomType) {
                _freeTimerInitialize(model.seeTryTime ?? 0);
              } else {
                state.payEnterRoom();
              }

              /// 直播间信息
              roomInfo(roomId: model.id!);
              if (_onlineTimer != null) {
                _onlineTimer?.cancel();
                _onlineTimer = null;
              }

              followNotifications();

              /// 粉丝信息
              audienceNumber(roomId: model.id!);
            }
          });
    });
    return;
  }

  void followNotifications() {
    var user = AppManager.getInstance<AppUser>();
    bool isAdmissionOpen =
        AppCacheManager.cache.getisAdmissionStealthOpen() ?? false;

    print("sdfsdf$isAdmissionOpen");
    if (!isAdmissionOpen) {
      var chatsModel = ChatModel(
        name: user.username.toString(),
        userId: user.userId.toString(),
        level: user.rank,
        messageType: MessageType.notify,
        carUrl: user.carUrl,
        nobleLevel: user.nobleLevel,
        guardLevel: state.joinroomInfo.value.guard,
        type: TextType.enterLiveRoom,
        adminFlag: Get.find<LiveRoomNewLogic>().state.adminFlag.value,
        uuid: '',
        content: '',
      );

      Get.find<LiveRoomChatViewModel>().enterRoomList.add(chatsModel);
      EventBus.instance.notificationListener(name: "enterRoom");
      if (AppManager.getInstance<AppUser>().carUrl.toString().isNotEmpty) {
        Get.find<LiveRoomChatViewModel>().setSvgUrl(
            AppManager.getInstance<AppUser>().carUrl.toString(),
            tag: "car");
      }
    }

    Get.find<LiveRoomChatViewModel>().addChats(
        user.username.toString(), "", user.userId.toString(),
        level: user.rank,
        messageType: MessageType.notify,
        number: 0,
        nobleLevel: user.nobleLevel,
        guardLevel: state.joinroomInfo.value.guard,
        adminFlag: Get.find<LiveRoomNewLogic>().state.adminFlag.value,
        carUrl: user.carUrl,
        type: TextType.enterLiveRoom);
  }

  Timer? _onlineTimer;

  /// 观众数
  void audienceNumber({required String roomId}) {
    if (_onlineTimer == null) {
      _onlineTimer = Timer.periodic(Duration(minutes: 5), (_) {
        audienceNumber(roomId: roomId);
        // _roomInfo(roomId);
      });
    }
    HttpChannel.channel.audienceNumber(roomId).then((value) {
      return value.finalize(
          wrapper: WrapperModel(),
          success: (data) {
            List lst = data["audienceList"] ?? [];
            int onlineNumber = data["onlineNum"] ?? 0;
            state._setAudiences(
                lst.map((e) => LivingAudienceEntity.fromJson(e)).toList(),
                onlineNumber);
            state.sortAudiences();
          });
    });
  }

  /// 更换房间
  AnchorListModelEntity changeRoom(
      {required int index, List<AnchorListModelEntity>? anchorListData}) {
    _freeTimer?.cancel();
    state._initFreeCount(-1);
    if (anchorListData != null) state._setRooms(anchorListData);
    state._setRoomIndex(index);
    state._disableRoom();
    AnchorListModelEntity model = state._rooms[state._roomIndex.value];
    if (state.roomInfo.value.roomId != null) {
      joinRoom(model, state.roomInfo.value.roomId.toString());
    } else {
      joinRoom(model, "0");
    }
    return model;

  }

  /// 更换房间数据
  void changeRoomData(
      {required int index, required List<AnchorListModelEntity> anchorListData}) {
    state._setRooms(anchorListData);
    state._setRoomIndex(index);
    state._disableRoom();
  }

  @override
  InternalFinalCallback<void> get onDelete {
    EventBus.instance.removeListener(_enterRoomSuccess, name: enterRoomSuccess);
    EventBus.instance.removeListener(_liverOffline, name: liverOffline);
    EventBus.instance.removeListener(_gameTimeOut, name: gameTimeOut);
    WidgetsBinding.instance.removeObserver(this);
    state._initFreeCount(-1);
    _timer?.cancel();
    _onlineTimer?.cancel();
    _freeTimer?.cancel();
    return super.onDelete;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // todo 重连
    }
  }

  AnimationController? controller;
  late Rx<Animation<Offset>?> offset;
  Animation<Offset>? offset2;
  int countComplete = 0;

  luckyAlert(BuildContext context, text, {ValueChanged<String>? onTap}) {
    controller!.forward();
    return SlideTransition(
      position: offset.value!,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.dp),
        child: ClipRRect(
          child: Container(
              width: context.width,
              padding: EdgeInsets.only(left: 10.dp),
              alignment: Alignment.center,
              height: 28.dp,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(R.bgLuckyAlert), fit: BoxFit.fill)),
              child: Row(
                children: [
                  Image.asset(
                    R.leafLuck,
                    width: 24.dp,
                    height: 24.dp,
                  ).paddingOnly(right: 2.dp),
                  Flexible(
                    child: MarqueeWidget(
                      direction: Axis.horizontal,
                      callBack: () {
                        controller!.reset();
                        offset.value = offset2;
                      },
                      child: Text(
                        '$text',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    flex: 1,
                    fit: FlexFit.tight,
                  ),
                  SizedBox(
                    width: 2.dp,
                  ),
                  ClipRRect(
                    child: InkWell(
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 8.dp),
                        alignment: Alignment.center,
                        height: 24.dp,
                        child: Text(
                          '去围观',
                          style: TextStyle(
                              color: Color(0xFFFF1EAF),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      onTap: onTap == null
                          ? null
                          : () {
                        _resetAnimLuck();
                        if (state.globalNoticeRoomId !=
                            StorageService.to.getString("roomId")) {
                          onTap.call(state.globalNoticeRoomId);
                        }
                      },
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(28.dp),
                    ),
                  ),
                  SizedBox(
                    width: 2.dp,
                  ),
                ],
              )),
          borderRadius: BorderRadius.all(
            Radius.circular(28.dp),
          ),
        ),
      ),
    );
  }

  void setupAnimToastLuck(TickerProvider tick) {
    controller =
        AnimationController(vsync: tick, duration: Duration(seconds: 2));
    controller?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (countComplete == 1) {
          _resetAnimLuck();
        }
        countComplete++;
      }
    });
    offset = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
        .animate(controller!)
        .obs;

    offset2 = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(-1.0, 0.0))
        .animate(controller!);
  }

  void _resetAnimLuck() {
    countComplete = -1;
    state.setglobalNotice(false);
    controller?.reset();
    offset = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
        .animate(controller!)
        .obs;
  }
}

class _LiveRoomNewState {
  /// 房间定位
  int topBarrage = 0;
  RxInt _roomIndex = (-1).obs;

  RxInt get roomIndex => _roomIndex;

  RxInt _freeTimeCount = (-1).obs;

  RxInt get freeTimeCount => _freeTimeCount;

  int? _cancelToken;
  bool showChat = false;
  bool autoShowGame = true;

  String? _lastRoom;

  //上一个直播间id
  String? previousRoom = "0";

  String _channelName = "";

  String get channelName => _channelName;

  String _token = "";

  String get token => _token;

  ///直播间通告消息
  String roomglobalNotice = "";

  ///中奖直播间Id
  String globalNoticeRoomId = "";

  int _uid = -1;
  RxDouble heightSurface = 0.0.obs;
  bool firstheightVLComes = false;

  int get uid => _uid;

  RxBool _showPayPopup = false.obs;

  RxBool get showPayPopup => _showPayPopup;

  ///试看时间
  RxInt _trySecs = 0.obs;

  RxInt get trySecs => _trySecs;

  ///房间收费类型
  RxInt _feeType = 0.obs;

  RxInt get feeType => _feeType;

  /// 是否暂停直播
  RxBool _pauseOrStart = false.obs;

  RxBool get pauseOrStart => _pauseOrStart;

  /// 收费观看余额是否足够
  RxBool _enoughMoney = true.obs;

  RxBool get enoughMoney => _enoughMoney;

  /// 收费观看时长
  RxInt _timeWatched = (1).obs;

  RxInt get timeWatched => _timeWatched;

  /// 主播硬币
  RxInt _coins = (0).obs;

  RxInt get coins => _coins;

  /// 房间信息
  Rx<LiveRoomInfoEntity> _roomInfo = LiveRoomInfoEntity().obs;

  Rx<LiveRoomInfoEntity> get roomInfo => _roomInfo;

  /// 加入房间返回信息
  Rx<JoinRoomInfoEntity> _joinroomInfo = JoinRoomInfoEntity().obs;

  Rx<JoinRoomInfoEntity> get joinroomInfo => _joinroomInfo;

  ///游戏直播间的数据
  Rx<GameDataResult> gameResult = GameDataResult().obs;

  setUpdateGameResult(GameDataResult value) {
    gameResult.value = value;
  }

  ///是否隐藏游戏播报
  RxBool isHideGameResult = false.obs;

  setUpdateIsHideGameResult(bool value) {
    isHideGameResult.value = value;
  }

  /// 房间信息是否为空
  RxBool _roomInfoEmpty = true.obs;
  RxBool roomSplit = false.obs;
  RxBool keyboardShow = false.obs;

  RxBool get roomInfoEmpty => _roomInfoEmpty;

  ///守护等级 0 默认 1
  /// "2001","周守护"
  /// "2002","月守护"
  /// "2003","年守护"
  /// 是否开通守护
  RxInt _guard = (0).obs;

  RxInt get guard => _guard;

  /// 用户是否被禁言
  RxBool _banFlag = (false).obs;

  RxBool get banFlag => _banFlag;

  ///用户是否是管理员
  RxInt _adminFlag = (0).obs;

  RxInt get adminFlag => _adminFlag;

  ///火力值
  RxInt _firepower = (0).obs;

  RxInt get firepower => _firepower;

  /// 是否付费观看  ，0表示未付费观看 1为按时付费观看，2 代表付费整场
  RxInt _payWatchTime = (0).obs;

  RxInt get payWatchTime => _payWatchTime;

  /// 房间是否有效
  RxBool _roomValid = false.obs;

  RxBool get roomValid => _roomValid;

  /// 是否关注
  RxBool _isFollowing = false.obs;

  RxBool get isFollowing => _isFollowing;

  /// 是否全局公告
  RxBool _globalNotice = false.obs;

  RxBool get globalNotice => _globalNotice;

  /// 当前直播间发生异常
  Rx<LivingRoomState> _livingState = Rx(LivingRoomState.linking);

  Rx<LivingRoomState> get livingState => _livingState;

  /// 礼物
  RxList<GiftEntity> _gifts = RxList();

  RxList<GiftEntity> get gifts => _gifts;

  /// 特权礼物
  RxList<GiftEntity> _privilegedGift = RxList();

  RxList<GiftEntity> get privilegedGift => _privilegedGift;

  /// 观众数量
  RxList<LivingAudienceEntity> _audiences = RxList();

  RxList<LivingAudienceEntity> get audiences => _audiences;

  /// 观众人数
  RxInt _audience = 0.obs;
  int romPageIndex = 0;

  RxInt get audience => _audience;

  RxInt _gifNum = 0.obs;

  RxInt get gifNum => _gifNum;

  int gifNumIndex = 0;

  ///守护人数
  RxInt _watchPower = (0).obs;

  RxInt get watchPower => _watchPower;

  /// 直播间
  RxList<AnchorListModelEntity> _rooms = RxList();

  RxList<AnchorListModelEntity> get rooms => _rooms;

  void _setRoomInfo(LiveRoomInfoEntity info) {
    _roomInfo.value = info;
    StorageService.to.setString("roomId", info.roomId.toString());

    if (info.isFollowed ?? false) {
      following();
    } else {
      cancelFollow();
    }
    _firepower.value = info.heat!;
    _watchPower.value = info.guardCount!;
    _roomInfoEmpty.value = false;
    _coins.value = info.coins ?? 0;
  }

  void _setJoimRoomInfo(JoinRoomInfoEntity info) {
    _joinroomInfo.value = info;
  }

  int addRoomInfo(int indexPage, AnchorListModelEntity info) {
    int index = _rooms.indexWhere((element) => element.id == info.id);
    if (index == -1) {
      _rooms = RxList()
        ..addAll(_rooms)
        ..add(info);
      return _rooms.length - 1;
    }
    if (indexPage == index) return -1;
    return index;
  }

  void setEnoughMoney(bool value) {
    _enoughMoney.value = value;
  }

  void setglobalNotice(bool value) {
    _globalNotice.value = value;
  }

  void setTimeWatched(int value) {
    _timeWatched.value = value;
  }

  void setWatchPower(int value) {
    _watchPower.value = value;
  }

  void setFirepower(int value) {
    _firepower.value = value;
  }

  /// 是否暂停直播
  void changePauseState(bool type) {
    this._pauseOrStart.value = type;
    try {
      Get.find<RoomBaseGameLogic>().state.pauseOrStart.value = type;
    } catch (e) {}
  }

  void setGuard(int value) {
    _guard.value = value;
  }

  void setTrySecs(int value) {
    _trySecs.value = value;
  }

  void setBanFlag(bool value) {
    _banFlag.value = value;
  }

  void setAdminFlag(int value) {
    _adminFlag.value = value;
  }

  void setFeeType(int value) {
    _feeType.value = value;
  }

  void _setCoins(int value) {
    _coins.value = value;
  }

  void setGifNum(int value) {
    _gifNum.value = value;
  }

  void setPayWatchTime(int value) {
    _payWatchTime.value = value;
  }

  void addGifNum() {
    _gifNum.value = gifNumIndex + _gifNum.value;
  }

  void _setGifts(List<GiftEntity> gifts) {
    this._gifts.value = gifts;
  }

  void _setPrivilegeGifts(List<GiftEntity> gifts) {
    this._privilegedGift.value = gifts;
  }

  void following() {
    this._isFollowing.value = true;
  }

  void cancelFollow() {
    this._isFollowing.value = false;
  }

  void _disableRoom() {
    _roomValid.value = false;
    _roomInfoEmpty.value = true;
    // _roomInfo = null;
    _coins.value = 0;
  }

  void _enableRoom() {
    _roomValid.value = true;
  }

  void _initFreeCount(int count) {
    _freeTimeCount.value = count;
  }

  void _setRoomIndex(int index) {
    if (index == -1) {
      index = 0;
    }
    if (_roomIndex.value != -1 && _rooms.length > _roomIndex.value) {
      _lastRoom = _rooms[_roomIndex.value].id;
    }
    _roomIndex.value = index;
    setLivingRoomState(LivingRoomState.linking);
  }

  void setLivingRoomState(LivingRoomState state) {
    _livingState.value = state;
  }

  void _setRooms(List<AnchorListModelEntity> data) {
    _rooms.value = data;
  }

  void _enterRoom(
      {required String channelName, required String token, required int uid}) {
    this._channelName = channelName;
    this._token = token;
    this._uid = uid;
    // AgoraRtc.rtc.addChannel(channelId, token, uid);
  }

  Future<void> leaveChannel() async {
    await AgoraRtc.rtc.leaveChannel();
    AgoraRtc.rtc.muteVideoStream(false);
    return;
  }

  Future payEnterRoom() {
    AgoraRtc.rtc.muteVideoStream(true);
    return AgoraRtc.rtc.addChannel(channelName, token, uid);
  }

  void _setAudiences(List<LivingAudienceEntity> audience, int count) {
    this._audiences.value = audience;
    this._audience.value = count;
  }

  void sortAudiences() {
    this.audiences.sort((a, b) => (a.joinTime!).compareTo(b.joinTime!));
    this.audiences.sort((a, b) => (b.heat!).compareTo(a.heat!));
  }

  void setAudiences(int count) {
    this._audience.value = count;
  }

  void setShowPayPopup(bool value) {
    _showPayPopup.value = value;
    if (!value) {
      Get.find<LiveRoomNewLogic>().trySeetimer?.cancel();
    }
  }
}

enum LivingRoomState {
  /// 余额不足 或其他失败原因
  lackOfBalance,

  /// 主播离线
  liverOffline,

  /// 连接中
  linking
}

class MarqueeWidget extends StatefulWidget {
  final Widget child;
  final Axis direction;
  final Duration animationDuration, pauseDuration, pauseEndDuration;
  final VoidCallback callBack;

  MarqueeWidget({
    Key? key,
    required this.child,
    required this.callBack,
    this.direction = Axis.horizontal,
    this.animationDuration = const Duration(milliseconds: 5000),
    this.pauseDuration = const Duration(milliseconds: 2000),
    this.pauseEndDuration = const Duration(milliseconds: 1000),
  }) : super(key: key);

  @override
  _MarqueeWidgetState createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController(initialScrollOffset: 50.0);
    WidgetsBinding.instance.addPostFrameCallback(scroll);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: widget.child,
      scrollDirection: widget.direction,
      controller: scrollController,
    );
  }

  void scroll(_) async {
    await Future.delayed(widget.pauseDuration);
    if (scrollController.hasClients) {
      await scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: widget.animationDuration,
        curve: Curves.ease,
      );
    }
    await Future.delayed(widget.pauseEndDuration);
    widget.callBack.call();
  }
}
