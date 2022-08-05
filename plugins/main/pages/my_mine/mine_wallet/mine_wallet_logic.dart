// ignore_for_file: deprecated_member_use

import 'package:alog/alog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:httpplugin/http_result_container/http_result_container.dart';
import 'package:spring/spring.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/generated/bank_list_entity.dart';
import 'package:star_common/http/cache.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/manager/app_manager.dart';
import 'package:hjnzb/pages/my_mine/mine_withdraw/mine_withdraw_view.dart';
import 'package:star_common/manager/user/user_balance_logic.dart';
import 'package:star_live/pages/recharge/recharge/recharge_view.dart';
import 'package:star_live/pages/recharge/diamonds/diamonds_view.dart';

import 'mine_charge_and_withdraw/mine_charge_and_withdraw_view.dart';
import 'mine_wallet_account_manage/mine_wallet_account_manage_view.dart';
import 'mine_wallet_state.dart';

/// @description:
/// @author
/// @date: 2022-05-31 14:43:43
//钱包账号管理
enum WalletAccount {
  bank, //银行卡
  topay, //topay
}

class MineWalletLogic extends GetxController with Toast {
  final state = MineWalletState();

  @override
  void onInit() {
    userBalanceData();
    super.onInit();
    getBankList();
    getWalletList();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

  }

  userBalanceData() {
    Get.find<UserBalanceLonic>().userBalanceData().then((value) {
      if (value is HttpResultContainer) {
        HttpResultContainer result = value;
        state.setUserBalanceData(UserBalanceData.fromJson(result.data["data"]));
      }
    });
  }

//充值记录
  gotoChargeAndWithdraw(BuildContext context) {
    // Navigator.pushNamed(context, AppRoutes.mineChargeAndWithdraw);
    Get.to(() => MineChargeAndWithdrawPage());
  }

  //提现
  gotoWithdraw(BuildContext context) {
    Get.to(() => MineWithdrawPage())?.then((value) => userBalanceData());
  }

  //充值
  gotoReCharge(BuildContext context) {
    Get.to(() => RechargePage(true))?.then((value) => userBalanceData());
  }

  //兑换钻石
  gotoRedeemDiamonds() {
    Get.to(() => DiamondsPage())?.then((value) {
      userBalanceData();
    });
  }

  //银行卡管理,钱包管理
  gotoBindBankManger(WalletAccount type) {
    Get.to(() => MineWalletAccountManagePage(), arguments: {
      "type": type,
      "list": type == WalletAccount.bank ? state.bankList : state.walletList
    })?.then((value) {
      if (type == WalletAccount.bank) {
        getBankList();
      } else {
        getWalletList();
      }
      userBalanceData();
    });
  }

  //更新个人信息
  getUserInfo() {
    HttpChannel.channel.userInfo().then((value) => value.finalize(
        wrapper: WrapperModel(),
        success: (data) {
          AppManager.getInstance<AppUser>().fromJson(data, false);
          update();
        }));
  }

  //用户已绑定的银行卡列表
  getBankList() {
    HttpChannel.channel.bindBankList().then((value) => value.finalize(
        wrapper: WrapperModel(),
        success: (data) {
          if (data is List) {
            state.setUpdateBankListCount(data.length);
            state.bankList = data.map((e) => BankListData.fromJson(e)).toList();
          }
          update();
        }));
  }

  //用户已绑定的钱包列表
  getWalletList() {
    HttpChannel.channel.bindWalletList().then((value) => value.finalize(
        wrapper: WrapperModel(),
        success: (data) {
          if (data is List) {
            state.setUpdateWalletCount(data.length);
            state.walletList =
                data.map((e) => BindWalletListEntity.fromJson(e)).toList();
          }
          update();
        }));
  }
}
