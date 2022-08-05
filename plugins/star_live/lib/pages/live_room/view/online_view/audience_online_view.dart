/*
 *  Copyright (C), 2015-2021
 *  FileName: audience_online_view
 *  Author: Tonight丶相拥
 *  Date: 2021/12/11
 *  Description: 
 **/

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_common/router/router_config.dart';
import '/pages/live_room/view/online_view/audience_online_logic.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';
import 'online_users_page.dart';

class AudienceOnlineView extends StatefulWidget {
  AudienceOnlineView(this.roomId, this.isAnchor);
  final bool isAnchor;
  final String roomId;

  @override
  createState() => _AudienceOnlineView();
}

class _AudienceOnlineView extends AppStateBase<AudienceOnlineView>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  late final AudienceOnlineLogic onlineUserController = AudienceOnlineLogic()
    ..roomId = widget.roomId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    Get.put(onlineUserController);
    _tabController.addListener(() {
      onlineUserController.showNoble(_tabController.index == 0);
    });
    onlineUserController.dataRefresh();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16.dp)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            // height: context.height*0.6,
            decoration: BoxDecoration(
                color: Color.fromRGBO(22, 23, 34, 0.9),
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(12.dp))),

            child: Stack(
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 12.dp),
                      Row(
                        children: [
                          CustomTabBar(
                                  controller: _tabController,
                                  isScrollable: false,
                                  tabs: (_) => [
                                        Obx(() {
                                          return CustomText(
                                                  "在线贵族(${onlineUserController.state.nobleData.length})")
                                              .padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 6.dp));
                                        }),
                                        Obx(() {
                                          return CustomText(
                                                  "在线人数(${onlineUserController.state.onlineNum})")
                                              .padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 6.dp));
                                        }),
                                      ],
                                  unselectedLabelStyle: TextStyle(
                                      fontSize: 14.sp, fontWeight: w_500),
                                  unselectedLabelColor:
                                      Color.fromARGB(255, 115, 117, 131),
                                  labelColor: Colors.white,
                                  indicatorWidth: 10,
                                  labelStyle: TextStyle(
                                      fontSize: 14.sp, fontWeight: w_500),
                                  decoration:
                                      UnderlineTabLinearGradientIndicatorCustom(
                                          width: 12.dp,
                                          gradient: LinearGradient(
                                              colors: AppColors
                                                  .buttonGradientColors)))
                              .expanded(),
                        ],
                      ),
                      SizedBox(height: 12.dp),
                      TabBarView(children: [
                        UserOnlinePage(onlineUserController, 1),
                        UserOnlinePage(onlineUserController, 0),
                        // PackageView()
                      ], controller: _tabController)
                          .paddingOnly(bottom: context.height * 0.5)
                          .expanded()
                    ]),
                widget.isAnchor
                    ? Container()
                    : Obx(() {
                        if (onlineUserController.state.isNoble.value) {
                          return Positioned.fill(
                            top: context.height * 0.5 -
                                60.dp -
                                AppLayout.safeBarHeight,
                            child: Container(
                              child: ClipRRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 5.0, sigmaY: 5.0),
                                  child: Container(
                                      height: 60.dp,
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              "加入贵族，享受独一无二的豪华特权",
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 12.sp,
                                              fontWeight: w_400,
                                              color: Colors.white,
                                            ).marginOnly(
                                                top: 10.dp, left: 16.dp),
                                            Image.asset(
                                              R.icOpenPeerage,
                                              width: 100.dp,
                                              height: 36.dp,
                                            )
                                                .container(
                                                    margin: EdgeInsets.only(
                                                        right: 19.dp))
                                                .gestureDetector(onTap: () {
                                                  Get.back();
                                                  Get.toNamed(AppRoutes.mineNoble);
                                            }),
                                          ])),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
