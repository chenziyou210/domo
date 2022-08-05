import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';

import 'withdraw_succeed_logic.dart';
import 'withdraw_succeed_state.dart';

/// @description:
/// @author 提现成功
/// @date: 2022-06-09 14:28:51
class WithdrawSucceedPage extends StatelessWidget {
  final WithdrawSucceedLogic logic = Get.put(WithdrawSucceedLogic());
  final WithdrawSucceedState state = Get.find<WithdrawSucceedLogic>().state;

  WithdrawSucceedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: Text("提现信息"),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    Map map = ModalRoute.of(context)!.settings.arguments as Map;
    var data = map['data'];
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(18.dp),
          height: 180.dp,
          width: double.infinity,
          color: AppMainColors.whiteColor6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        R.icWithdrawSucceed,
                        width: 22.dp,
                        height: 22.dp,
                      ),
                      SizedBox(
                        width: 4.dp,
                      ),
                      Text(
                        "提交成功",
                        style: TextStyle(
                            fontSize: 16.dp,
                            color: AppMainColors.whiteColor100),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 18.dp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "￥",
                        style: TextStyle(
                            fontSize: 16.dp,
                            color: AppMainColors.whiteColor100),
                      ),
                      Text(
                        "$data",
                        style: TextStyle(
                            fontSize: 32.dp,
                            color: AppMainColors.whiteColor100),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.dp,
                  ),
                  Text(
                    "提现金额",
                    style: TextStyle(
                        fontSize: 12.dp, color: AppMainColors.whiteColor40),
                  ),
                ],
              ),
              Text(
                "提现订单会在一天左右到账，请耐心等待",
                style: TextStyle(
                    fontSize: 12.dp, color: AppMainColors.whiteColor70),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 36.dp,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buts("查看详情").inkWell(onTap: () {
              Get.back();
            }),
            _buts("返回").inkWell(onTap: () {
              Get.back();
            }),
          ],
        ),
      ],
    );
  }

  Widget _buts(String value) {
    return Container(
      height: 40.dp,
      width: 120.dp,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 12.dp),
      decoration: BoxDecoration(
        color: value == "查看详情"
            ? AppMainColors.blue20
            : AppMainColors.string2Color("FF1EAF"),
        border: Border.all(
            width: 1.dp,
            color: value == "查看详情"
                ? AppMainColors.string2Color("32C5FF")
                : AppMainColors.string2Color("FF1EAF")),
        borderRadius: BorderRadius.circular(25.dp),
      ),
      child: Text(
        value,
        style: TextStyle(
            color: value == '查看详情'
                ? AppMainColors.string2Color("32C5FF")
                : Colors.white,
            fontSize: 16.dp),
      ),
    );
  }
}
