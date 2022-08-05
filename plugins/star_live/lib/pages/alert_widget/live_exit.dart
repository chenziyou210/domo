import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_common/manager/app_manager.dart';

class LiveExit extends StatelessWidget {
  const LiveExit(
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
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Stack(alignment: AlignmentDirectional.topCenter, children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.dp),
                    topRight: Radius.circular(12.dp)),
                color: AppMainColors.blickColor90),
            margin: EdgeInsets.only(top: 32.dp),
          ),
          Column(
            children: [
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
              CustomText(intl.followTheAnchor, style: AppStyles.f16w500white100),
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
                  width: 110.dp,
                  height: 24.dp,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.dp),
                      gradient: LinearGradient(
                          colors: AppMainColors.commonBtnGradient)),
                  child: Text(intl.followAndExit,
                      style: AppStyles.f12w400c255_255_255),
                ),
              ),
              SizedBox(height: 8.dp),
              GestureDetector(
                  onTap: () {
                    // Navigator.of(context).pop(false);
                    Get.back(result:  false);
                  },
                  child: Container(
                      width: 110.dp,
                      height: 24.dp,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.dp),
                          color: Colors.white.withOpacity(0.06),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.1), width: 1.dp)),
                      alignment: Alignment.center,
                      child: CustomText(intl.dropOut,
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: AppMainColors.whiteColor70,
                              fontWeight: w_400)))),
              Spacer()
            ],
          ),
        ]),
    );
  }
}
