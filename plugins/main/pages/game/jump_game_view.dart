import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hjnzb/business/homepage/widget/homepage_widget.dart';
import 'package:hjnzb/pages/game/games.dart';
import 'package:marquee/marquee.dart';
import 'package:spring/spring.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/manager/app_manager.dart';
import 'package:star_common/router/router_config.dart';
import 'package:star_live/pages/live/live_home_data.dart';
import 'package:star_live/pages/recharge/recharge/recharge_view.dart';
import 'package:star_common/manager/user/user_balance_logic.dart';

import '../message/message_logic.dart';
import 'jump_game_logic.dart';

class JumpGamePage extends StatefulWidget {
  @override
  createState() => _JumpGamePageState();
}

class _JumpGamePageState extends AppStateBase<JumpGamePage>
    with TickerProviderStateMixin, Toast {
  final logic = Get.put(JumpGameLogic());
  final state = Get.find<JumpGameLogic>().state;
  final livelogic = Get.put(LiveHomeData());

  ///刷新金币
  final SpringController springCoinsController =
      SpringController(initialAnim: Motion.pause);

  /// 数据
  TabController? _tabController;

  void _eventListener(int lenght) {
    _tabController?.dispose();
    _tabController = null;
    _tabController = TabController(length: lenght, vsync: this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic.loadGameList(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        width: this.width,
        height: 128.dp,
        decoration: BoxDecoration(
            color: AppMainColors.backgroudColor,
            image: new DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(R.appbarBg),
            )),
      ),
      Column(
        children: [
          _appBar(),
          //  SizedBox(height: 8.dp),
          Obx(() {
            var banner = logic.state.banner;
            // print("game banner ${banner}");
            if (banner.length > 0) {
              return Container(
                padding: EdgeInsets.only(left: 16.dp, right: 16.dp),
                child: _bannerWidget(context),
              );
            } else {
              return SizedBox(height: 0);
            }
          }),
          SizedBox(height: 12.dp),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 16.dp, right: 16.dp),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                height: 56.dp,
                width: 138.dp,
                child: Container(
                  padding: EdgeInsets.only(left: 8.dp, right: 8.dp),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(R.gameWalletBg),
                          fit: BoxFit.cover),
                      // color: AppMainColors.blackColor70,
                      border: Border.all(color: AppMainColors.whiteColor20),
                      borderRadius: BorderRadius.all(
                        Radius.circular(9.0.dp),
                      )),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                            "${AppManager.getInstance<AppUser>().username}",
                            fontSize: 12.sp,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white70),
                        SizedBox(height: 4.dp),
                        Row(
                          children: [
                            Obx(() {
                              var userBalance = Get.find<UserBalanceLonic>()
                                      .state
                                      .userBalance
                                      .value
                                      .balance ??
                                  0.0;
                              return Text(
                                "￥${userBalance.toStringAsFixed(2)}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontFamily: "Number",
                                  // softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ).expanded();
                            }),
                            Spring.rotate(
                              springController: springCoinsController,
                              child: InkWell(
                                child: Container(
                                    child: Image.asset(
                                        R.gameWalletVector,
                                        width: 16,
                                        height: 16)),
                                onTap: () {
                                  print('点击刷新余额');
                                  springCoinsController.play(
                                      motion: Motion.play);
                                  Get.find<UserBalanceLonic>()
                                      .userBalanceData();
                                },
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
              SizedBox().expanded(),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(R.gameDeposit,
                    width: 32.dp, height: 32.dp),
                SizedBox(
                  height: 4,
                ),
                CustomText(
                  "${intl.deposit}",
                  fontSize: 12.sp, color: Colors.white,
                  // overflow: TextOverflow.ellipsis,
                ),
              ]).gestureDetector(onTap: () {
                //存款
                // final logicTb = Get.put(TabbarControlLogic());
                // logicTb.toggleBottomType(2);
                // Get.find<TabbarControlLogic>().toggleBottomType(2);
                Get.to(() =>RechargePage(true));
                // Navigator.of(context).pushNamed(AppRoutes.mineWallet);
              }),
              SizedBox(width: 12.dp),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(R.gameWithdrawal,
                    width: 32.dp, height: 32.dp),
                SizedBox(
                  height: 4.dp,
                ),
                CustomText("${intl.withdraw}",
                    fontSize: 12.sp, color: Colors.white),
              ]).gestureDetector(onTap: () {
                //提现
                Get.toNamed(AppRoutes.mineWithdraw);
              }),
              SizedBox(width: 12.dp),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(R.gameActivity,
                    width: 32.dp, height: 32.dp),
                SizedBox(
                  height: 4.dp,
                ),
                CustomText("${intl.discount}",
                    fontSize: 12.sp, color: Colors.white),
              ]).gestureDetector(onTap: () {
                //优惠
                Get.toNamed(AppRoutes.mineActive);
              }),
              SizedBox(width: 12.dp),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(R.gameRecord, width: 32.dp, height: 32.dp),
                SizedBox(
                  height: 4.dp,
                ),
                CustomText("${intl.record}",
                    fontSize: 12.sp, color: Colors.white),
              ]).gestureDetector(onTap: () {
                //记录
                Get.toNamed(AppRoutes.mineGameRecordPage);
              }),
            ]),
          ),
          Obx(() {
            var gameTabList = state.games;
            if (gameTabList.length == 0) {
              return Container(color: AppMainColors.backgroudColor);
            } else {
              // _eventListener(gameTabList.length);
              return Games(games: state.games.value).expanded();
            }
          }),
        ],
      )
    ]));
  }

  Widget _bannerWidget(BuildContext context) {
    // return Container(
    //   height: (ScreenUtil().screenWidth - 32.dp) / 3.23,
    //   padding: EdgeInsets.only(left: 16.dp, right: 16.dp),
    //   child: ClipRRect(
    //     borderRadius: BorderRadius.circular(6.dp),
    //     child: Swiper(
    //       itemBuilder: (BuildContext context, int index) {
    //         return Container(
    //           decoration: BoxDecoration(
    //               gradient: LinearGradient(
    //                   colors: AppMainColors.homeItemDefaultGradient),
    //               image: DecorationImage(
    //                 image: NetworkImage(logic.state.banner[index].pic!),
    //                 fit: BoxFit.cover,
    //               )),
    //         );
    //       },
    //       autoplay: true,
    //       itemCount: logic.state.banner.length,
    //       scrollDirection: Axis.horizontal,
    //       pagination: SwiperPagination(
    //           builder: CustomRectSwiperPaginationBuilder(
    //         color: AppMainColors.whiteColor100,
    //         activeColor: AppMainColors.mainColor,
    //       )),
    //       control: null,
    //       layout: SwiperLayout.DEFAULT,
    //       onTap: (index) {
    //         var url = logic.state.banner[index].url!;
    //         if (url.contains("http")) {
    //           Map<String, dynamic> args = {"url": url};
    //           homeWebPage(context, args);
    //         } else {
    //           Map<String, dynamic> args = {"url": "https://www.baidu.com"};

    //           ///网络跳转
    //           homeWebPage(context, args);
    //         }
    //       },
    //     ),
    //   ),
    // ).inkWell();

    return HomeBannerWidget(logic.state.banner, (bannerIndex) {
      var url = logic.state.banner[bannerIndex].url!;
      if (url.contains("http")) {
        Map<String, dynamic> args = {"url": url};
        homeWebPage(context, args);
      } else {
        Map<String, dynamic> args = {"url": "http://www.baidu.com"};

        ///网络跳转
        homeWebPage(context, args);
      }
    });
  }

  _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: true,
      // leading: SizedBox.shrink(),
      // leadingWidth: 0,
      leading: new IconButton(
        // padding: EdgeInsets.only(left: 10.dp),
        icon: Image.asset(R.appLogo, width: 32.dp, height: 32.dp),
        onPressed: () {},
      ),
      // title: CustomText("${intl.game}", fontSize: 16, color: Colors.white),
      actions: <Widget>[
        // GameAnnouncement(),
        Container(
            alignment: Alignment.center,
            height: 44.dp,
            padding: EdgeInsets.only(left: 16.dp, right: 16.dp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Image.asset(AppImages.applogo, width: 32.dp, height: 32.dp),
                SizedBox(
                  width: 34.dp,
                ),
                Obx(() {
                  var announcementString = state.announcementString;
                  return Container(
                      // margin: EdgeInsets.only(
                      //     top: 0, bottom: 8, left: 10, right: 10),
                      // padding: EdgeInsets.only(left: 8, right: 8),
                      height: 24.dp,
                      decoration: BoxDecoration(
                          color: AppMainColors.whiteColor6,
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.dp))),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 8.dp,
                          ),
                          Image.asset(
                            R.icAnnounce,
                            width: 16.dp,
                            height: 16.dp,
                          ),
                          SizedBox(
                            width: 6.dp,
                          ),
                          Marquee(
                                  text: announcementString.isNotEmpty
                                      ? announcementString.value
                                      : "   ",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: w_500,
                                      color: Colors.white70),
                                  scrollAxis: Axis.horizontal,
                                  velocity: 50.0,
                                  blankSpace: 259.dp,
                                  accelerationCurve: Curves.linear,
                                  decelerationCurve: Curves.easeOut)
                              .expanded(),
                          SizedBox(
                            width: 8.dp,
                          ),
                        ],
                      )).expanded();
                }),
                SizedBox(
                  width: 12.dp,
                ),
                Image.asset(R.gameTopKf, width: 24.dp, height: 24.dp)
                    .gestureDetector(onTap: () {
                  final messageLogic = Get.find<MessageLogic>();
                  show();
                  messageLogic.getCustomerUrl().then((url) {
                    dismiss();
                    Get.toNamed(AppRoutes.contactServicePage,  arguments: {
                    "url": url,
                    "title": "${intl.customService}",
                    });
                  });
                }),
              ],
            )).expanded(),
      ],
    );
  }
}
