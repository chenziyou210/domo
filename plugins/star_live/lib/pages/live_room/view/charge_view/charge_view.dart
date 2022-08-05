/*
 *  Copyright (C), 2015-2022
 *  FileName: charge_view
 *  Author: Tonight丶相拥
 *  Date: 2022/4/15
 *  Description: 
 **/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';

import 'first_charge.dart';

class LiveChargeView extends AlertDialog {
  LiveChargeView(this.award, {this.onTap, this.onCharge});

  final VoidCallback? onTap;
  final VoidCallback? onCharge;
  final FirstChargeRewardEntity award;

  @override
  // TODO: implement backgroundColor
  Color? get backgroundColor => Colors.transparent;

  @override
  // TODO: implement elevation
  double? get elevation => 0;

  @override
  // TODO: implement contentPadding
  EdgeInsetsGeometry get contentPadding => EdgeInsets.zero;

  @override
  // TODO: implement insetPadding
  EdgeInsets get insetPadding => EdgeInsets.zero;

  @override
  // TODO: implement content
  Widget? get content => Stack(alignment: Alignment.topCenter, children: [
        Container(
          height: Get.height - 124.dp,
        ),
        Container(
            width: 375.dp,
            height: 465.dp,
            child: Image.asset(R.icBgRecharge)),
        Container(
          width: 230.dp,
          height: 57.dp,
          padding: EdgeInsets.only(left: 40.dp, top: 15.dp),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(R.bgRechargeTitle),
                  fit: BoxFit.fill)),
          child: CustomText(
            "充值任意金额送特惠大礼包",
            fontWeight: w_500,
            fontSize: 14.sp,
            color: Colors.black,
          ),
        ).position(top: 278.dp),
        Container(
                width: 205.dp,
                height: 32.dp,
                alignment: Alignment.center,
                child: Image.asset(R.icGotoRecharge))
            .cupertinoButton(onTap: onCharge)
            .position(top: 465.dp + 10.dp),
        _buildGift().position(top: 345.dp),
        Container(
          child: Image.asset(
            R.icClose,
            width: 34.dp,
            height: 34.dp,
          ),
        ).cupertinoButton(onTap: onTap).position(right: 25.dp, top: 42.dp)
      ]);

  Widget _buildGift() {
    if (award.awardInfo != null) {
      List<Gift>? gift = award.awardInfo?.gift;
      List<Tool>? tool = award.awardInfo?.tool;
      if (gift != null && gift.isNotEmpty) {
        return SizedBox(
          width: 300.dp,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(gift.length, (index) {
                return Column(
                  children: [
                    Container(
                        child: Image.network(
                          gift[index].giftIcon ?? "",
                          width: 70.dp,
                          height: 70.dp,
                        ),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage(R.bgRechargeGift)))),
                    SizedBox(
                      height: 8.dp,
                    ),
                    Text.rich(TextSpan(
                        text: "x",
                        style: AppStyles.f12w500c255_255_255,
                        children: [
                          TextSpan(
                            text: gift[index].num.toString(),
                            style: TextStyle(
                                fontWeight: w_400,
                                fontFamily: 'Number',
                                fontSize: 16.sp,
                                color: Colors.white),
                          ),
                        ])),
                    // CustomText(gift[index].num)
                  ],
                );
              })),
        );
      } else if (tool != null && tool.isNotEmpty) {
        return SizedBox(
            width: 300.dp,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(tool.length, (index) {
                  return Column(
                    children: [
                      Container(
                          child: Image.network(
                            tool[index].itemIcon ?? "",
                            width: 70.dp,
                            height: 70.dp,
                          ),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage(R.bgRechargeGift)))),
                      SizedBox(
                        height: 8.dp,
                      ),
                      Text.rich(TextSpan(
                          text: "x",
                          style: AppStyles.f12w500c255_255_255,
                          children: [
                            TextSpan(
                              text: tool[index].num.toString(),
                              style: TextStyle(
                                  fontWeight: w_400,
                                  fontFamily: 'Number',
                                  fontSize: 16.sp,
                                  color: Colors.white),
                            ),
                          ])),
                      // CustomText(gift[index].num)
                    ],
                  );
                })));
      }
    }
    return Container();
  }
}
