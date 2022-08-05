/*
 *  Copyright (C), 2015-2021
 *  FileName: live_room_chat_model
 *  Author: Tonight丶相拥
 *  Date: 2021/7/28
 *  Description: 
 **/

import 'dart:collection';
import 'dart:convert';
import 'package:alog/alog.dart';
import 'package:flutter/material.dart';
import 'package:star_common/common/app_common_widget.dart'
    show EventBus, givingGift, verifyRoomSuccess, winPrize, enterRoom;
import 'package:star_common/common/crypto/crypto.dart';
import 'package:star_common/common/storage.dart';
import 'package:star_common/http/cache.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/i18n/i18n.dart';
import 'package:star_live/pages/live_room/view/room_info_page/room_live_game/room_base_game/room_base_game_state.dart';
import '/pages/live_room/live_room_enum.dart';
import '/pages/live_room/view/gift_card/gift_card.dart';
import '/pages/live_room/view/svga/SVAGPlayer.dart';
import 'package:im_flutter_sdk/im_flutter_sdk.dart' hide MessageType;
import 'dart:async';
import 'package:star_common/common/toast.dart';
import 'package:star_common/manager/app_manager.dart';
import 'package:star_live/im/im_manager.dart';
import 'package:uuid/uuid.dart';
import 'package:star_common/generated/anchor_list_model_entity.dart';
import 'package:star_common/generated/im_room_account.dart';
import 'live_room_new_logic.dart';
import 'mute_model.dart';
import 'package:get/get.dart';

class IMModel extends EMChatManagerListener with Toast, WidgetsBindingObserver {
  IMModel() {
    WidgetsBinding.instance.addObserver(this);
  }

  void Function()? _scrollPopToTop;
  void Function(int)? _coins;

  Timer? giftTimer = null; // 定义定时器
  var giftTimeOut = const Duration(seconds: 3);
  var giftTimeShouldClose = false;
  var myGiftChat = HashMap<String, ChatGift>();

  void setUp(void Function()? scroll, void Function(int)? coins) {
    this._scrollPopToTop = scroll;
    this._coins = coins;
    EventBus.instance.addListener(_onVerifyRoom, name: verifyRoomSuccess);
    EMClient.getInstance.chatManager.addChatManagerListener(this);
  }

  /// 聊天室
  String? _roomId;
  String? _ImRoomId;
  late AppInternational intl;


  bool imCheckIng = false;

  /// 解除禁言倒计时
  Timer? _imCheckTimer;

  String headMessage = "";

  final LiveRoomChatViewModel chats = LiveRoomChatViewModel();

  final String _key = "sds1LI2OW&E&%@kI&FCuy";
  final String _messageKey = "hjnTextMessage";

  var gifNum = 1;

  /// 发送消息
  Future<void> sendText(
    String message, {
    TextType type: TextType.conversation,
    int? time,
    int? number,
    String? mutingId,
    String? roomId,
    bool isDanmu = false,
  }) async {
    var t = chats._message.value.type;
    var x = chats._message.value.ex;
    String e = "";
    if (chats._message.value.ex is Map) {
      try {
        e = jsonEncode(x);
      } catch (_) {}
    }

    String? m = xxtea.encryptToString(message, _key);
    if (roomId != null && roomId != _roomId) {
      return;
    }
    var user = AppManager.getInstance<AppUser>();
    print('NEO isDanmu $isDanmu');
    if (isDanmu) {
      chats.setDanmu(chats.createModel(
          user.username ?? "", message, user.userId ?? "",
          type: type,
          level: user.rank,
          guardLevel: Get.find<LiveRoomNewLogic>().state.guard.value,
          nobleLevel: user.nobleLevel,
          adminFlag: Get.find<LiveRoomNewLogic>().state.adminFlag.value,
          head: user.header,
          messageType: MessageType.notify));
    }
    var result = await EMClient.getInstance.chatManager.sendMessage(
        EMMessage.createCustomSendMessage(
            username: _roomId!,
            event: type.rawValue,
            params: {
          "userId": user.userId ?? "",
          "level": user.rank?.toString() ?? "0",
          "username": user.username ?? "",
          "head": user.header ?? "",
          "number": number?.toString() ?? "1",
          "time": time?.toString() ?? "0",
          "guardLevel":
              Get.find<LiveRoomNewLogic>().state.guard.value.toString(),
          "nobleLevel": user.nobleLevel.toString(),
          "isFee": isDanmu ? "1" : "0",
          "adminFlag":
              Get.find<LiveRoomNewLogic>().state.adminFlag.value.toString(),
          "message": m,
          "mutingId": mutingId ?? "",
          "type": t.rawValue,
          "extension": e
        })
          ..chatType = ChatType.ChatRoom);
    if (result.status == MessageStatus.FAIL) {
      var id = _roomId;
      _checkImStatus();
      sendText(message,
          type: type,
          time: time,
          number: number,
          mutingId: mutingId,
          roomId: id,
          isDanmu: isDanmu);
      return;
    }
    headMessage = "";
    if ( isDanmu) return;
    chats.addChats(user.username ?? "", message, user.userId!,
        guardLevel: Get.find<LiveRoomNewLogic>().state.guard.value,
        nobleLevel: user.nobleLevel,
        isFee: isDanmu ? 1 : 0,
        adminFlag: Get.find<LiveRoomNewLogic>().state.adminFlag.value,
        level: user.rank,
        number: number,
        type: type,
        messageType: t,
        ex: x);
    return;
  }

