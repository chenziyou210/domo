// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';
import 'package:star_common/common/common_widget/live/admin_icon_Widget.dart';
import 'package:star_common/common/common_widget/live/guard_icon_widget.dart';

import 'package:star_common/common/common_widget/live/peerage_widget.dart';
import 'package:star_common/common/common_widget/live/sex_icon_widget.dart';
import 'package:star_common/common/common_widget/signature_widget.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_common/router/router_config.dart';
import 'package:star_common/util_tool/stringutils.dart';
import 'package:star_live/pages/report_page/report_page_view.dart';
import '../../../../personal_information/my_fans/my_fans_view.dart';
import '../../../live_room_new_logic.dart';
import 'room_user_info_logic.dart';
import 'room_user_info_state.dart';
import 'package:quiver/strings.dart';

/// @description:
/// @author
/// @date: 2022-06-13 19:00:46
/// 用户信息弹框
class RoomUserInfoPage extends StatelessWidget {
  final RoomUserInfoLogic logic = Get.put(RoomUserInfoLogic());
  final RoomUserInfoState state = Get.find<RoomUserInfoLogic>().state;
  int userId;
  final bool isAnchor;

  RoomUserInfoPage(
    this.userId,
    this.isAnchor, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logic.userId = userId;
    return GetBuilder<RoomUserInfoLogic>(
        init: logic,
        global: false, //false 可以释放StatelessWidget
        builder: (c) {
          return Container(
              height: 368.dp + AppLayout.safeBarHeight,
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 40.dp,
                      ),
                      Container(
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.dp)),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppMainColors.blickColor90,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                          c.state.nobleType > 1003 ? 0 : 15),
                                      topRight: Radius.circular(
                                          c.state.nobleType > 1003 ? 0 : 15))),
                              child: Column(
                                children: [
                                  framedWings(context, c),
                                  SizedBox(
                                    height: 12.dp,
                                  ),
                                  information(c),
                                  SizedBox(
                                    height: 16.dp,
                                  ),
                                  genderAndRankOrNoble(c),
                                  SizedBox(
                                    height: 10.dp,
                                  ),
                                  Offstage(
                                    offstage:
                                        c.state.userinfo?.signature == null,
                                    child: SignatureWidget(
                                      signature: c.state.userinfo?.signature,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.dp,
                                  ),
                                  items(c),
                                  SizedBox(height: 12.dp),
                                  Divider(
                                    color: AppMainColors.separaLineColor6,
                                  ),
                                  bottom(context, c),
                                  SizedBox().expanded(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ).expanded(),
                    ],
                  ),
                  avatar(c),
                ],
              ));
        });
  }

  //@ta 主页
  Widget bottom(BuildContext context, RoomUserInfoLogic c) {
    if (isAnchor) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          muteItem(c.state.userinfo?.speakBan! == 1),
          divider(),
          managetItem(c.state.userinfo?.adminFlag! == 1),
          divider(),
          homePageItem(context)
        ],
      );
    } else {
      //管理员
      if (Get.find<LiveRoomNewLogic>().state.adminFlag == 1) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: muteItem(c.state.userinfo?.speakBan! == 1),
            ),
            // divider(),
            Expanded(
              child: atSomeOne(context),
            ),
            // divider(),
            Expanded(
              child: homePageItem(context),
            ),
          ],
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [atSomeOne(context), divider(), homePageItem(context)],
        );
      }
    }
  }

  Widget divider() {
    return Container(
      width: 1.dp,
      height: 28.dp,
      color: AppMainColors.separaLineColor6,
    );
  }

  Widget _bottomItem(Widget child, {required void Function()? onPressed}) {
    return Container(height: 40.dp, alignment: Alignment.center, child: child)
        .gestureDetector(onTap: onPressed);
  }

