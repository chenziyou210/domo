/*
 *  Copyright (C), 2015-2022
 *  FileName: live_room_view
 *  Author: Tonight丶相拥
 *  Date: 2022/1/7
 *  Description: 
 **/

import 'dart:async';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_live/agora_rtc/agora_rtc.dart';

import '../../live_room_new_logic.dart';

class LiveRoomView extends StatefulWidget {
  LiveRoomView(
      {required this.isOnlyOne,
      required this.index,
      required this.isSmallWindow});

  final bool isOnlyOne;
  final int index;
  final bool isSmallWindow;

  @override
  createState() => _LiveRoomViewState();
}

class _LiveRoomViewState extends State<LiveRoomView>
    with AutomaticKeepAliveClientMixin {
  LiveRoomNewLogic get _controller => Get.find<LiveRoomNewLogic>();

  AgoraRtcLogic get _agoraController => Get.find<AgoraRtcLogic>();

  @override
  bool get wantKeepAlive => true;

  bool isCaptured = false;
  late StreamSubscription<void> subscription;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(() {
      int roomIndex = _controller.state.roomIndex.value;
      if ((widget.isOnlyOne && roomIndex == widget.index) ||
          (!widget.isOnlyOne && widget.index == roomIndex + 1)) {
        return Obx(
          () {
            if (_agoraController.state.hasRemoteUid.value) {
              return _controller.state.pauseOrStart.value
                  ? Container(
                      color: AppMainColors.backgroudColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "直播暂停中,请稍等",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(height: widget.isSmallWindow ? 0 : 100)
                        ],
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(_controller
                                      .state
                                      .rooms[_controller.state.roomIndex.value]
                                      .roomCover ??
                                  ""),
                              fit: BoxFit.cover)),
                      child: isCaptured
                          ? Container(
                              color: AppMainColors.backgroudColor,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                      height: widget.isSmallWindow ? 0 : 100)
                                ],
                              ),
                            )
                          : RemoteView(
                              uid: _agoraController.state.remoteUid!,
                              channel: _controller.state.channelName,
                            ),
                    );
            }
            return Obx(
              () {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: ExtendedImage.network(
                        _controller
                                .state
                                .rooms[_controller.state.roomIndex.value]
                                .roomCover ??
                            "",
                        enableLoadState: false,
                        fit: BoxFit.cover,
                        loadStateChanged: (state) {
                          if (state.extendedImageLoadState ==
                                  LoadState.loading ||
                              state.extendedImageLoadState ==
                                  LoadState.failed) {
                            return Image.asset(R.imgPlaceHolder,
                                fit: BoxFit.cover);
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      }
      return Container();
    });
  }
}
