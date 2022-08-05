import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/router/router_config.dart';
import 'package:star_live/pages/live/live_home_data.dart';
import 'package:star_live/pages/rank_main/rank_main_view.dart';
import 'live_mainview_state.dart';

class LiveMainViewPageLogic extends GetxController
    with SingleGetTickerProviderMixin {
  final LiveMainViewState state = LiveMainViewState();

  @override
  void onInit() {
    super.onInit();
    state.controller = TabController(
        length: state.tabItems.length,
        vsync: this,
        initialIndex: state.currentIndex);
    // Future.delayed(Duration(seconds: 2),(){
    getHomeTabData();
    // });
  }

  reloadTabItems() {
    state.controller = TabController(
        length: state.tabItems.length,
        vsync: this,
        initialIndex: state.currentIndex);
    update();
  }

  int currentTabId(int index) {
    return state.tabItems[index].id!;
  }

  /* ----------- 请求  ---------------*/

  Future getHomeTabData() {
    return HttpChannel.channel.cateGoryLabel()
      ..then((value) => value.finalize(
          wrapper: WrapperModel(),
          success: (data) {
            List lst = data ?? [];
            List<HomeTabDataEntity> tabData =
                lst.map((e) => HomeTabDataEntity.fromJson(e)).toList();
            state.tabItems.clear();
            state.tabItems = tabData;
            //追加关注
            state.tabItems.insert(0, state.foucsItem());
            this.reloadTabItems();

            tabData.forEach((element) {
              print("tabbar.id   ${element.id}  名字：${element.name}");
            });
          }));
  }

  /* ------------- 跳转 --------------  */

  pushHomeSearchPage(BuildContext context) {
    Get.toNamed(AppRoutes.homeSearchPage);
  }

  pushHomeRankingPage(BuildContext context) {
    Get.toNamed(AppRoutes.rankIntegration);

  }

  pushLoginNewPage(BuildContext context) {
    Get.toNamed(AppRoutes.logInNew);
  }
}
