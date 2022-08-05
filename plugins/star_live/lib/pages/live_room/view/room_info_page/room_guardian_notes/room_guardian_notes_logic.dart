import 'package:alog/alog.dart';
import 'package:get/get.dart';

import 'room_guardian_notes_state.dart';

/// @description:
/// @author
/// @date: 2022-06-16 16:30:33
class RoomGuardianNotesLogic extends GetxController {
  final state = RoomGuardianNotesState();
  @override
  void onReady() {
    // TODO: implement onReady
    state.controller.addListener(() async {
      if (state.controller.offset < 80 && state.isScroll) {
        state.isScroll = false;
      } else if (state.controller.offset > 80 && state.isScroll == false) {
        state.isScroll = true;
      }
      update();
    });
    super.onReady();
  }
}
