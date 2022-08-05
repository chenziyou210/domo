// ignore_for_file: must_be_immutable, invalid_use_of_protected_member
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spring/spring.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/fly_widget.dart';
import 'package:star_common/common/counter_widget.dart';
import 'package:star_common/common/storage.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_common/http/cache.dart';
import 'package:star_common/manager/user/user_balance_logic.dart';
import 'package:star_live/pages/live_room/view/room_info_page/room_live_game/room_base_game/room_game_tools.dart';
import 'package:star_live/star_live.dart';

import '/pages/live_room/view/room_info_page/room_live_game/room_live_game_state.dart';
import 'room_base_game_logic.dart';
import 'room_base_game_state.dart';
import 'toggle_tab.dart';

/// @description:
/// @author
/// @date: 2022-06-20 17:10:52
class RoomBaseGamePage extends StatelessWidget {
  final RoomBaseGameLogic logic = Get.put(RoomBaseGameLogic());
  final RoomBaseGameState state = Get.find<RoomBaseGameLogic>().state;
  String? roomId;

  ///是否是主播
  final bool? isAnchor;
  RoomLiveGameList data;
  Widget? controlWidget;
  Widget? chatBox;
  Widget? pauseWidget;
  Widget? chatWidget;

  // Function(double) callheight;
  Function(bool)? _callShowChat;
  Function(Function(bool))? callShowChat;
  var globalKey = GlobalKey();
  var globalCoin = GlobalKey();

  RoomBaseGamePage(
      {Key? key,
      this.controlWidget,
      this.callShowChat,
      this.pauseWidget,
      this.chatWidget,
      bool isPaused = false,
      this.chatBox,
      this.roomId,
      required this.data,
      // required this.callheight,
      required this.isAnchor})
      : super(key: key) {
    state.pauseOrStart = isPaused.obs;
  }