  // return HttpChannel.channel.announcementList(type).then((value) {
  // return value.finalize<WrapperModel>(
  // wrapper: WrapperModel(),
  // failure: (e)=> showToast(e),
  // success: (data) {
  // List lst = data ?? [];
  // _data.value = lst.map((e) => AnnouncementEntity.fromJson(e)).toList();
  // }
  // ).isSuccess;
  // });

  String? getRoomId() {
    return _roomId;
  }

  List<String> _idsExists = List.empty(growable: true);

  void initRoom(AnchorListModelEntity? entry) {
    chats.cleanScreen();
    _idsExists.clear();
    if (entry != null) {
      getRoom(entry.id!);
    }
  }

  void leaveChatRoom(String roomId) async {
    _imCheckTimer?.cancel();
    _imCheckTimer = null;
    _idsExists.clear();
    if ((_roomId?.isNotEmpty ?? false)) {
      try {
        EMClient.getInstance.chatRoomManager.leaveChatRoom(roomId);
      } on EMError catch (e) {
        debugPrint("error code: ${e.code}, desc: ${e.description}");
      }
      _roomId = "";
    }
  }

  /// 获取聊天室
  Future<void> getRoom(String roomId) async {
    if (_roomId != roomId && (_roomId?.isNotEmpty ?? false)) {
      giftTimer?.cancel();
      giftTimer = null;
      leaveChatRoom(_roomId!);
    }
    _roomId = roomId;
    _getRoom(roomId);
  }

  Future<void> _getRoom(String roomId) async {
    if (_roomId != roomId) {
      return;
    }
    try {
      // var result = await EMClient.getInstance.chatRoomManager.getChatRoomWithId(roomId);
      // if (result.roomId == null ||  result.owner == null)
      _checkImStatus();
      var result = await EMClient.getInstance.chatRoomManager
          .fetchChatRoomInfoFromServer(roomId);
      if (result.roomId.isEmpty || result.owner == null) _getRoom(roomId);
    } catch (e) {
      print("");
    }
  }

  int _checkImCount = 0;

  Future<void> _checkImStatus() async {
    if (imCheckIng) {
      return;
    }
    Alog.e("开始检查IM状态 _roomId:$_roomId _ImRoomId:$_ImRoomId",
        tag: "checkImStatus");
    imCheckIng = true;
    var isLogin = false;
    try{
      isLogin = await EMClient.getInstance.isLoginBefore();
    }on EMError catch (e) {
      Alog.e(
          "EMError isLoginBefore error code: ${e.code}, desc: ${e.description}",
          tag: "checkImStatus");
    }
    try {
      if (!isLogin) {
        var user = AppManager.getInstance<AppUser>();
        if ((user.chatPassword?.isEmpty ?? true) ||
            (user.chatUsername?.isEmpty ?? true)) {
          var result = await chatRoomAccount();
          user.userUpdateIM(result);
        }
        await EMClient.getInstance
            .login(user.chatUsername ?? "", user.chatPassword ?? "");
      }
      if (_roomId?.isEmpty ?? true) {
        return;
      }
    } on EMError catch (e) {
      Alog.e(
          "EMError login error code: ${e.code}, desc: ${e.description}",
          tag: "checkImStatus");
      _imCheckTimer?.cancel();
      _imCheckTimer = null;
    } on Error catch (e) {
      Alog.e("Error error code: ${e.toString()}", tag: "checkImStatus");
      e.printError();
    }
    try {
      await EMClient.getInstance.chatRoomManager.joinChatRoom(_roomId!);
      _ImRoomId = _roomId;
    } on EMError catch (e) {
      if (e.code == 700) {
        _imCheckTimer?.cancel();
        _imCheckTimer = null;
        return;
      }
      Alog.e("EMError joinChatRoom code: ${e.code}, desc: ${e.description}",
          tag: "checkImStatus");
    }
    if (_ImRoomId != _roomId) {
      _checkImCount += 1;
      if (_imCheckTimer == null) {
        _checkImCount = 0;
        _imCheckTimer = Timer.periodic(Duration(seconds: 4), (timer) {
          if (_roomId?.isNotEmpty != true || _ImRoomId == _roomId) {
            _imCheckTimer?.cancel();
            _imCheckTimer = null;
            return;
          }
          // showToast("重新连接聊天室 $_checkImCount ...");
          print("重新连接聊天室 $_checkImCount ...");
          _checkImStatus();
          if (_checkImCount >= 3) {
            _imCheckTimer?.cancel();
            _imCheckTimer = null;
          }
        });
      }
    }
    imCheckIng = false;
    Alog.e("结束检查IM状态 _roomId:$_roomId _ImRoomId:$_ImRoomId",
        tag: "checkImStatus");
  }

