/*
 *  Copyright (C), 2015-2021
 *  FileName: live_room_new
 *  Author: Tonight丶相拥
 *  Date: 2021/12/9
 *  Description: 
 **/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_common/generated/anchor_list_model_entity.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/manager/app_manager.dart';
import 'package:star_common/util_tool/stringutils.dart';
import 'package:star_live/pages/live_room/view/end_draw/end_draw_logic.dart';
import 'live_room_new_logic.dart';

class AnchorEndsPage extends StatefulWidget {
  AnchorEndsPage(this.state,this.header,this.roomTitle,this.roomId,{required this.onTap});
  final LivingRoomState state;
  final String  header;
  final String  roomTitle;
  final String  roomId;

  final void Function(List<AnchorListModelEntity> data, int index) onTap;

  @override
  createState() => _AnchorEndsPageState();
}

class _AnchorEndsPageState extends AppStateBase<AnchorEndsPage> {
  // late Timer _timer;
  // RxInt _count = 4.obs;
  final EndDrawLogic _controller = EndDrawLogic();

  @override
  void initState() {
    Get.put(_controller);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return body;
  }

  @override
  // TODO: implement body
  Widget get body => Container(
    color: Color.fromRGBO(16, 16, 16, 0.7),
    padding: EdgeInsets.only(left: 16.dp, right: 16.dp),
    child: Stack(alignment: Alignment.center, children: [
      Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(height: AppLayout.statusBarHeight + 20.dp),
        GestureDetector(
          child: Container(
            width: 88.dp,
            height: 88.dp,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(44.dp),
            ),
            child: CircleAvatar(
              // radius: 88.dp,
              backgroundColor: Color(0xFFFFFFFF),
              backgroundImage: NetworkImage(widget.header),
            ),
          ),
          // onTap: () => logic.goEditInfo(context),
        ),
        SizedBox(height: 16.dp),
        CustomText(
          widget.roomTitle,
          fontSize: 16.sp,
          fontWeight: w_500,
          color: Colors.white,
        ),
        SizedBox(height: 4.dp),
        CustomText(
          "直播已结束",
          fontSize: 12.sp,
          fontWeight: w_400,
          color: Colors.white70,
        ),
        SizedBox(height: 16.dp),
        Container(
          width: 114.dp,
          height: 32.dp,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.dp),
              gradient:
              LinearGradient(colors: AppMainColors.commonBtnGradient)),
          child: Text("关注并退出",
              style: TextStyle(
                  color: Colors.white, fontWeight: w_400, fontSize: 14.sp)),
        ).inkWell(onTap: () {
          Get.back();
          HttpChannel.channel.audienceExitRoom(roomId:widget.roomId,
              follow: true).then((value) =>
              value.finalize(
                  wrapper: WrapperModel(),
                  success: (_) {
                    AppManager.getInstance<AppUser>().addAttention();
                  }
              )
          );
        }),
        SizedBox(height: 12.dp),
        Row(
          children: [
            CustomText(
              "为你推荐",
              fontSize: 14.sp,
              fontWeight: w_500,
              color: Colors.white,
            ),
          ],
        ),
        SizedBox(height: 12.dp),
        _listView(),
      ]),
      Row(mainAxisSize: MainAxisSize.min, children: [
        Image.asset(
          R.zbjDbGuanbi,
          fit: BoxFit.cover,
          width: 36,
        ).inkWell(onTap: () {
          Get.back();
        }),
      ]).position(
        top: AppLayout.statusBarHeight + 20,
        right: 6.dp,
      ),
    ]),
  );
  _listView() {
    return RefreshWidget(
        enablePullUp: true,
        onLoading: (c) async {
          await _controller.loadMore();
          if (_controller.hasMoreData) {
            c.loadComplete();
          } else {
            c.loadNoData();
          }
        },
        onRefresh: (c) async {
          await _controller.dataRefresh();
          c.refreshCompleted();
          c.resetNoData();
        },
        children: [
          Obx(
                () {
              if (_controller.state.data.length == 0) {
                return SliverFillRemaining();
              }
              return SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.745,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8),
                  delegate: SliverChildBuilderDelegate((_, index) {
                    AnchorListModelEntity model = _controller.state.data[index];
                    return [
                      _item(model).gestureDetector(onTap: () {
                        widget.onTap(_controller.state.data, index);
                      }).expanded()
                    ].column();
                  }, childCount: _controller.state.data.length));
            },
          )
        ]).expanded();
  }

  Widget _item(AnchorListModelEntity model) {
    final ListDataConfig dataConfig = ListDataConfig(anchorItem: model);
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          // 背景图
          FadeInImage.assetNetwork(
            placeholder: "",
            placeholderFit: BoxFit.cover,
            placeholderErrorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppMainColors.whiteColor15),
                  gradient: LinearGradient(
                    colors: AppMainColors.homeItemDefaultGradient,
                  ),
                ),
              );
            },
            image: dataConfig.roomCover(),
            fit: BoxFit.cover,
            imageErrorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppMainColors.whiteColor15),
                  gradient: LinearGradient(
                    colors: AppMainColors.homeItemDefaultGradient,
                  ),
                ),
              );
            },
          ).positionFill(),
          // 城市名字信息遮罩
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppMainColors.blackColor0,
                    AppMainColors.blackColor70,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
          ).position(bottom: 0, left: 0, right: 0, height: 60.dp),
          // 游戏主播房间类型
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0.dp),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppMainColors.homeItemGameBgTipGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(9.0.dp)),
            ),
            child: Text(
              dataConfig.roomName(),
              style: TextStyle(
                fontSize: 10.dp,
                fontWeight: FontWeight.w500,
                color: AppMainColors.whiteColor100,
              ),
            ),
          ).position(
              top: 8.dp,
              left: 8.dp,
              height: dataConfig.showRoomWidget() ? 18.dp : 0),
          //是否展示直播
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.0.dp),
            // alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppMainColors.blackColor70,
                border: Border.all(color: AppMainColors.whiteColor70),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0.dp),
                )),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                  R.icLive,
                  width: 8,
                  height: 8,
                ),
                Text(
                  " 直播中",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: AppMainColors.whiteColor100,
                  ),
                )
              ],
            ),
          ).position(
              top: 8.dp,
              right: 8.dp,
              height: dataConfig.showLiveWidget() ? 16.dp : 0),
          // 房间信息富文本
          RichText(
              text: TextSpan(text: "", children: [
                //1.富文本
                WidgetSpan(
                    child: Row(
                      children: [
                        //Top榜内容
                        Container(
                          height: dataConfig.showTopWidget() ? 16.dp : 0,
                          padding: EdgeInsets.symmetric(horizontal: 4.dp),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: AppMainColors.rankBgGradient),
                              borderRadius:
                              BorderRadius.all(Radius.circular(2.0.dp))),
                          child: Row(
                            children: [
                              Image.asset(
                                R.icHomeRank,
                                height: 12.dp,
                                width: 12.dp,
                              ),
                              Text(
                                dataConfig.showTopText(),
                                textAlign: TextAlign.center,
                                style: AppStyles.f10w500c255_255_255,
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 4.dp),
                        //收费内容
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 4.dp),
                          height: dataConfig.showBillWidget() ? 16.dp : 0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            // gradient: LinearGradient(colors: AppMainColors.homeItembillGradient),
                            borderRadius: BorderRadius.all(Radius.circular(2.0.dp)),
                            border: Border.all(
                                color: AppMainColors.whiteColor60, width: 0.5),
                          ),
                          child: Text(dataConfig.showBillText(),
                              style: AppStyles.f10w400c70white),
                        ),
                      ],
                    )),
                //2.房间名字
                WidgetSpan(
                  child: Container(
                    height: 28,
                    alignment: Alignment.bottomLeft,
                    // width: double.infinity,
                    child: Text(
                      dataConfig.roomTitle(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 12.dp,
                          // fontWeight: FontWeight.bold,
                          fontWeight: FontWeight.w500,
                          color: AppMainColors.whiteColor100,
                          height: 1.5),
                    ),
                  ),
                ),
                WidgetSpan(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //城市
                        Text(
                          dataConfig.showCityText(),
                          style: TextStyle(
                              fontSize: 10.dp,
                              // fontWeight: FontWeight.w400,
                              fontWeight: FontWeight.w300,
                              color: AppMainColors.whiteColor70,
                              height: 1.5),
                        ),
                        //热度
                        Text(dataConfig.showHeatText(),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 12.dp,
                                overflow: TextOverflow.ellipsis,
                                fontFamily: "Number",
                                color: AppMainColors.whiteColor70,
                                height: 1.5))
                      ],
                    )),
              ])).position(left: 8.dp, right: 8.dp, bottom: 4.dp),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _timer.cancel();
  }
}

