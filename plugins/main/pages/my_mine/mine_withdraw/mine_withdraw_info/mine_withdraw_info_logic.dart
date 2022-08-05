// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:alog/alog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/common_widget/app_dialog.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/generated/bank_list_entity.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/manager/app_manager.dart';
import 'package:hjnzb/pages/my_mine/mine_withdraw/bind_wallet_address/bind_wallet_address_view.dart';
import 'package:hjnzb/pages/my_mine/mine_withdraw/mine_add_bank/mine_add_bank_view.dart';
import 'package:hjnzb/pages/my_mine/my_mine_setting/my_mine_pament_password/my_mine_pament_password_view.dart';
import 'package:hjnzb/pages/my_mine/pay_password/pay_password_view.dart';
import 'mine_withdraw_info_state.dart';
import 'selet_my_bank/selet_my_bank_view.dart';
import 'withdraw_info/withdraw_info_view.dart';
import 'withdrawal_instructions/withdrawal_instructions_view.dart';

/// @description:
/// @author
/// @date: 2022-06-03 12:51:36
///
typedef MyCardSelectCallBack(var params);

class MineWithdrawInfoLogic extends GetxController with Toast {
  final state = MineWithdrawInfoState();

  @override
  void onInit() {
    super.onInit();
    requestQueryUserBalance();
  }

  @override
  void onReady() {
    super.onReady();
    if (state.withdrawData?.withdrawTypeNo == "Bank") {
      //银行卡
      getBankList();
    } else if (state.withdrawData?.withdrawTypeNo == "Wallet") {
      //钱包
      getWalletList();
    }
  }

  //获取打码量
  requestQueryUserBalance() {
    HttpChannel.channel.queryUserBalance().then((value) => value.finalize(
        wrapper: WrapperModel(),
        failure: (e) => showToast(e),
        success: (data) {
          Alog.i(data);
          if (data is Map<String, dynamic>) {
            state.balanceData = WithDrawUserBalance.fromJson(data);
          }

          update();
        }));
  }

  ///获取银行卡列表
  getBankList() {
    HttpChannel.channel.bindBankList().then((value) => value.finalize(
        wrapper: WrapperModel(),
        success: (data) {
          if (data is List) {
            state.bankList = data.map((e) => BankListData.fromJson(e)).toList();
            if ((state.bankList?.length ?? 0) > 0) {
              //第一个银行卡信息
              state.bankCardInfo = state.bankList?.first;
            }
            state.setUpdateIsCardInfo(cardInfo());
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
            state.walletList =
                data.map((e) => BindWalletListEntity.fromJson(e)).toList();

            if ((state.walletList?.length ?? 0) > 0) {
              //第一个银行卡信息
              state.walletinfo = state.walletList?.first;
            }
            state.setUpdateIsCardInfo(cardInfo());
          }
          update();
        }));
  }

  bool cardInfo() {
    if (state.withdrawData?.withdrawTypeNo == "Bank") {
      //银行卡
      return (state.bankList?.length ?? 0) > 0;
    } else if (state.withdrawData?.withdrawTypeNo == "Wallet") {
      //钱包
      return (state.walletList?.length ?? 0) > 0;
    }
    return false;
  }

  //最大金额
  maxAmount() {
    if ((state.balanceData?.withdraw ?? 0) > 0) {
      showToast("还要打码量${state.balanceData?.withdraw},才能提现");
    } else {
      if (!cardInfo()) {
        if (state.withdrawData?.withdrawTypeNo == "Bank") {
          //银行卡
          showToast("请绑定银行卡");
        } else if (state.withdrawData?.withdrawTypeNo == "Wallet") {
          //钱包
          showToast("请绑定钱包地址");
        }
        return;
      }
      if (state.balanceData == null) {
        return;
      }
      if (state.balanceData!.balance! >= state.withdrawData!.maxAmount!) {
        state.controller.text =
            "${(state.withdrawData?.maxAmount ?? 0).toStringAsFixed(0)}";
      } else {
        state.controller.text =
            "${(state.balanceData?.balance ?? 0).toStringAsFixed(0)}";
      }
      state.setUpdateInputAmount(state.controller.text);
    }
  }

