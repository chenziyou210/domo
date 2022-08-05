/*
 *  Copyright (C), 2015-2021
 *  FileName: end_draw_new
 *  Author: Tonight丶相拥
 *  Date: 2021/12/10
 *  Description: 
 **/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/generated/anchor_list_model_entity.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/util_tool/stringutils.dart';
import 'end_draw_logic.dart';

class LivingRoomEndDrawNew extends StatefulWidget {
  LivingRoomEndDrawNew(this.id, {required this.onTap});

  final String id;
  final void Function(List<AnchorListModelEntity> data, int index) onTap;

  @override
  createState() => _LivingRoomEndDrawNewState();
}

class _LivingRoomEndDrawNewState extends AppStateBase<LivingRoomEndDrawNew> {

  late final EndDrawLogic _controller = EndDrawLogic();

  @override
  void initState() {
    Get.put(_controller);
    _controller.dataRefresh();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 260.dp,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.9)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText("${intl.recommended}",
                  fontSize: 12.dp, color: Colors.white)
              .paddingOnly(top: 100, left: 10, bottom: 10),
          RefreshWidget(
              enablePullUp: true,
              onLoading: (c) async {
                await _controller.loadMore();
                c.refreshCompleted();
                c.resetNoData();
              },
              onRefresh: (c) async {
                await _controller.dataRefresh();
                c.refreshCompleted();
                c.resetNoData();
              },
              children: [
                Obx(() {
                  if (_controller.state.data.length == 0) {
                    return SliverFillRemaining();
                  }
                  return SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 8),
                      delegate: SliverChildBuilderDelegate((_, index) {
                        var model = _controller.state.data[index];
                        return [
                          Container(
                            width: 140.dp,
                            height: 160.dp,
                            child: HomeAnchorItem(model).inkWell(onTap: () {
                              widget.onTap(_controller.state.data, index);
                              Get.back();
                            }),
                          ),
                        ].column();
                      }, childCount: _controller.state.data.length));
                })
              ]).clipRRect(radius: BorderRadius.circular(10)).expanded(),
        ],
      ),
    );
  }
}

class HomeAnchorItem extends StatelessWidget {
  final AnchorListModelEntity anchorItem;

  const HomeAnchorItem(this.anchorItem, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ListDataConfig dataConfig = ListDataConfig(anchorItem: anchorItem);

    return Container(
      // margin: EdgeInsets.only(4),
      child: ClipRRect(
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
                children: [
                  // Lottie.asset('assets/data/studio.json',
                  //     width: 8, height: 8, fit: BoxFit.cover),
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
                  dataConfig.showTopWidget()
                      //Top榜内容
                      ? Container(
                          height: 16.dp,
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
                        )
                      : Container(),

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
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w300,
                        color: AppMainColors.whiteColor70,
                        height: 1.5),
                  ).expanded(),
                  SizedBox(width: 8),
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
      ),
    );
  }
}

/**
 * 这里控制数据展示 从首页挪过来，
 * 不同数值的展示方式，可以通过这个配置
 * UI不变的话，处理config 即可
 * */
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
    //需要时自行配置 这里直接返回false
    var key = anchorItem.barType != 2;
    return false;
  }

  String roomName() {
    var key = anchorItem.gameName ?? "";
    return key;
  }

  ///*3.是否展示直播icon*/
  bool showLiveWidget() {
    //需要时自行配置 这里直接返回false
    var key = (anchorItem.state == 1 && anchorItem.barType == 2);
    return false;
  }

  ///4.*======.富文本内容控制 ========*/
  // 计费相关
  bool showTopWidget() {
    //需要时自行配置 这里直接返回false
    var key = anchorItem.rank != 0;
    switch (anchorItem.barType) {
      //附近不用展示
      case 2:
        key = false;
        break;
      default:
        break;
    }
    return false;
  }

  String showTopText() {
    var key = "TOP${anchorItem.rank}";
    return key;
  }

  // 计费相关
  bool showBillWidget() {
    //需要时自行配置 这里直接返回false
    bool key = false;
    if (anchorItem.feeType == 1) {
      key = true;
    }
    if (anchorItem.feeType == 2) {
      key = true;
    }
    return false;
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
