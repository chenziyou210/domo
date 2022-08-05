import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:star_common/generated/bank_list_entity.dart';
import 'package:hjnzb/pages/my_mine/mine_withdraw/mine_withdraw_logic.dart';

/// @description:
/// @author
/// @date: 2022-06-03 12:51:36
class MineWithdrawInfoState {
  MineWithdrawInfoState() {
    ///Initialize variables
  }
  //输入金额输入框
  final controller = TextEditingController();
  RxString inputAmount = "0".obs;
  setUpdateInputAmount(String value) {
    inputAmount.value = value;
  }
  ///是否有银行卡,或者钱包
  RxBool isCardInfo = false.obs;
  setUpdateIsCardInfo(bool value) {
    isCardInfo.value = value;
  }

  ///银行卡信息
  BankListData? bankCardInfo;
  //钱包信息
  BindWalletListEntity? walletinfo;

  MineWithdrawData? withdrawData;
  List<BankListData>? bankList;
  List<BindWalletListEntity>? walletList;
  //余额,打码量
  WithDrawUserBalance? balanceData;
  int selectIndex = 0;
//   String content = """1.提现时需绑定您有效的收款信息，请核实您的填写的信息无误。
// 2.提现条件：打码量为0时，可进行提现行为，打码量不为0时，不可以进行提现。

// 打码量指在平台消费的金额，可以为游戏中的有效投注金额数及直播消费金额数
// 列如：您充值了100元，需要您游戏娱乐投注100元或以上金额，也可以兑换为钻石进行消费，当消费金额满足时，方可提现。
// 因存在系统结算时间，请以当前打码量为准。

// 备注：禁止在本平台进行洗黑钱，恶意套利等行为，如发现将永久封号处理。""";
}

class WithDrawUserBalance {
  double? balance;
  double? withdraw;

  WithDrawUserBalance({this.balance, this.withdraw});

  WithDrawUserBalance.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    withdraw = json['withdraw'];
  }
}
