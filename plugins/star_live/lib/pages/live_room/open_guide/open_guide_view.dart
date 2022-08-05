import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/common_widget/app_dialog.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_common/manager/user/user_balance_logic.dart';

import '../../live/change_diamond_widget.dart';
import '../../recharge/recharge/recharge_view.dart';
import '../live_room_new_logic.dart';
import '../view/guide_view/guide_widget_logic.dart';
import 'open_guide_logic.dart';

class OpenGuidePage extends StatelessWidget with Toast {
  final logic = Get.put(OpenGuideLogic());
  final state = Get.find<OpenGuideLogic>().state;

  var clickPos = 0.obs;
  var text = "".obs;

  @override
  Widget build(BuildContext context) {
    Get.find<OpenGuideLogic>().getLiveRoomWatchUser();
    return Container(
      height: 374.dp + AppLayout.safeBarHeight,
      decoration: BoxDecoration(
          color: AppMainColors.string2Color('#161722'),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.dp),
              topRight: Radius.circular(12.dp))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 12.dp,
          ),
          CustomText(
            "开通守护",
            style: AppStyles.f16w500white100,
          ),
          SizedBox(
            height: 12.dp,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.dp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildGuardItem(R.icWeeklyGuard, state.guardTitle[0],
                    state.openFee[0], 0, state.renewalFee[0]),
                _buildGuardItem(R.icMonthlyGuard, state.guardTitle[1],
                    state.openFee[1], 1, state.renewalFee[1]),
                _buildGuardItem(R.icYearlyGuard, state.guardTitle[2],
                    state.openFee[2], 2, state.renewalFee[2])
              ],
            ),
          ),
          SizedBox(
            height: 16.dp,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: CustomText(
              "为主播开通守护，畅想尊贵特权～",
              style: AppStyles.f14w400c70white,
            ),
          ).marginOnly(left: 16.dp),
          SizedBox(
            height: 12.dp,
          ),
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildPrivilegeItem(R.icIdMark, "身份识别", 1.0),
                _buildPrivilegeItem(
                    R.icEnterSpecialEffect, "进场特效", 1.0),
                _buildPrivilegeItem(R.icExclusiveGift, "专属礼物",
                    clickPos == 0 ? 0.5 : 1.0),
                _buildPrivilegeItem(
                    R.icAntiKick, "防踢禁言", clickPos == 2 ? 1.0 : 0.5),
              ],
            );
          }),
          SizedBox(
            height: 20.dp,
          ),
          Row(
            children: [
              SizedBox(width: 16.dp,),
              ChangeDiamondWidget(),
              Spacer(),
              Obx(() {
                if (state.data.value.type == 0) {
                  text.value = "开通";
                } else if (state.data.value.type == 2001) {
                  if (clickPos.value == 0) {
                    text.value = "续费";
                  } else {
                    text.value = "开通";
                  }
                } else if (state.data.value.type == 2002) {
                  if (clickPos.value == 0) {
                    text.value = "不可降级开通";
                  } else if (clickPos.value == 1) {
                    text.value = "续费";
                  } else {
                    text.value = "开通";
                  }
                } else {
                  if (clickPos.value == 0) {
                    text.value = "不可降级开通";
                  } else if (clickPos.value == 1) {
                    text.value = "不可降级开通";
                  } else {
                    text.value = "续费";
                  }
                }
                return text.value == "不可降级开通"
                    ? openGuardContainer(text.value).marginOnly(right: 16.dp)
                    : openguardContainer(text.value, context).marginOnly(right: 16.dp);
              }),
            ],
          )
        ],
      ),
    );
  }

  Container openGuardContainer(String text) {
    return Container(
      height: 28.dp,
      padding: EdgeInsets.symmetric(vertical: 4.dp, horizontal: 10.dp),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.dp)),
          border: Border.all(color: AppMainColors.whiteColor10, width: 1.dp),
          gradient: LinearGradient(
              colors: [AppMainColors.whiteColor10, AppMainColors.whiteColor6])),
      child: CustomText(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
          fontWeight: w_400,
        ),
      ),
    );
  }

  Row openguardContainer(String text, BuildContext context) {
    return Row(
      children: [
        CustomText(text == "续费" ? "${state.data.value.expireTime}到期   " : "",
            style: TextStyle(
              color: AppMainColors.whiteColor70,
              fontSize: 10.sp,
              fontWeight: w_400,
            )),
        Container(
          height: 28.dp,
          padding: EdgeInsets.symmetric(horizontal: 10.dp),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16.dp)),
              gradient: const LinearGradient(
                  colors: AppMainColors.commonBtnGradient)),
          child: CustomText(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: w_400,
            ),
          ).gestureDetector(onTap: () {
            var pos = clickPos.value;
            var diamond = Get.find<UserBalanceLonic>()
                .state
                .userBalance
                .value
                .coinBalance;
            if (text == '开通') {
              if (int.tryParse(state.openFee[pos])! > diamond!) {
                _showTipDialog(context);
                return;
              }
            } else if (text == '续费') {
              if (int.tryParse(state.renewalFee[pos])! > diamond!) {
                _showTipDialog(context);
                return;
              }
            }
            _showBuyDialog(context, text, pos);
          }),
        )
      ],
    );
  }

  _showTipDialog(BuildContext context) {
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
            // Navigator.of(context).pushReplacementNamed(AppRoutes.tab);
            // Get.toNamed(TabbarControlPage());
          },
        );
      },
    );
  }

  Widget _buildGuardItem(
      String url, String title, String diamondNum, int index, String renewal) {
    return Obx(() {
      return Container(
        width: (Get.width - 24.dp - 32.dp) / 3,
        decoration: BoxDecoration(
            color: index == clickPos.value
                ? AppMainColors.mainColor.withOpacity(0.1):Colors.white10,
            border: Border.all(
                color: index == clickPos.value
                    ? AppMainColors.mainColor.withOpacity(0.3)
                    : Colors.white10),
            borderRadius: BorderRadius.all(Radius.circular(4.dp))
            ),
        child: Column(
          children: [
            SizedBox(
              height: 12.dp,
            ),
            Image.asset(
              url,
              width: 78.dp,
              height: 78.dp,
            ),
            SizedBox(
              height: 8.dp,
            ),
            CustomText(
              title,
              style: TextStyle(
                  fontWeight: w_600, fontSize: 14.sp, color: Colors.white),
            ),
            SizedBox(
              height: 4.dp,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                R.icWallekMiniDiamond,
                width: 16.dp,
                height: 16.dp,
              ),
              SizedBox(
                width: 4.dp,
              ),
              CustomText(
                diamondNum,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: w_400,
                    fontFamily: 'Number'),
              ),
            ]),
            SizedBox(
              height: 4.dp,
            ),
            CustomText("续费$renewal",
                style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: AppMainColors.whiteColor100)),
            SizedBox(
              height: 8.dp,
            ),
          ],
        ),
      );
    }).gestureDetector(onTap: () {
      clickPos.value = index;
    });
  }

  _showBuyDialog(BuildContext context, String title, int pos) {
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
                  text: title == '开通'
                      ? state.openFee[pos]
                      : state.renewalFee[pos],
                  style: TextStyle(
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
                  text: "${state.guardTitle[pos]}",
                  style: TextStyle(
                      color: AppMainColors.whiteColor70,
                      fontSize: 14.sp,
                      fontWeight: w_400),
                ),
              ])),
          title: title == '开通' ? '购买' : title,
          cancelText: "取消",
          confirmText: '确定',
          confirm: () {
            Get.back();
            Get.put(LiveRoomWatchList()).openOrRenew(pos, success: () {
              Get.find<LiveRoomNewLogic>()
                  .state
                  .setGuard(state.data.value.type ?? 0);
              showToast("守护开通成功");
              // Navigator.of(context).pop();
            }, failure: (e) {
              showToast("$e");
              // Navigator.of(context).pop();
            });
          },
        );
      },
    );
  }

  Widget _buildPrivilegeItem(String url, String name, double opacity) {
    return Opacity(
      opacity: opacity,
      child: Column(
        children: [
          Image.asset(
            url,
            width: 36.dp,
            height: 36.dp,
          ),
          SizedBox(
            height: 6.dp,
          ),
          CustomText(
            name,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12.sp,
              fontWeight: w_400,
            ),
          ),
        ],
      ),
    );
  }
}
