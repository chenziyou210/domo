/*
 *  Copyright (C), 2015-2021
 *  FileName: online_view
 *  Author: Tonight丶相拥
 *  Date: 2021/12/11
 *  Description: 
 **/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/i18n/i18n.dart';

import 'package:star_common/generated/living_audience_entity.dart';

class OnlineViewState<T extends StatefulWidget> extends State<T> {

  late final PagingMixin<LivingAudienceEntity> controller;

  AppInternational get intl => AppInternational.of(context);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 21, 23, 35),
        borderRadius: BorderRadius.vertical(top: Radius.circular(10))
      ),
      child: Column(
        children: [
          SizedBox(height: 16),
          RefreshWidget(
            // enablePullUp: true,
            onLoading: (c) async{
              await controller.loadMore();
              if (controller.hasMoreData) {
                c.loadComplete();
              }else {
                c.loadNoData();
              }
            },
            onRefresh: (c) async{
              await controller.dataRefresh();
              c.refreshCompleted();
              c.resetNoData();
            },
            children: [
              Obx((){
                if (controller.data.length == 0) {
                  return SliverFillRemaining();
                }
                return SliverList(delegate: SliverChildBuilderDelegate((_, index) {
                  return Column(
                    children: [
                      cellAtIndex(index),
                      CustomDivider(
                        color: Color.fromARGB(255, 33, 36, 54),
                        indent: 16,
                        endIndent: 16
                      )
                    ]
                  );
                }, childCount: controller.data.length));
              })
            ]
          ).expanded()
        ]
      )
    );
  }

  Widget cellAtIndex(int index){
    return SizedBox();
  }
}