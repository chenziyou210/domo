import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:hjnzb/pages/my_mine/mine_wallet/mine_charge_and_withdraw/mine_charge_and_withdraw_view.dart';
import 'package:star_common/config/app_layout.dart';

import 'mine_withdraw_logic.dart';
import 'mine_withdraw_state.dart';

/// @description:
/// @author
/// @date: 2022-06-02 18:45:52
class MineWithdrawPage extends StatelessWidget {
  final MineWithdrawLogic logic = Get.put(MineWithdrawLogic());
  final MineWithdrawState state = Get.find<MineWithdrawLogic>().state;

  MineWithdrawPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DefaultAppBar(
          title: CustomText("${intl.withdraw}",
              fontSize: 18.sp, color: Colors.white),
          centerTitle: true,
          actions: [
            Container(
                child: TextButton(
              onPressed: () {
                Get.to(() => MineChargeAndWithdrawPage());
              },
              child: Text(
                "充提记录",
                style: TextStyle(color: Colors.white, fontSize: 14.dp),
              ),
            ))
          ],
        ),
        body: GetBuilder<MineWithdrawLogic>(
            init: logic,
            global: false,
            builder: (c) {
              return Container(
                margin: EdgeInsets.only(top: 16.dp),
                child: ListView.builder(
                    itemCount: logic.items?.length ?? 0,
                    itemBuilder: (c, index) {
                      return _item(logic.items?[index]).inkWell(onTap: () {
                        logic.gotoMineWithdrawInfo(logic.items?[index]);
                      });
                    }),
              );
            }));
  }

  Widget _item(MineWithdrawData? data) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 16.dp, 0),
      margin: EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(width: 0.5, color: AppMainColors.whiteColor6))),
      height: 74.dp,
      child: Row(
        children: [
          Container(
            width: 40.dp,
            height: 40.dp,
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: NetworkImage(data?.iconUrl ?? ""))),
          ),
          SizedBox(
            width: 12.dp,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 14.dp,
              ),
              Text(
                data?.name ?? "",
                style: TextStyle(
                    color: Colors.white, fontSize: 16.dp, fontWeight: w_400),
              ),
              Spacer(),
              Text(
                data?.remark ?? "",
                style: TextStyle(
                    fontSize: 12.dp,
                    color: AppMainColors.whiteColor40,
                    fontWeight: w_400),
              ),
              SizedBox(
                height: 14.dp,
              ),
            ],
          ),
          Spacer(),
          Image.asset(
            R.comJiantouRight,
            width: 18.dp,
            height: 18.dp,
            // color: AppMainColors.whiteColor40,
          ),
        ],
      ),
    );
  }
}