//todo 点击改变
  Widget muteItem(bool isMute) {
    return _bottomItem(
        !isMute
            ? Text("禁言", style: AppStyles.f14w400c255_255_255)
            : Text("已被禁言",
                style: AppStyles.f14w400c255_255_255.copyWith(
                    color: Colors.white.withOpacity(0.4))), onPressed: () {
      logic.changeRoomBanspeak();
    });
  }

  Widget managetItem(bool isManager) {
    return _bottomItem(
        !isManager
            ? Text("设为管理员", style: AppStyles.f14w400c255_255_255)
            : Text("已设为管理员",
                style: AppStyles.f14w400c255_255_255.copyWith(
                    color: Colors.white.withOpacity(0.4))), onPressed: () {
      logic.changeRoomManage();
    });
  }

  Widget homePageItem(BuildContext context) {
    return _bottomItem(
        Text(
          "主页",
          style: TextStyle(
              color: Colors.white, fontSize: 14.sp, fontWeight: w_400),
        ), onPressed: () {
      Get.back();
      Get.toNamed(AppRoutes.userById,
          arguments: {"userId": this.userId.toString()});
      // Navigator.of(context).pushNamed(AppRoutes.userById,
      //     arguments: {"userId": this.userId.toString()});
    });
  }

  Widget atSomeOne(BuildContext context) {
    return _bottomItem(
        Text(
          "@TA",
          style: TextStyle(
              color: Colors.white, fontSize: 14.sp, fontWeight: w_400),
        ), onPressed: () {
      Get.back(result: {
        "event": "call",
        "userName": logic.state.userinfo!.username!,
        "id": logic.state.userinfo!.shortId
      });
    });
  }

  Widget items(RoomUserInfoLogic c) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _followOrFans(c).gestureDetector(onTap: () {
          Get.to(() =>MyFansPage(arguments: {
            "type": 0,
            "userId": userId.toString()}));
        }),
        SizedBox(
          width: 8.dp,
        ),
        item(c.state.userinfo?.heat ?? 0, "送出火力")
      ],
    );
  }

  Widget _followOrFans(RoomUserInfoLogic c) {
    //
    return item(c.state.userinfo?.attentionNum ?? 0, "关注");
  }

  Widget item(int index, String title) {
    var nums = StringUtils.showNmberOver10k(index);
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
            nums,
            style: TextStyle(
                color: Colors.white,
                fontWeight: w_400,
                fontFamily: 'Number',
                fontSize: 16.sp),
          ),
          Text(
            title,
            style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.4),
                fontSize: 12.sp,
                fontWeight: w_400),
          ),
        ],
      ),
    );
  }

  //性别,等级,贵族
  Widget genderAndRankOrNoble(RoomUserInfoLogic c) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UserLevelView(c.state.userinfo?.rank ?? 0),
        Offstage(
            offstage: c.state.nobleType == 0,
            child: PeerageWidget(c.state.nobleType, 4)),
        GuardIconWidget(c.state.userinfo?.watchType, 4),
        AdminIconWidget(c.state.userinfo?.adminFlag),
        SizedBox(
          width: 4.dp,
        ),
        SexIconWidget(c.state.userinfo?.sex)
      ],
    );
  }

  //ID和城市
  Widget information(RoomUserInfoLogic c) {
    return Column(
      children: [
        Text(
          //名字
          c.state.userinfo?.username ?? "",
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
        SizedBox(
          height: 5.dp,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              //id
              "ID: " + (c.state.userinfo?.shortId ?? ""),
              style: TextStyle(
                  color: AppColors.main_white_opacity_7, fontSize: 10.sp),
            ),
            SizedBox(
              width: 10.dp,
            ),
            Image.asset(
              R.icLocation,
              width: 12.dp,
              height: 12.dp,
            ),
            Text(
                //城市
                getCity(c.state.userinfo?.city),
                style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: w_400,
                    color: AppMainColors.whiteColor70)),
          ],
        )
      ],
    );
  }

  String getCity(String? city) {
    return isBlank(city) ? '火星' : city.toString();
  }

  //相框翅膀
  Widget framedWings(BuildContext context, RoomUserInfoLogic c) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Offstage(
            offstage: c.state.nobleType == 0 || c.state.nobleType == 1001,
            child: Image.asset(
              //相框边上的
              c.setFramedWings(c.state.nobleType),
              fit: BoxFit.fill,
            ),
          ),
          isAnchor
              ? Container(margin: EdgeInsets.only(top: 30.dp))
              : Container(
                  margin: EdgeInsets.only(top: 30.dp, left: 16.dp),
                  child: Image.asset(R.comJubao,
                          width: 16.dp, height: 16.dp)
                      .gestureDetector(onTap: () {
                    //警告
                    Get.bottomSheet(ReportPagePage());
                  }),
                )
        ],
      ),
    );
  }

  //头像
  Widget avatar(RoomUserInfoLogic c) {
    return Container(
      width: 90.dp,
      height: 90.dp,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            constraints: BoxConstraints(
              maxHeight: 66.dp,
              maxWidth: 66.dp
            ),
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: AppMainColors.whiteColor100,
              // border: Border.all(color: Colors.white, width: 1.dp),
              borderRadius: BorderRadius.circular(33.dp.ceilToDouble()),
            ),
            child: CircleAvatar(
              radius: 33.dp.ceilToDouble(),
              backgroundColor: Color(0xFFFFFFFF),
              backgroundImage: NetworkImage(c.state.userinfo?.header?? ""),
            ),
          ),
          Offstage(
            offstage: c.state.nobleType == 0,
            child: Image.asset(
              //相框
              c.setAvatarFrame(c.state.nobleType),
              fit: BoxFit.fill,
              width: 90.dp,
              height: 90.dp,
            ),
          )
        ],
      ),
    );
  }
}
