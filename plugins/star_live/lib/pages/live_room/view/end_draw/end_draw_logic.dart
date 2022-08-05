/*
 *  Copyright (C), 2015-2021
 *  FileName: end_draw_logic
 *  Author: Tonight丶相拥
 *  Date: 2021/11/26
 *  Description: 
 **/

import 'package:get/get.dart';
import 'package:star_common/common/storage.dart';
import 'package:star_common/generated/anchor_list_model_entity.dart';
import 'package:star_common/http/http_channel.dart';


class EndDrawLogic extends GetxController with PagingMixin<AnchorListModelEntity> {
  EndDrawLogic();
  final _EndDrawState state = _EndDrawState();

  @override
  void onReady() {
    super.onReady();
    dataRefresh();
    print("jimi  sd");
  }

  @override
  Future dataRefresh() {
    // TODO: implement refresh
    page = 1;
    return getData(page, (data) {
      state._setData(data);
    });
  }

  @override
  Future loadMore() {
    // TODO: implement loadMore
    page ++;
    return getData(page,  (data) {
      state._addMoreData(data);
    });
  }

  /// 获取数据
  Future getData(int page,  void Function(List<AnchorListModelEntity>) callBack){
    return HttpChannel.channel.livingRoomRecommend( page)
      ..then((value) => value.finalize(
        wrapper: WrapperModel(),
        success: (data) {
          List d = data["data"] ?? [];
          callBack(d.map((e) => AnchorListModelEntity.fromJson(e)).toList());
        }
      ));
  }
}

class _EndDrawState {
  RxList<AnchorListModelEntity> _data = <AnchorListModelEntity>[].obs;
  RxList<AnchorListModelEntity> get data => _data;

  void _setData(List<AnchorListModelEntity> data){
    List<AnchorListModelEntity> audiencesList = [];
    data.forEach((element) {
      if (element.id.toString().trim() !=
          StorageService.to.getString("roomId").trim()) {
        audiencesList.add(element);
      }
    });
    _data.value = audiencesList;
  }

  void _addMoreData(List<AnchorListModelEntity> data){
    _data += data;
  }

}