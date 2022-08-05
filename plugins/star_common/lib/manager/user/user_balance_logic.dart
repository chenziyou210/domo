/*
 *  Copyright (C), 2015-2021
 *  FileName: live_new_logic
 *  Author: Tonight丶相拥
 *  Date: 2021/12/7
 *  Description: 
 **/

import 'package:get/get.dart';
import 'package:star_common/http/http_channel.dart';

class UserBalanceLonic extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userBalanceData();
  }

  final UserBalanceState state = UserBalanceState();

  Future userBalanceData() {
    return HttpChannel.channel.userBalance()
      ..then((value) => value.finalize(
          wrapper: WrapperModel(),
          success: (data) {
            state.setUserBalanceData(UserBalanceData.fromJson(data));
          }));
  }
}

class UserBalanceData {
  double? balance;
  int? giftDiamondNum;
  int? binkBankNum;
  int? coinBalance;
  int? walletAddress;

  UserBalanceData(
      {this.balance,
      this.giftDiamondNum,
      this.binkBankNum,
      this.coinBalance,
      this.walletAddress});

  UserBalanceData.fromJson(Map<String, dynamic> json) {
    balance = double.parse(json['balance']);
    giftDiamondNum = json['giftDiamondNum'];
    binkBankNum = json['binkBankNum'];
    coinBalance = json['coinBalance'];
    walletAddress = json['walletAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balance'] = this.balance;
    data['giftDiamondNum'] = this.giftDiamondNum;
    data['binkBankNum'] = this.binkBankNum;
    data['coinBalance'] = this.coinBalance;
    data['walletAddress'] = this.walletAddress;
    return data;
  }
}

class UserBalanceState {
  Rx<UserBalanceData> _userBalance = UserBalanceData().obs;
  Rx<UserBalanceData> get userBalance => _userBalance;
  UserBalanceData? oldUserBalance;

  void setUserBalanceData(UserBalanceData value) {
    oldUserBalance = _userBalance.value;
    _userBalance.value = value;
    print('NEO GAME oldUserBalance: ${oldUserBalance?.balance}');
    print('NEO GAME _userBalance: ${_userBalance.value.balance}');
  }
}
