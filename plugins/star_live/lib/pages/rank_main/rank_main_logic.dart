import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/storage.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/generated/rank_new_entity.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/util_tool/stringutils.dart';

import '../live_room/live_room_new_logic.dart';
import 'rank_main_state.dart';

class RankMainLogic extends GetxController with GetTickerProviderStateMixin, PagingMixin ,Toast{
  final RankMainState state = RankMainState();

  @override
  void onInit() {
    super.onInit();
    state.mainController = TabController(length: 2, vsync: this,initialIndex: 0);

    state.menuIndex.value = Get.arguments ?? 0;
    changeMenuTitle(state.menuIndex.value);
  }

  changeMenuTitle(int index){
    state.menuIndex.value = index;
    state.mainController.animateTo(index);
  }

  /*==========  数据请求 =============*/

  Future dataRefresh({String? refreshKey}) {
    return _loadData(1,  (data) {
      if(data.isNotEmpty){
        data.forEach((element) {
          element.isAnchor = state.menuIndex == 0;
          element.heatString = StringUtils.showNmberOver10k(element.heat);
        });

        if(refreshKey == state.getRefreshKey()){
          List tempList = state.currentListData();
          tempList.replaceRange(0, data.length, data);
          update([state.getRefreshKey()]);
        }

      }
    });
  }

  Future _loadData(int page, void Function(List<RankNewEntity>) success){
    /// 下标从1开始
    int  dateType = state.menuIndex.value == 0
        ? state.subAnchorIndex
        : state.subUserIndex ;
    int  rankType = state.menuIndex.value ;
    return HttpChannel.channel.anchorRank(
        page: page,
        dateType: dateType + 1,
        rankType: rankType + 1,
        pageSize: 30
    ).then((value) => value.finalize(
          wrapper: WrapperModel(),
          success: (data) {
            List lst = data ?? [];
            success(lst.map((e) => RankNewEntity.fromJson(e)).toList());
          }
    ));
  }

  ///关注
  toggleAttentionAtIndex(RankNewEntity itemModel,int index){
    Future future;
    String userId = itemModel.userId ?? "";
    String roomId = itemModel.roomId ?? "";
    show();
    if (itemModel.attention == true) {
      future = HttpChannel.channel.favoriteCancel(userId);

    } else {
      future = HttpChannel.channel.favoriteInsert(userId,roomId);
    }
    future.then((value) => value.finalize(
        wrapper: WrapperModel(),
        failure: (e) => showToast(e),
        success: (_) {
          dismiss();
          //如果传进来的是已关注的 那么成功之后是取消 通知当前直播间
          if(itemModel.attention == true){
            if(roomId == StorageService.to.getString("roomId")){
              if(Get.isRegistered<LiveRoomNewLogic>()){
                Get.find<LiveRoomNewLogic>().state.cancelFollow();
              }
            }
          }else{
            //如果传进来的是没有关注的 那么成功之后是已关注 通知当前直播间
            if(Get.isRegistered<LiveRoomNewLogic>()){
              Get.find<LiveRoomNewLogic>().state.following();
            }
          }
          //通知页面更新
          List tempList = state.currentListData();
          RankNewEntity model = tempList[index];
          model.attention = !itemModel.attention!;
          update([state.getRefreshKey()]);

        }));
  }

}
