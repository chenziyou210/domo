/*
 *  Copyright (C), 2015-2021
 *  FileName: live_detail_model
 *  Author: Tonight丶相拥
 *  Date: 2021/8/9
 *  Description: 
 **/

import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/generated/anchor_list_model_entity.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:httpplugin/http_result_container/http_result_container.dart';

class LiveViewModel extends CommonNotifierModel with PagingMixin<AnchorListModelEntity>, Toast {
  LiveViewModel(this._type);
  final int? _type;

   int ? type;

  /// 数据请求
  Future _dataRequest(int page, {Failure? failure, void Function(dynamic)? success}) {
    // int type = this.type ?? _type;

    print("下拉刷新");

    Future<HttpResultContainer> future;
    if (this.type == null) {
      if(_type==1111){
        future = HttpChannel.channel.watchlistListByType(page);
      }else{
        future = HttpChannel.channel.anchorListByType(page, _type,15);
      }
    }else {
      future = HttpChannel.channel.searchAnchorOnType(type!, page: page);
    }
    return future..then((value) =>
        value.finalize(
          wrapper: WrapperModel(),
          failure: failure,
          success: (data) {
            if (data is Map) {
              List lst = data["data"] ?? [];
              // _count = data["total"];
              success?.call(lst.map((e) => AnchorListModelEntity.fromJson(e)).toList());
            }
          }
        ));
  }

  @override
  Future dataRefresh() {
    // TODO: implement refresh
    page = 1;
    return _dataRequest(page, failure: (e) {
      showToast(e);
    }, success: (data){
      dismiss();
      page ++;
      this.data = data;
      updateState();
    });
  }

  @override
  Future loadMore() {
    // TODO: implement loadMore
    return _dataRequest(page, failure: (e) {
      showToast(e);
    }, success: (data){
      page ++;
      this.data += data;
      updateState();
    });
  }

  // @override
  // // TODO: implement hasMoreData
  // bool get hasMoreData => _count == null || data.length < _count!;
}



