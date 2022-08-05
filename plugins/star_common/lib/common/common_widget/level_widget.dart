/*
 *  Copyright (C), 2015-2021
 *  FileName: level_widget
 *  Author: Tonight丶相拥
 *  Date: 2021/7/19
 *  Description: 
 **/

import 'package:flutter/material.dart';
import 'package:star_common/common/app_common_widget.dart';

class LevelWidget extends StatelessWidget {
  final String image;
  final int level;

  const LevelWidget(this.image, this.level, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(alignment: Alignment.center, children: [
      Image.asset(image),
      Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text("$level", style: AppStyles.f10w400c255_255_255))
    ]);
  }
}
