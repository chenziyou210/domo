import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/common_widget/live/guard_icon_widget.dart';
import 'package:star_common/common/common_widget/live/peerage_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/lottie/lottie_view.dart';
import 'package:star_common/manager/user/config_info_logic.dart';
import 'package:star_common/util_tool/stringutils.dart';
import '../../../custom_service/contact_service_page.dart';
import '../../live_room_new_logic.dart';
import '../../open_guide/open_guide_view.dart';
import 'guide_widget_logic.dart';

class GuardWidget extends StatelessWidget {
  final bool isAnchor;

  GuardWidget(this.isAnchor);

  final LiveRoomWatchList logic = Get.put(LiveRoomWatchList());
  final RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    logic.liveRoomWatchData();
    return ClipRect(
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            height: context.height * 0.8,
            width: context.width,
            decoration: BoxDecoration(
              color: AppMainColors.blickColor90,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.dp),
                  topRight: Radius.circular(12.dp)),
            ),
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Container(
                  height: 210.dp,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(R.zbjShouhu), fit: BoxFit.fill)),
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [ Align(
                      alignment: Alignment.topRight,
                      child: CustomText(
                        "守护说明",
                        style: TextStyle(
                            fontWeight: w_400,
                            fontSize: 12.sp,
                            color: AppMainColors.whiteColor40),
                      ).paddingOnly(right: 16.dp, top: 12.dp).gestureDetector(
                          onTap: () {
                            Get.to(() => ContactServicePage(arguments: {
                              "url":
                              "${Get.find<ConfigInfoLonic>().state.configInfo.value.sysHelpH5?.watchInfo}",
                              "title": '守护说明'}));
                          }),
                    ),
                      guardHead().marginOnly(top: 26.dp),],
                  ),
                ),

                guardRankList(context).marginOnly(top: 210.dp, bottom: 60.dp),
                isAnchor
                    ? Container()
                    : Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          children: [
                            CircleAvatar(
                                radius: 12.dp,
                                backgroundImage: NetworkImage(
                                    Get.find<LiveRoomNewLogic>()
                                            .state
                                            .roomInfo
                                            .value
                                            .header ??
                                        "")),
                            SizedBox(
                              width: 10.dp,
                            ),
                            CustomText(
                              "为TA守护 ，成为我的人",
                              style: TextStyle(
                                  fontWeight: w_500,
                                  fontSize: 12.sp,
                                  color: Colors.white),
                            ).expanded(),
                            Image.asset(
                              R.btnOpenGuard,
                              width: 100.dp,
                              height: 36.dp,
                            )
                                .container(
                                    margin: EdgeInsets.only(right: 20.dp))
                                .gestureDetector(onTap: () {
                              Get.back();
                              // showGuard(context);
                              Get.bottomSheet(OpenGuidePage());
                            }),
                          ],
                        ),
                      ).marginOnly(bottom: 23.dp, left: 16.dp)
              ],
            ),
          )),
    );
  }

  Widget guardHead() {
    return Obx(() {
      LiveRoomWatchListData itemModel = LiveRoomWatchListData();
      if (logic.state.liveRoomWatchList.length > 0) {
        itemModel = logic.state.liveRoomWatchList[0];
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            itemModel.userId == 0
                ? Image.asset(
                    R.rankHeadMoren,
                    fit: BoxFit.cover,
                    width: 60.dp,
                    height: 60.dp,
                  ).marginOnly(top: 10.dp)
                : Stack(
                    children: [
                      ExtendedImage.network(itemModel.header!,
                              width: 68.dp, height: 68.dp, fit: BoxFit.fill)
                          .clipRRect(radius: BorderRadius.circular(34.dp))
                          .position(left: 4.dp, top: 4.dp),
                      Image.asset(
                        R.icGuardBgChampion,
                        width: 76.dp,
                        height: 76.dp,
                      )
                    ],
                  ),
            SizedBox(
              height: 8.dp,
            ),
            CustomText(
              itemModel.userId == 0 ? "上周无人登榜" : itemModel.username!,
              style: AppStyles.f16w500white100,
            ),
            SizedBox(
              height: itemModel.userId == 0 ? 10.dp : 8.dp,
            ),
            itemModel.userId == 0
                ? CustomText(
                    "开通守护，多送礼物可成为TA的荣耀守护哦",
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppMainColors.whiteColor70),
                  )
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserLevelView(itemModel.rank!),
                          PeerageWidget(itemModel.nobleType, 4),
                          GuardIconWidget(itemModel.watchType, 4)
                        ],
                      ),
                      SizedBox(
                        height: 8.dp,
                      ),
                      Text.rich(TextSpan(
                          text: "上周贡献",
                          style: AppStyles.f14w500c255_255_255,
                          children: [
                            TextSpan(
                                text: StringUtils.showNmberOver10k(
                                    itemModel.heat),
                                style: TextStyle(
                                    color: AppMainColors.mainColor,
                                    fontFamily: "Number",
                                    fontWeight: w_400,
                                    fontSize: 16.sp)),
                            TextSpan(
                              text: "火力",
                            )
                          ])),
                    ],
                  )
          ],
          // child:
        );
      } else {
        return EmptyView(emptyType: EmptyType.noData, topOffset: 200);
      }
    });
  }

  Widget guardRankList(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      header: LottieHeader(),
      footer: LottieFooter(),
      onRefresh: () async {
        await logic.liveRoomWatchData();
        refreshController.refreshCompleted();
        return;
      },
      child: Obx(() {
        var values = logic.state.liveRoomWatchList;
        if (values.length > 1) {
          return Container(
            child: ListView.builder(
                itemCount: values.length - 1,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (widgetContext, index) {
                  var model = values[index + 1];

                  return getGuardItem(model);
                }),
          );
        } else {
          return Container();
        }
      }),
    );
  }

  Widget getGuardItem(LiveRoomWatchListData itemModel) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 16.dp),
            ExtendedImage.network(itemModel.header!,
                    width: 40.dp, height: 40.dp, fit: BoxFit.fill)
                .clipRRect(radius: BorderRadius.circular(20.dp)),
            SizedBox(
              width: 16.dp,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 18.dp,
                ),
                CustomText("${itemModel.username}",
                    style: TextStyle(
                        fontWeight: w_500,
                        fontSize: 14.sp,
                        color: AppMainColors.whiteColor100)),
                SizedBox(
                  height: 4.dp,
                ),
                Row(
                  children: [
                    UserLevelView(itemModel.rank!),
                    PeerageWidget(itemModel.nobleType, 4),
                    GuardIconWidget(itemModel.watchType, 4),
                    itemModel.roomAdmin == 1
                        ? Image.asset(
                            R.icAdministrator,
                            width: 16.dp,
                            height: 16.dp,
                          )
                        : Container(),
                  ],
                ),
                SizedBox(
                  height: 18.dp,
                ),
              ],
            ).expanded(),
            Text.rich(TextSpan(
                text: StringUtils.showNmberOver10k(itemModel.heat),
                style: AppStyles.number12w400white,
                children: [
                  TextSpan(
                      text: "火力",
                      style: TextStyle(
                          color: AppMainColors.whiteColor40,
                          fontWeight: w_400,
                          fontSize: 10.sp)),
                ])),
            SizedBox(width: 16.dp),
          ],
        ),
        CustomDivider(
          color: AppMainColors.separaLineColor6,
        ).marginOnly(left: 72.dp),
      ],
    );
  }
}