  /// 获取环信账号
  Future<IMRoomAccountEntity> chatRoomAccount([bool force = false]) async {
    return HttpChannel.channel.chatRoomAccount(force).then((value) {
      WrapperModel wrapper = value.finalize(
          wrapper: WrapperModel(),
          failure: (e) => showToast(e),
          success: (data) {});
      var result = IMRoomAccountEntity.fromJson(wrapper.object);
      if (!force) {
        if ((result.chatPassword?.isEmpty ?? true) ||
            (result.chatUsername?.isEmpty ?? true)) {
          return chatRoomAccount(true);
        }
      }
      return result;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      ImManager.imLogIn().then((value) {
        if (_roomId != null) _getRoom(_roomId!);
      });
    } else if (state == AppLifecycleState.detached) {
      giftTimer?.cancel();
      giftTimer = null;
      _imCheckTimer?.cancel();
      _imCheckTimer = null;
    }
  }

  @override
  void onMessagesReceived(List<EMMessage> msg) {
    List<EMMessage> ms = List<EMMessage>.empty(growable: true)..addAll(msg);
    for (int i = 0; i < ms.length; i++) {
      if (_idsExists.indexOf(ms[i].msgId) >= 0) {
        ms.removeAt(i);
        i--;
        continue;
      }
      _idsExists.add(ms[i].msgId);
    }

    ms.forEach((element) {
      if (element.conversationId != _roomId) return;
      if (element.body is EMCustomMessageBody) {
        var body = element.body as EMCustomMessageBody?;
        String? m = body?.params?["message"].toString();
        m = xxtea.decryptToString(m, _key);
        if (m == null) {
          ms.remove(element);
          return;
        }
        String? event = body?.event;
        Map<String, String> params = body!.params!;
        Alog.e("params:${params}", tag: "onMessagesReceived");
        if (TextType.conversation.rawValue == event) {
          String name = params["username"].toString();
          String message = m; //params["message"].toString();
          String userId = params["userId"].toString();
          int nobleLevel = int.parse(params["nobleLevel"]!);
          int level = int.parse(params["level"]!);
          int isFee = int.parse(params["isFee"]!);

          int guardLevel = int.parse(params["guardLevel"]!);
          int adminFlag = int.parse(params["adminFlag"]!);

          // int? number = int.parse(params["level"]!);
          TextType type = TextType.conversation;
          // if (TextType.gift.rawValue == event) {
          //   type = TextType.gift;
          // }
          String typeValue = params["type"]!;
          dynamic ex = params["extension"];
          if (ex != null && ex is String && ex.isNotEmpty) {
            try {
              ex = jsonDecode(ex);
            } catch (_) {
              ex = null;
            }
          }
          // 判断拓展id ex["id"] == id1
          GlobalKey? key;
          if (ex is Map &&
              ex["id"] == AppManager.getInstance<AppUser>().userId) {
            chats._addCount();
            key = GlobalKey();
          }
          print('NEO isDanmu isFee $isFee');
          if (isFee == 1) {
            chats.setDanmu(chats.createModel(name, message, userId,
                type: type,
                level: level,
                adminFlag: adminFlag,
                guardLevel: guardLevel,
                nobleLevel: nobleLevel,
                head: params["head"].toString(),
                messageType: MessageType.notify));
          } else {
            chats.addChats(name, message, userId,
                level: level,
                type: type,
                guardLevel: guardLevel,
                adminFlag: adminFlag,
                nobleLevel: nobleLevel,
                isFee: isFee,
                messageType: MessageType.$default.getMessageType(typeValue),
                ex: ex,
                key: key);
            _scrollPopToTop?.call();
          }
        }
      }
    });
    super.onMessagesReceived(ms);
  }

  void setGiftMessage(dynamic message) {
    Alog.e(message, tag: "GifJson");
    String name = message["sender"];
    String svgUrl = message["gUrl"];
    int number = int.parse(message["gNum"].toString());
    int giftCount = int.parse(message["gCount"].toString());
    String userId = message["uId"].toString();
    int giftId = int.parse(message["gId"].toString());
    int giftype = int.parse(message["gType"].toString());
    int giftGrade = int.parse(message["gGrade"].toString());
    int contributeSort = int.parse(message["contributeSort"].toString());
    print("objectgiftype$giftype");
    if (AppManager.getInstance<AppUser>().userId == userId) {
      var sameGift = chats.chats.where((element) =>
          element.type == TextType.gift &&
          element.userId == userId &&
          element.giftId == giftId);
      if (sameGift.isNotEmpty) {
        if ((sameGift.first.num ?? 0) > (number * (giftCount + 1))) {
          return;
        }
      }
    }
    var model = chats.createModel(
        name, "${intl.send}${message["gName"]}", userId,
        type: TextType.gift,
        gifUrl: svgUrl,
        giftPic: message["gPic"].toString(),
        head: message["uHead"].toString(),
        contributeSort: contributeSort,
        giftId: giftId,
        giftype: giftype,
        messageType: MessageType.notify,
        number: giftCount);

    if(svgUrl.isNotEmpty && svgUrl.endsWith('svga')){
      chats.setSvgUrl(svgUrl, isTop: giftGrade == 3, tag: "gift");
    }

    handleGiftMsg(model, giftGrade);
  }

  void setJoinMessage(dynamic message) {
    var t = TextType.enterLiveRoom;
    var name = message["uName"];
    var level = message["uRank"];
    var userId = message["uId"].toString();
    var carUrl = message["carUrl"].toString();
    bool visible = message["visible"];
    bool isAdmin = message["isAdmin"];

    if (userId != AppManager.getInstance<AppUser>().userId) {
      if(!visible){
        if (carUrl.isNotEmpty) {
          chats.setSvgUrl(carUrl, tag: "car"); //播放坐骑动画
        }
        chats._enterRoomNotify(
            ChatModel(
                userId: userId.toString(),
                name: name,
                uuid: chats._getUuid,
                level: level,
                carUrl: carUrl,
                visible:visible,
                adminFlag: isAdmin?1:0,
                guardLevel: message["uGuard"],
                nobleLevel: message["uNoble"],
                messageType: MessageType.notify,
                content: "${intl.enterLivingRoom}"),
            carUrl);
      }
      chats.addChats(name, "${intl.enterLivingRoom}", userId,
          level: level,
          messageType: MessageType.notify,
          number: 0,
          guardLevel: message["uGuard"],
          nobleLevel: message["uNoble"],
          carUrl: carUrl,
          visible:visible,
          adminFlag: isAdmin?1:0,
          isAdmin:isAdmin,
          type: t);
    }
  }

  void setLevelUpMessage(dynamic message) {
    var t = TextType.enterLiveRoom;
    var name = message["uName"];
    var level = message["uRank"];
    var userId = message["uId"].toString();

    chats._enterRoomNotify(
        ChatModel(
            userId: userId.toString(),
            name: name,
            uuid: chats._getUuid,
            level: level,
            levelUp: 1,
            messageType: MessageType.notify,
            content: "${intl.enterLivingRoom}"),
        "");
    // chats.addChats(name, "", userId,
    //     level: level,
    //     messageType: MessageType.notify,
    //     number: 0,
    //     levelUp: 1,
    //     type: t);
  }

  void setgameBetMessage(dynamic message) {
    var userId = message["uId"].toString();
    var gmId = message["gmId"];
    var uName = message["uName"];
    var gameName = message["gameName"];
    var gmBet = message["gmBet"];
    List lists = json.decode(message["followBetInfo"]);
    List<GameOdds> betOdds = [];
    for (String data in lists) {
      Map<String, dynamic> map = json.decode(data);
      betOdds.add(GameOdds.fromJson(map));
    }
    chats.addChats(uName, "", userId,
        type: TextType.bootomIm,
        gmId: gmId,
        gameName: gameName,
        betInfo: betOdds,
        gmBet: "$gmBet",
        messageType: MessageType.notify);
  }

  void setWinningPushMessage(dynamic message) {
    var userId = message["uId"].toString();
    var gmId = message["gmId"];
    var uName = message["uName"];
    var gameName = message["gameName"];
    var gmBet = message["gameBetResult"];


    print("dsdsdsdsd${message["gmBet"]}  ${message["gameName"]}  ");
    chats.addChats(
        uName,
        "",
        userId,
        type: TextType.winLotteryMsg,
        gmId:gmId,
        gameName:gameName,
        gmBet:"$gmBet",
        messageType: MessageType.notify);

  }

  void setfollowMessage(dynamic message) {
    var t = TextType.attention;
    var name = message["uName"];
    var level = message["uRank"];
    var userId = message["uId"].toString();
    bool isAdmin = message["isAdmin"];
    // chats._enterRoomNotify(
    //     ChatModel(
    //         userId: userId.toString(),
    //         name: name,
    //         uuid: chats._getUuid,
    //         level: level,
    //         messageType: MessageType.notify,
    //         content: "${intl.enterLivingRoom}"),
    //     "");
    chats.addChats(name, "", userId,
        level: level, messageType: MessageType.notify,
        guardLevel: message["uGuard"],
        nobleLevel: message["uNoble"],
        adminFlag: isAdmin?1:0,
        number: 0, type: t);
  }

  bool sendAdvanceGift(int giftId, int number, int comboCount,int giftype) {
    var chatGift = myGiftChat["${giftId}"];
    if (chatGift != null) {
      giftTimeShouldClose = false;
      var chat = chatGift.chat;
      var model = chats.createModel(
          "${chat.name}", "${chat.content}", "${chat.userId}",
          type: TextType.gift,
          gifUrl: chat.gifUrl,
          giftPic: chat.giftPic,
          head: chat.head,
          contributeSort: chat.contributeSort,
          giftId: giftId,
          giftype: giftype,
          messageType: MessageType.notify,
          number: comboCount);
      myGiftChat["${model.giftId}"] =
          ChatGift(model, chatGift.giftGrade, isAdvance: true);
      handleGiftMsg(model, chatGift.giftGrade, isAdvance: true);
    }
    return chatGift != null;
  }

  void handleGiftMsg(ChatModel model, int giftGrade, {isAdvance = false}) {
    ChatGift chatGift = ChatGift(model, giftGrade);
    if (model.userId == AppManager.getInstance<AppUser>().userId) {
      if (!isAdvance) {
        var advanceModel = myGiftChat["${model.giftId}"];
        if (advanceModel?.isAdvance == true) {
          if ((advanceModel?.chat.num ?? 0) == (model.num ?? 0)) {
            advanceModel?.isAdvance = false;
            return;
          }
          return;
        }
      }
      if (myGiftChat["${model.giftId}"] == null) {
        myGiftChat["${model.giftId}"] = chatGift;
      }
    }
    chats.chatGift.removeWhere((element) =>
        element.chat.userId == model.userId &&
        element.chat.giftId == model.giftId);
    chats.chats.removeWhere((element) =>
        element.userId == model.userId && element.giftId == model.giftId);
    chats.chatGift.add(chatGift);
    var gifts = getGifts();
    if (gifts.isNotEmpty) {
      print('NEO H1');
      chats.chats.addAll(gifts);
    }
    if (giftTimer == null) {
      int timerCount = 0;
      giftTimeShouldClose = false;
      giftTimer = Timer.periodic(giftTimeOut, (timer) {
        Alog.e(
            "定时器执行---timerCount:$timerCount---shouldClose:"
            "$giftTimeShouldClose--gift:${chats.chatGift.length}",
            tag: "giftTimer");
        if (chats.chatGift.isNotEmpty) {
          timerCount++;
          print('NEO H2');
          chats.chats.addAll(getGifts());
        } else {
          if (giftTimeShouldClose) {
            timerCount++;
            if (timerCount > 1) {
              clearGiftTips();
              if (chats.chatGift.isEmpty && getGiftChatNum() == 0) {
                giftTimer?.cancel();
                giftTimer = null;
              } else {
                giftTimeShouldClose = false;
              }
            }
          }
          if (!giftTimeShouldClose && chats.chatGift.isEmpty) {
            giftTimeShouldClose = true;
            timerCount = 0;
          }
        }
      });
    }
  }

  void clearGiftTips() {
    print('NEO H2');
    int nowTime = DateTime.now().millisecondsSinceEpoch;
    chats.chats.removeWhere((element) =>
        element.type == TextType.gift && !chats.chatGift.contains(element));
    var gifts = chats.chats.where((element) => element.type == TextType.gift);
    chats.chatGift.forEach((gift) {
      for (var chat in gifts) {
        if (gift.chat == chat) {
          if (gift.waitClose) {
            if (gift.closeTime <= nowTime) {
              print('NEO H4');
              chats.chats.remove(gift.chat);
              chats.chatGift.remove(gift);
              return;
            }
          } else {
            print('NEO H5');
            chats.chats.remove(gift.chat);
            chats.chatGift.remove(gift);
            return;
          }
        }
      }
    });
  }

  int getGiftChatNum() {
    int length = 0;
    var chatModels = chats.chats.value;
    for (int i = chatModels.length - 1; i >= 0; i--) {
      ChatModel last = chatModels[i];
      if (last.type == TextType.gift) {
        length += 1;
      }
    }
    return length;
  }

  List<ChatModel> getGifts({List<ChatModel>? list}) {
    if (chats.playState.value == -1) {
      return [];
    }
    var giftChats = list ?? [];
    if (getGiftChatNum() >= 2 && chats.chatGift.isNotEmpty) {
      clearGiftTips();
    }
    if (getGiftChatNum() < 2 && chats.chatGift.isNotEmpty) {
      for (int i = chats.chatGift.length - 1; i >= 0; i--) {
        ChatGift last = chats.chatGift[i];
        if (last.waitClose == false) {
          if (last.giftGrade == 3) {
            last.closeTime =
                DateTime.now().add(Duration(seconds: 3)).millisecondsSinceEpoch;
            last.waitClose = true;
          }
          giftChats.add(last.chat);
          chats.chatGift.remove(last);
          break;
        }
      }
    }
    Alog.e(giftChats.toString(), tag: "getGifts");
    return giftChats;
  }

  @override
  void dispose() {
    leaveChatRoom(_roomId ?? "");
    chats.svgUrl = <String>[].obs;
    _imCheckTimer?.cancel();
    giftTimer?.cancel();
    _scrollPopToTop = null;
    EMClient.getInstance.chatManager.removeChatManagerListener(this);
    WidgetsBinding.instance.removeObserver(this);
    EventBus.instance.removeListener(_onVerifyRoom, name: verifyRoomSuccess);
  }

  void subtractCount() {
    chats._subtractCount();
  }

  void _onVerifyRoom(arguments) {
    chats.clearChats();
    // var time = arguments["time"];
    // var startTime = arguments["banOpentime"];
    String banFlag = arguments["banFlag"].toString();
    getRoom(arguments["chatRoomId"]);
  }
}

class LiveRoomChatViewModel extends GetxController {
  RxList<ChatModel> _chats = <ChatModel>[].obs;

