/*
 *  Copyright (C), 2015-2021
 *  FileName: live_room_new
 *  Author: Tonight丶相拥
 *  Date: 2021/12/9
 *  Description:
 **/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/common_widget/app_dialog.dart';
import 'package:star_common/common/storage.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/router/router_config.dart';

import '../../../../agora_rtc/agora_rtc.dart';
import '../../../recharge/recharge/recharge_view.dart';
import '../../live_room_new_logic.dart';

class LivingPayPoppupPage extends StatefulWidget {
  @override
  createState() => _LivingPayPoppupPageState();
}

class _LivingPayPoppupPageState extends AppStateBase<LivingPayPoppupPage> {
  /// 数据
  LiveRoomNewLogic get _controller => Get.find<LiveRoomNewLogic>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bool isShow = _controller.state.showPayPopup.value &&
        _controller.state.livingState.value == LivingRoomState.linking;
    if (isShow) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (!_controller.state.enoughMoney.value) {
          _showBalanceDialog();
        } else {
          _showDialog();
        }
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return body;
  }

  @override
  // TODO: implement body
  Widget get body => Stack(alignment: Alignment.center, children: [
        // Positioned.fill(
        //   child: ExtendedImage.network(
        //     _controller
        //             .state.rooms[_controller.state.roomIndex.value].roomCover ??
        //         "",
        //     enableLoadState: false,
        //     fit: BoxFit.cover,
        //     loadStateChanged: (state) {
        //       if (state.extendedImageLoadState == LoadState.loading ||
        //           state.extendedImageLoadState == LoadState.failed) {
        //         return Image.asset(AppImages.imgPlaceHolder, fit: BoxFit.cover);
        //       }
        //     },
        //   ),
        // ),
      ]);

  _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AppDialog(
          CustomText(
            _controller.state.feeType.value == 1
                ? "主播开启了付费直播，${_controller.state.roomInfo.value.timeDeduction}钻/分钟，是否付费进入直播间 ？"
                : "主播开启了付费直播，${_controller.state.roomInfo.value.ticketAmount}钻/场，是否付费进入直播间 ？",
            style: TextStyle(
                fontSize: 14.dp, fontWeight: w_400, color: Colors.white70),
          ),
          title: "付费直播",
          cancelText: "退出",
          confirmText: "确定",
          cancel: () {
            ExitLiveRoom();
          },
          confirm: () {
            HttpChannel.channel.liveRoomPayWatch()
              ..then((value) => value.finalize(
                  wrapper: WrapperModel(),
                  success: (_) {
                    Get.back();
                    if (_controller.state.feeType.value == 1) {
                      _controller.state.setPayWatchTime(1);
                    } else {
                      _controller.state.setPayWatchTime(2);
                    }
                    _controller.state.setShowPayPopup(false);
                    _controller.state.payEnterRoom();
                  },
                  failure: (e) {
                    Get.back();
                    _showBalanceDialog();
                  }));
          },
        );
      },
    );
  }

  _showBalanceDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AppDialog(
          CustomText(
            "很抱歉，当前钻石钱包余额不足，请前往充值或兑换",
            style: TextStyle(
                fontSize: 14.dp, fontWeight: w_400, color: Colors.white70),
          ),
          cancelText: "取消",
          confirmText: "前往充值",
          cancel: () {
            ExitLiveRoom();
          },
          confirm: () {
            Get.back();
            _showDialog();
            Get.to(() => RechargePage(true));
          },
        );
      },
    );
  }

  ///退出直播间
  void ExitLiveRoom() {
    HttpChannel.channel.audienceExitRoom(
        roomId: StorageService.to.getString("roomId"), follow: false);
    if(_controller.state.roomSplit.value){
      _controller.closeGameBackView?.call("payload");
      Future.delayed(Duration(milliseconds: 200), () {
        Get.back();
        _controller.state.roomSplit.value = false;
      });
    }
    Get.back();
  }
}
