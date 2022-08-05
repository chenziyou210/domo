/*
 *  Copyright (C), 2015-2021
 *  FileName: muting_list_mode
 *  Author: Tonight丶相拥
 *  Date: 2021/11/2
 *  Description: 
 **/

import 'package:star_common/generated/favorite_entity.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:hjnzb/pages/black_list/black_list_model.dart';

class MutingListModel extends BlackListModel {
  MutingListModel(this._anchorId);
  final String _anchorId;

  @override
  Future dataRequest(int page,
      {void Function(String p1)? failure, Function? success}) {
    // TODO: implement dataRequest
    return HttpChannel.channel
        .banSpeakList(_anchorId, page)
        .then((value) => value.finalize(
            wrapper: WrapperModel(),
            failure: failure,
            success: (data) {
              List lst = data["data"] ?? [];
              success
                  ?.call(lst.map((e) => FavoriteEntity.fromJson(e)).toList());
            }));
  }

  void delete(int index) {
    show();
    HttpChannel.channel
        .deleteBanSpeak(data[index].id!)
        .then((value) => value.finalize(
            wrapper: WrapperModel(),
            failure: (e) => showToast(e),
            success: (_) {
              dismiss();
              data.removeAt(index);
              data = List.from(data);
              notifyListeners();
            }));
  }
}
