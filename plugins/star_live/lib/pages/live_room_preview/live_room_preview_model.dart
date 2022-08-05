/*
 *  Copyright (C), 2015-2021
 *  FileName: live_room_preview_model
 *  Author: Tonight丶相拥
 *  Date: 2021/9/26
 *  Description: 
 **/


import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:star_common/base/app_base.dart';
import 'package:star_common/generated/anchor_label_entity.dart';
import 'package:star_common/http/http_channel.dart';

class LiveRoomPreviewModel extends AppModel with ChangeNotifier {

  int _index = 0;
  int get index => _index;

  /// 更改下标
  void changeIndex(int index){
    this._index = index;
    if (hasListeners) {
      notifyListeners();
    }
  }

  late Future _future;
  Future get future => _future;

  /// 标签
  List<AnchorLabelEntity> _label = [];
  List<AnchorLabelEntity> get label => _label;

  int? _labelIndex = 0;
  int? get labelIndex => _labelIndex;

  void changeLabel(int index){
    _labelIndex = index;
    if (hasListeners) {
      notifyListeners();
    }
  }

  /// 主播标签
  Future anchorLabel() async{
    _future = HttpChannel.channel.anchorLabel()..then((value) =>
      value.finalize(
        wrapper: WrapperModel(),
        failure: (err) => showToast(err),
        success: (data) {
          List lst = data["data"] ?? [];
          _label = lst.map((e) => AnchorLabelEntity.fromJson(e)).toList();
        }
      ));

    return;
  }
}