  RxList<ChatModel> get chats => _chats;

  List<ChatGift> chatGift = <ChatGift>[];

  /// 进入直播间
  RxList<ChatModel> _enterRoom = RxList();

  RxList<ChatModel> get enterRoomList => _enterRoom;

  List<String> _cars = [];

  List<String> get cars => _cars;

  /// 中奖
  RxList<ChatModel> _winP = RxList();

  RxList<ChatModel> get winP => _winP;

  /// 赠送礼物
  RxList<ChatModel> _sendGift = RxList();

  RxList<ChatModel> get sendGift => _sendGift;

  /// 滚动列表
  RxList<String> _popList = <String>[].obs;

  RxList<String> get popList => _popList;

  /// 是否聚焦
  RxBool get isOnFocus => _isOnFocus;
  RxBool _isOnFocus = false.obs;

  /// 是否显示连击
  RxBool get isBatter => _isBatter;
  RxBool _isBatter = false.obs;

  RxInt playState = 0.obs;

  void setIsBatter(bool value) {
    _isBatter.value = value;
  }

  void setHintText(String value) {
    _hintText.value = value;
  }

  RxList<ChatModel> danmu = <ChatModel>[].obs;
  void setDanmu(ChatModel value) async {
    print("NEO setDanmu $value");
    danmu += [value];
  }

