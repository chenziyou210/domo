import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/manager/user/user_info.dart';
import 'package:star_common/router/router_config.dart';
import 'package:star_live/pages/personal_information/my_fans/my_fans_view.dart';
import '../../business/homepage/models/homepage_model.dart';
import 'mine_withdraw/mine_withdraw_view.dart';
import 'my_mine_state.dart';

/// @description:
/// @author
/// @date: 2022-05-24 16:16:17
class MyMineLogic extends GetxController with Toast {
  final state = MyMineState();
  final UserInfoLogic userInfoLogic = Get.find<UserInfoLogic>();

  @override
  void onReady() {
    super.onReady();
  }

  Future appBannerLoad() {
    return HttpChannel.channel.advertiseBanner(advertiseType: 7)
      ..then((value) => value.finalize(
          wrapper: WrapperModel(),
          success: (data) {
            List lst = data ?? [];
            List<HomeBannerInfo> banner =
                lst.map((e) => HomeBannerInfo.fromJson(e)).toList();
            state.addBanner(banner);
          }));
  }

  requestGamesData() {
    return HttpChannel.channel.advertiseBanner(advertiseType: 41)
      ..then((value) => value.finalize(
          wrapper: WrapperModel(),
          success: (data) {
            List lst = data ?? [];
            List<HomeBannerInfo> gameBanner =
                lst.map((e) => HomeBannerInfo.fromJson(e)).toList();
            state.games.clear();
            state.games.value = gameBanner;
          }));
  }

  gotoSetting(BuildContext context) {
    Get.toNamed(AppRoutes.mineSetting);
  }

  gotoUserInfo(BuildContext context) {
    Get.toNamed(AppRoutes.userById,arguments: {"userId": userInfoLogic.state.user.userId, "isMine": true});
  }

  gotoFollowAndFans(BuildContext context) {
    Get.to(() =>MyFansPage(arguments: {
      "type": 0,
      "userId": userInfoLogic.state.user.userId}
    ));
  }

  gotoActive(BuildContext context) {
    Get.toNamed(AppRoutes.mineActive);
  }

  gotoWithDraw(BuildContext context) {
    Get.to(() => MineWithdrawPage())
        ?.then((value) => userInfoLogic.requestUserInfo());
  }

  ///贵族
  gotoNoble(BuildContext context) {
    Get.toNamed(AppRoutes.mineNoble);
  }

  mineItemEvent(GroupTypes type, BuildContext context) async {
    switch (type) {
      case GroupTypes.diamondDetails:
        Get.toNamed(AppRoutes.mineIncomeExpenditureDetailsPage);
        break;
      case GroupTypes.gameRecord:
        Get.toNamed(AppRoutes.mineGameRecordPage);
        break;
      case GroupTypes.myFocus:
        gotoFollowAndFans(context);
        break;
      case GroupTypes.myBackpack:
        Get.toNamed(AppRoutes.mineBackpackPage);
        break;
      case GroupTypes.phoneApprove:
        Get.toNamed(AppRoutes.minePhoneApprovePage);
        break;
      case GroupTypes.myLevel:
        Get.toNamed(AppRoutes.mineMyLevelPage);
        break;
    }
  }

  void goEditInfo(BuildContext context) {
    Get.toNamed(AppRoutes.mineEditInfo);
  }

  void gotoWallet(BuildContext context) {
    Get.toNamed(AppRoutes.mineWallet);
  }
}
