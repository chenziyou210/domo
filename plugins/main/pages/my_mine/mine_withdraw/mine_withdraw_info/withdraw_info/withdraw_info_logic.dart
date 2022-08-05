import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hjnzb/pages/my_mine/mine_wallet/mine_charge_and_withdraw/mine_charge_and_withdraw_view.dart';
import 'package:hjnzb/pages/my_mine/my_mine_view.dart';
import 'package:star_common/router/router_config.dart';

import 'withdraw_info_state.dart';

/// @description:
/// @author
/// @date: 2022-07-26 17:10:43
class WithdrawInfoLogic extends GetxController {
  final state = WithdrawInfoState();
  goToInfo() {
    Get.to(() => MineChargeAndWithdrawPage());
  }

  gotoHome(BuildContext context) {
    // Get.back();
    Navigator.of(context).popUntil(ModalRoute.withName(AppRoutes.tab));
  }
}