  /// svga播放列表
  RxList<String> svgUrl = <String>[].obs;

  void setSvgUrl(String? value, {bool isTop = false, String? tag}) async {
    print("objectssssss1111");
    if (StorageService.to.getString("giftEffect") == "0") {
      print("object2222");
      return;
    }

    if ("car" == tag && AppCacheManager.cache.getiDriveOpen() == true) {
      print("objectsssss3333");
      return;
    }
    if ("gift" == tag && AppCacheManager.cache.getiGiftOpen() == true) {
      print("objectssss4444");
      return;
    }
    if (value == null || value.toString().toLowerCase() == "null") {
      print("objectssssss5555");
      Alog.e("setSvgUrl:$value ,error", tag: "$tag");
      return;
    }
    Alog.e("setSvgUrl:$value ,isTop:$isTop", tag: "$tag");
    if (isTop) {
      if (svgUrl.length > 0 && svgUrl.first == value) {
        print("object6666");
        return;
      }
      print("objectsssssss7777");
      svgUrl.insert(0, value);
    } else {
      if (svgUrl.length > 0 && svgUrl.last == value) {
        print("object8888");
        return;
      }
      print("objectsssssss9999");
      svgUrl += [value];
    }
  }

  /// 跳转数
  RxInt _count = 0.obs;

