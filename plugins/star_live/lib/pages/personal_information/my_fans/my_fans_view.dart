import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';
import 'package:star_common/common/common_widget/live/sex_icon_widget.dart';
import 'package:star_common/common/storage.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_common/generated/anchor_list_model_entity.dart';
import 'package:star_common/lottie/refresh_lottie_foot.dart';
import 'package:star_common/lottie/refresh_lottie_head.dart';
import 'package:star_common/manager/app_manager.dart';
import 'package:star_live/pages/live_room/live_room_new.dart';
import 'package:star_live/pages/rank_main/live_avatar.dart';

import 'my_fans_logic.dart';
import 'my_fans_state.dart';

/// @description:
/// @author
/// @date: 2022-05-25 18:52:49
class MyFansPage extends StatelessWidget with Toast {
  BuildContext? _context;
  String userId;
  int type = 0;
  MyFansPage({dynamic arguments})
      : this.type = arguments["type"],
        this.userId = arguments["userId"];

  @override
  Widget build(BuildContext context) {
    _context = context;
    // if (type == 1) {
    //   logic.setPageIndex(false);
    // } else {
    //   logic.setPageIndex(true);
    // }
    return GetBuilder<MyFansLogic>(
      init: MyFansLogic(type, userId),
      tag: DateTime.now().toString(),
      builder: (logic) {
        final state = logic.state;
        return Scaffold(
          appBar: DefaultAppBar(
            title: CustomText(type == 0 ? "${intl.attention}" : "${intl.fans}",
                fontSize: 18.dp, color: Colors.white),
            centerTitle: true,
          ),
          body: SafeArea(child: _body(logic, state, type)),
        );
      },
    );
  }

  Widget _body(MyFansLogic logic, MyFansState state, int type) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          height: 32,
          color: Color.fromRGBO(255, 255, 255, 0.06),
          child: Text("共${state.totalNum}人",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              )).paddingOnly(left: 16),
        ),
        Flexible(
          child: SmartRefresher(
            controller: state.refreshController,
            enablePullDown: true,
            header: LottieHeader(),
            footer: LottieFooter(),
            enablePullUp: true,
            onRefresh: () {
              // state.loadType = LoadType.refreshData;
              // logic.loadGameBetRecord();
              logic.state.page = 1;
              logic.requestPage();
            },
            onLoading: () {
              // state.loadType = LoadType.loadMoreData;
              // logic.loadGameBetRecord();
              logic.requestPage();
            },
            child: state.listData.isEmpty
                ? EmptyView(emptyType: EmptyType.noData)
                : ListView.builder(
                    itemCount: state.listData.length,
                    itemBuilder: (context, index) {
                      return _item(logic, state, index, type);
                    },
                  ),
          ),
          fit: FlexFit.tight,
          flex: 1,
        )
      ],
    );
  }

  _item(MyFansLogic logic, MyFansState state, int index, int type) {
    var dataValue = state.listData[index];

    bool onLive = false;
    if (state.userId == AppManager.getInstance<AppUser>().userId!) {
      var onLineState = dataValue["state"];
      onLive = onLineState == 1;
    }
    if (userId != null) {
      onLive = false;
    }
    // bool onLive = onLineState == 1;
    AnchorListModelEntity model = AnchorListModelEntity();
    int tempIndex = 0;
    model.id = dataValue['roomId'].toString();
    model.roomCover = dataValue['roomCover'];
    Map<String, dynamic> args = {
      "index": tempIndex,
      "rooms": [model],
      "userId": dataValue['userId'].toString(),
      "needToRoom": onLive
    };
    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.dp),
            margin: EdgeInsets.all(4.dp),
            width: 70.dp,
            height: 70.dp,
            child: OnLiveAvatar(
              padding: EdgeInsets.all(2),
              imgUrl: dataValue['header'],
              onLive: onLive,

              ///此属性 确定宽高，x2 圆形
              radius: 26,
              locImageChild:
                  Image.asset(R.homeQuanbu, width: 16, height: 16),
              onPressed: () {
                if (onLive && StorageService.to.getBool('keyAnchor') == false) {
                  // if (onLive) {
                  //在线跳转直播间
                  Get.to(() => AudienceNewPage(arguments: args));
                } else {
                  logic.pushToOtherInfo(
                    _context,
                    args,
                  );
                }
              },
              isAnchor: true,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${dataValue['username']}",
                    style: TextStyle(
                        color: AppMainColors.whiteColor100,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  // showLevel(dataValue), //去除等级显示
                ],
              ),
              SizedBox(
                height: 8.dp,
              ),
              Row(
                children: [
                  SexIconWidget(dataValue['sex']),
                  SizedBox(
                    width: 4.dp,
                  ),
                  SizedBox(
                    width: 180.dp,
                    child: Text(
                      "${dataValue['signature'] ?? "TA好像忘记签名了"}".isEmpty
                          ? "TA好像忘记签名了"
                          : dataValue['signature'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                    ),
                  ),
                ],
              ),
            ],
          ).gestureDetector(onTap: () {
            logic.pushToOtherInfo(_context, args);
          }),
          // sizedBox(width: 4),
          type == 0 ? _but(logic, state, index) : Container(),
        ],
      ),
    );
  }

  Widget _but(MyFansLogic logic, MyFansState state, int index) {
    var dataValue = state.listData[index];
    int isFollow = dataValue['isFollow'] ?? 1;
    return InkWell(
      onTap: () {
        if (StorageService.to.getBool('keyAnchor') == false) {
          if (isFollow == 1) {
            logic.favoriteCancel(index);
          } else {
            logic.favoriteInsert(index);
          }
        }
      },
      child: isFollow == 1 ? showFollow() : showCancelFollow(),
    );
  }

  //  显示性别
  Widget showFollow() {
    return Container(
      width: 60.dp,
      padding: EdgeInsets.only(top: 4.dp, bottom: 4.dp),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.mine_wallet_gb,
        border: Border.all(color: AppColors.mine_wallet_line, width: 1.dp),
        borderRadius: BorderRadius.circular(16.dp),
      ),
      child: Text(
        "已关注",
        style: TextStyle(color: Colors.grey, fontSize: 12.sp),
      ),
    );
  }

  Widget showCancelFollow() {
    return Container(
      width: 60.dp,
      height: 24.dp,
      padding: EdgeInsets.only(top: 4.dp, bottom: 4.dp),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.dp),
          gradient: LinearGradient(colors: AppMainColors.commonBtnGradient)),
      child: Text("关注", style: TextStyle(color: Colors.white, fontSize: 12.sp)),
    );
  }
}
