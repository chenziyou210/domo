import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/common_widget/components/components_view.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:hjnzb/pages/game/game_list_model.dart';
import 'package:star_common/manager/user/user_balance_logic.dart';
import 'package:star_common/router/router_config.dart';
import 'package:star_live/pages/live/live_home_data.dart';
import '../../business/homepage/models/homepage_model.dart';
import 'jump_game_state.dart';

class JumpGameLogic extends GetxController with Toast {
  final JumpGameState state = JumpGameState();

  @override
  void onInit() {
    super.onInit();
    appBannerLoad();
    appAnnouncementLoad();
  }

  void loadGameList(bool needActivity) {
    // if (needActivity) show();
    HttpChannel.channel.gameList().then((value) {
      // state.refreshController.refreshCompleted();
      // dismiss();
      value.finalize(
          wrapper: WrapperModel(),
          failure: (e) => showToast(e),
          success: (data) {
            List lst = data ?? [];
            state.addGames(lst.map((e) => GameList.fromJson(e)).toList());
          });
    });
  }

  Future appBannerLoad() {
    return HttpChannel.channel.advertiseBanner(advertiseType: 6)
      ..then((value) => value.finalize(
          wrapper: WrapperModel(),
          success: (data) {
            List lst = data ?? [];
            List<HomeBannerInfo> banner =
                lst.map((e) => HomeBannerInfo.fromJson(e)).toList();
            state.addBanner(banner);
          }));
  }

  Future appAnnouncementLoad() {
    return HttpChannel.channel.announcementList(3)
      ..then((value) => value.finalize(
          wrapper: WrapperModel(),
          success: (data) {
            List lst = data ?? [];
            List<HomeAnnouncementEntity> announcement =
                lst.map((e) => HomeAnnouncementEntity.fromJson(e)).toList();
            state.setAnnouncementData(announcement);
          }));
  }

  void gameTransferIn(String gameId) {
    // print('游戏上分');
    HttpChannel.channel.transferIn(gameId: gameId).then((value) {
      // state.refreshController.refreshCompleted();
      // dismiss();
      value.finalize(
          wrapper: WrapperModel(),
          failure: (e) => showToast(e),
          success: (data) {
            print('游戏下分成功');
            Get.find<UserBalanceLonic>().userBalanceData();
          });
    });
  }

  void gameTransferInOut(String gameId) {
    // print('游戏上分');
    HttpChannel.channel.transferInOut(gameId: gameId).then((value) {
      // state.refreshController.refreshCompleted();
      // dismiss();
      value.finalize(
          wrapper: WrapperModel(),
          failure: (e) => showToast(e),
          success: (data) {
            print('游戏上分成功');
          });
    });
  }

  void gotoGameDetail(String gameId) {
    show();
    HttpChannel.channel
        .gameUrl(
            // gameCompanyId: model.gameCompanyId!,
            gameId: gameId)
        .then((value) {
      value.finalize(
          wrapper: WrapperModel(),
          failure: (e) => showToast(e),
          success: (data) {
            dismiss();
            var gameUrl = data["gameUrl"];
            Get.toNamed(AppRoutes.webviewGame, arguments: {
              "url": gameUrl,
              "gameId": gameId,
            });
            // Navigator.of(context).pushNamed(AppRoutes.webviewGame, arguments: {
            //   "url": gameUrl,
            //   "gameId": gameId,
            // });
          });
    });
  }
}
