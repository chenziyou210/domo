/*
 *  Copyright (C), 2015-2021
 *  FileName: cell
 *  Author: Tonight丶相拥
 *  Date: 2021/8/4
 *  Description: 
 **/

import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/common_widget/level_widget.dart';
import '';

class PersonCell extends StatelessWidget {
  PersonCell(this.entity);
  final PersonModel entity;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(children: [
      ClipRRect(
          child: ExtendedImage.network(entity.avatar,
              enableLoadState: false,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(24)),
          borderRadius: BorderRadius.circular(24)),
      SizedBox(width: 16),
      Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Row(children: [
              Text(entity.name, style: AppStyles.f16w500c38_38_40),
              SizedBox(width: 4),
              LevelWidget(R.vipBackground, 18)
            ]),
            SizedBox(height: 4),
            Text(entity.signature, style: AppStyles.f15w400c193_192_201)
          ]))
    ]);
  }
}

class PersonModel {
  PersonModel(
      {required this.avatar,
      required this.signature,
      required this.name,
      required this.level});
  // 头像
  final String avatar;
  // 姓名
  final String name;
  // 等级
  final int level;
  // 签名
  final String signature;
}
