import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_common/lottie/lottie_view.dart';
import 'package:star_common/util_tool/string_extension.dart';
import 'mine_charge_and_withdraw_logic.dart';
import 'mine_charge_and_withdraw_state.dart';

/// @description: 充值提现记录
/// @author  Austin
/// @date: 2022-05-31 18:29:10
class MineChargeAndWithdrawPage extends StatefulWidget {
  @override
  State<MineChargeAndWithdrawPage> createState() =>
      _MineChargeAndWithdrawPageState();
}

class _MineChargeAndWithdrawPageState extends State<MineChargeAndWithdrawPage>
    with SingleTickerProviderStateMixin {
  final MineChargeAndWithdrawLogic logic =
      Get.put(MineChargeAndWithdrawLogic());
  final MineChargeAndWithdrawState state =
      Get.find<MineChargeAndWithdrawLogic>().state;
  late TabController _tabController;
  // MineChargeAndWithdrawPage({Key? key}) : super(key: key);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // state.controller.requestRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        centerTitle: true,
        title: TabBar(
          isScrollable: true,
          indicatorColor: Colors.transparent,
          labelColor: AppMainColors.whiteColor100,
          unselectedLabelColor: AppMainColors.whiteColor70,
          labelStyle:
              TextStyle(fontSize: 18.sp, fontWeight: AppLayout.boldFont),
          unselectedLabelStyle: TextStyle(fontSize: 16.sp),
          controller: _tabController,
          onTap: (index) {
            // Alog.i(index);
          },
          tabs: state.titles.map((title) {
            return CustomText(title);
          }).toList(),
        ),
      ),
      body: TabBarView(
          controller: _tabController,
          children: [WithdrawRecordList(), ChargeRecordList()]),
    );

    // SafeArea(
    //   child: GetBuilder<MineChargeAndWithdrawLogic>(
    //     init: logic,
    //     builder: (c) {
    //       return _body(context);
    //     },
    //   ),
    // ),
    // );
  }
}

class WithdrawRecordList extends StatelessWidget {
  WithdrawRecordList({Key? key}) : super(key: key);
  final logic = Get.put(MineChargeAndWithdrawLogic());
  final state = Get.find<MineChargeAndWithdrawLogic>().state;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<MineChargeAndWithdrawLogic>(
        // id: GameRecordType.today,
        builder: (logic) {
          return SmartRefresher(
            enablePullUp: state.loadMore,
            controller: state.withdrawController,
            header: LottieHeader(),
            footer: LottieFooter(),
            onRefresh: () {
              state.loadMore = true;
              logic.requestWithdrawList(true);
            },
            onLoading: () {
              logic.requestWithdrawList(false);
            },
            child: state.withdrawalRecordsList.length == 0
                ? EmptyView(
                    emptyType: EmptyType.noData,
                  )
                : _list(context),
          );
        },
      ),
    );
  }

  Widget _list(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: state.withdrawalRecordsList.length,
        itemBuilder: (c, i) {
          return _withdrawItem(i);
        });
  }

  Widget _withdrawItem(int index) {
    WithdrawalRecordsData model = state.withdrawalRecordsList[index];
    return Container(
      height: 73.dp,
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 16.dp),
      // margin: EdgeInsets.symmetric(horizontal: 16.dp),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            child: Image.network(
              model.iconUrl ?? "",
            ),
          ),
          SizedBox(
            width: 12.dp,
          ),
          Expanded(
              child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      model.withdrawType ?? "",
                      style: TextStyle(color: AppMainColors.whiteColor100),
                    ),
                    Text(
                      model.orderStatus ?? "",
                      style: TextStyle(
                          fontSize: 12.dp,
                          color: logic.statusColor(model.orderStatus ?? "")),
                    ),
                  ],
                ).marginOnly(right: 16.dp, top: 15.dp),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dateTimeWithString(model.createTime ?? ""),
                      style: TextStyle(
                          fontSize: 12.dp, color: AppMainColors.whiteColor20),
                    ),
                    Text("¥${model.money}", style: AppStyles.number(16.sp)),
                  ],
                ).marginOnly(right: 16.dp, bottom: 13.dp),
              ),
              Container(
                height: 0.5,
                color: AppMainColors.whiteColor6,
              )
            ],
          )),
        ],
      ),
    );
  }
}

class ChargeRecordList extends StatelessWidget {
  ChargeRecordList({Key? key}) : super(key: key);
  final logic = Get.put(MineChargeAndWithdrawLogic());
  final state = Get.find<MineChargeAndWithdrawLogic>().state;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<MineChargeAndWithdrawLogic>(
        // id: GameRecordType.today,
        builder: (logic) {
          return SmartRefresher(
            enablePullUp: state.loadMore,
            controller: state.chargeController,
            header: LottieHeader(),
            footer: LottieFooter(),
            onRefresh: () {
              state.loadMore = true;
              logic.requestChargeList(true);
            },
            onLoading: () {
              logic.requestChargeList(false);
            },
            child: state.rechargeRecordList.length == 0
                ? EmptyView(
                    emptyType: EmptyType.noData,
                  )
                : _list(context),
          );
        },
      ),
    );
  }

  Widget _list(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: state.rechargeRecordList.length,
        itemBuilder: (c, i) {
          return _withdrawItem(i);
        });
  }

  Widget _withdrawItem(int index) {
    RechargeRecordData model = state.rechargeRecordList[index];
    return Container(
      height: 73.dp,
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 16.dp),
      // margin: EdgeInsets.symmetric(horizontal: 16.dp),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            child: Image.network(model.iconUrl ?? ""),
          ),
          SizedBox(
            width: 12.dp,
          ),
          Expanded(
              child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      model.payTypeNo ?? "",
                      style: TextStyle(color: AppMainColors.whiteColor100),
                    ),
                    Text(
                      model.orderStatus ?? "",
                      style: TextStyle(
                          fontSize: 12.dp,
                          color: logic.statusColor(model.orderStatus ?? "")),
                    ),
                  ],
                ).marginOnly(right: 16.dp, top: 15.dp),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dateTimeWithString(model.createTime ?? ""),
                      style: TextStyle(
                          fontSize: 12.dp, color: AppMainColors.whiteColor20),
                    ),
                    Text("¥${model.rechargeMoney}",
                        style: AppStyles.number(16.sp)),
                  ],
                ).marginOnly(right: 16.dp, bottom: 13.dp),
              ),
              Container(
                height: 0.5,
                color: AppMainColors.whiteColor6,
              )
            ],
          )),
        ],
      ),
    );
  }
}
