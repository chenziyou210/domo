import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:hjnzb/pages/my_mine/mine_wallet/mine_charge_and_withdraw/mine_charge_and_withdraw_view.dart';
import 'package:star_common/common/common_widget/custom_gradientbutton/custom_gradientbutton.dart';

import 'mine_withdraw_info_logic.dart';
import 'mine_withdraw_info_state.dart';

/// @description:
/// @author
/// @date: 2022-06-03 12:51:36
/// 提现
class MineWithdrawInfoPage extends StatelessWidget {
  final MineWithdrawInfoLogic logic = Get.put(MineWithdrawInfoLogic());
  final MineWithdrawInfoState state = Get.find<MineWithdrawInfoLogic>().state;

  MineWithdrawInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    state.withdrawData = Get.arguments;
    return Scaffold(
      appBar: DefaultAppBar(
        title: CustomText("${state.withdrawData?.name ?? ""}",
            fontSize: 18.dp, color: Colors.white),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                Get.to(() => MineChargeAndWithdrawPage());
              },
              child: Text(
                "充提记录",
                style: TextStyle(color: Colors.white, fontSize: 14.dp),
              ))
        ],
      ),
      body: GetBuilder<MineWithdrawInfoLogic>(
          init: logic,
          global: false,
          builder: (c) {
            return SingleChildScrollView(
              child: _body(context),
            );
          }),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.dp),
      child: Column(
        children: [
          _topView(),
          _withdrawContent(context),
        ],
      ),
    );
  }

  Widget _topView() {
    if (state.withdrawData?.withdrawTypeNo == "Bank") {
      return Container(
              height: 123.dp,
              alignment: Alignment.topCenter,
              padding: EdgeInsets.all(16.dp),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(46, 57, 74, 1),
                  Color.fromRGBO(67, 84, 103, 1)
                ]),
                image: DecorationImage(
                    image: AssetImage(R.icTxYinhangkaBg),
                    alignment: Alignment.centerRight),
                borderRadius: BorderRadius.circular(8.dp),
              ),
              child: topBankInfo())
          .inkWell(onTap: () {
        if ((logic.state.bankList?.length ?? 0) > 0) {
          logic.changingBankCard();
        } else {
          logic.bindBankCard();
        }
      });
    } else if (state.withdrawData?.withdrawTypeNo == "Wallet") {
      return Container(
              height: 64.dp,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 16.dp, right: 16.dp),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(R.icTxQianbaoBg),
                    alignment: Alignment.centerRight),
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(46, 57, 74, 1),
                  Color.fromRGBO(80, 88, 112, 1)
                ]),
                borderRadius: BorderRadius.circular(8.dp),
              ),
              child: topWalletInfo())
          .inkWell(onTap: () {
        if ((logic.state.walletList?.length ?? 0) > 0) {
          logic.changingWallet();
        } else {
          logic.bindWallet();
        }
      });
    }
    return Container();
  }

  Widget topBankInfo() {
    if ((logic.state.bankList?.length ?? 0) > 0) {
      var cardNumber = logic.state.bankCardInfo?.cardNumber!;
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                  width: 40.dp,
                  height: 40.dp,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20.dp)),
                  )),
              Container(
                width: 28.dp,
                height: 28.dp,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            logic.state.bankCardInfo?.bankIcon ?? ""))),
              ),
            ],
          ).marginOnly(right: 12.dp),
          // CircleAvatar(
          //   backgroundColor: Colors.white,
          //   radius: 14.dp,
          //   backgroundImage:
          //       NetworkImage(logic.state.bankCardInfo?.bankIcon ?? ""),
          // )
          Container(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  logic.state.bankCardInfo?.bankName ?? "",
                  style: TextStyle(
                      fontSize: 16.dp,
                      color: AppMainColors.whiteColor100,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 4.dp,
                ),
                Text(
                  "储蓄卡",
                  style: TextStyle(
                      fontSize: 12.dp, color: AppMainColors.whiteColor20),
                ),
                SizedBox(
                  height: 24.dp,
                ),
                Text(
                    "****  ****  ****  ${cardNumber!.substring(cardNumber.length - 4)}",
                    style: AppStyles.number(18.sp)),
              ],
            ),
          ),
          Spacer(),
          Container(
            alignment: Alignment(0, 0),
            height: 24.dp,
            width: 48.dp,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromRGBO(255, 255, 255, 0.1), width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(15.dp))),
            child: Text(
              '+ 更换',
              style: TextStyle(color: Colors.white, fontSize: 10.dp),
            ),
          )
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            R.icMineAddbank,
            width: 40.dp,
            height: 40.dp,
            fit: BoxFit.fill,
          ).marginOnly(right: 12.dp),
          Container(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "暂无银行卡",
                  style: TextStyle(
                      fontSize: 16.dp,
                      color: AppMainColors.whiteColor100,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 4.dp,
                ),
                Text(
                  "请新增银行卡",
                  style: TextStyle(
                      fontSize: 12.dp, color: AppMainColors.whiteColor20),
                ),
                SizedBox(
                  height: 24.dp,
                ),
                Text(
                  "****  ****  ****  ****",
                  style: TextStyle(
                      fontSize: 16.dp,
                      color: AppMainColors.whiteColor100,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            alignment: Alignment(0, 0),
            height: 24.dp,
            width: 48.dp,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromRGBO(255, 255, 255, 0.1), width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(15.dp))),
            child: Text(
              '+ 绑定',
              style: TextStyle(color: Colors.white, fontSize: 10.dp),
            ),
          )
        ],
      );
    }
  }

  Widget topWalletInfo() {
    if ((logic.state.walletList?.length ?? 0) > 0) {
      var walletAddress = (logic.state.walletinfo!.walletAddress ?? "")
          .replaceFirst(RegExp(r'\d{4}'), '****', 4);
      return Container(
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                    width: 40.dp,
                    height: 40.dp,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20.dp)),
                    )),
                Container(
                  width: 28.dp,
                  height: 28.dp,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              logic.state.walletinfo?.walletIcon ?? ""))),
                ),
              ],
            ),
            SizedBox(
              width: 12,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  logic.state.walletinfo?.walletName ?? "",
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ).marginOnly(bottom: 2.dp),
                Text(
                  "地址: " + walletAddress,
                  style: TextStyle(
                      color: AppMainColors.whiteColor70, fontSize: 14.sp),
                )
              ],
            ),
            Spacer(),
            Container(
              alignment: Alignment(0, 0),
              height: 24.dp,
              width: 48.dp,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromRGBO(255, 255, 255, 0.1), width: 0.5),
                  borderRadius: BorderRadius.all(Radius.circular(15.dp))),
              child: Text(
                '更换',
                style: TextStyle(color: Colors.white, fontSize: 10.dp),
              ),
            )
          ],
        ),
      );
    } else {
      return Row(children: [
        Image.asset(
          R.icMineAddbank,
          width: 40.dp,
          height: 40.dp,
          fit: BoxFit.fill,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "暂无钱包地址",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        Spacer(),
        Container(
          alignment: Alignment(0, 0),
          height: 24.dp,
          width: 48.dp,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Color.fromRGBO(255, 255, 255, 0.1), width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(15.dp))),
          child: Text(
            '+ 绑定',
            style: TextStyle(color: Colors.white, fontSize: 10.dp),
          ),
        )
      ]);
    }
  }

  Widget _withdrawContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 24.dp),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "提现金额",
                style: TextStyle(
                    fontSize: 14.dp,
                    fontWeight: FontWeight.w500,
                    color: AppMainColors.whiteColor100),
              ),
            ],
          ),
          SizedBox(
            height: 18.dp,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "￥",
                    style: TextStyle(color: Colors.white, fontSize: 16.dp),
                  ),
                  SizedBox(
                    width: 4.dp,
                  ),
                  Expanded(
                    child: TextField(
                      controller: state.controller,
                      style: AppStyles.number(24.sp),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 8.dp),
                          isDense: true,
                          hintText:
                              "请输入${state.withdrawData?.minAmount ?? 0} ~ ${state.withdrawData?.maxAmount ?? 0}金额范围",
                          hintStyle: TextStyle(
                              color: AppMainColors.whiteColor20,
                              fontSize: 13.sp),
                          border: InputBorder.none),
                      onChanged: (d) {
                        logic.onChanged(d);
                      },
                    ),
                  ),
                  Text(
                    "最大金额",
                    style: TextStyle(
                        color: AppMainColors.string2Color("EEFF87"),
                        fontWeight: FontWeight.w100,
                        fontSize: 12.dp),
                  ).gestureDetector(onTap: () {
                    logic.maxAmount();
                  }),
                ],
              ),
              Container(
                height: 0.5.dp,
                color: AppMainColors.whiteColor6,
              ),
              SizedBox(
                height: 12.dp,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => (double.parse(state.inputAmount.value) >
                              (logic.state.balanceData?.balance ?? 0.00) ||
                          double.parse(state.inputAmount.value) >
                              double.parse(
                                  "${state.withdrawData?.maxAmount ?? 0.00}"))
                      ? Text(
                          "超出可提现金额",
                          style: TextStyle(color: Colors.red, fontSize: 12.sp),
                        )
                      : Text(
                          "账户金额 ${logic.state.balanceData?.balance ?? 0}元",
                          style: TextStyle(
                              color: AppMainColors.whiteColor70,
                              fontSize: 12.dp),
                        )),
                  Row(
                    children: [
                      Text(
                        "打码量 ${logic.state.balanceData?.withdraw ?? 0} ",
                        style: TextStyle(
                            color: AppMainColors.whiteColor70, fontSize: 12.sp),
                      ),
                      Spacer(),
                      Text(
                        "提现说明",
                        style: TextStyle(
                            color: Color.fromRGBO(50, 197, 255, 1),
                            fontSize: 12.sp),
                      ).gestureDetector(
                        onTap: () {
                          logic.withdrawalInstructions();
                        },
                      )
                    ],
                  ).marginOnly(top: 4)
                ],
              ),
              SizedBox(
                height: 27.dp,
              ),
              _but(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _but(BuildContext context) {
    return Obx(() => Opacity(
          opacity:
              state.isCardInfo.value && int.parse(state.inputAmount.value) > 0
                  ? 1
                  : 0.5,
          child: Container(
            height: 38.dp,
            width: double.infinity,
            margin: EdgeInsets.all(16.dp),
            child: GradientButton(
              child: Text(
                '提现',
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
              onPressed: () {
                if (state.isCardInfo.value &&
                    int.parse(state.inputAmount.value) > 0) {
                  logic.withdrawalFunds(context);
                }
              },
            ),
          ),
        ));
  }
}
