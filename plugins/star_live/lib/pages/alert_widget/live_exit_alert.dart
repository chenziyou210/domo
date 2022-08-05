/*
 *  Copyright (C), 2015-2021
 *  FileName: live_exit_alert
 *  Author: Tonight丶相拥
 *  Date: 2021/7/21
 *  Description: 
 **/

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/i18n/i18n.dart';
import 'package:star_common/manager/app_manager.dart';

// const String _url = "https://img2.baidu.com/it/u=1077360284,2857506492&fm=26&fmt=auto&gp=0.jpg";
class LiveExitAlert extends AlertDialog {
  const LiveExitAlert(
      {Key? key,
      this.onPop,
      required this.url,
      required this.anchorId,
      required this.roomId})
      : super(key: key);
  final VoidCallback? onPop;
  final String url;
  final String anchorId;
  final String roomId;

  @override
  // TODO: implement contentPadding
  EdgeInsetsGeometry get contentPadding => EdgeInsets.zero;

  @override
  // TODO: implement insetPadding
  EdgeInsets get insetPadding => EdgeInsets.zero;
  @override
  Color? get backgroundColor => Colors.transparent;

  @override
  // TODO: implement content
  Widget? get content => Builder(builder: (context) {
        var intl = AppInternational.of(context);


         return Container(
            alignment: Alignment.center,
            width: 215.dp,
            height: 240.dp,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.dp)),
                color: AppMainColors.blickColor90),
            child: Column(
              children: [
                SizedBox(height: 24.dp),
                Container(
                  width: 64.dp,
                  height: 64.dp,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.dp),
                    borderRadius: BorderRadius.circular(44.dp),
                  ),
                  child: CircleAvatar(
                    // radius: 88.dp,
                    backgroundColor: Color(0xFFFFFFFF),
                    backgroundImage: NetworkImage(url),
                  ),
                ),
                SizedBox(height: 8.dp),
                CustomText(intl.followTheAnchor,
                    style: AppStyles.f16w500white100),
                SizedBox(height: 16.dp),
                GestureDetector(
                  onTap: () {
                    // Navigator.of(context).pop(true);
                    Get.back(result:  true);
                    HttpChannel.channel
                        .audienceExitRoom(roomId: roomId, follow: true)
                        .then((value) => value.finalize(
                            wrapper: WrapperModel(),
                            success: (_) {
                              AppManager.getInstance<AppUser>().addAttention();
                            }));
                  },
                  child: Container(
                    width: 120.dp,
                    height: 32.dp,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.dp),
                        gradient: LinearGradient(
                            colors: AppMainColors.commonBtnGradient)),
                    child: Text(intl.followAndExit,
                        style: AppStyles.f12w400c255_255_255),
                  ),
                ),
                SizedBox(height: 8.dp),
                GestureDetector(
                    onTap: () {
                      Get.back(result:  false);
                      // Navigator.of(context).pop(false);
                    },
                    child: Container(
                        width: 120.dp,
                        height: 32.dp,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.dp),
                            color: Colors.white.withOpacity(0.06),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.1),
                                width: 1.dp)),
                        alignment: Alignment.center,
                        child: CustomText(intl.dropOut,
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: AppMainColors.whiteColor70,
                                fontWeight: w_400)))),
                Spacer()
              ],
            ),
        );
      });
}
