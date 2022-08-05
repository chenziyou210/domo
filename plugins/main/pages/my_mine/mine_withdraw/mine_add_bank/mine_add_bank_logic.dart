import 'package:alog/alog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/http_channel.dart';

import 'mine_add_bank_state.dart';
import 'select_bank/select_bank_view.dart';

/// @description:
/// @author
/// @date: 2022-06-03 18:27:11

typedef AddBankParms(String bankName, String bankId);

class MineAddBankLogic extends GetxController with Toast {
  final state = MineAddBankState();
  @override
  void onInit() {
    super.onInit();
  }

  dialogBankList(BuildContext context) {
    customShowModalBottomSheet(
        context: context,
        builder: (_) {
          return SelectBankPage((bankName, bankId) {
            state.bankController.text = bankName;
            state.bankNmae = bankName;
            state.bankId = bankId;
            update();
          });
        },
        fixedOffsetHeight: 360.dp,
        isScrollControlled: false,
        barrierColor: Colors.transparent,
        backgroundColor: Colors.transparent);
  }

  requestBindBank(BuildContext context) {
    if (state.bankId.isEmpty) {
      showToast("请添加银行卡信息");
      return;
    }
    if (state.cardNumberController.text.isEmpty) {
      showToast("请添加银行卡号");
      return;
    }
    if (state.nameController.text.isEmpty) {
      showToast("请添加持卡人信息");
      return;
    }
    HttpChannel.channel
        .bindBankModify(
          bankId: state.bankId,
          accountOpenBank: state.accountOpenBankController.text,
          bankname: state.bankNmae,
          cardNumber: state.cardNumberController.text,
          name: state.nameController.text,
          remark: '',
        )
        .then((value) => value.finalize(
            wrapper: WrapperModel(),
            failure: (e) => showToast(e),
            success: (data) {
              if (data == null) {
                showToast("添加银行卡成功");
                Get.back(result: 1);
              }
            }));
  }

  onChange() {
    state.setUpdateBinds(state.accountOpenBankController.text.isNotEmpty &&
        state.bankController.text.isNotEmpty &&
        state.cardNumberController.text.isNotEmpty &&
        state.nameController.text.isNotEmpty);
  }
}
