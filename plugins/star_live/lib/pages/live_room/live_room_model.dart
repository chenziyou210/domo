/*
 *  Copyright (C), 2015-2021
 *  FileName: live_room_model
 *  Author: Tonight丶相拥
 *  Date: 2021/7/28
 *  Description: 
 **/

import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/storage.dart';
import 'package:star_live/agora_rtc/agora_rtc.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/generated/gift_entity.dart';
import 'package:star_common/generated/sample_user_info_entity.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/manager/app_manager.dart';
import 'package:star_live/pages/live_room/view/room_info_page/room_live_game/game_net_work.dart';
import '../../common/user_info_operation.dart';
import '/pages/live_room/mute_model.dart';

// import '../../business/home_pages/homepage/homepage_logic.dart';
import 'package:star_common/generated/LiveRoomInfoEntity.dart';
import 'package:star_common/manager/user/user_balance_logic.dart';
import 'package:star_common/common/app_common_widget.dart'
    show EventBus, refreshAttention;

class LiveRoomModel extends AppModel {
  LiveRoomModel({required bool isAnchor, MuteModel? model}) {
    // this.trtcModel = TRTCModel(viewNeedPop, scrollPopToTop, isAnchor: isAnchor,
    //     mute: model);
  }
  LiveRoomViewModel viewModel = LiveRoomViewModel();
  // late TRTCModel trtcModel;

  void dispose() {
    // trtcModel.dispose();
  }

  void dataRefresh() {
    viewModel.dataRefresh();
  }

  void loadMore() {
    viewModel.loadMore();
  }

  void follow(String id) {
    HttpChannel.channel.favoriteInsert(id,StorageService.to.getString("roomId"))
      ..then((value) => value.finalize(
          wrapper: WrapperModel(),
          success: (_) {
            viewModel._following();

            ///刷新关注
            // Get.find<HomepageLogic>().changeTabDataWithType(1111);
            EventBus.instance.notificationListener(name: refreshAttention);
          }));
  }

  /// 计时收费
  void timerLive(dynamic value, String id) {
    HttpChannel.channel.timerLiveRoom(id)
      ..then((value) => value.finalize(
          wrapper: WrapperModel(),
          failure: (e) {
            showToast(e);
            AgoraRtc.rtc.leaveChannel();
          },
          success: (_) {
            Get.find<UserBalanceLonic>().userBalanceData();
          }));
  }

  void followCancel(String id) {
    HttpChannel.channel.favoriteCancel(id)
      ..then((value) => value.finalize(
          wrapper: WrapperModel(),
          success: (_) {
            viewModel._cancelFollow();

            ///刷新关注
            EventBus.instance.notificationListener(name: refreshAttention);
          }));
  }

  // /// 房间验证
  // Future<WrapperModel> verify(String roomId, bool state, value) async{
  //   show();
  //   var result = await HttpChannel.channel.verifyLiveRoom(roomId: roomId,
  //       state: state ? 1 : 2, value: value).then((value) =>
  //       value.finalize<WrapperModel>(
  //           wrapper: WrapperModel(),
  //           failure: (e) => showToast(e),
  //           success: (_) {
  //             dismiss();
  //           }
  //       ));
  //   return result;
  // }

  Future roomInfo({required String roomId}) {
    return HttpChannel.channel.liveRoomInfo(roomId: roomId)
      ..then((value) => value.finalize(
          wrapper: WrapperModel(),
          success: (data) {
            if (data != null) {
              viewModel._setRoomInfo(LiveRoomInfoEntity.fromJson(data));
              // trtcModel.viewModel.setAudienceCount(viewModel._entity!.audiencesCount ?? 0);
            }
          }));
  }

  /// 游戏现状
  Future<void> runtimeGame() async {
    await HttpChannel.channel.runtimeGame().then((value) => value.finalize(
        wrapper: WrapperModel(),
        success: (data) {
          AppManager.getInstance<Game>().setCurrentData(data);
        }));
    return;
  }
}

class LiveRoomViewModel extends CommonNotifierModel
    with PagingMixin<GiftEntity>, Toast {
  /// 房间信息
  LiveRoomInfoEntity? _entity;
  LiveRoomInfoEntity? get roomInfo => _entity;

  // 姓名
  String? _name = "Henrietta";
  String? get name => _name;

  // id
  String? _id = "4126345";
  String? get id => _id;

  String? _coin = "345667";
  String? get coin => _coin;

  bool _follow = false;
  bool get follow => _follow;

  void _following() {
    _follow = true;
    updateState();
  }

  void _cancelFollow() {
    _follow = false;
    updateState();
  }

  void _setRoomInfo(LiveRoomInfoEntity info) {
    this._entity = info;
    this._follow = this._entity!.isFollowed ?? false;
    updateState();
  }

  @override
  Future loadMore() {
    // TODO: implement loadMore
    return _getData(page, (e) {
      showToast(e);
    }, (data) {
      this.data += data;
      page++;
      updateState();
    });
  }

  @override
  Future dataRefresh() {
    // TODO: implement refresh
    page = 1;
    return _getData(page, (e) {
      showToast(e);
    }, (data) {
      this.data = data;
      page++;
      updateState();
    });
  }

  Future _getData(int page, void Function(String) failure,
      void Function(List<GiftEntity>) success) {
    return UserInfoOperation.getGiftList(
        success: (list) {
          success(list);
        },
        specialSuccess: (list) {});
  }
}
