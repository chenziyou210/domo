/*
 *  Copyright (C), 2015-2021
 *  FileName: charge_logic
 *  Author: Tonight丶相拥
 *  Date: 2021/11/29
 *  Description: 
 **/

import 'package:get/get.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/generated/channel_list_entity.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/i18n/i18n.dart';

class ChargeLogic extends GetxController with Toast {
  final _ChargeState state = _ChargeState();

  /// 展示
  Future showBank() {
    return HttpChannel.channel.showBank().then((value) => value.finalize(
        wrapper: WrapperModel(),
        success: (data) {
          List lst = data ?? [];
          state
              ._setData(lst.map((e) => ChannelListEntity.fromJson(e)).toList());
        }));
  }

  /// 选中银行
  void selectBank(int index) {
    state._selectBank(index);
  }

  /// 选中下标
  void selectIndex(int index) {
    state._selectIndex(index);
  }

  var _intl = AppInternational.current;

  void confirm(String amount, void Function(String) success,
      Map<String, dynamic>? arguments) {
    double a;
    if (state.index.value == -1) {
      showToast(_intl.pleaseChooseChannel);
      return;
    }
    if (amount.isEmpty) {
      if (state.index1.value == -1) {
        showToast(_intl.pleaseEnterAmount);
        return;
      }
      a = state.data[state.index.value].date![state.index1.value].amount!;
    } else {
      try {
        a = double.parse(amount);
      } catch (e) {
        showToast(e.toString());
        return;
      }
    }
    show();
    HttpChannel.channel
        .createOrder(
            orderPrice: a,
            channelName: state.data[state.index.value].name!,
            arguments: arguments)
        .then((value) {
      return value.finalize(
          wrapper: WrapperModel(),
          failure: (e) => showToast(e),
          success: (data) {
            dismiss();
            success(data["pageurl"]);
          });
    });
  }
}

class _ChargeState {
  /// 数据
  RxList<ChannelListEntity> _data = RxList<ChannelListEntity>();
  RxList<ChannelListEntity> get data => _data;

  /// 是否显示
  RxBool _offstage = true.obs;
  RxBool get offstage => _offstage;

  /// 银行
  RxInt _index = (-1).obs;
  RxInt get index => _index;

  /// 充值数量
  RxInt _index1 = (-1).obs;
  RxInt get index1 => _index1;

  /// 设置数据
  void _setData(List<ChannelListEntity> data) {
    _data.value = data;
  }

  void _selectBank(int index) {
    _index.value = index;
    _index1.value = -1;
  }

  void _selectIndex(int index) {
    _index1.value = index;
  }
}
