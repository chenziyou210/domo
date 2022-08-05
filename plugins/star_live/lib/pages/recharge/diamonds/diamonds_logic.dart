import 'package:alog/alog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/http_channel.dart';

import 'package:star_common/manager/user/user_balance_logic.dart';

class DiamondsLogic extends GetxController with Toast {
  final DiamondsState state = DiamondsState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadDataList();
  }

  Future diamondExchange(int packageId) {
    show();
    return HttpChannel.channel
        .diamondExchange(packageId)
        .then((value) => value.finalize(
            wrapper: WrapperModel(),
            success: (data) {
              showToast("兑换成功");
              Get.find<UserBalanceLonic>().userBalanceData();
              dismiss();
            },
            failure: (e) => showToast(e),
            ));
  }

  Future loadDataList() {
    return HttpChannel.channel.diamondList().then((value) => value.finalize(
        wrapper: WrapperModel(),
        success: (data) {
          if (data is List && data.isNotEmpty) {
            state._setData(
                data.map((e) => DiamondListEntity.fromJson(e)).toList());
          }
        }));
  }

  List<TextSpan> parseContent(String? content, List<List<int>>? catchEye) {
    List<TextSpan> result = [];
    var cacheEyeList = catchEye ?? [];
    result.add(TextSpan(
        text: content?.substring(0, catchEye?[0][0]) ?? content ?? "",
        style: TextStyle(
          color: AppMainColors.whiteColor70,
          fontWeight: w_400,
          fontSize: 14.dp,
        )));
    if (cacheEyeList.isNotEmpty) {
      var index = 0;
      for (var value in cacheEyeList) {
        result.add(TextSpan(
            text: content?.substring(value[0], value[1]) ?? "",
            style: TextStyle(
              color: AppMainColors.mainColor,
            )));
        if (index + 1 < cacheEyeList.length) {
          if (value[1] + 1 != cacheEyeList[index + 1][0]) {
            result.add(TextSpan(
                text:
                    content?.substring(value[1], cacheEyeList[index + 1][0]) ??
                        ""));
          }
          index++;
        } else {
          result.add(TextSpan(text: content?.substring(value[1])));
        }
      }
    }
    return result;
  }
}

class DiamondsState {
  RxList<DiamondListEntity> _data = <DiamondListEntity>[].obs;

  RxList<DiamondListEntity> get data => _data;

  void _setData(List<DiamondListEntity> value) {
    _data.value = value;
  }
}

class DiamondListEntity {
  int? amount;
  var money;
  int? id;

  DiamondListEntity({this.amount, this.money, this.id});

  DiamondListEntity.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    money = json['money'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['money'] = this.money;
    data['id'] = this.id;
    return data;
  }
}
