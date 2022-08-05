import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';
import 'package:hjnzb/pages/my_mine/mine_wallet/mine_wallet_logic.dart';

import 'mine_wallet_account_manage_logic.dart';
import 'mine_wallet_account_manage_state.dart';

/// @description:
/// @author
/// @date: 2022-06-15 17:35:12
class MineWalletAccountManagePage extends StatelessWidget {
  final MineWalletAccountManageLogic logic =
      Get.put(MineWalletAccountManageLogic());
  final MineWalletAccountManageState state =
      Get.find<MineWalletAccountManageLogic>().state;

  MineWalletAccountManagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    state.accountType = Get.arguments["type"];
    return GetBuilder<MineWalletAccountManageLogic>(
        init: logic,
        global: false,
        builder: (c) {
          return Scaffold(
              appBar: DefaultAppBar(
                title: Text(
                  state.accountType == WalletAccount.bank ? "银行卡管理" : "钱包地址管理",
                  style: TextStyle(color: Colors.white, fontSize: 18.dp),
                ),
                centerTitle: true,
              ),
              body: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    //头部
                    child: Container(
                      margin: EdgeInsets.only(left: 16.dp),
                      height: 25.dp,
                      child: Text(
                        (state.accountType == WalletAccount.bank
                                ? "*银行卡"
                                : "*钱包地址") +
                            "最多只能添加${state.maxAccountCount}张",
                        style: TextStyle(
                            color: AppColors.main_white_opacity_7,
                            fontSize: 12.dp),
                      ),
                    ),
                  ),
                  SliverFixedExtentList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return items(index);
                      }, childCount: logic.itemLength()), //个数
                      itemExtent: 84.dp), //高度
                  SliverToBoxAdapter(
                      //尾部
                      child: Offstage(
                    offstage: logic.setIsHide(),
                    child: Container(
                      alignment: Alignment(0, 0),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 0.06),
                          borderRadius:
                              BorderRadius.all(Radius.circular(4.dp))),
                      margin: EdgeInsets.fromLTRB(16.dp, 16.dp, 16.dp, 0),
                      height: 64.dp,
                      child: Text(
                        "+添加新的" +
                            (state.accountType == WalletAccount.bank
                                ? "银行卡号"
                                : "钱包地址"),
                        style: TextStyle(
                            color: AppColors.main_white_opacity_7,
                            fontSize: 14.dp),
                      ),
                    ).gestureDetector(onTap: () {
                      logic.addAccount();
                    }),
                  ))
                ],
              ));
        });
  }

  Widget items(int index) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.dp, 8.dp, 16.dp, 0),
      padding: EdgeInsets.only(left: 16, right: 12.dp),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(R.walletAccountItemBgIcon),
              alignment: Alignment.topRight),
          gradient: logic.setColors(index),
          borderRadius: BorderRadius.all(Radius.circular(4.dp))),
      child: Row(
        children: [
          Container(
            width: 40.dp,
            height: 40.dp,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.dp)),
            ),
            child: Center(
              child: Container(
                width: 28.dp,
                height: 28.dp,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(logic.setIconUrl(index)))),
              ),
            ),
          ),
          SizedBox(
            width: 8.dp,
          ),
          logic.setTltieView(index),
          Spacer(),
          logic.deleteAccount(index)
        ],
      ),
    );
  }
}
