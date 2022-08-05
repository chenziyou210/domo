import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/manager/user/user_balance_logic.dart';
import 'package:star_common/router/router_config.dart';

class ChangeDiamondWidget extends StatelessWidget {
  const ChangeDiamondWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Image.asset(
        R.icWallekMiniDiamond,
        width: 16.dp,
        height: 16.dp,
      ),
      SizedBox(
        width: 4.dp,
      ),
      Obx(
        () {
          var userCoins =
              Get.find<UserBalanceLonic>().state.userBalance.value.coinBalance;
          return CustomText(
            "钻石${userCoins ?? 0}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: w_400,
            ),
          );
        },
      ),
      SizedBox(
        width: 16.dp,
      ),
      CustomText("兑换",
          style: TextStyle(
            color: AppMainColors.string2Color("32C5FF"),
            fontSize: 12.sp,
            fontWeight: w_400,
          )).gestureDetector(onTap: () {
        //todo
        Get.toNamed(AppRoutes.redeemDiamonds, arguments: {"code": "page1"})?.then((value) {
        });
        // Navigator.of(context).pushNamed(AppRoutes.redeemDiamonds,
        //     arguments: {"code": "page1"}).then((value) {
        // });
        // Navigator.pushNamed(context, AppRoutes.redeemDiamonds,arguments: {"code": "page1"});
      }),
    ]);
  }
}
