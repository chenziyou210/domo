import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';

import 'room_live_game_logic.dart';
import 'room_live_game_state.dart';

/// @description:
/// @author
/// @date: 2022-06-20 15:58:22
/// 直播间游戏

class RoomLiveGamePage extends StatelessWidget {
  final Widget? controlWidget;
  final Widget? chatBox;
  final RoomLiveGameLogic logic = Get.put(RoomLiveGameLogic());

  ///是否是主播
  final bool? isAnchor;

  RoomLiveGamePage(
      {Key? key, this.controlWidget, this.chatBox, required this.isAnchor})
      : super(key: key);
  final GlobalKey _scaffold = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final h = 343.dp + (controlWidget != null ? 25.dp : 0);
    logic.state.isAnchor = isAnchor;
    return GetBuilder<RoomLiveGameLogic>(
      init: logic,
      // global: false,
      builder: (_) {
        return Obx(
          () => Visibility(
            key: _scaffold,
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.dp),
                    topRight: Radius.circular(12.dp)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    height: h,
                    padding: EdgeInsets.only(top: 10.dp),
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(22, 23, 34, 0.9),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.dp),
                          topRight: Radius.circular(12.dp)),
                    ),
                    child: logic.state.gameListData.length == 0
                        ? EmptyView(emptyType: EmptyType.noData)
                            .gestureDetector(
                            onTap: () {
                              logic.requestGame();
                            },
                          )
                        : _body(h),
                  ),
                ),
              ),
            ),
            visible: logic.state.visible.value,
          ),
        );
      },
    );
  }

  Widget _body(double h) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTabBar1(
          tabs: (_) {
            return logic.state.gameListData.map((e) {
              return Container(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    CustomText(e.name!),
                    SizedBox(height: 4.dp),
                    !e.isSeledet
                        ? SizedBox(
                            height: 2.dp,
                          )
                        : Image.asset(
                            R.tabsSeletedIcon,
                            width: 12.dp,
                            height: 2.dp,
                            fit: BoxFit.fill,
                          )
                  ],
                ),
              );
            }).toList();
          },
          onTap: (index) {
            logic.seledetd(index);
          },
          labelStyle: TextStyle(fontSize: 14.sp, fontWeight: w_500),
          unselectedLabelStyle: TextStyle(fontSize: 14.sp, fontWeight: w_400),
          unselectedLabelColor: AppColors.main_white_opacity_7,
          labelColor: Colors.white,
          controller: logic.state.tabController!,
          labelPadding: EdgeInsets.only(left: 16.dp),
          borderSide: BorderSide(width: 0, color: Colors.transparent),
          isScrollable: true,
        ),
        SizedBox(
          height: 20.dp,
        ),
        CustomTabBarView(
          children: logic.gameViews((index) {
            if (index < 0) {
              return;
            }
            logic.state.visible.value = false;
            logic.showGame(_scaffold.currentContext,
                logic.state.gameList[index], chatBox, controlWidget, () {
              logic.state.visible.value = true;
            });
          }),
          controller: logic.state.tabController,
          onPageChange: (index) {
            logic.seledetd(index);
          },
        ).expanded()
      ],
    );
  }

  Widget tableItem(
      RoomLiveGameLogic logic, BuildContext context, RoomLiveGameList data) {
    return GestureDetector(
      //游戏点击
      onTap: () {
        logic.state.visible.value = false;
        logic.showGame(_scaffold.currentContext, data, chatBox, controlWidget,
            () {
          logic.state.visible.value = true;
        });
      },
      child: Column(
        children: [
          FadeInImage(
            width: 66.dp,
            height: 66.dp,
            fit: BoxFit.fill,
            placeholder: AssetImage(R.gamePlaceholder),
            image: NetworkImage(data.icon ?? ""),
          ),
          SizedBox(
            height: 4.dp,
          ),
          Text(
            data.name!,
            style:
                TextStyle(color: AppMainColors.whiteColor40, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}