class ListDataConfig {
  ListDataConfig({
    required this.anchorItem,
  });

  final AnchorListModelEntity anchorItem;

  ///*1.房间名字 房间背景图片*/
  String roomTitle() {
    String key = "";
    switch (anchorItem.barType) {
      case 2:
      // key = anchorItem.distance.toString();
        key = anchorItem.username ?? "";

        break;
      default:
        key = anchorItem.roomTitle ?? "";
        break;
    }
    return key;
  }

  String roomCover() {
    var key = anchorItem.roomCover ?? "";
    return key;
  }

  ///*2.是否展示房间图标 */
  bool showRoomWidget() {
    var key = anchorItem.gameName != null && anchorItem.gameName!.length > 0;
    return key;
  }

  String roomName() {
    var key = anchorItem.gameName ?? "";
    return key;
  }

  ///*3.是否展示直播icon*/
  bool showLiveWidget() {
    var key = (anchorItem.state == 1 && anchorItem.barType == 2);
    return key;
  }

  ///4.*======.富文本内容控制 ========*/
  // 计费相关
  bool showTopWidget() {
    var key = anchorItem.rank != 0;
    switch (anchorItem.barType) {
    //附近不用展示
      case 2:
        key = false;
        break;
      default:
        break;
    }
    return key;
  }

  String showTopText() {
    var key = "TOP${anchorItem.rank}";
    return key;
  }

  // 计费相关
  bool showBillWidget() {
    bool key = false;
    if (anchorItem.feeType == 1) {
      key = true;
    }
    if (anchorItem.feeType == 2) {
      key = true;
    }
    return key;
  }

  String showBillText() {
    String key = "";
    if (anchorItem.feeType == 1) {
      key = "${anchorItem.timeDeduction!}钻/分钟";
    } else if (anchorItem.feeType == 2) {
      key = "${anchorItem.ticketAmount!}钻/场";
    }
    return key;
  }

  String showCityText() {
    var key = anchorItem.region ?? "火星";
    if (key.length <= 0) {
      key = "火星";
    }
    return key;
  }

  String showHeatText() {
    var key = StringUtils.showNmberOver10k(anchorItem.heat);
    return key;
  }
}
