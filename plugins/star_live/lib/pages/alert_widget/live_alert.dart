/*
 *  Copyright (C), 2015-2021
 *  FileName: live_alert
 *  Author: Tonight丶相拥
 *  Date: 2021/7/21
 *  Description:
 **/

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:extended_image/extended_image.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/common_widget/signature_widget.dart';
import 'package:star_common/generated/sample_user_info_entity.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/i18n/i18n.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:httpplugin/http_result_container/http_result_container.dart';
import 'package:star_common/router/router_config.dart';
import 'package:star_common/util_tool/stringutils.dart';
import 'package:star_common/common/common_widget/live/sex_icon_widget.dart';

import '../live_room/live_room_new_logic.dart';
import '../personal_information/my_fans/my_fans_view.dart';
import '../report_page/report_page_view.dart';

class LiveAlertWidget extends StatefulWidget {
  LiveAlertWidget(this.entity, this.id,
      {required this.anchorId,
      required this.isLiveOwner,
      // required this.mute,
      this.onMute,
      required this.userId,
      this.hideAttentionButton: false,
      this.showCallButton: false});

  final SampleUserInfoEntity entity;
  final String id;
  final String userId;
  final bool isLiveOwner;
  final String anchorId;

  // final bool mute;
  final void Function(int time)? onMute;
  final bool hideAttentionButton;
  final bool showCallButton;

  @override
  createState() => _LiveAlertWidgetState(entity);
}

class _LiveAlertWidgetState extends State<LiveAlertWidget> with Toast {
  _LiveAlertWidgetState(this.entity);

