/*
 *  Copyright (C), 2015-2022
 *  FileName: gift_package_view
 *  Author: Tonight丶相拥
 *  Date: 2022/4/25
 *  Description:
 **/

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_common/i18n/i18n.dart';

import 'package:star_common/generated/gift_entity.dart';
import 'package:star_common/router/router_config.dart';

import '../../mine_backpack/views/room_bag_page.dart';
import '../gift_view.dart';

class GiftPackageView extends StatefulWidget {
  GiftPackageView(
      {required this.gifts,
      required this.privilegeGifts,
      required this.roomId});

  final List<GiftEntity> gifts;
  final String? roomId;

  final List<GiftEntity> privilegeGifts;

  @override
  createState() => _PackageViewState();
}

class _PackageViewState extends State<GiftPackageView>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

  }

  //记录切换移动的点
   var temopPostion = 0.0;
   var isChange = false;

  bool handleNotification(ScrollNotification notification){

    final ScrollMetrics metrics = notification.metrics;

    double maxExten = metrics.maxScrollExtent;
    double current = metrics.pixels;
    bool atEdge = metrics.atEdge;

    switch (notification.runtimeType){
      case ScrollStartNotification: {

      } break;
      case ScrollUpdateNotification:{
        //只对第一页进行处理，二三页如果要考虑多列表情况需要在严谨的判断
        if(_tabController.index == 0){
          if(current - 20 > maxExten){
              _tabController.animateTo(1);
            return true;
          }
        }
      } print("正在滚动"); break;
      // case ScrollEndNotification: print("滚动停止"); break;
      // case OverscrollNotification: print("滚动到边界"); break;
    }

    return true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var intl = AppInternational.of(context);
    return  Container(
      child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.dp)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
              height: 350.dp + AppLayout.safeBarHeight,
              decoration: BoxDecoration(
                  color: AppMainColors.blickColor90,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16.dp))),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(height: 12.dp),
                Row(
                  children: [
                    SizedBox(width: 6.dp),
                    CustomTabBar(
                        controller: _tabController,
                        isScrollable: true,
                        tabs: (_) => [
                          CustomText(intl.gift).padding(
                              padding: EdgeInsets.only(bottom: 8.dp)),
                          CustomText(intl.privilege).padding(
                              padding: EdgeInsets.only(bottom: 8.dp)),
                          CustomText(intl.package)
                              .padding(padding: EdgeInsets.only(bottom: 8.dp))
                        ],
                        unselectedLabelStyle:
                        TextStyle(fontSize: 14.sp, fontWeight: w_400),
                        unselectedLabelColor: AppMainColors.whiteColor70,
                        labelColor: Colors.white,
                        indicatorWidth: 10.dp,
                        labelStyle: TextStyle(fontSize: 14.sp, fontWeight: w_500),
                        decoration: UnderlineTabLinearGradientIndicatorCustom(
                            width: 12.dp,
                            isCircle: true,
                            borderSide: BorderSide(width: 1.dp, color: Colors.white),
                            gradient: LinearGradient(
                                colors: AppColors.buttonGradientColors)))
                        .expanded(),
                    Image.asset(R.icPeerage, width: 16.dp, height: 16.dp)
                        .padding(padding: EdgeInsets.only(bottom: 4.dp)),
                    SizedBox(width: 4.dp),
                    CustomText("成为贵族",
                        fontSize: 12.sp,
                        fontWeight: w_400,
                        color: AppMainColors.whiteColor70)
                        .padding(padding: EdgeInsets.only(bottom: 6))
                        .gestureDetector(onTap: () {
                         Get.toNamed(AppRoutes.mineNoble);
                    }),
                    SizedBox(width: 16.dp),
                  ],
                ),
                SizedBox(height: 10.dp),
                TabBarView(children: [
                   wrapWithNotify(GiftView(gifts: widget.gifts, type: 0, isAnchor: false)),
                   wrapWithNotify(GiftView(gifts: widget.privilegeGifts, type: 1, isAnchor: false)),
                   wrapWithNotify(RoomBagPage(widget.roomId),),
                  // PackageView()
                ], controller: _tabController)
                    .expanded()
              ])),
        ),
      ),
    );
  }

  Widget wrapWithNotify(Widget child){
    return NotificationListener<ScrollNotification>(
      child: child,
      onNotification: handleNotification,

    );
  }
}


