import 'package:alog/alog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/generated/bank_list_entity.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:hjnzb/pages/my_mine/mine_withdraw/mine_add_bank/mine_add_bank_view.dart';

import '../../bind_wallet_address/bind_wallet_address_view.dart';
import 'selet_my_bank_state.dart';

/// @description:
/// @author
/// @date: 2022-06-07 15:55:38
class SeletMyBankLogic extends GetxController with Toast {
  final state = SeletMyBankState();

  @override
  void onInit() {
    super.onInit();
  }

  gotoAddNewWithdrawType(BuildContext context) {
    Alog.e("选择银行");
    // Navigator.pop(context);
    // Navigator.of(context).pushNamed(AppRoutes.minaddBank);
    Get.back();
    Get.to(() => MineAddBankPage());
  }

  gotoAddNewWalletType(BuildContext context) {
    Alog.e("选择钱包");
    // Navigator.pop(context);
    // Navigator.of(context).pushNamed(AppRoutes.minaddBank);
    Get.back();
    Get.to(() => BindWalletAddressPage());
  }

  ///获取银行卡列表
  void requestMyBankList(int type) {
    // HttpChannel.channel.bindBankList().then((value) {
    //   var code = value.data['code'];
    //   if (code == 0) {
    //     state.list = value.data['data'];
    //     update();
    //   } else {
    //     showToast("${value.data['message']}");
    //   }
    // }, onError: (e) {});
    ///获取银行卡列表

    //用户已绑定的钱包列表
    if (type == 1) {
      HttpChannel.channel.bindWalletList().then((value) => value.finalize(
          wrapper: WrapperModel(),
          success: (data) {
            if (data is List) {
              state.walletList =
                  data.map((e) => BindWalletListEntity.fromJson(e)).toList();
            }
            update();
          }));
    } else {
      HttpChannel.channel.bindBankList().then((value) => value.finalize(
          wrapper: WrapperModel(),
          success: (data) {
            if (data is List) {
              state.bankList =
                  data.map((e) => BankListData.fromJson(e)).toList();
            }
            update();
          }));
    }
  }
}