  ///绑定银行卡
  bindBankCard() {
    Get.to(() =>MineAddBankPage())?.then((value) => getBankList());
  }

  ///新增钱包地址
  bindWallet() {
    Get.to(() =>BindWalletAddressPage())?.then((value) => getWalletList());
  }

  //更换银行卡
  changingBankCard() {
    //选择银行卡
    Get.bottomSheet(SeletMyBankPage(0, state.bankCardInfo),
            barrierColor: Colors.transparent,
            backgroundColor: Colors.transparent)
        .then((value) {
      if (value is BankListData) {
        state.bankCardInfo = value;
        update();
      }
    });
  }

  onChanged(String text) {
    state.setUpdateInputAmount(text.isEmpty ? "0" : text);
  }

  //更换银行卡
  changingWallet() {
    //选择银行卡
    Get.bottomSheet(SeletMyBankPage(1, state.walletinfo),
            barrierColor: Colors.transparent,
            backgroundColor: Colors.transparent)
        .then((value) {
      if (value is BindWalletListEntity) {
        state.walletinfo = value;
        update();
      }
    });
  }

  //提现
  withdrawalFunds(BuildContext context) {
    if (double.parse(state.controller.text) > state.balanceData!.balance!) {
      showToast("您的账户余额为${state.balanceData!.balance!}元");
      return;
    }
    if (int.parse(state.controller.text) < state.withdrawData!.minAmount!) {
      showToast("最低提现金额${state.withdrawData!.minAmount!}元");
      return;
    }
    if (int.parse(state.controller.text) > state.withdrawData!.maxAmount!) {
      showToast("最高提现金额${state.withdrawData!.maxAmount!}元");
      return;
    }
    // FocusScope.of(context).requestFocus(FocusNode());
    if (AppManager.getInstance<AppUser>().withdrawPasswordFlag == 0) {
      //没设置支付密码去设置.
      Get.dialog(AppDialog(
        Text("您还未设置支付密码,设置后才可提现",
            style: TextStyle(color: AppMainColors.whiteColor70, fontSize: 14)),
        cancelText: "取消",
        confirmText: "确认",
        confirm: () {
          Get.back();
          Get.to(() => MyMinePamentPasswordPage());
        },
      ));
      return;
    }
    var typeNo = state.withdrawData?.withdrawTypeNo;

    PayPasswordPage.show((value) {
      if (typeNo == "Bank") {
        //银行卡
        withdrawalFundsNet(
            bankId: "${state.bankCardInfo?.id}",
            walletType: state.walletinfo?.walletType,
            withdrawPassword: value,
            withdrawType: state.withdrawData?.withdrawTypeNo);
      } else if (typeNo == "Wallet") {
        //钱包
        withdrawalFundsNet(
            bankId: "",
            walletType: state.walletinfo?.walletType,
            withdrawPassword: value,
            withdrawType: state.withdrawData?.withdrawTypeNo);
      }
    });
  }

  withdrawalFundsNet({
    required String? bankId,
    required String? walletType,
    required String withdrawPassword,
    required String? withdrawType,
  }) {
    HttpChannel.channel
        .createWithdrawOrder(
            bankId: bankId,
            walletType: walletType,
            withdrawType: withdrawType,
            withdrawPassword: withdrawPassword,
            withdrawMoney: int.parse(state.controller.text))
        .then((value) => value.finalize(
            wrapper: WrapperModel(),
            failure: (e) => showToast(e),
            success: (data) {
              if (data == null) {
                Get.back();
                Get.to(() => WithdrawInfoPage(),
                    arguments: state.controller.text);
              }
            }));
  }

  ///提现说明
  withdrawalInstructions() {
    Get.to(() => WithdrawalInstructionsPage());
  }
}
