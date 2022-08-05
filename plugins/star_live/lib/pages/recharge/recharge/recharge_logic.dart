// ignore_for_file: avoid_single_cascade_in_expression_statements, avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'dart:io';

import 'package:alog/alog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/common_widget/components/components_view.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:url_launcher/url_launcher.dart';

import 'recharge_state.dart';

/// @description:
/// @author
/// @date: 2022-06-10 13:21:23
class RechargeLogic extends GetxController with Toast {
  Timer? _timer;
  int _index = 0;
  final state = RechargeState();

  @override
  void onInit() {
    requestQueryChannelList();
    announcement();
    // advertiseBanner();
    super.onInit();
  }

  ///跑马灯
  announcement() {
    HttpChannel.channel.announcementList(3)
      ..then((value) => value.finalize(
          wrapper: WrapperModel(),
          success: (data) {
            if (data != null && data is List) {
              List datas = data;
              String content = "";
              datas.forEach((element) {
                RechargeRunningLightData annouData =
                    RechargeRunningLightData.fromJson(element);
                content += annouData.content ?? "";
              });
              state.setUpdateContents(
                  content.replaceAll("\r", "").replaceAll("\n", ""));
            }
          }));
  }

  requestQueryChannelList() {
    show();
    HttpChannel.channel.queryChannelList().then((value) => value.finalize(
        wrapper: WrapperModel(),
        failure: (e) => showToast(e),
        success: (data) {
          if (data != null) {
            List datas = data ?? [];
            state.setUpdateRechargeList(
                datas.map((e) => RechargeData.fromJson(e)).toList());
          }
          dismiss();
        }));
  }

  requestChargeMoney(TextEditingController rechargeMoney, String channelId,
      BuildContext context) {
    show();
    HttpChannel.channel
        .createRechargeOrder(channelId, rechargeMoney.text)
        .then((value) => value.finalize(
            wrapper: WrapperModel(),
            failure: (e) => showToast(e),
            success: (data) {
              Alog.i(data);
              Map map = data;
              if (data != null && map.length > 0) {
                startTimer(map["orderNo"], context);
                _safeLaunch(map["payUrl"]);
              } else {
                showToast("支付错误，请联系客服...");
              }
              dismiss();
            }));
  }



  Future<bool> _safeLaunch(String url) async {

    try {
      return await launchUrl(
        Uri.parse(url.trim()),
        mode: Platform.isAndroid
            ? LaunchMode.externalNonBrowserApplication
            : LaunchMode.externalApplication,
      );
    } catch (e) {
      return false;
    }
  }



  requestQueryRechargeByOrderNo(String orderNo, BuildContext context) {
    HttpChannel.channel
        .queryRechargeByOrderNo(orderNo)
        .then((value) => value.finalize(
            wrapper: WrapperModel(),
            failure: (e) => showToast(e),
            success: (data) {
              Map map = data;
              if (data != null && map.length > 0) {
                if (int.parse("${map['payStatus']}") == 1) {
                  showToast("充值成功,请查看你的余额...");
                  _timer?.cancel();
                } else {
                  startTimer(orderNo, context);
                }
              }
            }));
  }

  void startTimer(String orderNo, BuildContext context) {
    const oneSec = const Duration(seconds: 5);
    if (_index >= 5) {
      _timer = Timer.periodic(
        oneSec,
        (Timer timer) {
          requestQueryRechargeByOrderNo(orderNo, context);
          // Navigator.pop(context);
          timer.cancel();
        },
      );
    } else {
      _index++;
    }
  }

  Future<String> getCustomerUrl() async {
    final result = await HttpChannel.channel.customerServiceList();
    List list = result.data['data'] ?? [];
    if (list.isNotEmpty) {
      return list.first['url'].toString();
    } else {
      return "";
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
}
