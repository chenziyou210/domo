import 'package:get/get.dart';

import '../../../../../live_room_new_logic.dart';
import 'state.dart';

class GameHowToPlayLogic extends GetxController {
  final GameHowToPlayState state = GameHowToPlayState();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    Get.find<LiveRoomNewLogic>().closeGameBackView = (payload) {
      Get.back();
    };
  }
}
