/*
 *  Copyright (C), 2015-2022
 *  FileName: gift_card
 *  Author: Tonight丶相拥
 *  Date: 2022/4/25
 *  Description: 
 **/

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/generated/gift_entity.dart';

class GiftDescriptionEntity {
  GiftDescriptionEntity(this.number, this.description);

  final int number;
  final String description;
}

class GiftCard extends StatelessWidget {
  GiftCard(this.entity, {this.isSelect = false});

  final GiftEntity entity;
  bool isSelect;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double size = isSelect ? 64.dp : 48.dp;
    return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            bottom: 49.dp,
            child: ExtendedImage.network(entity.picUrl ?? "",
              enableLoadState: false,
              width: size,
              height: size,
              fit: BoxFit.cover),
          ),
          Positioned(
            bottom: 8.dp,
            child: Column(
              children: [
                SizedBox(height: 8.dp),
                //按照UI要求左边距离边界8
                Container(child: CustomText("${entity.name}", style: AppStyles.f12w400white,overflow: TextOverflow.ellipsis,).marginSymmetric(horizontal: 8.dp)),
                SizedBox(height: 2.dp),
                Container(child: CustomText("${entity.coins} 钻", style: AppStyles.f10w400c70white,overflow: TextOverflow.ellipsis,).marginSymmetric(horizontal: 8.dp)),
              ],
            ),
          ),
          _showLable().position(top: 8.dp, right: 2.dp)
    ]);
  }

  Widget _showLable() {
    if (entity.type!=1&&entity.type!=4) {
    //   //守护
      late Widget text;
      if (entity.type == 2) {
        text = CustomText("Lv${entity.levelLimit}",fontSize: 8.sp,color:Colors.white,fontWeight: w_400,fontFamily: 'Number',);
      }else if(entity.type == 3){
        text = CustomText("守护",fontSize: 8.sp,fontWeight: w_400,color:Colors.white,fontFamily: 'Number',);
      }
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 4.dp,vertical: 1.dp),
        decoration: BoxDecoration(
            color: AppMainColors.whiteColor40,
            borderRadius: BorderRadius.circular(6.dp)),
        child: text,
      );
     }
     return Container();
  }
}

class GiftIndex {
  int page = -1;
  int index = -1;

  void reset() {
    this.page = -1;
    this.index = -1;
  }

  bool isZero() {
    return page != -1 && index != -1;
  }

  void setLocation(int page, int index) {
    this.page = page;
    this.index = index;
  }
}

class GiftModel {
  GiftModel(this.id, this.number, this.name, this.type);

  int id;
  int type;
  int number;
  String name;
}
