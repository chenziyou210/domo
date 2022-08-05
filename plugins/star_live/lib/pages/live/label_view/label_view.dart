/*
 *  Copyright (C), 2015-2022
 *  FileName: label_view
 *  Author: Tonight丶相拥
 *  Date: 2022/4/20
 *  Description: 
 **/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';

import '../live_home_data.dart';

class LabelView extends GetView<LiveHomeData> {
  LabelView({this.onTap, required this.selectJudge});
  final void Function(int)? onTap;
  final bool Function(int) selectJudge;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Get.put(LiveHomeData());
    return Obx((){
      var labels = controller.state.labels;
      var length = labels.length;
      if (length == 0) {
        return SizedBox();
      }
      return Row(
          children: [
            Wrap(
                runSpacing: 8,
                spacing: 8,
                children: [
                  for(int i = 0; i < length; i ++)
                    Obx((){
                      if (selectJudge(i)) {
                        return Container(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            constraints: BoxConstraints(minHeight: 25.dp),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.dp / 2),
                                gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 245, 76, 157),
                                      Color.fromARGB(255, 252, 126, 186)
                                    ]
                                )
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(labels[i].title,
                                      fontSize: 12.sp,
                                      color: Colors.white
                                  )
                                ]
                            )
                        );
                      }
                      return Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          constraints: BoxConstraints(minHeight: 25.dp),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25.dp / 2)
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(labels[i].title,
                                    fontSize: 12.sp,
                                    color: Color.fromARGB(255, 75, 75, 75)
                                )
                              ]
                          )
                      ).cupertinoButton(onTap: ()=> onTap?.call(i));
                    })
                ]
            ).expanded()
          ]
      );
    });
  }
}