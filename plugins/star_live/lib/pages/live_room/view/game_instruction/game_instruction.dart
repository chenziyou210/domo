/*
 *  Copyright (C), 2015-2022
 *  FileName: game_instruction
 *  Author: Tonight丶相拥
 *  Date: 2022/2/17
 *  Description: 
 **/

import 'package:flutter/material.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';
import 'package:star_common/i18n/i18n.dart';
import 'package:flutter_html/flutter_html.dart';

class GameInstruction extends StatelessWidget {
  GameInstruction(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 346.dp,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            height: 48,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: AppColors.buttonGradientColors)
            ),
            child: CustomText("${AppInternational.of(context).gameInstruction}",
              fontSize: 16.sp,
              fontWeight: w_500,
              color: Colors.white
            )
          ),
          SingleChildScrollView(
            child: Html(
                data: text
            ).padding(padding: EdgeInsets.only(top: 24)),
          ).expanded()
        ]
      )
    ).clipRRect(
      radius: BorderRadius.vertical(top: Radius.circular(8))
    );
  }
}