  RxInt get count => _count;

  /// 默认消息类型
  Rx<_MessageState> _message = _MessageState().obs;

  Rx<_MessageState> get messageState => _message;
  RxString _hintText = "".obs;
  RxString get hintText => _hintText;

  void cleanScreen() {
    playState.value = -1;
    chatGift.clear();
    danmu.clear();
    _chats.clear();
    setIsBatter(false);
    Future.delayed(Duration(milliseconds: 20), () {
      playState.value = 0;
    });
  }

  void onFocus() {
    _isOnFocus.value = true;
  }

  void _addCount() {
    _count++;
  }

  void removeChatModel(ChatModel model) {
    _chats.remove(model);
  }

  void _subtractCount() {
    if (_count.value > 0) {
      _count--;
    } else {
      _count.refresh();
    }
  }

  void _resetMessage() {
    _message.value = _MessageState();
  }

  void unFocus() {
    _isOnFocus.value = false;
    _resetMessage();
  }

  ChatModel insertChat(ChatModel model) {
    print('NEO H6 before${_chats.length}');
    _chats.insert(0, model);
    if (_chats.length > 1000) {
      _chats.removeLast();
    }
    print('NEO H6 after${_chats.length}');
    return model;
  }

  /// 添加聊天
  ChatModel addChats(String name, String message, String userId,
      {int? level,
      int? number,
      required TextType type,
      String? gifUrl,
      int? giftId,
      String? giftPic,
      String? head,
      String? carUrl,
      int? guardLevel,
      int? adminFlag,
      int? isFee,
      int? levelUp,
      int? nobleLevel,
      int? contributeSort,
      int? gmId,
      int? giftype,
      String? gmBet,
      List<GameOdds>? betInfo,
      String? gameName,
      bool? visible,
      bool? isAdmin,
      dynamic ex,
      required MessageType messageType,
      GlobalKey? key}) {
    var model = createModel(name, message, userId,
        key: key,
        level: level,
        type: type,
        giftId: giftId,
        number: number,
        gifUrl: gifUrl,
        levelUp: levelUp,
        adminFlag: adminFlag,
        guardLevel: guardLevel,
        nobleLevel: nobleLevel,
        giftPic: giftPic,
        head: head,
        isFee: isFee,
        gmId: gmId,
        gmBet: gmBet,
        giftype: giftype,
        visible: visible,
        isAdmin: isAdmin,
        betInfo: betInfo,
        gameName: gameName,
        carUrl: carUrl,
        contributeSort: contributeSort,
        ex: ex,
        messageType: messageType);
    return insertChat(model);
  }

