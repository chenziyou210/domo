// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:alog/alog.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/generated/sample_user_info_entity.dart';
import 'package:star_common/http/http_channel.dart';

import 'room_user_info_state.dart';

/// @description:
/// @author
/// @date: 2022-06-13 19:00:46
class RoomUserInfoLogic extends GetxController with Toast {
  final state = RoomUserInfoState();
  late int userId;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    //getUserInfo(this.userId);
    getLiveRoomUserInfo(this.userId);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    Alog.e("释放");
  }

  void getLiveRoomUserInfo(int userId) {
    HttpChannel.channel.getLiveRoomUserInfo("${userId}")
      ..then((value) {
        value.finalize(
            wrapper: WrapperModel(),
            failure: (e) {
              showToast(e);
            },
            success: (data) {
              state.userinfo = SampleUserInfoEntity.fromJson(data);
              state.nobleType = state.userinfo!.nobleType;
              update();
            });
      });
  }

  //  设置禁言
  changeRoomBanspeak() {
    if (state.userinfo?.nobleType == 2003) {
      /// 年守护用户无法禁言
      showToast('该用户为守护用户无法禁言');
      return;
    }

    if (state.nobleType == 1006 || state.nobleType == 1007) {
      /// 年守护用户无法禁言
      showToast('该用户为贵族用户无法禁言');
      return;
    }

    if (state.userinfo?.speakBan == 0) {
      liveRoomBanspeak();
    } else {
      // liveRoomBanspeakDelete();
    }
  }

  ///  取消禁言
  liveRoomBanspeakDelete() {
    HttpChannel.channel
        .liveRoomBanspeakDelete("${this.userId}")
        .then((value) => value.finalize(
            wrapper: WrapperModel(),
            failure: (e) => showToast(e),
            success: (data) {
              // print(data);
              showToast("取消禁言成功");
              state.userinfo?.speakBan = 0;
              update();
            }));
  }

  ///  添加禁言
  liveRoomBanspeak() {
    HttpChannel.channel
        .liveRoomBanspeak("${this.userId}")
        .then((value) => value.finalize(
            wrapper: WrapperModel(),
            failure: (e) => showToast(e),
            success: (data) {
              // print(data);
              showToast("添加禁言成功");
              state.userinfo?.speakBan = 1;
              update();
            }));
  }

//  设置管理员
  changeRoomManage() {
    if (state.userinfo?.adminFlag == 0) {
      liveRoomManagerAdd();
    } else {
      liveRoomManagerDelete();
    }
  }

  /// 添加管理员
  liveRoomManagerAdd() {
    HttpChannel.channel
        .liveRoomManagerAdd("${this.userId}")
        .then((value) => value.finalize(
            wrapper: WrapperModel(),
            failure: (e) => showToast(e),
            success: (data) {
              print(data);
              showToast("添加管理员成功");
              state.userinfo?.adminFlag = 1;
              update();
            }));
  }

  /// 取消管理员
  liveRoomManagerDelete() {
    HttpChannel.channel
        .liveRoomManagerDelete("${this.userId}")
        .then((value) => value.finalize(
            wrapper: WrapperModel(),
            failure: (e) => showToast(e),
            success: (data) {
              showToast("取消管理员成功");
              state.userinfo?.adminFlag = 0;
              update();
            }));
  }

  //设置翅膀
  String setFramedWings(int type) {
    switch (type) {
      //游侠没翅膀
      // case 1001:
      //   return AppImages.room_sheet_top_youxia;
      case 1002:
        return R.gzZlkQishi;
      case 1003:
        return R.gzZlkZijue;
      case 1004:
        return R.gzZlkBojue;
      case 1005:
        return R.gzZlkHoujue;
      case 1006:
        return R.gzZlkGongjue;
      case 1007:
        return R.gzZlkGuowang;
      default:
        return "";
    }
  }

  //相框
  String setAvatarFrame(int type) {
    switch (type) {
      case 1001:
        return R.nobleAvatarYouxia;
      case 1002:
        return R.nobleAvatarQishi;
      case 1003:
        return R.nobleAvatarZijue;
      case 1004:
        return R.nobleAvatarBojue;
      case 1005:
        return R.nobleAvatarHoujue;
      case 1006:
        return R.nobleAvatarGongjue;
      case 1007:
        return R.nobleAvatarGuowang;
      default:
        return "";
    }
  }

  // String setTitleNoble(int type) {
  //   switch (type) {
  //     case 1001:
  //       return AppImages.room_sheet_youxia;
  //     case 1002:
  //       return AppImages.room_sheet_qishi;
  //     case 1003:
  //       return AppImages.room_sheet_zijue;
  //     case 1004:
  //       return AppImages.room_sheet_bojue;
  //     case 1005:
  //       return AppImages.room_sheet_houjue;
  //     case 1006:
  //       return AppImages.room_sheet_gongjue;
  //     case 1007:
  //       return AppImages.room_sheet_guowang;
  //     default:
  //       return "";
  //   }
  // }

}
