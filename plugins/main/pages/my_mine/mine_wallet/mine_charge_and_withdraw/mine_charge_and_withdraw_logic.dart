import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/http_channel.dart';

import 'mine_charge_and_withdraw_state.dart';

/// @description:
/// @author
/// @date: 2022-05-31 18:29:10
class MineChargeAndWithdrawLogic extends GetxController with Toast {
  final state = MineChargeAndWithdrawState();
  @override
  void onInit() {
    super.onInit();
    requestWithdrawList(true);
    requestChargeList(true);
  }

  @override
  void onReady() {
    super.onReady();
  }

  //提现记录
  requestWithdrawList(bool refreshOrLoad) {
    if (refreshOrLoad) {
      state.withdrawalRecordsList.clear();
      state.pageIndex = 1;
    } else {
      state.pageIndex += 1;
    }
    HttpChannel.channel
        .withdrawInfo(page: state.pageIndex)
        .then((value) => value.finalize(
            wrapper: WrapperModel(),
            failure: (e) => showToast(e),
            success: (data) {
              List datas = data["data"];
              if (refreshOrLoad) {
                state.withdrawalRecordsList = datas
                    .map((e) => WithdrawalRecordsData.fromJson(e))
                    .toList();
                state.withdrawController.refreshCompleted();
              } else {
                if (datas.length > 0) {
                  datas.map((e) {
                    state.withdrawalRecordsList
                        .add(WithdrawalRecordsData.fromJson(e));
                  });
                }
                if (datas.length < 10) {
                  state.withdrawController.loadNoData();
                } else {
                  state.withdrawController.loadComplete();
                }
              }
              update();
            }));
  }

  ///充值记录
  requestChargeList(bool refreshOrLoad) {
    if (refreshOrLoad) {
      //刷新
      state.pageIndex = 1;
      state.rechargeRecordList.clear();
    } else {
      state.pageIndex += 1;
    }
    HttpChannel.channel
        .chargeRecord(page: state.pageIndex)
        .then((value) => value.finalize(
            wrapper: WrapperModel(),
            failure: (e) => showToast(e),
            success: (data) {
              List datas = data["data"];
              if (refreshOrLoad) {
                state.rechargeRecordList =
                    datas.map((e) => RechargeRecordData.fromJson(e)).toList();
                state.chargeController.refreshCompleted();
              } else {
                if (datas.length > 0) {
                  datas.map((e) {
                    state.rechargeRecordList
                        .add(RechargeRecordData.fromJson(e));
                  });
                }
                if (datas.length < 10) {
                  state.chargeController.loadNoData();
                } else {
                  state.chargeController.loadComplete();
                }
              }
              update();
            }));
  }

  changeTable(int table) {
    if (table == 1) {
      if (state.withdrawalRecordsList.length == 0) {
        state.chargeController.requestRefresh();
      }
    } else {
      if (state.rechargeRecordList.length == 0) {
        state.withdrawController.requestRefresh();
      }
    }
    update();
  }

  Color statusColor(String status) {
    if (status == "成功") {
      return AppMainColors.whiteColor70;
    } else if (status == "处理中") {
      return Color.fromRGBO(238, 255, 135, 1);
    } else if (status == "失败") {
      return Color.fromRGBO(255, 55, 55, 1);
    } else {
      return AppMainColors.whiteColor70;
    }
  }
}
