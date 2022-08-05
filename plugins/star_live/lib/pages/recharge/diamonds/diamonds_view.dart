import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spring/spring.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/common_widget/app_dialog.dart';
import 'package:star_common/common/toast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:star_common/lottie/refresh_lottie_foot.dart';
import 'package:star_common/lottie/refresh_lottie_head.dart';
import 'package:star_common/base/app_base.dart';

import 'package:star_common/manager/user/user_balance_logic.dart';
import 'package:star_common/router/router_config.dart';
import 'package:star_live/pages/recharge/recharge/recharge_view.dart';
import '../recharge/recharge_logic.dart';
import 'diamonds_logic.dart';

class DiamondsPage extends StatefulWidget {
  DiamondsPage({this.code});

  final String? code;

  @override
  createState() => _DiamondsPageState();
}

class _DiamondsPageState extends AppStateBase<DiamondsPage> with Toast {
  final DiamondsLogic logic = Get.put(DiamondsLogic());
  final RefreshController refreshController = RefreshController();

  ///刷新金币动画
  final SpringController springCoinsController =
      SpringController(initialAnim: Motion.pause);

  ///刷新钻石动画
  final SpringController springDrinksCoinsController =
      SpringController(initialAnim: Motion.pause);

  @override
  void initState() {
    super.initState();
  }

