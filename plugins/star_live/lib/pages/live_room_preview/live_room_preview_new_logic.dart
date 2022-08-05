/*
 *  Copyright (C), 2015-2021
 *  FileName: live_room_preview_new_logic
 *  Author: Tonight丶相拥
 *  Date: 2021/12/9
 *  Description: 
 **/

import 'package:get/get.dart';
import 'live_room_type.dart';

class LiveRoomPreviewNewLogic extends GetxController {
  final _LiveRoomPreviewState state = _LiveRoomPreviewState();

  /// 修改房间类型
  void changeLiveRoomType(LiveRoomType type) {
    if (type != state.type.value)
      state._changeIndex(type);
  }

  void labelChange(int index){
    state._labelChange(index);
  }
}

class _LiveRoomPreviewState {

  final List<LiveRoomType> types = [
    LiveRoomType.game,
    LiveRoomType.common,
    LiveRoomType.ticket,
    LiveRoomType.timer
  ];

  /// 房间类型下标
  Rx<LiveRoomType> _index = Rx(LiveRoomType.game);
  Rx<LiveRoomType> get type => _index;

  RxList<int> _indexes = <int>[].obs;
  RxList<int> get indexes => _indexes;

  void _labelChange(int index){
    if (_indexes.length >= 2) {
      _indexes.removeAt(0);
    }
    _indexes.add(index);
  }

  /// 修改房间类型
  void _changeIndex(LiveRoomType type) {
    this._index.value = type;
  }
}