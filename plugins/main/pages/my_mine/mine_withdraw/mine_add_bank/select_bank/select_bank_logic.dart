import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/http/http_channel.dart';

import 'select_bank_state.dart';

/// @description:
/// @author
/// @date: 2022-06-06 12:37:04
class SelectBankLogic extends GetxController {
  final state = SelectBankState();
  @override
  void onInit() {
    super.onInit();
  }

  requestBankList() {
    HttpChannel.channel.systemBankList().then((value) {
      if (value != null) {
        state.list = value.data['data'];
        update();
      } else {}
    }, onError: (e) {
      print(e);
    });
  }

  selectionData(BuildContext context, int index) {
    state.showIndex = index;
    update();
    Get.back();
  }
}