  /// 界面宽
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
          width: MediaQuery.of(context).size.width,
          height: 100.dp,
          decoration: BoxDecoration(
              color: AppMainColors.backgroudColor,
              image: new DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(R.appbarBg),
              ))),
      Column(children: [
        DefaultAppBar(
          centerTitle: true,
          title: CustomText("${intl.redeemDiamonds}",
              fontSize: 18.sp, color: Colors.white),
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
              final rechargeLogic = Get.find<RechargeLogic>();
              rechargeLogic.getCustomerUrl().then((url) {
                dismiss();
                Get.toNamed(AppRoutes.contactServicePage, arguments: {
                  "url": url,
                  "title": "${intl.customService}",
                });
              });
            }),
          ],
        ),
        SizedBox(height: 6),
        Obx(() {
          var userBalance =
              Get.find<UserBalanceLonic>().state.userBalance.value;
          return Container(
            alignment: Alignment.center,
            height: 100.dp,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(R.diamondsTopBgIcon)),
                borderRadius: BorderRadius.all(Radius.circular(8.dp)),
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(226, 96, 136, 1),
                  Color.fromRGBO(242, 216, 120, 1),
                ])),
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
                            buildRow(R.rechargeYue, "${intl.balance}"),
                            Spring.rotate(
                                springController: springCoinsController,
                                animStatus: (AnimStatus status) {
                                  print(status);
                                },
                                child: Image.asset(
                                  R.comShuaxinAssets,
                                  width: 16.dp,
                                  height: 16.dp,
                                ).inkWell(onTap: () {
                                  springCoinsController.play(
                                      motion: Motion.play);
                                  springDrinksCoinsController.play(
                                      motion: Motion.pause);
                                  Get.find<UserBalanceLonic>()
                                      .userBalanceData();
                                })).marginOnly(left: 10.dp),
                          ],
                        ),
                        SizedBox(height: 10),
                        CustomText(
                          "${(userBalance.balance ?? 0).toStringAsFixed(2)}",
                          style: AppStyles.number(18.sp),
                        ),
                      ]),
                  Container(
                    height: 50.dp,
                    width: 1.dp,
                    color: Colors.white.withOpacity(0.2),
                  ).marginOnly(left: 16.dp, right: 16.dp),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            buildRow(
                                R.rechargeZuanshi, "${intl.diamond}"),
                            Spring.rotate(
                                springController: springDrinksCoinsController,
                                animStatus: (AnimStatus status) {
                                  print(status);
                                },
                                child: Image.asset(
                                  R.comShuaxinAssets,
                                  width: 16.dp,
                                  height: 16.dp,
                                ).inkWell(onTap: () {
                                  springCoinsController.play(
                                      motion: Motion.pause);
                                  springDrinksCoinsController.play(
                                      motion: Motion.play);
                                  Get.find<UserBalanceLonic>()
                                      .userBalanceData();
                                })).marginOnly(left: 10.dp),
                          ],
                        ),
                        SizedBox(height: 10),
                        CustomText("${userBalance.coinBalance ?? 0}",
                            style: AppStyles.number(18.sp)),
                      ]).expanded(),
                  Container(
                      padding: EdgeInsets.only(
                          left: 8.dp, right: 12.dp, top: 4.dp, bottom: 4.dp),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(R.icDuihuanBg)),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              bottomLeft: Radius.circular(20.0))),
                      child: Row(
                        children: [
                          Image.asset(
                            R.icDiamondPageRecharge,
                            width: 24.dp,
                            height: 24.dp,
                          ),
                          CustomText("${intl.recharge}",
                              fontWeight: w_500,
                              fontSize: 14.sp,
                              color: Colors.white),
                        ],
                      )).gestureDetector(onTap: () {
                    //开通守护的兑换点击
                    if (widget.code.toString() == 'page1') {
                      Get.to(() =>RechargePage(true));
                    } else {
                      Get.back();
                      // Navigator.of(context).pop();
                    }
                    // Navigator.of(context).pushReplacementNamed(AppRoutes.tab);
                  })
                ]),
          ).paddingOnly(left: 16.dp, right: 16.dp);
        }),
        SmartRefresher(
            controller: refreshController,
            header: LottieHeader(),
            footer: LottieFooter(),
            onRefresh: () async {
              await logic.loadDataList();
              refreshController.refreshCompleted();
              return;
            },
            child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: Obx(() {
                  return Container(
                    margin: EdgeInsets.only(top: 13, left: 16, right: 16),
                    child: diamondRechargeList(logic.state.data),
                  );
                }))).expanded(),
      ])
    ]));
  }

  Widget buildRow(String url, String text,
      [double imageSize = 24,
      double boxSize = 6,
      MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start]) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Image.asset(
          url,
          width: imageSize.dp,
          height: imageSize.dp,
        ),
        SizedBox(
          width: boxSize.dp,
        ),
        CustomText(
          text,
          style: AppStyles.number(14.dp),
        ),
      ],
    );
  }

  GridView diamondRechargeList(List<DiamondListEntity> amountList) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, //每行三列
        childAspectRatio: 109 / 62,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: amountList.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
            decoration: new BoxDecoration(
              color: AppMainColors.witheOpacity6,
              //设置四周圆角 角度
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            child: GestureDetector(
                onTap: () {
                  double userBalance = Get.find<UserBalanceLonic>()
                          .state
                          .userBalance
                          .value
                          .balance ??
                      0.0;
                  var diamondMoney = amountList[index].money;
                  if (userBalance >= diamondMoney) {
                    _showDialog(
                        context,
                        "${amountList[index].money}",
                        "${amountList[index].amount}",
                        amountList[index].id ?? 1);
                  } else {
                    _showTipDialog();
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildRow(
                        R.rechargeZuanshi,
                        "${amountList[index].amount}",
                        16.dp,
                        5.dp,
                        MainAxisAlignment.center),
                    Container(
                            alignment: Alignment(0, 0),
                            child: CustomText("售${amountList[index].money}金币",
                                fontSize: 12.sp,
                                color: AppMainColors.witheOpacity70))
                        .marginOnly(top: 8.dp),
                  ],
                )));
      },
    );
  }

  Widget _buildWidget(String money, String diamond) {
    return Text.rich(TextSpan(
        style: TextStyle(
          color: AppMainColors.whiteColor70,
          fontWeight: w_400,
          fontSize: 14.sp,
        ),
        children: [
          TextSpan(
              text: "确定消耗",
              style: TextStyle(
                  color: AppMainColors.whiteColor70, fontSize: 14.dp)),
          TextSpan(
              text: money,
              style:
                  TextStyle(color: AppMainColors.mainColor, fontSize: 14.dp)),
          TextSpan(
              text: "金币兑换",
              style: TextStyle(
                  color: AppMainColors.whiteColor70, fontSize: 14.dp)),
          TextSpan(
              text: diamond,
              style:
                  TextStyle(color: AppMainColors.mainColor, fontSize: 14.dp)),
          TextSpan(
              text: intl.diamond,
              style: TextStyle(
                  color: AppMainColors.whiteColor70, fontSize: 14.dp)),
        ]));
  }

  _showDialog(
      BuildContext context, String money, String diamond, int packageId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AppDialog(
          _buildWidget(
            money,
            diamond,
          ),
          cancelText: "取消",
          confirm: () {
            Get.back();
            logic.diamondExchange(packageId);
          },
        );
      },
    );
  }

  _showTipDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AppDialog(
          CustomText(
            "很抱歉，当前余额不足以兑换更多钻石，请前往充值～",
            style: TextStyle(
                fontSize: 14.sp, fontWeight: w_400, color: Colors.white70),
          ),
          cancelText: "取消",
          confirmText: "前往充值",
          confirm: () {
            Get.back();
            Get.to(() => RechargePage(true));
          },
        );
      },
    );
  }
}
