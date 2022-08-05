import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hjnzb/pages/my_mine/mine_income_expenditure_details/mine_income_expenditure_details_view.dart';
import 'package:spring/spring.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';

import 'mine_wallet_logic.dart';
import 'mine_wallet_state.dart';

/// @description:   Wallet View
/// @author  austin
/// @date: 2022-05-31 14:43:43
class MineWalletPage extends StatelessWidget {
  final MineWalletLogic logic = Get.put(MineWalletLogic());
  final MineWalletState state = Get.find<MineWalletLogic>().state;

  MineWalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: CustomText("钱包", fontSize: 18.dp, color: Colors.white),
        centerTitle: true,
      ),
      body: GetBuilder<MineWalletLogic>(
        init: logic,
        global: false,
        builder: (c) {
          return SingleChildScrollView(
            child: Column(
              children: [
                _myProperty(context),
                _myDiamond(),
                _accountManagement()
              ],
            ),
          );
        },
      ),
    );
  }

  //我的资产 - 余额
  Widget _myProperty(BuildContext c) {
    return Obx(() => Container(
          width: double.infinity,
          height: 175.dp,
          margin: EdgeInsets.fromLTRB(16.dp, 16.dp, 16.dp, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            gradient: LinearGradient(colors: [
              Color.fromRGBO(115, 75, 228, 1),
              Color.fromRGBO(204, 115, 184, 1),
            ], begin: Alignment.centerLeft, end: Alignment.centerRight),
          ),
          child: Stack(
            children: [
              Image.asset(
                R.icWalletProperty,
              ),
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                bottom: 0,
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(16.dp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            R.rechargeYue,
                            width: 24.dp,
                            height: 24.dp,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "我的资产(金币)",
                            style: TextStyle(
                                fontSize: 16.dp,
                                color: AppMainColors.whiteColor70),
                          ),
                          Spring.rotate(
                              springController: state.springCoinsController,
                              animStatus: (AnimStatus status) {
                                print(status);
                              },
                              child: Image.asset(
                                R.comShuaxinAssets,
                                width: 16,
                                height: 16,
                              ).inkWell(onTap: () {
                                state.springDrinksCoinsController
                                    .play(motion: Motion.pause);
                                state.springCoinsController
                                    .play(motion: Motion.play);
                                logic.userBalanceData();
                              })).marginOnly(left: 10),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            (state.userBalance.value.balance ?? 0.0)
                                .toStringAsFixed(2),
                            style: AppStyles.number(24.sp),
                          ).marginOnly(bottom: 4.dp),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "充提记录",
                                style: TextStyle(
                                    color: AppMainColors.whiteColor70,
                                    fontSize: 12.dp),
                              ),
                              Image.asset(
                                R.comJiantouRight,
                                width: 16.dp,
                                height: 16.dp,
                              ).marginOnly(left: 5),
                            ],
                          ).inkWell(onTap: () {
                            logic.gotoChargeAndWithdraw(c);
                          }),
                        ],
                      ),
                      Container(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _but("充值").gestureDetector(onTap: () {
                            logic.gotoReCharge(c);
                          }),
                          _but("提现").gestureDetector(onTap: () {
                            logic.gotoWithdraw(c);
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _but(String vaelue) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppMainColors.whiteColor70, width: 0.5.dp),
          color: vaelue == "充值" ? AppMainColors.pink20 : AppMainColors.blue20,
          borderRadius: BorderRadius.all(Radius.circular(24.dp))),
      alignment: Alignment.center,
      width: 120.dp,
      height: 40.dp,
      child: Text(
        vaelue,
        style: TextStyle(color: Colors.white, fontSize: 16.dp),
      ),
    );
  }

  //我的资产,钻石
  Widget _myDiamond() {
    return Obx(() => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(R.icWalletDiamond), fit: BoxFit.fill),
        ),
        width: double.infinity,
        height: 150.dp,
        margin: EdgeInsets.fromLTRB(16.dp, 13.dp, 16.dp, 0),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 24.dp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    R.icWallekCharge,
                    width: 70.dp,
                    height: 30.dp,
                  ).gestureDetector(onTap: () {
                    logic.gotoRedeemDiamonds();
                  }),
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 16.dp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 16.dp,
                    ),
                    Image.asset(
                      R.icWallekMiniDiamond,
                      width: 24.dp,
                      height: 24.dp,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      "钻石资产",
                      style: TextStyle(
                          fontSize: 16.dp, color: AppMainColors.whiteColor70),
                    ),
                    Spring.rotate(
                        springController: state.springDrinksCoinsController,
                        animStatus: (AnimStatus status) {
                          print(status);
                        },
                        child: Image.asset(
                          R.comShuaxinAssets,
                          width: 16,
                          height: 16,
                        ).inkWell(onTap: () {
                          state.springCoinsController
                              .play(motion: Motion.pause);
                          state.springDrinksCoinsController
                              .play(motion: Motion.play);
                          logic.userBalanceData();
                        })).marginOnly(left: 10),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _myDiamondText('剩余钻石',
                        "${state.userBalance.value.coinBalance ?? 0}", true),
                    _myDiamondText(
                            '消费的钻石',
                            "${(state.userBalance.value.giftDiamondNum ?? 0).toStringAsFixed(2)}",
                            false)
                        .gestureDetector(onTap: () {
                      Get.to(() => MineIncomeExpenditureDetailsPage());
                    }),
                  ],
                ),
              ],
            ),
          ],
        )));
  }

  Widget _myDiamondText(String title, String value, bool offstage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 38.dp,
        ),
        Text(
          title,
          style: TextStyle(color: AppMainColors.whiteColor70, fontSize: 14.dp),
        ),
        SizedBox(
          height: 8.dp,
        ),
        Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: AppStyles.number(24.sp),
            ),
            Offstage(
              offstage: offstage,
              child: Image.asset(
                R.comArrowRight,
                width: 16.dp,
                height: 16.dp,
                color: AppMainColors.whiteColor70,
              ).marginOnly(left: 10, top: 4.dp),
            )
          ],
        )
      ],
    );
  }

  Widget _accountManagement() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(R.icWallekAccountManage),
              fit: BoxFit.fill)),
      width: double.infinity,
      height: 150.dp,
      margin: EdgeInsets.fromLTRB(16.dp, 13.dp, 16.dp, 0),
      child: Column(
        children: [
          SizedBox(
            height: 16.dp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 16.dp,
              ),
              Image.asset(
                R.icWallekMiniAccountManage,
                width: 24.dp,
                height: 24.dp,
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                "账户管理",
                style: TextStyle(
                    fontSize: 16.dp, color: AppMainColors.whiteColor70),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(
                () => _myAccount(
                  "银行卡",
                  "${logic.state.userBalance.value.binkBankNum ?? 0}张",
                ).gestureDetector(onTap: () {
                  logic.gotoBindBankManger(WalletAccount.bank);
                }),
              ),
              Spacer(),
              Obx(() => _myAccount(
                    "钱包地址",
                    "${logic.state.userBalance.value.walletAddress ?? 0}个",
                  ).gestureDetector(onTap: () {
                    logic.gotoBindBankManger(WalletAccount.topay);
                  })),
            ],
          ),
        ],
      ),
    );
  }

  Widget _myAccount(String title, String subTitle) {
    return Container(
      width: 137.dp,
      margin: EdgeInsets.only(left: 25.dp, top: 30.dp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: AppColors.main_white_opacity_7, fontSize: 16.dp),
          ),
          SizedBox(
            height: 20.dp,
          ),
          Row(
            children: [
              Text(
                subTitle,
                style: TextStyle(color: Colors.white, fontSize: 14.dp),
              ),
              SizedBox(
                width: 15,
              ),
              Image.asset(
                R.comArrowRight,
                width: 16.dp,
                height: 16.dp,
                color: AppMainColors.whiteColor70,
              )
            ],
          )
        ],
      ),
    );
  }
}