  ChatModel createModel(String name, String message, String userId,
      {int? level,
      int? number,
      required TextType type,
      String? gifUrl,
      int? giftId,
      String? giftPic,
      String? head,
      String? carUrl,
      int? guardLevel,
      int? nobleLevel,
      int? contributeSort,
      int? isFee,
      int? levelUp,
      int? adminFlag,
      int? gmId,
      int? giftype,
      String? gmBet,
      List<GameOdds>? betInfo,
      String? gameName,
      bool? visible,
      bool? isAdmin,
      dynamic ex,
      required MessageType messageType,
      GlobalKey? key}) {
    return ChatModel(
        userId: userId,
        name: name,
        key: key,
        level: level ?? 0,
        content: message,
        type: type,
        giftId: giftId,
        carUrl: carUrl,
        guardLevel: guardLevel,
        nobleLevel: nobleLevel,
        num: number,
        levelUp: levelUp,
        gifUrl: gifUrl,
        giftPic: giftPic,
        isFee: isFee,
        adminFlag: adminFlag,
        gmId: gmId,
        visible: visible,
        isAdmin: isAdmin,
        gmBet: gmBet,
        giftype: giftype,
        betInfo: betInfo,
        gameName: gameName,
        head: head,
        contributeSort: contributeSort,
        ex: ex,
        uuid: _getUuid,
        messageType: messageType);
  }

