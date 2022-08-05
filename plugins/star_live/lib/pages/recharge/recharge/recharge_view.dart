// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spring/spring.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/toast.dart';
import 'package:marquee/marquee.dart';
import 'package:star_common/manager/user/user_balance_logic.dart';
import 'package:star_common/router/router_config.dart';

import '../recharge_page.dart';
import 'recharge_logic.dart';
import 'recharge_state.dart';

/// @description:
/// @author
/// @date: 2022-06-10 13:21:23
class RechargePage extends StatefulWidget {
  final bool isBack;

  RechargePage(this.isBack);

  @override
  createState() => RechargePageState();
}

//充值
class RechargePageState extends AppStateBase<RechargePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin, Toast {
  final RechargeLogic logic = Get.put(RechargeLogic());
  final RechargeState state = Get.find<RechargeLogic>().state;

  // var datas;

  @override
  bool get wantKeepAlive => true;
  bool haveTitle = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _bodys(context);
  }

  Widget buildRow(String url, String text) {
    return Row(
      children: [
        Image.asset(
          url,
          width: 24.dp,
          height: 24.dp,
        ),
        SizedBox(
          width: 6.dp,
        ),
        CustomText(text,
            fontSize: 14.dp, fontWeight: w_500, color: Colors.white),
      ],
    );
  }

  Widget _bodys(BuildContext context) {
    return Scaffold(
        body: Stack(alignment: AlignmentDirectional.topCenter, children: [
      Container(
        width: MediaQuery.of(context).size.width,
        height: 100.dp,
        decoration: BoxDecoration(
          color: AppMainColors.backgroudColor,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(R.appbarBg),
          ),
        ),
      ),
      Column(
        children: [
          topinfo(),
          GetBuilder<RechargeLogic>(
              init: logic,
              builder: (c) {
                return rechargePageView();
              }).expanded()
        ],
      )
    ]));
  }

  Widget rechargePageView() {
    return Obx(() => logic.state.rechargeList.isEmpty
        ? EmptyView(emptyType: EmptyType.noData).gestureDetector(onTap: () {
            logic.requestQueryChannelList();
          })
        : Container(
                margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: RechargePageView()));
  }

  Widget topinfo() {
    return Column(children: [
      DefaultAppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          leading: widget.isBack ? CustomBackButton() : Container(),
          title: CustomText("${intl.rechargeCentre}",
              fontSize: 18.dp, color: Colors.white),
          centerTitle: true,
          actions: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 16),
              child: Image.asset(
                R.icCustomerService,
                width: 24.dp,
                height: 24.dp,
              ),
            ).gestureDetector(onTap: () {
              show();
              logic.getCustomerUrl().then((url) {
                dismiss();
                Get.toNamed(AppRoutes.contactServicePage, arguments: {
                "url": url,
                "title": "${intl.customService}",
                });
              });
            }),
          ]),
      SizedBox(height: 6),
      Container(
          alignment: Alignment.center,
          height: 100.dp,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(R.rechargeTopBgIcon),
                  fit: BoxFit.fill),
              borderRadius: BorderRadius.all(Radius.circular(8.dp)),
              gradient: LinearGradient(colors: [
                Color(0xFF734BE4),
                Color(0xFFCC73B8),
              ])),
          margin: EdgeInsets.only(left: 16, right: 16),
          padding: EdgeInsets.only(left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        buildRow(R.rechargeYue, "金币余额"),
                        Spring.rotate(
                            springController: state.springCoinsController,
                            child: Image.asset(
                              R.comShuaxinAssets,
                              width: 16,
                              height: 16,
                            ).inkWell(onTap: () {
                              state.springDrinksCoinsController
                                  .play(motion: Motion.pause);
                              state.springCoinsController
                                  .play(motion: Motion.play);
                              Get.find<UserBalanceLonic>().userBalanceData();
                            })).marginOnly(left: 10),
                      ],
                    ),
                    SizedBox(height: 10),
                    Obx((() => CustomText(
                          "${(Get.find<UserBalanceLonic>().state.userBalance.value.balance ?? 0).toStringAsFixed(2)}",
                          style: AppStyles.number18w4004white,
                        )))
                  ]),
              Container(
                height: 50.dp,
                width: 1.dp,
                color: Colors.white.withOpacity(0.2),
              ),
              // SizedBox(
              //   width: 26.dp,
              // ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      buildRow(R.rechargeZuanshi, "${intl.diamond}"),
                      Spring.rotate(
                          springController: state.springDrinksCoinsController,
                          child: Image.asset(
                            R.comShuaxinAssets,
                            width: 16,
                            height: 16,
                          ).inkWell(onTap: () {
                            state.springCoinsController
                                .play(motion: Motion.pause);
                            state.springDrinksCoinsController
                                .play(motion: Motion.play);
                            Get.find<UserBalanceLonic>().userBalanceData();
                          })).marginOnly(left: 10),
                    ],
                  ),
                  SizedBox(height: 10),
                  Obx((() => CustomText(
                        "${Get.find<UserBalanceLonic>().state.userBalance.value.coinBalance ?? 0}",
                        style: AppStyles.number18w4004white,
                      )))
                ],
              ),
              Container(
                  padding: EdgeInsets.only(
                      left: 8.dp, right: 12.dp, top: 4.dp, bottom: 4.dp),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(R.icDuihuanBg),
                          fit: BoxFit.fill)),
                  child: Row(
                    children: [
                      Image.asset(
                        R.icExchange,
                        width: 24.dp,
                        height: 24.dp,
                      ),
                      CustomText("${intl.changeDiamonds}",
                          fontWeight: w_500,
                          fontSize: 14.sp,
                          color: Colors.white),
                    ],
                  )).gestureDetector(onTap: () {
                // pushViewControllerWithName(AppRoutes.redeemDiamonds);
                // Navigator.of(context).pushNamed(AppRoutes.redeemDiamonds,
                //     arguments: {"code": "page2"}).then((value) {});
                Get.toNamed(AppRoutes.redeemDiamonds,arguments: {"code": "page2"})?.then((value) {});
              }),
            ],
          )),
      Container(
        margin: EdgeInsets.only(top: 8, left: 16, right: 16),
        decoration: BoxDecoration(
            color: AppMainColors.whiteColor6,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: rechargeMarquee(),
      )
    ]);
  }
}

Widget rechargeMarquee() {
  final RechargeState state = Get.find<RechargeLogic>().state;
  return Obx(() {
    var announcementString = state.contents;
    return Container(
        // margin: EdgeInsets.only(
        //     top: 0, bottom: 8, left: 10, right: 10),
        // padding: EdgeInsets.only(left: 8, right: 8),
        height: 24.dp,
        decoration: BoxDecoration(
            color: AppMainColors.whiteColor6,
            borderRadius: BorderRadius.all(Radius.circular(12.dp))),
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
        ));
  });
}
