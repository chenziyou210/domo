// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spring/spring.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_common/manager/user/user_balance_logic.dart';
import 'package:star_live/pages/live_room/view/room_info_page/room_live_game/room_base_game/room_base_game_logic.dart';
import '/pages/live_room/view/room_info_page/room_live_game/room_base_game/room_base_game_state.dart';

import 'room_game_bet_logic.dart';
import 'room_game_bet_state.dart';

/// @description:
/// @author
/// @date: 2022-06-23 14:30:56
class RoomGameBetPage extends StatelessWidget {
  final RoomGameBetLogic logic = Get.put(RoomGameBetLogic());
  final RoomGameBetState state = Get.find<RoomGameBetLogic>().state;

  List<GameOdds> odds = [];
  RoomGameBetPage({Key? key, required this.odds}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    state.odds = this.odds;
    state.updataIssueId(this.odds.first.issueId ?? "0");
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16.dp)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
              height: 345.dp,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(22, 23, 34, 0.9),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.dp),
                      topRight: Radius.circular(12.dp))),
              child: GetBuilder<RoomGameBetLogic>(
                init: logic,
                global: false,
                builder: (c) {
                  return Column(
                    children: [
                      bettingTopWidget(context),
                      bettingTopTitle(context),
                      bettingListWidget(context),
                      bottomBetting(context),
                      SizedBox(
                        height: AppLayout.safeBarHeight,
                      )
                    ],
                  );
                },
              )),
        ),
      ),
    );
  }

  //投注倍数
  Widget bottomBetting(BuildContext context) {
    var width = (MediaQuery.of(context).size.width -
            (logic.muItem.length - 1) * 8.dp -
            16.dp * 2) /
        logic.muItem.length;
    return Container(
      height: 90.dp,
      child: Column(
        children: [
          Expanded(
              child: Container(
            margin: EdgeInsets.only(left: 16.dp, right: 16.dp),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: logic.muItem.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      logic.seledetMu(index);
                    },
                    child: Container(
                      alignment: Alignment(0, 0),
                      decoration: BoxDecoration(
                          color: logic.muItem[index].seleted
                              ? AppColors.mainColor.withOpacity(0.1)
                              : Colors.transparent,
                          border: Border.all(
                              color: logic.muItem[index].seleted
                                  ? AppColors.mainColor.withOpacity(0.3)
                                  : Color.fromRGBO(255, 255, 255, 0.2),
                              width: 0.5),
                          borderRadius: BorderRadius.circular(14.dp)),
                      child: Text(
                        logic.muItem[index].name!,
                        style: TextStyle(
                            color: logic.muItem[index].seleted
                                ? AppColors.mainColor
                                : Color.fromRGBO(255, 255, 255, 0.7),
                            fontSize: 12.dp),
                      ),
                    ));
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: width / 28.dp,
                  crossAxisSpacing: 8.dp,
                  crossAxisCount: logic.muItem.length),
            ),
          )),
          Container(
            height: 0.5,
            color: AppMainColors.whiteColor10,
          ),
          bottomBettingInfo(context)
        ],
      ),
    );
  }

  //下注行数据
  Widget bottomBettingInfo(BuildContext context) {
    return Container(
      height: 54.dp,
      padding:
          EdgeInsets.only(top: 8.dp, left: 15.dp, bottom: 8.dp, right: 15.dp),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                    text: "合计: ",
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.7),
                        fontSize: 12.dp),
                    children: [
                      TextSpan(
                          text: "${odds.length}",
                          style: AppStyles.number(12.sp,
                              color: AppColors.mainColor)),
                      TextSpan(
                          text: " 注   金额: ",
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 0.7),
                              fontSize: 12.dp)),
                      TextSpan(
                          text: "${logic.state.betsAmount}",
                          style: AppStyles.number(12.sp,
                              color: AppColors.mainColor)),
                      TextSpan(
                          text: "元",
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 0.7),
                              fontSize: 12.dp)),
                    ]),
                maxLines: 1,
              ),
              Row(
                children: [
                  Image.asset(
                    R.gameYueIcon,
                    width: 16.dp,
                    height: 16.dp,
                    fit: BoxFit.fill,
                  ).marginOnly(right: 5),
                  Obx(
                    () => Text(
                      "余额:${Get.find<UserBalanceLonic>().state.userBalance.value.balance ?? 0.0}",
                      style: AppStyles.number(14.sp,
                          color: Color.fromRGBO(255, 255, 255, 0.7)),
                    ),
                  ),
                  Spring.rotate(
                      springController: state.springCoinsController,
                      child: Image.asset(
                        R.comShuaxinAssets,
                        width: 16,
                        height: 16,
                      ).inkWell(onTap: () {
                        state.springCoinsController.play(motion: Motion.play);
                        Get.find<UserBalanceLonic>().userBalanceData();
                      })).marginOnly(left: 10),
                ],
              )
            ],
          ),
          Spacer(),
          Container(
            alignment: Alignment(0, 0),
            child: GestureDetector(
                onTap: () {
                  try{
                    Get.back();
                    (Get.find<RoomBaseGameLogic>()
                        .getBetting(state.odds, state.mu, state.issueId.value));
                  }catch(e){
                    print(e);
                  }
                },
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Image.asset(
                      R.icConfirmNotextButton,
                      width: 80.dp,
                      height: 36.dp,
                      fit: BoxFit.fill,
                    ),
                    Text(
                      "下注",
                      style: TextStyle(color: Colors.white, fontSize: 14.dp),
                      textAlign: TextAlign.center,
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }

  /// 投注项
  Widget bettingListWidget(BuildContext context) {
    return Expanded(
        child: Container(
      width: MediaQuery.of(context).size.width,
      constraints: BoxConstraints(
          maxHeight: 345.dp - AppLayout.safeBarHeight - 84.dp - 32.dp - 56.dp),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: odds.length,
          itemExtent: 43.dp, //强制高度为43.0
          itemBuilder: (BuildContext context, int index) {
            return listItem(context, odds[index], index);
          }),
    ));
  }

  ///单个item
  Widget listItem(BuildContext context, GameOdds odd, int index) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Color.fromRGBO(22, 23, 34, 0.7),
          border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.white.withAlpha(10)),
          )),
      child: Row(
        children: [
          Container(
              alignment: Alignment(0, 0),
              width: MediaQuery.of(context).size.width / 5 * 2,
              child: RichText(
                text: TextSpan(
                    text: (odd.gameName ?? "") + "-" + odd.oddName! + " | ",
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.4),
                        fontSize: 12.dp),
                    children: [
                      TextSpan(
                          text: odd.name!,
                          style: TextStyle(
                              color: AppColors.mainColor, fontSize: 12.dp))
                    ]),
              )),
          SizedBox(
            width: 0.5,
            height: 42.dp,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.white.withAlpha(10)),
            ),
          ),
          Container(
            alignment: Alignment(0, 0),
            width: MediaQuery.of(context).size.width / 5 + 10,
            child: Text(
              "${odd.odds}",
              style: AppStyles.number(14.sp,
                  color: Color.fromRGBO(50, 197, 255, 1)),
            ),
          ),
          SizedBox(
            width: 0.5,
            height: 42.dp,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.white.withAlpha(10)),
            ),
          ),
          Container(
              alignment: Alignment(0, 0),
              width: MediaQuery.of(context).size.width / 5 + 10,
              child: Container(
                alignment: Alignment(0, 0),
                width: 64.dp,
                height: 28.dp,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.2),
                    borderRadius: BorderRadius.all(Radius.circular(14.dp))),
                child: Text(
                  odd.chips ?? "",
                  style: AppStyles.number(14.sp, color: Colors.white),
                ),
              )),
          SizedBox(
            width: 0.5,
            height: 42.dp,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.white.withAlpha(10)),
            ),
          ),
          Container(
              alignment: Alignment(0, 0),
              width: MediaQuery.of(context).size.width / 5 - 22,
              child: IconButton(
                icon: Icon(
                  Icons.clear,
                  size: 16.dp,
                  color: Color.fromRGBO(255, 255, 255, 0.4),
                ),
                onPressed: () {
                  logic.deleteBet(index);
                },
              )),
        ],
      ),
    );
  }

  ///投注顶部的Widget
  Widget bettingTopWidget(BuildContext context) {
    return Obx(() => Container(
          width: MediaQuery.of(context).size.width,
          height: 56.dp,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(R.gameBettingTopIcon), fit: BoxFit.fill)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 16.dp,
                  ),
                  Text(
                    "确认投注",
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                  Spacer(),
                  Text(
                    "关闭",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: w_400),
                  ).gestureDetector(onTap: () {
                    Get.back();
                  }),
                  SizedBox(
                    width: 16.dp,
                  ),
                ],
              ).marginOnly(bottom: 2.dp),
              Row(
                children: [
                  SizedBox(
                    width: 16.dp,
                  ),
                  Text(
                    "第${int.parse(state.issueId.value) + 1} 本期截止",
                    style: TextStyle(color: Colors.white, fontSize: 12.dp),
                  ),
                  SizedBox(
                    width: 10.dp,
                  ),
                  Text(logic.time(),
                      style: AppStyles.number(14.sp,
                          color: Color.fromRGBO(120, 255, 166, 1))),
                ],
              ),
            ],
          ),
        ));
  }

  ///顶部下面的标题
  Widget bettingTopTitle(BuildContext context) {
    return Container(
      height: 32.dp,
      color: Color.fromRGBO(100, 100, 100, 0.4),
      child: Row(
        children: [
          Container(
            alignment: Alignment(0, 0),
            width: MediaQuery.of(context).size.width / 5 * 2,
            child: Text(
              "玩法",
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.4), fontSize: 12.dp),
            ),
          ),
          SizedBox(
            width: 0.5,
            height: 32.dp,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.white.withAlpha(10)),
            ),
          ),
          Container(
            alignment: Alignment(0, 0),
            width: MediaQuery.of(context).size.width / 5 + 10,
            child: Text(
              "赔率",
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.4), fontSize: 12.dp),
            ),
          ),
          SizedBox(
            width: 0.5,
            height: 32.dp,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.white.withAlpha(10)),
            ),
          ),
          Container(
              alignment: Alignment(0, 0),
              width: MediaQuery.of(context).size.width / 5 + 10,
              child: Text(
                "金额",
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.4), fontSize: 12.dp),
              )),
          SizedBox(
            width: 0.5,
            height: 32.dp,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.white.withAlpha(10)),
            ),
          ),
          Container(
            alignment: Alignment(0, 0),
            width: MediaQuery.of(context).size.width / 5 - 22,
            child: Text(
              "删除",
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.4), fontSize: 12.dp),
            ),
          ),
        ],
      ),
    );
  }
}
