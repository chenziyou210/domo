/*
 *  Copyright (C), 2015-2022
 *  FileName: giving_coins
 *  Author: Tonight丶相拥
 *  Date: 2022/4/24
 *  Description: 
 **/

import 'package:flutter/material.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';
import 'package:star_common/i18n/i18n.dart';

class GivingCoins extends AlertDialog {
  GivingCoins({this.onTap, required this.coins});
  final VoidCallback? onTap;
  final dynamic coins;
  final AppInternational _intl = AppInternational.current;

  @override
  // TODO: implement content
  Widget? get content => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        children: [
          Image.asset(R.givingCoins),
          SizedBox(width: 16),
          CustomText(_intl.congratulationOnGettingCoins(coins),
            fontSize: 16,
            fontWeight: w_600,
            color: Color.fromARGB(255, 27, 27, 27)
          ).expanded()
        ]
      ),
      SizedBox(height: 16),
      CustomText(_intl.useInstruction,
        fontSize: 14,
        fontWeight: w_500,
        color: Color.fromARGB(255, 57, 57, 57)
      ),
      SizedBox(height: 8),
      CustomText(_intl.givingCoinsInstruction,
        fontSize: 10,
        color: Color.fromARGB(255, 57, 57, 57),
        fontWeight: w_500
      )
    ]
  );
  
  @override
  // TODO: implement actions
  List<Widget>? get actions => [
    Container(
      width: 167,
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: AppColors.buttonGradientColors),
        borderRadius: BorderRadius.circular(20)
      ),
      child: CustomText(_intl.known,
        fontSize: 16,
        color: Colors.white,
        fontWeight: w_500
      ).center
    ).cupertinoButton(onTap: onTap)
  ];

  @override
  // TODO: implement actionsAlignment
  MainAxisAlignment? get actionsAlignment => MainAxisAlignment.center;
}