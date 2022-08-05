import 'package:get/get.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/manager/user/user_balance_logic.dart';

import '../../../../live_room_new_logic.dart';
import 'web_view_game_page_state.dart';

/// @description:
/// @author
/// @date: 2022-07-22 19:10:44
class WebViewGamePageLogic extends GetxController with Toast {
  final state = WebViewGamePageState();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    gameTransferInOut(state.gameId ?? "");
    Get.find<LiveRoomNewLogic>().closeGameBackView = (payload) {
      Get.back();
    };
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    gameTransferIn(state.gameId ?? "");
  }

  void gameTransferIn(String gameId) {
    HttpChannel.channel.transferIn(gameId: gameId).then((value) {
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
    HttpChannel.channel.transferInOut(gameId: gameId).then((value) {
      value.finalize(
          wrapper: WrapperModel(),
          failure: (e) => showToast(e),
          success: (data) {
            print('游戏上分成功');
          });
    });
  }
}