  void onCall(String userId, String name) {
    onFocus();
    _message.value.type = MessageType.call;
    _message.value.ex = {"userId": userId, "name": name};
    _message.refresh();
  }

  void onReply(String userId, String name, String content) {
    onFocus();
    _message.value.type = MessageType.reply;
    _message.value.ex = {"userId": userId, "name": name, "content": content};
    _message.refresh();
  }

  void _enterRoomNotify(ChatModel chat, String url) {
    _enterRoom.add(chat);
    if (url.isNotEmpty) _cars.add(url);
    EventBus.instance.notificationListener(name: enterRoom);
  }

  void _winPrizeNotify(ChatModel chat) {
    _winP.add(chat);
    EventBus.instance.notificationListener(name: winPrize);
  }

  void _sendGiftNotify(ChatModel chat) {
    _sendGift.add(chat);
    EventBus.instance.notificationListener(name: givingGift);
  }

  /// 添加滑动列表
  void addPopList(String message) {
    _popList += [message];
  }

  void clearChats() {
    _chats.value = [
      ChatModel(
          level: 5,
          name: "",
          type: TextType.initializeMessage,
          userId: "",
          content: "",
          messageType: MessageType.$default,
          uuid: _getUuid),
    ];
    _enterRoom.value = [];
    _winP.value = [];
    _sendGift.value = [];
    _cars.clear();
  }

  String get _getUuid => Uuid().v1();
}

class ChatModel {
  ChatModel({
    this.name,
    this.level,
    required this.userId,
    required this.content,
    this.num,
    this.type: TextType.conversation,
    this.gifUrl,
    this.giftId,
    this.ex,
    this.giftPic,
    this.head,
    this.isFee,
    this.adminFlag,
    this.guardLevel,
    this.nobleLevel,
    this.contributeSort,
    this.levelUp,
    this.carUrl,
    this.gmId,
    this.gmBet,
    this.betInfo,
    this.gameName,
    this.visible,
    this.isAdmin,
    this.giftype,
    required this.uuid,
    required this.messageType,
    this.key,
  });
  final int? gmId;
  final String? gmBet;
  final String? gameName;
  final String? name;
  final String? gifUrl;
  final String content;
  final bool? visible;
  final bool? isAdmin;
  final int? level;
  final TextType type;
  final String userId;
  final int? num;
  final int? giftId;
  final int? isFee;
  final int? adminFlag;
  final int? guardLevel;
  final int? levelUp;
  final int? giftype;
  final int? nobleLevel;
  final String uuid;
  final List<GameOdds>? betInfo;
  final dynamic ex;
  final String? giftPic;
  final String? head;
  final String? carUrl;
  final int? contributeSort;

  /// 0: 默认  1: @  2: 回复
  final MessageType messageType;
  GlobalKey? key;

  @override
  String toString() {
    return 'ChatModel{name: $name,giftype:$giftype ,levelUp:   $levelUp, gifUrl: $gifUrl, content: $content, level: $level, type: $type, userId: $userId, num: $num, giftId: $giftId, isFee: $isFee, adminFlag: $adminFlag, guardLevel: $guardLevel, nobleLevel: $nobleLevel, uuid: $uuid, ex: $ex, giftPic: $giftPic, head: $head, carUrl: $carUrl, contributeSort: $contributeSort, messageType: $messageType, key: $key}';
  }
}

class _MessageState {
  MessageType type = MessageType.$default;
  dynamic ex;
}

class ChatGift implements Comparable<ChatGift> {
  ChatGift(this.chat, this.giftGrade,
      {this.closeTime = 0, this.isAdvance = false, this.waitClose = false});

  final ChatModel chat;
  final int giftGrade;
  int closeTime;
  bool waitClose = false;
  bool isAdvance;

  @override
  int compareTo(ChatGift other) {
    if (giftGrade < other.giftGrade) {
      return -1;
    } else if (giftGrade > other.giftGrade) {
      return 1;
    } else {
      return 0;
    }
  }
}
// @override
// int compareTo(ChatModel other) {
//   return other.giftId??0;
// }
