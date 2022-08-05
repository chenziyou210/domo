import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:spring/spring.dart';
import 'package:star_common/generated/bank_list_entity.dart';
import 'package:star_common/manager/user/user_balance_logic.dart';

/// @description:
/// @author
/// @date: 2022-05-31 14:43:43
class MineWalletState {
  // dynamic? data = null;
  // UserBalanceLonic balanceLonic = Get.find<UserBalanceLonic>();
  MineWalletState() {
    ///Initialize variables
  }
  Rx<UserBalanceData> _userBalance = UserBalanceData().obs;
  Rx<UserBalanceData> get userBalance => _userBalance;

  ///刷新金币动画
  final SpringController springCoinsController =
      SpringController(initialAnim: Motion.pause);

  ///刷新钻石动画
  final SpringController springDrinksCoinsController =
      SpringController(initialAnim: Motion.pause);

  void setUserBalanceData(UserBalanceData value) {
    _userBalance.value = value;
  }

  List<BankListData>? bankList;
  List<BindWalletListEntity>? walletList;
  RxInt bankListCount = 0.obs;
  setUpdateBankListCount(int value) {
    bankListCount.value = value;
  }

  RxInt walletCount = 0.obs;
  setUpdateWalletCount(int value) {
    walletCount.value = value;
  }
}
