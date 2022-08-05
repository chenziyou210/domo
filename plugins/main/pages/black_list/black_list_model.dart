/*
 *  Copyright (C), 2015-2021
 *  FileName: black_list_model
 *  Author: Tonight丶相拥
 *  Date: 2021/8/4
 *  Description: 
 **/

import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:star_common/base/app_base.dart';
import 'package:star_common/generated/favorite_entity.dart';
import 'package:star_common/http/http_channel.dart';

class BlackListModel extends AppModel
    with PagingMixin<FavoriteEntity>, ChangeNotifier {
  @override
  Future loadData() {
    // TODO: implement loadData
    return dataRefresh();
  }

  @override
  // TODO: implement hasMoreData
  bool get hasMoreData => _count == null || data.length < _count!;

  // 总数
  int? _count;

  @override
  Future dataRefresh() {
    // TODO: implement refresh
    page = 1;
    return dataRequest(page, success: (data) {
      page++;
      this.data = data;
      notifyListeners();
    }, failure: (e) {
      showToast(e);
    });
  }

  @override
  Future loadMore() {
    return dataRequest(page, success: (data) {
      page++;
      this.data += data;
      notifyListeners();
    }, failure: (e) {
      showToast(e);
    });
  }

  // 数据加载
  Future dataRequest(int page,
      {void Function(String)? failure, Function? success}) {
    return HttpChannel.channel.blackList(page)
      ..then((value) => value.finalize(
          wrapper: WrapperModel(),
          failure: failure,
          success: (data) {
            if (data is Map) {
              _count = data["total"];
            }
            List lst = data["data"] ?? [];
            success?.call(lst.map((e) => FavoriteEntity.fromJson(e)).toList());
          }));
  }

  void onDelete(int index) {}
}
