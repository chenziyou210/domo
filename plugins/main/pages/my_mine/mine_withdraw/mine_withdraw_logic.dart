import 'package:alog/alog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hjnzb/pages/my_mine/mine_phone_approve/mine_phone_approve_view.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/common_widget/app_dialog.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/cache.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/manager/app_manager.dart';

import 'mine_withdraw_info/mine_withdraw_info_view.dart';
import 'mine_withdraw_state.dart';

/// @description:
/// @author
/// @date: 2022-06-02 18:45:52
class MineWithdrawLogic extends GetxController with Toast {
  final state = MineWithdrawState();

  gotoMineWithdrawInfo(MineWithdrawData? data) {
    Alog.d(AppManager.getInstance<AppUser>().phone);
    if ((AppManager.getInstance<AppUser>().phone ?? "").isEmpty ||
        AppCacheManager.cache.getisGuest() == true) {
      showDialog();
      return;
    }
    Get.to(() => MineWithdrawInfoPage(), arguments: data);
  }

  showDialog() {
    Get.dialog(AppDialog(
      Text("设置支付密码需进行手机号认证,是否进行认证?",
          style: TextStyle(color: AppMainColors.whiteColor70, fontSize: 14)),
      cancelText: "取消",
      confirmText: "立即认证",
      confirm: () {
        Get.back();
        Get.to(() => MinePhoneApprovePage());
      },
    ));
  }

  @override
  void onInit() {
    super.onInit();
    HttpChannel.channel.withdrawList().then((value) => value.finalize(
        wrapper: WrapperModel(),
        failure: (e) => showToast(e),
        success: (data) {
          if (data is List) {
            items = data.map((e) => MineWithdrawData.fromJson(e)).toList();
          }
          update();
        }));
  }

  List<MineWithdrawData>? items;
}

class MineWithdrawData {
  int? minAmount;
  int? taxRate;
  int? isFree;
  String? withdrawTypeNo;
  String? name;
  ///手续费
  String? remark;
  String? iconUrl;
  int? maxAmount;

  MineWithdrawData(
      {this.minAmount,
      this.taxRate,
      this.isFree,
      this.withdrawTypeNo,
      this.name,
      this.remark,
      this.iconUrl,
      this.maxAmount});

  MineWithdrawData.fromJson(Map<String, dynamic> json) {
    minAmount = json['minAmount'];
    taxRate = json['taxRate'];
    isFree = json['isFree'];
    withdrawTypeNo = json['withdrawTypeNo'];
    name = json['name'];
    remark = json['remark'];
    iconUrl = json['iconUrl'];
    maxAmount = json['maxAmount'];
  }
}
