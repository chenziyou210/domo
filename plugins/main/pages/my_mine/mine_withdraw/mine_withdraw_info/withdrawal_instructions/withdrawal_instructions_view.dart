import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';

import 'withdrawal_instructions_logic.dart';
import 'withdrawal_instructions_state.dart';

/// @description:
/// @author
/// @date: 2022-07-23 16:22:49
class WithdrawalInstructionsPage extends StatelessWidget {
  final WithdrawalInstructionsLogic logic =
      Get.put(WithdrawalInstructionsLogic());
  final WithdrawalInstructionsState state =
      Get.find<WithdrawalInstructionsLogic>().state;

  WithdrawalInstructionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: Text(
          "提现说明",
          style: TextStyle(color: Colors.white, fontSize: 18.sp),
        ),
      ),
      body: Column(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "提现规则",
                  style: TextStyle(
                      color: Colors.white, fontSize: 14.sp, fontWeight: w_500),
                ).marginOnly(bottom: 16.dp),
                Text(state.content,
                    style: TextStyle(
                        color: AppMainColors.whiteColor70,
                        fontWeight: w_400,
                        fontSize: 14.sp))
              ],
            ).marginAll(16),
            decoration: BoxDecoration(
                color: Color.fromRGBO(50, 197, 255, 0.1),
                borderRadius: BorderRadius.all(Radius.circular(8))),
          ).marginAll(16.dp)
        ],
      ),
    );
  }
}