  @override
  Widget build(BuildContext context) {
    _callShowChat = (bool) {
      logic.state.holdGame50.value = bool;
    };

    if (callShowChat != null) {
      callShowChat!(_callShowChat!);
    }
    state.roomId = StorageService.to.getString("roomId");
    state.data = this.data;
    state.isAnchor = isAnchor;
    // callheight(state.viewHeight + MediaQuery.of(context).padding.bottom);
    state.widgetHeight = MediaQuery.of(context).size.height;
    state.safeHeight = AppLayout.statusBarHeight + AppLayout.safeBarHeight;
    return GetBuilder<RoomBaseGameLogic>(
      init: logic,
      global: false,
      builder: ((c) {
        return Container(
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.dp),
                topRight: Radius.circular(15.dp)),
          ),
          child: chatWidget == null
              ? body(context, c)
              : Obx(
                  () => body(context, c),
                ),
        );
      }),
    );
  }

  ///顶部投注记录,开奖记录,玩法,切换
  Widget topWidget(RoomBaseGameLogic c) {
    return Stack(
      children: [
        Container(
          height: 32.dp,
          decoration: BoxDecoration(
            color: Color(0xff13131d).withAlpha(153),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.dp),
                topRight: Radius.circular(15.dp)),
          ),
        ),
        Container(
          height: 32.dp,
          padding: EdgeInsets.only(left: 20.dp, right: 20.dp),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(30, 30, 30, 0.8),
                  offset: Offset(0, 3),
                  spreadRadius: 0.5,
                  blurRadius: 0),
              BoxShadow(
                  color: Color.fromRGBO(19, 19, 29, 0.6),
                  offset: Offset(0, 3),
                  spreadRadius: 0.5,
                  blurRadius: 0)
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.dp),
                topRight: Radius.circular(15.dp)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Offstage(
                  offstage: isAnchor == true,
                  child: Row(
                    children: [
                      titleIcon(c.state.bettingShow && state.height >= 108.dp,
                              "投注记录")
                          .inkWell(onTap: () {
                        logic.showRecords(1);
                      }),
                      SizedBox(
                        width: 20.dp,
                      )
                    ],
                  )),
              titleIcon(c.state.prizeDrawsShow && state.height >= 108.dp, "开奖记录")
                  .inkWell(onTap: () {
                logic.showRecords(2);
              }),
              SizedBox(
                width: 20.dp,
              ),
              Text(
                "玩法",
                style: TextStyle(
                    color: AppMainColors.whiteColor70, fontSize: 12.sp),
              ).inkWell(onTap: () {
                logic.showPlay();
              }),
              Spacer(),
              logic.isMore()
                  ? Text(
                      state.height > 108.dp ? "收起记录" : "查看更多",
                      style: TextStyle(
                          color: Color.fromRGBO(50, 197, 255, 1),
                          fontSize: 12.sp),
                    ).inkWell(onTap: (() {
                      state.height > 108.dp
                          ? logic.collectMore()
                          : logic.viewMore();
                    }))
                  : Row(children: [
                      Image.asset(
                        R.icLittleGame,
                        width: 18.dp,
                        height: 18.dp,
                      ),
                      SizedBox(
                        width: 4.dp,
                      ),
                      Text(
                        '切换',
                        style: TextStyle(
                            color: AppMainColors.whiteColor70, fontSize: 12.sp),
                      ),
                    ]).inkWell(onTap: () {
                      logic.showToggle(
                        controlWidget,
                        chatBox,
                      );
                    }),
            ],
          ),
        )
      ],
    );
  }

  Widget titleIcon(bool selete, String title) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
              color:
                  selete ? AppMainColors.mainColor : AppMainColors.whiteColor70,
              fontSize: 12.sp),
        ),
        Icon(
          selete ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          size: 18.dp,
          color: AppMainColors.whiteColor70,
        )
      ],
    );
  }

  //投注记录,开奖记录
  Widget records() {
    return Offstage(
        offstage: state.height == 0,
        child: RefreshIndicator(
            displacement: 0,
            color: Colors.transparent,
            strokeWidth: 0,
            onRefresh: () async {
              logic.refreshNetData();
            },
            child: Container(
              height: state.height,
              color: Color(0xCC161722),
              child: logic.itemCount() == 0
                  ? EmptyView(
                emptyType: EmptyType.noData,
                imagePaddingBottom: 30.dp,
              ).gestureDetector(onTap: () {
                logic.noDataRefresh();
              })
                  : ListView.builder(
                controller: state.controller,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return recordsItem(index);
                },
                itemCount: logic.itemCount(),
              ).marginOnly(top: 10.dp),
            )));
  }

  ///历史
  Widget recordsItem(int index) {
    return Container(
        height: logic.resultHeight() + 0.5.dp,
        margin:
            EdgeInsets.only(left: 16.dp, right: data.id == 5.dp ? 0 : 16.dp),
        child: Column(
          children: [
            logic.gameResult(index),
            Spacer(),
            Container(
              color: state.prizeDrawsShow == true
                  ? AppMainColors.whiteColor6
                  : Colors.transparent,
              height: 0.5.dp,
            )
          ],
        ));
  }

  //本期数据
  Widget currentData() {
    return Container(
      height: 56.dp,
      margin: EdgeInsets.only(top: 12.dp),
      child: Row(
        children: [
          FadeInImage(
            width: 54.dp,
            height: 54.dp,
            fit: BoxFit.fill,
            placeholder: AssetImage(R.gamePlaceholder),
            image: NetworkImage(data.icon ?? ""),
          ),
          SizedBox(
            width: 8.dp,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                //游戏名称
                data.name!,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              Obx(() => RichText(
                      //倒计时
                      text: TextSpan(
                          text: logic.statetype(),
                          style: TextStyle(color: AppMainColors.whiteColor40),
                          children: [
                        TextSpan(
                            text: logic.time(),
                            style: TextStyle(color: logic.timeColor()))
                      ])))
            ],
          ),
          Flexible(
            child: logic.gameResutl(),
            flex: 1,
          )
        ],
      ),
    );
  }

  ///投注列表
  Widget bettingList(BuildContext context) {
    return Obx(() => Container(
          padding: EdgeInsets.only(top: 24.dp),
          child: Column(
            children: [
              if (logic.state.oddsLabels.length != 0)
                Stack(
                  children: [
                    ToggleTab(
                      height: 32.dp,
                      width: context.width - 36.dp,
                      isShadowEnable: false,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      selectedIndex: state.selectedIndex.value,
                      selectedLabelIndex: (index) {
                        logic.selectedIndex(index);
                      },
                      selectedBackgroundColors: [
                        Color.fromRGBO(197, 251, 255, 1),
                        Color.fromRGBO(236, 212, 255, 1),
                        Color.fromRGBO(255, 255, 255, 1)
                      ],
                      unSelectedBackgroundColors: [
                        Colors.transparent,
                      ],
                      selectedTextStyle: TextStyle(
                          color: Color.fromRGBO(16, 16, 16, 1),
                          shadows: [
                            Shadow(
                                color: Color(0x69072757),
                                offset: Offset(0, 3.dp),
                                blurRadius: 6.dp)
                          ],
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold),
                      unSelectedTextStyle: TextStyle(
                          color: AppMainColors.whiteColor70, fontSize: 12.dp),
                      labels: state.oddsLabels,
                    ),
                    if(state.actBetAnimType.value > 0)
                      Container(color: Colors.transparent,
                        height: 32.dp,
                        width: context.width - 36.dp,)
                  ],
                ),
              if (state.odds.value.odds?.length != 0)
                Container(
                  height: 132.dp,
                  padding: EdgeInsets.only(top: 10.dp),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: state.crossAxisCount.value, //每行几个
                      childAspectRatio: state.childAspectRatio.value, //
                    ),
                    itemCount: state.odds.value.odds?.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      GameOdds? odd = state.odds.value.odds?[index];
                      return RepaintBoundary(
                        key: state.odds.value.odds?[index].global,
                        child: item(odd, index).gestureDetector(onTap: () {
                          print('-state.actBetAnimType.value = Anh ${state.actBetAnimType.value}');
                          if(state.actBetAnimType.value == 0 && (odd?.listCoin.length ?? 0) == 0)
                            logic.selectedItemIndex(index);
                        }),
                      );
                    },
                  ),
                )
            ],
          ),
        ));
  }

  Widget item(GameOdds? odd, int index) {
    return state.odds.value.odds?.length == 0
        ? Container()
        : Obx(() => Container(
              margin: EdgeInsets.all(4.dp),
              alignment: Alignment(0, 0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(odd?.selected == true
                          ? R.selectBoxGame
                          : R.deselectBoxGame))),
              child: Stack(
                alignment: Alignment(0, 0),
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      data.id == 4 //鱼虾蟹
                          ? logic.yuxiaxie(index)
                          : RoomGameTools.oddName(
                              odd?.name ?? "",
                              state.oddsLabels.length > 0
                                  ? state.oddsLabels[state.selectedIndex.value]
                                  : ""),
                      SizedBox(
                        height: data.id == 4
                            ? 1.dp
                            : (state.crossAxisCount > 4 ? 2.dp : 8.dp),
                      ),
                      Text("${odd?.odds}",
                          style: AppStyles.number(
                              (state.crossAxisCount > 4 || data.id == 4)
                                  ? 12.sp
                                  : 16.sp,
                              color: odd?.selected == true
                                  ? Colors.white
                                  : AppMainColors.adornColor)),
                      if (data.id == 4)
                        SizedBox(
                          height: 2.dp,
                        ),
                    ],
                  ),
                  Container(
                      child: Obx(() =>
                          Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              for (var i = 0;
                              i <
                                  (state.odds.value.odds?[index].listCoin.value.length ??
                                      0);
                              i++)
                                itemCoin(index, i)
                            ],
                          )
                      )
                  )
                ],
              ),
            ));
  }

  //底部 -> 余额,刷新,充值,下注
  Widget bottomWidget(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RepaintBoundary(
            key: globalCoin,
            child: Image.asset(
              R.gameYueIcon,
              width: 16.dp,
              height: 16.dp,
            ),
          ),
          SizedBox(
            width: 5.dp,
          ),
          Obx((){
            double oldVL = Get.find<UserBalanceLonic>().state.oldUserBalance?.balance ?? 0.0;
            double newVL = Get.find<UserBalanceLonic>().state.userBalance.value.balance ?? 0.0;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text(
                  "余额 ",
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
              ),
              CounterText(
                  key: Key('${DateTime.now().microsecond}'),
                  enable: Get.find<UserBalanceLonic>().state.oldUserBalance!=null
                      && oldVL < newVL && state.actBetAnimType.value == 2,
                  oldValue: oldVL,
                  newValue: newVL,
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  callback: (double value) {
                    Get.find<UserBalanceLonic>().state.oldUserBalance?.balance = value;
                  },
              )
              ],);
            },
          ),
          SizedBox(
            width: 10.dp,
          ),
          Spring.rotate(
              springController: state.springCoinsController,
              child: Image.asset(
                R.comShuaxinAssets,
                width: 12.dp,
                height: 12.dp,
              ).inkWell(onTap: () {
                state.springCoinsController.play(motion: Motion.play);
                logic.showAnimation();
              })).marginOnly(right: 18.dp),
          Text(
            "充值",
            style: TextStyle(
                color: AppMainColors.adornColor,
                fontSize: 12.sp,
                fontWeight: w_400),
          ).gestureDetector(onTap: () {
            logic.recharge();
          }),
          Spacer(),
          Container(
            height: 40.dp,
            width: 134.dp,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.dp),
                color: Color(0x0FFFFFFF)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 4.dp,
                ),
                RepaintBoundary(
                  key: globalKey,
                  child: logic.chips(),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_drop_up,
                  color: Color(0x66FFFFFF),
                ),
                Spacer(),
                Image.asset(
                  R.icConfirmButton,
                  width: 56.dp,
                  height: 32.dp,
                  fit: BoxFit.fill,
                ).gestureDetector(onTap: () {
                  if(state.actBetAnimType.value == 0){
                    logic.placeBets();
                  }
                }),
                SizedBox(
                  width: 4.dp,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  body(context, c) {
    bool isOver = 200.dp - state.height <= 0;
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      if (chatBox != null && !isOver)
        SizedBox(
          height: 96.dp,
        ),
      if (chatBox != null && !isOver)
        Flexible(
          child: Stack(
            children: [
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  Future.delayed(Duration(milliseconds: 200), () {
                    heighSheetCallBack?.call(constraints.maxHeight);
                  });
                  return Container(color: Colors.transparent);
                },
              ),
              Container(
                padding: EdgeInsets.only(left: 12.dp, right: 180.dp),
                child: chatBox!,
              ),
              Obx(() => Visibility(
                    child: pauseWidget != null ? pauseWidget! : Container(),
                    visible: state.pauseOrStart.value,
                  ))
            ],
          ),
        ),
      if (controlWidget != null && !isOver)
        Padding(
          padding: EdgeInsets.only(left: 12.dp, right: 12.dp, bottom: 4.dp),
          child: controlWidget!,
        ),
      chatWidget != null && logic.state.holdGame50.value
          ? Padding(
              padding: EdgeInsets.only(bottom: 0.dp),
              child: chatWidget!,
              key: Key("A"),
            )
          : Column(
          key: Key("B"),
          children: [
          if (chatWidget == null || !logic.state.holdGame50.value)
            topWidget(c),
          if (chatWidget == null || !logic.state.holdGame50.value)
            records(),
          if (chatWidget == null || !logic.state.holdGame50.value)
            Container(
                color: Color(0xE6161722),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        currentData().paddingOnly(left: 16.dp),
                        bettingList(context)
                            .paddingSymmetric(horizontal: 16.dp),
                        Offstage(
                          offstage: isAnchor == true,
                          child: bottomWidget(context)
                              .paddingSymmetric(horizontal: 16.dp),
                        ),
                        SizedBox(
                          height: 16.dp,
                        )
                      ],
                    ),
                    Positioned(
                      child: LayoutBuilder(builder: (c, b) {
                        print('NEO  state.actBetAnimType.value = ${state.actBetAnimType.value}');
                        return Obx((){
                          return Offstage(offstage: state.actBetAnimType.value == 0,
                            child: _itemFly(c, b));
                        });
                      }),
                      bottom: 15.5.dp,
                      top: 133.dp,
                      left: 15.dp,
                      right: 20.dp,
                    )
                  ],
                ))
        ],
      ),
    ]);
  }

  Widget itemCoin(int index, int i) {
    CoinItem? coin = state.odds.value.odds?[index].listCoin.value[i];
    var rng = Random();
    if (coin == null) return Container();
    if (coin.w != -1) {
      return Positioned(
        child: Container(
          child: Image.asset(_getCoinImage(coin.value.toInt()),
              fit: BoxFit.fill),
          width: coin.w,
          height: coin.h,
        ),
        top: coin.y,
        left: coin.x,
      );
    } else {
      return Container(
        child: LayoutBuilder(
          builder: (c, b) {
            final x = rng.nextInt(b.maxHeight.toInt() - b.maxHeight ~/ 3)
                .toDouble();
            final y = rng
                .nextInt(b.maxWidth.toInt() - b.maxWidth ~/ 3)
                .toDouble();
            final w = b.maxHeight / 3;
            final h = b.maxHeight / 3;
            state.odds.value.odds?[index].listCoin.value[i].x = x;
            state.odds.value.odds?[index].listCoin.value[i].y = y;
            state.odds.value.odds?[index].listCoin.value[i].w = w;
            state.odds.value.odds?[index].listCoin.value[i].h = h;

            coin = state.odds.value.odds?[index].listCoin.value[i];
            AppCacheManager.cache.setBetCoin('${state.roomId}_${state.odds.value.odds![index].id}',
                jsonEncode(state.odds.value.odds![index].listCoin.value));
            return Stack(
              children: [
                Positioned(
                  child: Container(
                    width: b.maxHeight / 3,
                    height: b.maxHeight / 3,
                    child: Image.asset(_getCoinImage(coin?.value.toInt()),
                        fit: BoxFit.fill),
                  ),
                  top: coin?.y,
                  left: coin?.x,
                )
              ],
            );
          },
        ),
      );
    }
  }

  Widget recallFly(c, b, index, type, GameOdds item) {
    List<CoinItem> list = List.empty(growable: true)..addAll(item.listSavedCoin);

    return Stack(
      children: [
        for (int i = 0; i < list.length; i++)
          Fly(
            key: Key('${DateTime.now().microsecond}'),
            context: c,
            value: list[i].value,
            icon: _getCoinImage(list[i].value.toInt()),
            callback: (v) {
              //do nothing
            },
            constraint: b,
            animationDuration: Duration(milliseconds: 500),
            global: globalKey,
            xParentDest: list[i].x,
            yParentDest: list[i].y,
            globalCoin: globalCoin,
            iconDisplay: logic.chipsBet(),
            globalList: item.global,
            type: type,
            child: Image.asset(_getCoinImage(list[i].value.toInt()),
                width: 28.dp, height: 28.dp, fit: BoxFit.fill),
          )
      ],
    );
  }
  Widget itemFlyBet(c, b, index, bool selected, type) {
    if (!selected) return Container();
    GameOdds item = state.odds.value.odds![index];
    Widget child = Container();
    logic.betArr.forEach((element) {
      if (element['oddsId'] == item.id) {
       if(type == 1){
          child = createFly(b, c, element, index, type);
        }else {
         child = recallFly(c, b, index, item.isWining ? 2 : 3, item);
        }
      }
      Future.delayed(Duration(
          milliseconds: type == 1 ? 500 : 800), () {
        state.actBetAnimType.value = 0;
      });
    });
    return child;
  }

  _getCoinImage(coin) {
    for (int i = 0; i < state.mulNum.length; i++) {
      if (state.mulNum[i] == '$coin') return state.mul[i];
    }
    return R.mulConfig;
  }

  _itemFly(c,b) {
    return Stack(children: [
      for (int i = 0;
      i <
          (state.odds.value.odds?.length ??
              0);
      i++)
        itemFlyBet(
            c,
            b,
            i,
            state.odds.value.odds?[i]
                .selected ??
                false,
            state.actBetAnimType.value)
    ],);
  }

  Widget createFly(b,c, element, index, type) {
    var amount = element['betAmount'];
    final listCoins = List.empty(growable: true);
    logic.state.mulNum.forEach((element) {
      listCoins.add(int.tryParse(element));
    });
    // final otherCoin = AppCacheManager.cache.getMultiplier();
    // if (otherCoin != null && otherCoin.isNotEmpty) {
    //   listCoins.add(int.parse(otherCoin));
    // }
    listCoins.sort();
    final listRs = List.empty(growable: true);
    for (int i = listCoins.length - 1; i >= 0; i--) {
      while (listCoins[i] <= amount && amount > 0) {
        listRs.add(
            {'coin': listCoins[i], 'icon': _getCoinImage(listCoins[i])});
        amount -= listCoins[i];
      }
    }
    return Stack(
      children: [
        for (int i = 0; i < listRs.length; i++)
          Fly(
            key: Key('${DateTime.now().microsecond}'),
            context: c,
            value: listRs[i]['coin'].toDouble(),
            icon: listRs[i]['icon'],
            callback: (v) {
              state.odds.value.odds![index].listCoin.add(v);
              AppCacheManager.cache.setBetCoin('${state.roomId}_${state.odds.value.odds![index].id}',
                  jsonEncode(state.odds.value.odds![index].listCoin));
            },
            constraint: b,
            global: globalKey,
            globalCoin: globalCoin,
            iconDisplay: logic.chipsBet(),
            globalList: state.odds.value.odds![index].global,
            type: type,
            child: Image.asset(listRs[i]['icon'],
                width: 28.dp, height: 28.dp, fit: BoxFit.fill),
          )
      ],
    );
  }
}
