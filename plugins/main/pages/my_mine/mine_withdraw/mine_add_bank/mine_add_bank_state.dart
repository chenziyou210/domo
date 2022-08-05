import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// @description:
/// @author
/// @date: 2022-06-03 18:27:11
class MineAddBankState {
  RxBool binds = false.obs;
  setUpdateBinds(bool value) {
    binds.value = value;
  }

  late String bankNmae = "";
  late String bankId = "";
  late TextEditingController accountOpenBankController;
  late TextEditingController bankController;
  late TextEditingController cardNumberController;
  late TextEditingController nameController;

  List? list = null;
  MineAddBankState() {
    accountOpenBankController = TextEditingController();
    cardNumberController = TextEditingController();
    nameController = TextEditingController();
    bankController = TextEditingController();
  }
}
