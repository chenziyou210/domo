/*
 *  Copyright (C), 2015-2021
 *  FileName: live_room_enum
 *  Author: Tonight丶相拥
 *  Date: 2021/10/13
 *  Description: 
 **/

/*
*  Im {
                 系统通知: {
                      中奖通知
                      送礼物(全局)
                      app {
                           下注通知(可以跟投)，
                           进入直播间，
                           关注通知
                      }
                 }，
                 用户发消息
            }*/

enum TextType {
  conversation,
  /// 送礼物
  gift,
  // mute,
  // muteCancel,
  /// 初始化消息
  initializeMessage,
  /// 游戏开始
  // startGameIm,
  ///关注主播
  attention,
  enterLiveRoom,
  // winPrize,
  /// 下注通知
  bootomIm,
  /// 中奖通知
  winLotteryMsg
}

extension TextTypeExtension on TextType {

  String get rawValue {
    String value = "unknown";
    switch (this){
      case TextType.conversation:
        value = "hjnTextMessage";
        break;
      case TextType.gift:
        value = "brushGiftIm";//"hjnGiftMessage";
        break;
      // case TextType.system:
      //   value = "hjnSystemMessage";
      //   break;
      // case TextType.mute:
      //   value = "hjnMuteMessage";
      //   break;
      // case TextType.muteCancel:
      //   value = "hjnMuteCancelMessage";
      //   break;
      case TextType.initializeMessage:
        value = "hjnInitializeMessage";
        break;
      // case TextType.startGameIm:
      //   value = "startGameIm";
      //   break;
      case TextType.attention:
        value = "atentionUserIm";
        break;
      case TextType.enterLiveRoom:
        value = "enterLiveroomIm";
        break;
      // case TextType.winPrize:
      //   value = "winPreizeIm";
      //   break;
      case TextType.bootomIm:
        value = "bootomIm";
        break;
      case TextType.winLotteryMsg:
        value = "sendIsmute";
        break;
    }
    return value;
  }
}


enum MessageType {
  $default,
  call,
  reply,
  notify,
  other
}

extension MessageTypeExtension on MessageType {
   String get rawValue {
    String value = "0";
    switch(this){
      case MessageType.$default:
        value = "0";
        break;
      case MessageType.call:
        value = "1";
        break;
      case MessageType.reply:
        value = "2";
        break;
      case MessageType.notify:
        value = "3";
        break;
      case MessageType.other:
        value = "-1";
        break;
      default:
        value = "0";
        break;
    }
    return value;
  }

  /// 获取type
  MessageType getMessageType(String value){
    var list = MessageType.values.where((element)
      => element.rawValue == value).toList();
    if (list.length > 0) {
      return list[0];
    }
    return this;
  }
}