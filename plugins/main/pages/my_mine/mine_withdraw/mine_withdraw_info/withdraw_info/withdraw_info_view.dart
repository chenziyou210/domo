import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';

import 'withdraw_info_logic.dart';
import 'withdraw_info_state.dart';

/// @description:
/// @author
/// @date: 2022-07-26 17:10:43
class WithdrawInfoPage extends StatelessWidget {
  final WithdrawInfoLogic logic = Get.put(WithdrawInfoLogic());
  final WithdrawInfoState state = Get.find<WithdrawInfoLogic>().state;

  WithdrawInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithdrawInfoLogic>(
        init: logic,
        builder: ((controller) => Scaffold(
              // backgroundColor: AppMainColors.string2Color("#101010"),
              appBar: DefaultAppBar(
                title: Text(
                  "提现信息",
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ),
              ),
              body: Column(
                children: [
                  Container(
                      height: 177.dp,
                      color: AppMainColors.whiteColor6,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                R.icVector,
                                width: 22.dp,
                                height: 22.dp,
                              ),
                              Text(
                                "提交成功",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.sp),
                              ).marginOnly(left: 9.dp)
                            ],
                          ).marginOnly(top: 17.dp, bottom: 17.dp),
                          RichText(
                              text: TextSpan(
                                  text: "¥",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24.sp),
                                  children: [
                                TextSpan(
                                    text: Get.arguments ?? "",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 32.sp))
                              ])),
                          Text(
                            "提现金额",
                            style: TextStyle(
                                color: AppMainColors.whiteColor40,
                                fontSize: 12.sp),
                          ).marginOnly(top: 8.dp),
                          Text(
                            "提现订单会在一天左右到账，请耐心等待",
                            style: TextStyle(
                                color: AppMainColors.whiteColor70,
                                fontSize: 12.sp),
                          ).marginOnly(top: 24.dp)
                        ],
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          child: Text(
                            "查看详情",
                            style: TextStyle(
                                color: AppMainColors.string2Color("#32C5FF"),
                                fontSize: 16.sp),
                          ),
                          width: 120.dp,
                          height: 40.dp,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.dp)),
                            border: Border.all(
                                width: 1,
                                color: AppMainColors.string2Color("#32C5FF")),
                            color: AppMainColors.string2Color("#32C5FF")
                                .withOpacity(0.2),
                          )).gestureDetector(
                        onTap: () {
                          logic.goToInfo();
                        },
                      ),
                      Container(
                              child: Text(
                                "去首页",
                                style: TextStyle(
                                    color:
                                        AppMainColors.string2Color("#32C5FF"),
                                    fontSize: 16.sp),
                              ),
                              width: 120.dp,
                              height: 40.dp,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.dp)),
                                  gradient: LinearGradient(
                                      colors: AppMainColors.commonBtnGradient)))
                          .gestureDetector(
                        onTap: () {
                          logic.gotoHome(context);
                        },
                      )
                    ],
                  ).marginOnly(top: 48.dp, right: 15.dp, left: 15.dp)
                ],
              ),
            )));
  }
}
