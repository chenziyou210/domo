import 'package:get/get.dart';
import 'package:star_common/http/http_channel.dart';

import '../live_room_new_logic.dart';
import 'open_guide_state.dart';

class OpenGuideLogic extends GetxController {
  final OpenGuideState state = OpenGuideState();


  Future getLiveRoomWatchUser() {
    return HttpChannel.channel.getLiveRoomWatchUser("${Get.find<LiveRoomNewLogic>().state.roomInfo.value.roomId}")
      ..then((value) => value.finalize(
          wrapper: WrapperModel(),
          success: (data) {
            state.setDetails(LiveRoomWatchUserData.fromJson(data));
          }));
  }


}
