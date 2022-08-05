/*
 *  Copyright (C), 2015-2022
 *  FileName: first_charge
 *  Author: Tonight丶相拥
 *  Date: 2022/4/15
 *  Description: 
 **/

import 'package:flutter/material.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/i18n/i18n.dart';

class FirstChargeView extends AlertDialog {
  FirstChargeView({required this.onTap});
  final VoidCallback onTap;
  @override
  // TODO: implement backgroundColor
  Color? get backgroundColor => Colors.transparent;

  @override
  // TODO: implement contentPadding
  EdgeInsetsGeometry get contentPadding => EdgeInsets.zero;

  @override
  // TODO: implement insetPadding
  EdgeInsets get insetPadding => EdgeInsets.zero;

  @override
  // TODO: implement content
  Widget? get content => Stack(
    alignment: Alignment.center,
    children: [
      Image.asset(R.firstCharge).container(),
      Image.asset(R.livingClose).container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          shape: BoxShape.circle
        )
      ).cupertinoButton(onTap: onTap).position(right: 60, top: 10),
      CustomText(AppInternational.current.doubleTheFirstCharge,
        fontSize: 22.sp, fontWeight: w_600,
        color: Colors.white
      ).position(top: 100),
      CustomText(AppInternational.current.goToRecharge,
        fontSize: 22.sp, fontWeight: w_600,
        color: Colors.white
      ).padding(padding: EdgeInsets.symmetric(
          horizontal: 60, vertical: 20
      )).cupertinoButton(onTap: (){

      }).position(bottom: 0),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 64),
          Row(
            children: [

            ]
          ).container(decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 232, 236),
            borderRadius: BorderRadius.circular(6)
          ), height: 40, width: 220),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(R.livingCoin),
              SizedBox(width: 8),
              CustomText("1000金币+超值大礼包",
                fontSize: 14.sp, color: Color.fromARGB(255, 238, 32, 62),
                fontWeight: w_600)
            ]
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ItemWidget(title: "兰博基尼",
                  image: "",
                  subTitle: "x2天"),
              SizedBox(width: 8),
              _ItemWidget(title: "礼物",
                  image: "",
                  subTitle: "x10朵"),
              SizedBox(width: 8),
              _ItemWidget(title: "积分",
                  image: "",
                  subTitle: "100")
            ]
          )
        ]
      )
    ]
  );
}

class _ItemWidget extends StatelessWidget {
  _ItemWidget({required this.title,
    required this.image,
    required this.subTitle});
  final String title;
  final String image;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 62,
      constraints: BoxConstraints(minHeight: 81),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 232, 236),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(height: 4),
        CustomText("$title",
          fontSize: 10.sp,
          color: Color.fromARGB(255, 221, 66, 87),
          fontWeight: w_400),
        SizedBox(height: 4),
         // Image.asset(AppImages.carMarket),
        SizedBox(height: 8),
        Container(
          height: 20, color: Color.fromARGB(255, 245, 98, 122),
          child: CustomText("$subTitle",
            fontSize: 12.sp, color: Colors.white,
            fontWeight: w_400).center)
        ])).clipRRect(radius: BorderRadius.circular(4));
  }
}