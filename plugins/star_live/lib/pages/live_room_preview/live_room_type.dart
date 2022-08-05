/*
 *  Copyright (C), 2015-2021
 *  FileName: live_room_type
 *  Author: Tonight丶相拥
 *  Date: 2021/9/26
 *  Description: 
 **/

import 'package:star_common/i18n/i18n.dart';

enum LiveRoomType {
  common,
  password,
  ticket,
  timer,
  game
}


extension LiveRoomTypeExtension on LiveRoomType {
  int get rawValue {
    int value = -1;
    //（1:普通房间 2:门票房间 3:计时房间 4:游戏房间）
    switch(this) {
      case LiveRoomType.common:
        value = 1;
        break;
      case LiveRoomType.password:
        value = 0;
        break;
      case LiveRoomType.ticket:
        value = 2;
        break;
      case LiveRoomType.timer:
        value = 3;
        break;
      case LiveRoomType.game:
        value = 4;
        break;
    }
    return value;
  }

  String get description {
    String value = "unKnown";
    var isCN = AppInternational.current is $zh_CN;
    switch(this) {
      case LiveRoomType.common:
        if (isCN) {
          value = "普通房间";
        }else {
          value = "Common Room";
        }
        break;
      case LiveRoomType.password:
        if (isCN) {
          value = "密码房间";
        }else {
          value = "Password Room";
        }
        break;
      case LiveRoomType.ticket:
        if (isCN) {
          value = "门票房间";
        }else {
          value = "Ticket Room";
        }
        break;
      case LiveRoomType.timer:
        if (isCN) {
          value = "计时收费房间";
        }else {
          value = "Timer Room";
        }
        break;
      case LiveRoomType.game:
        if (isCN) {
          value = "游戏房间";
        }else {
          value = "Game Room";
        }
        break;
    }
    return value;
  }
}