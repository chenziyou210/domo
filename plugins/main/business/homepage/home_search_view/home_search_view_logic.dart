import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/router/router_config.dart';
import 'home_search_view_state.dart';

class HomeSearchViewLogic extends GetxController with Toast {
  final HomeSearchViewState state = HomeSearchViewState();



  @override
  void onInit() {
    // TODO: implement onIni
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    state.myController.clear();
    state.searchList.clear();
    state.inputText.value = "";
    state.isSearch.value = false;
    super.onClose();

  }

  @override
  // TODO: implement onDelete
  InternalFinalCallback<void> get onDelete {
    state.myController.clear();
    state.searchList.clear();
    state.inputText.value = "";
    update();
    return super.onDelete;
  }

  /*  ============== 点击  ================*/
  /// 观众直播间列表
  pushAudiencePage(BuildContext context, Map arguments) {
    Get.toNamed(AppRoutes.audiencePage,arguments: arguments);
  }

  /// 个人信息
  pushUserInfo(BuildContext context, Map<String, dynamic> args) {
    Get.toNamed(AppRoutes.userById, arguments: args);
  }

  /*  ============== 请求  ================*/
  requestSearchInfoData() async {
    var key = state.inputText.value;
    if (key.length > 0) {
      show();
      await Future(() => HttpChannel.channel.homeSearchInfo(userIdOrName: key)
        ..then((value) => value.finalize(
            wrapper: WrapperModel(),
            success: (data) {
              dismiss();
              List lst = data ?? null;
              List<HomeSearchModel> searchInfo =
                  lst.map((e) => HomeSearchModel.fromJson(e)).toList();
              state.searchList.clear();
              state.searchList.addAll(searchInfo);
              update();
            },
            failure: (e) {
              dismiss();
              showToast(e, duration: Duration(seconds: 2));
            })));
    } else {
      showToast("请输入关键字", duration: Duration(seconds: 2));
    }
  }
}
