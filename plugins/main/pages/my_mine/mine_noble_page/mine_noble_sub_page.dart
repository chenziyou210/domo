// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';
import 'package:star_common/common/common_widget/app_dialog.dart';
import 'package:star_common/common/toast.dart';
import 'package:hjnzb/pages/my_mine/mine_noble_page/mine_noble_page_state.dart';
import 'package:star_common/manager/user/user_balance_logic.dart';
import 'package:star_live/pages/recharge/recharge/recharge_view.dart';

typedef _CallBack = void Function(int type);

class MineNobleSubPage extends StatefulWidget {
  final _CallBack callBack;
  final MineNobleData data;
  String expiryTime;
  int openType;

  MineNobleSubPage(
      {Key? key,
      required this.data,
      required this.expiryTime,
      required this.openType,
      required this.callBack})
      : super(key: key);

  @override
  createState() => _MineNobleSubPagePageState();
}

class _MineNobleSubPagePageState extends AppStateBase<MineNobleSubPage>
    with Toast {
  @override
  Widget build(BuildContext context) {
    MineNobleData data = widget.data;
    return Container(
        color: Color.fromRGBO(16, 16, 16, 1),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      height: 158.dp,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Image.asset(
                            R.nobleTopBgIcon,
                            fit: BoxFit.fill,
                          ),
                          Container(
                            width: 260.dp,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20.dp,
                                ),
                                Image.asset(
                                  data.nobleImageName!,
                                  fit: BoxFit.fill,
                                  width: 80.dp,
                                  height: 80.dp,
                                ).marginOnly(bottom: 8.dp),
                                Text(
                                  "贵族·" + data.nobleName!,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: w_600),
                                ).marginOnly(bottom: 4.dp),
                                Offstage(
                                  offstage: widget.openType != widget.data.type,
                                  child: Text(
                                    widget.expiryTime + "到期",
                                    style: TextStyle(
                                        color: AppMainColors.whiteColor70,
                                        fontSize: 10.sp,
                                        fontWeight: w_400),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                  SizedBox(
                    height: 16.dp,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 16.dp,
                      ),
                      diamondContainers(context, "首次开通", data.firstTimeNum,
                          data.giftFirstTimeNum),
                      SizedBox(
                        width: 16.dp,
                      ),
                      diamondContainers(
                          context, "续费", data.renewalNUm, data.giftRenewalNUm),
                      SizedBox(
                        width: 16.dp,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.dp,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 16.dp,
                      ),
                      Image.asset(
                        R.nobleOpenLockIcon,
                        width: 24.dp,
                        height: 24.dp,
                      ),
                      SizedBox(
                        width: 4.dp,
                      ),
                      Text(
                        data.nobleName! + "·解锁${data.privilegesNum}个特权",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: w_400),
                      ).marginOnly(bottom: 4.dp)
                    ],
                  ),
                  SizedBox(
                    height: 15.dp,
                  ),
                  Container(
                      height: 260.dp,
                      child: GridView.builder(
                          itemCount: data.items!.length,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent:
                                      MediaQuery.of(context).size.width / 4,
                                  childAspectRatio: 1),
                          itemBuilder: (context, index) {
                            return privilegeItem(data.items![index]);
                          })),
                  SizedBox(
                    height: MediaQuery.of(context).padding.bottom + 10.dp,
                  )
                ],
              ),
            ),
            Column(
              children: [
                Spacer(),
                openNoble().marginOnly(
                    bottom: MediaQuery.of(context).padding.bottom + 10.dp)
              ],
            )
          ],
        ));
  }

  Widget openNoble() {
    if (widget.openType == 0 || widget.openType < widget.data.type) {
      return _showOpen();
    } else if (widget.openType > widget.data.type) {
      return _showDegrade();
    } else if (widget.openType == widget.data.type) {
      return _showRenewal();
    }
    return Container();
  }

  Widget _showDegrade() {
    return Container(
        alignment: Alignment(0, 0),
        height: 32.dp,
        child: Container(
            alignment: Alignment(0, 0),
            width: 120.dp,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  AppMainColors.whiteColor10,
                  AppMainColors.separaLineColor6
                ]),
                border:
                    Border.all(color: AppMainColors.whiteColor10, width: 1.dp),
                borderRadius: BorderRadius.all(Radius.circular(16.dp))),
            child: CustomText(
              "暂不可降级开通",
              color: AppMainColors.whiteColor70,
              fontWeight: w_400,
              fontSize: 14.sp,
            )));
  }

  Widget _showOpen() {
    return Container(
      alignment: Alignment(0, 0),
      height: 32.dp,
      child: Container(
        alignment: Alignment(0, 0),
        width: 120.dp,
        child: CustomText(
          "立即开通",
          color: AppMainColors.whiteColor100,
          fontWeight: w_400,
          fontSize: 14.sp,
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: AppMainColors.commonBtnGradient),
            borderRadius: BorderRadius.all(Radius.circular(16.dp))),
      ).gestureDetector(onTap: () {
        var balance =
            Get.find<UserBalanceLonic>().state.userBalance.value.coinBalance;
        if (balance != null) if (balance < widget.data.firstTimeNum) {
          _showRechargeDialog(context);
        } else {
          _showBuyDialog(context, "购买", widget.data.firstTimeNum.toString(),
              widget.data.type, widget.data.nobleName!);
        }
      }),
    );
  }

  Widget _showRenewal() {
    return Container(
      alignment: Alignment(0, 0),
      height: 32.dp,
      child: Container(
        alignment: Alignment(0, 0),
        width: 120.dp,
        child: CustomText(
          "续费",
          color: AppMainColors.whiteColor100,
          fontWeight: w_400,
          fontSize: 14.sp,
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: AppMainColors.commonBtnGradient),
            borderRadius: BorderRadius.all(Radius.circular(16.dp))),
      ).gestureDetector(onTap: () {
        var balance =
            Get.find<UserBalanceLonic>().state.userBalance.value.coinBalance;
        if (balance != null) if (balance < widget.data.renewalNUm) {
          _showRechargeDialog(context);
        } else {
          _showBuyDialog(context, "续费", widget.data.renewalNUm.toString(),
              widget.data.type, widget.data.nobleName!);
        }
      }),
    );
  }

  _showRechargeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AppDialog(
          const Text(
            '很抱歉，当前钱包余额不足，请前往充值~',
            style: TextStyle(
                color: AppMainColors.whiteColor70,
                fontSize: 14,
                fontWeight: w_400),
          ),
          cancelText: "取消",
          confirmText: '前往充值',
          confirm: () {
            Get.back();
            Get.to(() => RechargePage(true));
          },
        );
      },
    );
  }

  _showBuyDialog(BuildContext context, String title, String number, int type,
      String name) {
    showDialog(
      context: context,
      builder: (_) {
        return AppDialog(
          Text.rich(TextSpan(
              text: "您将消耗",
              style: TextStyle(
                color: AppMainColors.whiteColor70,
                fontWeight: w_400,
                fontSize: 14.sp,
              ),
              children: [
                TextSpan(
                  text: number,
                  style: TextStyle(
                      fontFamily: "Number",
                      color: AppMainColors.mainColor,
                      fontSize: 14.sp,
                      fontWeight: w_400),
                ),
                TextSpan(
                  text: "钻石",
                  style: TextStyle(
                      color: AppMainColors.whiteColor70,
                      fontSize: 14.sp,
                      fontWeight: w_400),
                ),
                TextSpan(
                  text: title,
                  style: TextStyle(
                      color: AppMainColors.whiteColor70,
                      fontSize: 14.sp,
                      fontWeight: w_400),
                ),
                TextSpan(
                  text: "贵族",
                  style: TextStyle(
                      color: AppMainColors.whiteColor70,
                      fontSize: 14.sp,
                      fontWeight: w_400),
                ),
                TextSpan(
                  text: name,
                  style: TextStyle(
                      color: AppMainColors.whiteColor70,
                      fontSize: 14.sp,
                      fontWeight: w_400),
                ),
              ])),
          title: title,
          cancelText: "取消",
          confirmText: '确定',
          confirm: () {
            Get.back();
            widget.callBack(type);
          },
        );
      },
    );
  }

  Widget diamondContainers(
      BuildContext context, String title, int num1, int num2) {
    return Container(
      width: (MediaQuery.of(context).size.width - 16.dp * 3) / 2,
      height: 80.dp,
      decoration: BoxDecoration(
          color: AppMainColors.separaLineColor6,
          borderRadius: BorderRadius.all(Radius.circular(4.dp))),
      child: Column(
        children: [
          SizedBox(
            height: 4.dp,
          ),
          Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: 12.sp, fontWeight: w_500),
          ),
          SizedBox(
            height: 4.dp,
          ),
          Container(
            height: 1.dp,
            color: AppMainColors.separaLineColor6,
          ),
          SizedBox(
            height: 8.dp,
          ),
          RichText(
              text: TextSpan(
                  text: "${num1}",
                  style: AppStyles.number(20.sp, color: AppColors.mainColor),
                  children: [
                TextSpan(
                    text: " 钻石/月",
                    style: TextStyle(
                        color: AppMainColors.whiteColor70, fontSize: 12.sp))
              ])),
          SizedBox(
            height: 1.dp,
          ),
          Text(
            "赠送${num2}贵族钻石",
            style: TextStyle(
                color: AppColors.mainColor, fontSize: 10.sp, fontWeight: w_400),
          )
        ],
      ),
    );
  }

  Widget privilegeItem(PrivilegeItem m) {
    return Container(
        child: Opacity(
      opacity: m.isLightUp ? 1 : 0.3, //透明度
      child: Column(
        children: [
          Image.asset(
            m.itemImageName!,
            width: 36.dp,
            height: 36.dp,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 3.dp,
          ),
          Text(
            m.title!,
            style: TextStyle(
                color: Colors.white, fontSize: 12.sp, fontWeight: w_400),
          ),
          SizedBox(
            height: 2.dp,
          ),
          Text(
            m.subTitle!,
            style: TextStyle(
                color: Color.fromRGBO(153, 153, 153, 1),
                fontSize: 10.sp,
                fontWeight: w_400),
          ),
        ],
      ),
    ));
  }
}
