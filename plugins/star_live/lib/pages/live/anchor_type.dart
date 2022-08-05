/*
 *  Copyright (C), 2015-2021
 *  FileName: anchor_type
 *  Author: Tonight丶相拥
 *  Date: 2021/8/9
 *  Description: 
 **/


enum AnchorType {
  attention,
  popular,
  game
}

extension AnchorTypeExtension on AnchorType {
  int get rawValue {
    int value;
    switch (this) {
      case AnchorType.attention:
        value = 1;
        break;
      case AnchorType.popular:
        value = 2;
        break;
      case AnchorType.game:
        value = 3;
        break;
    }
    return value;
  }
}