  final SampleUserInfoEntity entity;
  late bool _attention;
  int? time;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _attention = entity.follow ?? false;
  }

  void _toggleAttention() async {
    Future<HttpResultContainer> future;
    if (_attention) {
      show();
      future = HttpChannel.channel.favoriteCancel(widget.userId);
    } else {
      show();
      future = HttpChannel.channel.favoriteInsert(widget.userId, widget.id);
    }
    future.then((value) => value.finalize(
        wrapper: WrapperModel(),
        failure: (e) => showToast(e),
        success: (data) {
          Get.find<LiveRoomNewLogic>().state.following();

          _attention = !_attention;
          if (_attention) {
            Get.find<LiveRoomNewLogic>().following();
            showToast("${intl.attentionSuccess}");
            widget.entity.fansNum = (widget.entity.fansNum ?? 0) + 1;
          } else {
            Get.find<LiveRoomNewLogic>().cancelFollowing();
            showToast("取消关注成功");
            widget.entity.fansNum = (widget.entity.fansNum ?? 0) - 1;
            if ((widget.entity.fansNum ?? 0) < 0) {
              widget.entity.fansNum = 0;
            }
          }
          dismiss();
          setState(() {});
        }));
  }

  @override
  Widget build(BuildContext context) {
    var intl = AppInternational.of(context);
    // TODO: implement build
    return Stack(children: [
      Container(
        margin: EdgeInsets.only(top: 32.dp),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(16.dp)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.dp),
                color: AppMainColors.blickColor90,
              ),
            ),
          ),
        ),
      ),
      Image.asset(R.comJubao, width: 16.dp, height: 16.dp)
          .padding(padding: EdgeInsets.only(top: (12 + 32).dp, left: 16.dp))
          .gestureDetector(onTap: () {
        customShowModalBottomSheet(
            context: context,
            builder: (_) {
              return ReportPagePage();
            },
            fixedOffsetHeight: 307.dp,
            isScrollControlled: false,
            barrierColor: Colors.transparent,
            backgroundColor: Colors.transparent);
      }),
      Column(
        children: [
          // Container(
          //   height: 40,
          // ),
          Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32.dp),
              color: AppMainColors.whiteColor100,
            ),
            child: ClipRRect(
              child: ExtendedImage.network(entity.header ?? "",
                  width: 64.dp,
                  height: 64.dp,
                  fit: BoxFit.cover,
                  enableLoadState: false),
              borderRadius: BorderRadius.circular(32.dp),
            ),
          ),
          SizedBox(height: 9.dp),
          CustomText(entity.username ?? "",
              style: TextStyle(
                  fontSize: 16.sp, fontWeight: w_500, color: Colors.white)),
          SizedBox(height: 8.dp),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            CustomText("${intl.id}：${entity.shortId}",
                style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: w_400,
                    color: AppMainColors.whiteColor70)),
            SizedBox(width: 30.dp),
            Image.asset(
              R.icLocation,
              width: 12.dp,
              height: 12.dp,
            ),
            SizedBox(width: 4.dp),
            Text("${entity.city}",
                style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: w_400,
                    color: AppMainColors.whiteColor70)),
          ]),
          SizedBox(
            height: 16.dp,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            // UserLevelView(entity.rank ?? 1),
            // UserLevelView(1, name: "主播"),
            Container(
              width: 28.dp,
              height: 14.dp,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.dp),
                  color: AppMainColors.mainColor60),
              child: CustomText(
                '主播',
                style: TextStyle(
                    fontFamily: 'Number',
                    color: AppMainColors.whiteColor100, //rgba(1, 154, 231, 1)
                    fontSize: 10.sp,
                    fontWeight: w_400),
              ),
            ),
            SizedBox(width: 8.dp),
            SexIconWidget(entity.sex),
          ]),
          SizedBox(height: 10.dp),
          SignatureWidget(
            signature: entity.signature,
          ),
          SizedBox(height: 30.dp),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            item(entity.fansNum ?? 0, "粉丝").gestureDetector(
              onTap: () {
                Get.to(() =>MyFansPage(arguments: {
                  "type": 1,
                  "userId": widget.userId}));
              },
            ),
            SizedBox(
              width: 8.dp,
            ),
            item(entity.heat ?? 0, "收到火力")
          ]),
          SizedBox(height: 12.dp),
          Divider(
            color: AppMainColors.separaLineColor6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              followItem(context),
              Container(
                width: 1.dp,
                height: 28.dp,
                color: AppMainColors.separaLineColor6,
              ),
              atSomeOne(context),
              Container(
                width: 1.dp,
                height: 28.dp,
                color: AppMainColors.separaLineColor6,
              ),
              homePageItem(context)
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    ]);
  }

  Widget item(int index, String title) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.dp),
      decoration: BoxDecoration(
          color: AppMainColors.separaLineColor6,
          borderRadius: BorderRadius.circular(4.dp)),
      alignment: Alignment.center,
      width: 125.dp,
      child: Column(
        children: [
          Text(
            StringUtils.showNmberOver10k(index),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: w_600,
              fontFamily: "Number",
            ),
          ),
          Text(
            title,
            style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.4), fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  Widget _bottomItem(Widget child, {required void Function()? onPressed}) {
    return Container(height: 40.dp, alignment: Alignment.center, child: child)
        .gestureDetector(onTap: onPressed);
  }

  Widget homePageItem(BuildContext context) {
    return _bottomItem(
        Text(
          "主页",
          style: TextStyle(
              color: Colors.white, fontSize: 14.sp, fontWeight: w_400),
        ), onPressed: () {
          Get.back();
          Get.toNamed(AppRoutes.userById, arguments: {"userId": widget.userId});
    });
  }

  Widget atSomeOne(BuildContext context) {
    return _bottomItem(
        Text(
          "@TA",
          style: TextStyle(
              color: Colors.white, fontSize: 14.sp, fontWeight: w_400),
        ), onPressed: () {
      Get.back(result:  {"action": 1});
    });
  }

  Widget follow(bool isFollow) {
    return isFollow
        ? Text(intl.followed,
            style: TextStyle(
                    color: Colors.white, fontSize: 14.sp, fontWeight: w_400)
                .copyWith(color: Colors.white.withOpacity(0.40)))
        : Text(intl.attention,
            style: TextStyle(
                color: Colors.white, fontSize: 14.sp, fontWeight: w_400));
  }

  Widget followItem(BuildContext context) {
    return _bottomItem(follow(_attention), onPressed: () {
      _toggleAttention();
    });
  }
}
