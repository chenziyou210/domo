/*
 *  Copyright (C), 2015-2021
 *  FileName: follow_bet
 *  Author: Tonight丶相拥
 *  Date: 2021/12/20
 *  Description: 
 **/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/i18n/i18n.dart';

import 'package:star_common/manager/user/user_balance_logic.dart';

class BetModel {
  BetModel(
      {required this.betNumber,
      required this.betValue,
      required this.gamePlay});
  final String betValue;
  final int gamePlay;
  final int betNumber;
}

class FollowBetWidget extends StatelessWidget with Toast {
  FollowBetWidget(this.gameName, this.id, this.bets, {required this.anchorId});
  final String gameName;
  final String id;
  final String anchorId;
  final List<BetModel> bets;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
    var intl = AppInternational.of(context);
    return Container(
        width: size.width,
        height: size.height / 2,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 21, 23, 35),
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        child: Column(children: [
          SizedBox(height: 8),
          Row(children: [
            CustomText(gameName,
                fontSize: 16.sp, fontWeight: w_600, color: Colors.white),
            Spacer(),
            CustomText(
              "${intl.at} $id ${intl.period}",
              fontSize: 12.sp,
              fontWeight: w_500,
              color: Colors.white,
            )
          ]).padding(padding: EdgeInsets.symmetric(horizontal: 16)),
          SizedBox(height: 8),
          CustomDivider(),
          SizedBox(height: 8),
          ListView.separated(
                  itemBuilder: (_, index) {
                    var model = bets[index];
                    return Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 8),
                          Spacer(),
                          CustomText("${model.betNumber}",
                              fontSize: 14.sp,
                              fontWeight: w_500,
                              color: Color.fromARGB(255, 255, 147, 185)),
                          SizedBox(width: 8)
                        ]);
                  },
                  separatorBuilder: (_, __) => SizedBox(height: 8),
                  itemCount: bets.length)
              .expanded(),
          Container(
                  width: 263.dp,
                  height: 44.dp,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: AppColors.buttonGradientColors),
                      borderRadius: BorderRadius.circular(8)),
                  alignment: Alignment.center,
                  child: CustomText("${intl.confirmWager}",
                      fontWeight: w_500, color: Colors.white, fontSize: 16.dp))
              .cupertinoButton(onTap: () {
            //result["gameName"] = gameName;
            //     result["periodTime"] = lastPeriodTime;
            //     result["anchorId"] = id;
            //     var l = gamePlays.where((element) {
            //       int index = gamePlays.indexOf(element);
            //       var bets = _bets[index];
            //       element._selectIndexes = bets;
            //       return bets.isNotEmpty;
            //     }).map((e) => e._selectIndexes.map((e1) => {
            //       "gamePlay": e.options[e1].gamePlay,
            //       "betNum": _betNum.value,
            //       "betValue": e.options[e1].betValue
            //     }).toList()).toList();
            //     if (l.length == 0) {
            //       return null;
            //     }
            //     /// 具体数据
            //     result["betList"] = l.reduce((value, element) => value + element);
            show();
            HttpChannel.channel.bet({
              "gameName": gameName,
              "periodTime": int.parse(this.id),
              "anchorId": anchorId,
              "betList": bets
                  .map((e) => {
                        "gamePlay": e.gamePlay,
                        "betNum": e.betNumber,
                        "betValue": e.betValue
                      })
                  .toList()
            }).then((value) => value.finalize(
                wrapper: WrapperModel(),
                failure: (e) => showToast(e),
                success: (_) {
                  Get.find<UserBalanceLonic>().userBalanceData();
                  showToast("${intl.betSuccess}");
                  Get.back();
                }));
          })
        ]));
  }
}
