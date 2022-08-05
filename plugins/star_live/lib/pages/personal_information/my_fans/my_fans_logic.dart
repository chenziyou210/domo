import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/manager/app_manager.dart';
import 'package:star_common/manager/user/user_info.dart';
import 'package:star_common/router/router_config.dart';
import 'my_fans_state.dart';

/// @description:
/// @author
/// @date: 2022-05-25 18:52:49
class MyFansLogic extends GetxController with Toast {
  final state = MyFansState();
  MyFansLogic(int type, String? userId) {
    // print('type ===== $type');
    state.folowOrFans = type == 0;
    state.userId = userId ?? AppManager.getInstance<AppUser>().userId!;
    state.pageController = PageController(
      initialPage: type,
      keepPage: true,
    );
    state.listData = [];
    state.page = 1;
    state.totalNum = 0;
    requestPage();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    // state.refreshController.requestRefresh();
  }

  requestPage() {
    if (state.folowOrFans == true) {
      HttpChannel.channel
          .favoritePaging(state.userId, state.page, 20)
          .then((value) {
        var data = value.data['data']['data'];
        state.totalNum = value.data['data']['total'];
        if (state.page == 1) {
          state.listData = data;
        } else {
          state.listData += data;
        }
        if (data.length > 0) {
          state.page++;
        }
        // if (data.length < 20) {
        //   state.refreshController.refreshCompleted();
        //   state.refreshController.resetNoData();
        // } else {
        state.refreshController.refreshCompleted();
        state.refreshController.loadComplete();
        // }
        update();
      });
    } else {
      HttpChannel.channel.fansPage(state.userId, state.page, 20).then((value) {
        var data = value.data['data']['data'];
        state.totalNum = value.data['data']['total'];
        if (state.page == 1) {
          state.listData = data;
        } else {
          state.listData += data;
        }
        if (data.length > 0) {
          state.page++;
        }
        // if (data.length < 20) {
        //   state.refreshController.refreshCompleted();
        //   state.refreshController.resetNoData();
        // } else {
        state.refreshController.refreshCompleted();
        state.refreshController.loadComplete();
        // }
        update();
      });
    }
  }

  /// 粉丝列表
  // requestFanListPage(int page) {
  //   HttpChannel.channel.fansPage(1).then((value) {
  //     state.listData = [];
  //     var data = value.data['data']['data'];
  //     state.listData = data;
  //     update();
  //     state.refreshController.refreshCompleted();
  //     state.refreshController.loadComplete();
  //   });
  // }

  void setFollowOrFans(bool value) {
    state.folowOrFans = value;
    update();
    state.pageController.jumpToPage(value == true ? 0 : 1);
  }

  void favoriteCancel(int index) {
    // TODO: implement onDelete
    var model = state.listData[index];
    print(model);
    show();
    HttpChannel.channel
        .favoriteCancel(model["userId"].toString())
        .then((value) => value.finalize(
            wrapper: WrapperModel(),
            failure: (e) => showToast(e),
            success: (_) {
              dismiss();
              model['isFollow'] = 0;
              update();
            }));
  }

  void favoriteInsert(int index) {
    // TODO: implement onDelete
    var model = state.listData[index];
    print(model);
    show();
    HttpChannel.channel
        .favoriteInsert(model["userId"].toString(),"")
        .then((value) => value.finalize(
            wrapper: WrapperModel(),
            failure: (e) => showToast(e),
            success: (_) {
              dismiss();
              model['isFollow'] = 1;
              update();
            }));
  }

  pushToOtherInfo(BuildContext? context, Map<String, dynamic> args) {
    if (context != null) {
      Get.toNamed(AppRoutes.userById, arguments: args);
      // Navigator.of(context).pushNamed(AppRoutes.userById, arguments: args);
    }
  }
}
