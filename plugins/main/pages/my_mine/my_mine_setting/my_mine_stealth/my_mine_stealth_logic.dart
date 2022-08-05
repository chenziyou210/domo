import 'package:get/get.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/cache.dart';
import 'package:star_common/http/http_channel.dart';

import 'my_mine_stealth_state.dart';

/// @description:
/// @author
/// @date: 2022-06-26 11:30:26
class MyMineStealthLogic extends GetxController with Toast {
  final state = MyMineStealthState();
  @override
  void onInit() {
    getNobelHideStatus();
    super.onInit();
  }

  void getNobelHideStatus() {
    HttpChannel.channel.getNobelHideStatus()
      ..then((value) {
        value.finalize(
            wrapper: WrapperModel(),
            failure: (e) {
              showToast(e);
            },
            success: (data) {
              state.enterHide = data['roomProperties'];
              state.rankListHide = data['rankProperties'];
              update();
            });
      });
  }

  Future setNobelHideStatus(int? rankProperties, int? roomProperties) {
    show();
    return HttpChannel.channel
        .setNobelHideStatus(rankProperties, roomProperties)
      ..then((value) {
        value.finalize(
            wrapper: WrapperModel(),
            failure: (e) {
              showToast(e);
            },
            success: (data) {
              dismiss();
              update();
            });
      });
  }
}
