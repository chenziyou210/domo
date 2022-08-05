/*
 *  Copyright (C), 2015-2021
 *  FileName: balance_recharge
 *  Author: Tonight丶相拥
 *  Date: 2021/10/13
 *  Description: 
 **/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/i18n/i18n.dart';
import 'package:star_common/manager/user/user_balance_logic.dart';

class BalanceRechargePage extends StatelessWidget with Toast {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AppInternational intl = AppInternational.of(context);
    return Scaffold(
      appBar: DefaultAppBar(),
      backgroundColor: Colors.white,
      body: Container(
          child: Column(children: [
        SizedBox(height: 8),
        CustomTextField(
                controller: _controller,
                hintTextStyle: AppStyles.f14w400c125_125_125,
                hintText: intl.pleaseEnterChargeAmount,
                style: AppStyles.f14w400c0_0_0,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.numberWithOptions(decimal: true))
            .container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.c121_121_121),
                    borderRadius: BorderRadius.circular(25))),
        SizedBox(height: 36),
        Container(
                alignment: Alignment.center,
                // margin: EdgeInsets.only(left: 48),
                height: 35,
                width: 110,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17.5),
                    color: AppColors.c249_102_87,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 4,
                          spreadRadius: 0,
                          color: AppColors.c167_167_167.withOpacity(0.5))
                    ]),
                child:
                    Text(intl.recharge, style: AppStyles.f14w400c255_255_255))
            .gestureDetector(onTap: () {
          String text = _controller.text.replaceAll(" ", "");
          if (text.isEmpty) {
            showToast(intl.pleaseEnterChargeAmount);
            return;
          }
          double? balance = double.tryParse(text);
          if (balance == null) {
            return;
          }
          show();
          HttpChannel.channel
              .balanceRecharge(balance)
              .then((value) => value.finalize(
                  wrapper: WrapperModel(),
                  failure: (e) => showToast(e),
                  success: (_) {
                    showToast(intl.rechargeSuccess);
                    Get.find<UserBalanceLonic>().userBalanceData();
                    _controller.clear();
                  }));
        })
      ])),
    );
  }
}
