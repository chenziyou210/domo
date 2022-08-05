/*
 *  Copyright (C), 2015-2021
 *  FileName: live_enum
 *  Author: Tonight丶相拥
 *  Date: 2021/10/14
 *  Description: 
 **/

///主播默认房间（0：普通房间1：密码房间2：门票房间3：计时房间4：游戏房间）
enum LiveEnum {
  common,
  secret,
  ticker,
  timer,
  game
}

extension LiveEnumExtension on LiveEnum {
  LiveEnum getLiveType(int index){
    if (LiveEnum.values.length < index) {
      return this;
    }
    var lst = LiveEnum.values.where((element) => element.rawValue == index).toList();
    if (lst.length <= 0) {
      return this;
    }
    return lst[0];
  }

  int get rawValue {
    int value = 0;
    switch(this) {
      case LiveEnum.common:
        value = 0;
        break;
      case LiveEnum.secret:
        value = 1;
        break;
      case LiveEnum.ticker:
        value = 2;
        break;
      case LiveEnum.timer:
        value = 3;
        break;
      case LiveEnum.game:
        value = 4;
        break;
    }
    return value;
  }

  String get description {
    String value = "common";
    switch(this) {
      case LiveEnum.common:
        value = "common";
        break;
      case LiveEnum.secret:
        value = "secret";
        break;
      case LiveEnum.ticker:
        value = "ticker";
        break;
      case LiveEnum.timer:
        value = "timer";
        break;
      case LiveEnum.game:
        value = "game";
        break;
    }
    return value;
  }
}