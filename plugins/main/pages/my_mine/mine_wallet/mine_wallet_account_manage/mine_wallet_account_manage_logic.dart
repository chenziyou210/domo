import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/generated/bank_list_entity.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:hjnzb/pages/my_mine/mine_wallet/mine_wallet_logic.dart';
import 'package:hjnzb/pages/my_mine/mine_withdraw/bind_wallet_address/bind_wallet_address_view.dart';
import 'package:hjnzb/pages/my_mine/mine_withdraw/mine_add_bank/mine_add_bank_view.dart';

import 'mine_wallet_account_manage_state.dart';

/// @description:
/// @author
/// @date: 2022-06-15 17:35:12
class MineWalletAccountManageLogic extends GetxController with Toast {
  final state = MineWalletAccountManageState();

  bool setIsHide() {
    if (state.accountType == WalletAccount.bank) {
      return (state.bankList?.length ?? 0) >= state.maxAccountCount;
    } else {
      return (state.walletList?.length ?? 0) >= state.maxAccountCount;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  //item个数
  int itemLength() {
    if (state.accountType == WalletAccount.bank) {
      return state.bankList?.length ?? 0;
    } else {
      return state.walletList?.length ?? 0;
    }
  }

  //渐变色
  LinearGradient setColors(int index) {
    if (state.accountType == WalletAccount.bank) {
      if (index == 0) {
        return LinearGradient(colors: [
          Color.fromRGBO(44, 123, 163, 1),
          Color.fromRGBO(46, 46, 160, 1)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight);
      } else if (index == 1) {
        return LinearGradient(colors: [
          Color.fromRGBO(155, 56, 144, 1),
          Color.fromRGBO(149, 47, 79, 1)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight);
      } else if (index == 2) {
        return LinearGradient(colors: [
          Color.fromRGBO(163, 113, 58, 1),
          Color.fromRGBO(166, 51, 51, 1)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight);
      } else if (index == 3) {
        return LinearGradient(colors: [
          Color.fromRGBO(141, 189, 87, 1),
          Color.fromRGBO(150, 132, 40, 1)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight);
      } else {
        return LinearGradient(colors: [
          Color.fromRGBO(71, 175, 138, 1),
          Color.fromRGBO(60, 163, 58, 1)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight);
      }
    } else {
      if (index == 0) {
        return LinearGradient(colors: [
          Color.fromRGBO(78, 92, 206, 1),
          Color.fromRGBO(113, 59, 176, 1)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight);
      } else if (index == 1) {
        return LinearGradient(colors: [
          Color.fromRGBO(128, 121, 37, 1),
          Color.fromRGBO(141, 109, 31, 1)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight);
      } else if (index == 2) {
        return LinearGradient(colors: [
          Color.fromRGBO(22, 122, 108, 1),
          Color.fromRGBO(18, 105, 125, 1)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight);
      } else if (index == 3) {
        return LinearGradient(colors: [
          Color.fromRGBO(62, 148, 167, 1),
          Color.fromRGBO(36, 66, 144, 1)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight);
      } else {
        return LinearGradient(colors: [
          Color.fromRGBO(126, 90, 203, 1),
          Color.fromRGBO(119, 27, 134, 1)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight);
      }
    }
  }

//设置图片
  String setIconUrl(int index) {
    if (state.accountType == WalletAccount.bank) {
      return state.bankList?[index].bankIcon ?? "";
    } else {
      return state.walletList?[index].walletIcon ?? "";
    }
  }

  Widget setTltieView(int index) {
    if (state.accountType == WalletAccount.bank) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            state.bankList?[index].bankName ?? "",
            style: TextStyle(color: Colors.white, fontSize: 16.dp),
          ),
          SizedBox(
            height: 4.dp,
          ),
          Text(
            "储蓄卡",
            style: TextStyle(
                color: AppColors.main_white_opacity_7, fontSize: 12.dp),
          ),
        ],
      );
    } else {
      return Text(
        state.walletList?[index].walletName ?? "",
        style: TextStyle(color: Colors.white, fontSize: 16.dp),
      );
    }
  }

  Widget deleteAccount(int index) {
    var title = "";
    if (state.accountType == WalletAccount.bank) {
      var cardNumber = state.bankList?[index].cardNumber ?? "";
      title = "****  " + cardNumber.substring(cardNumber.length - 4);
    } else {
      var cardNumber = state.walletList?[index].walletAddress ?? "";
      title = "****  " + cardNumber.substring(cardNumber.length - 4);
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Image.asset(
          R.comShanchuIcon,
          width: 16,
          height: 16,
        ).gestureDetector(onTap: () {
          if (state.accountType == WalletAccount.bank) {
            deleteBankCard(index);
          } else {
            deleteWallet(index);
          }
        }).marginOnly(top: 8.dp),
        Spacer(),
        Text(
          title,
          style: AppStyles.number(16.sp),
        ).marginOnly(bottom: 17.dp)
      ],
    );
  }

//删除银行卡
  deleteBankCard(int index) {
    HttpChannel.channel
        .deleteBindBank(state.bankList?[index].id ?? 0)
        .then((value) => value.finalize(
            wrapper: WrapperModel(),
            failure: (e) => showToast(e),
            success: (data) {
              if (index <= (state.bankList?.length ?? 0)) {
                state.bankList?.removeAt(index);
                update();
              }
            }));
  }

  //删除钱包
  deleteWallet(int index) {
    HttpChannel.channel
        .deleteWallet(state.walletList?[index].id ?? 0)
        .then((value) => value.finalize(
            wrapper: WrapperModel(),
            failure: (e) => showToast(e),
            success: (data) {
              if (index <= (state.walletList?.length ?? 0)) {
                state.walletList?.removeAt(index);
                update();
              }
            }));
  }

  //添加账号
  addAccount() {
    if (state.accountType == WalletAccount.bank) {
      Get.to(() => MineAddBankPage())?.then((value) {
        if (value != null) {
          getBankList();
        }
      });
    } else {
      Get.to(() => BindWalletAddressPage())?.then((value) {
        if (value != null) {
          getWalletList();
        }
      });
    }
  }

//用户已绑定的银行卡列表
  getBankList() {
    HttpChannel.channel.bindBankList().then((value) => value.finalize(
        wrapper: WrapperModel(),
        success: (data) {
          if (data is List) {
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
            state.walletList =
                data.map((e) => BindWalletListEntity.fromJson(e)).toList();
          }
          update();
        }));
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    if (state.accountType == WalletAccount.bank) {
      //银行卡
      state.bankList = Get.arguments["list"];
    } else if (state.accountType == WalletAccount.topay) {
      //钱包
      state.walletList = Get.arguments["list"];
    }
    update();
  }
}
