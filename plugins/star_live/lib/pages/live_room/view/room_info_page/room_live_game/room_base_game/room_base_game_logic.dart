// ignore_for_file: unnecessary_brace_in_string_interps, must_be_immutable, unused_element, deprecated_member_use
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:alog/alog.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';
import 'package:star_common/common/fly_widget.dart';
import 'package:star_common/common/storage.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_common/http/cache.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/manager/user/user_balance_logic.dart';

import '/pages/live_room/view/room_info_page/room_live_game/game_net_work.dart';
import '/pages/live_room/view/room_info_page/room_live_game/room_base_game/room_game_tools.dart';
import '/pages/live_room/view/room_info_page/room_live_game/room_game_bet/room_game_bet_view.dart';
import '/pages/live_room/view/room_info_page/room_live_game/room_live_game_view.dart';
import '/pages/recharge/recharge/recharge_view.dart';
import '../../../../live_room_new_logic.dart';
import '../game_net_work.dart';
import 'game_how_to_play/view.dart';
import 'room_base_game_state.dart';
/// @description:
/// @author
/// @date: 2022-06-20 17:10:52
class RoomBaseGameLogic extends GetxController
    with SingleGetTickerProviderMixin, Toast {
  final state = RoomBaseGameState();
  Timer? _timer;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (AppCacheManager.cache.getMultiplier() != null &&
        (AppCacheManager.cache.getMultiplier()?.length ?? 0) > 0) {
      if (state.mulNum.contains(AppCacheManager.cache.getMultiplier())) {
        //设定的筹码
        for (var i = 0; i < state.mulNum.length; i++) {
          if (state.mulNum[i] == AppCacheManager.cache.getMultiplier()) {
            state.chips = double.parse(state.mulNum[i]);
            state.chipsImage = state.mul[i];
          }
        }
      } else {
        //自定义筹码
        state.chips = double.parse(AppCacheManager.cache.getMultiplier()!);
        state.chipsImage = R.mulConfig;
      }
      update();
    }
    Get.find<LiveRoomNewLogic>().closeGameBackView = (payload) {
      Get.back();
    };
  }

//投注
  List<Map<String, dynamic>> betArr = [];
  getBetting(List<GameOdds> listOdds, mu, String issueIdVL) {
    if (state.countdownTime.value <= 6) {
      showToast("暂时不可投注!");
      return;
    }
    String issueId = "${(int.parse(issueIdVL) + 1)}";
    //投注项
    betArr = [];
    var gameId = listOdds.first.gameId ?? 0;
    var gameName = listOdds.first.gameName ?? "";
    listOdds.forEach((element) {
      print('NEO listOdds - $element');
      betArr.add({
        "betAmount": this.state.chips * mu,
        "oddsId": element.id,
        "optionId": element.optionId
      });
    });

    if ((Get.find<UserBalanceLonic>().state.userBalance.value.balance ?? 0.0) ==
        0 ||
        (Get.find<UserBalanceLonic>().state.userBalance.value.balance ?? 0.0) <
            this.state.chips * mu * listOdds.length) {
      showToast("余额不足,请先充值");
      return;
    }

    //Future.delayed(Duration(seconds: 1), (){
      List<String> odds = [];
      listOdds.forEach((element) {
        odds.add(json.encode(element.toJson()));
      });
      HttpChannel.channel.gameRoomBetting(
          StorageService.to.getString("roomId"),
          gameId,
          issueId,
          GameNetWork.shared.userid,
          gameName,
          betArr,
          json.encode(odds))
        ..then((value) => value.finalize(
            wrapper: WrapperModel(),
            failure: (e) {
              Alog.d(e);
              if (e.length > 15) {
                showToast("暂时无法下注");
                return;
              }
              showToast(e);
            },
            success: (data) async {
              showToast("投注成功");
              prepareAnimBet();
              ///投注成功,获取用户信息
              Get.find<UserBalanceLonic>().userBalanceData();
              //Get.back(result: "userBalance");
            }));
    //});
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    _timer?.cancel();
  }

  @override
  void onReady() {
    super.onReady();
    GameNetWork.shared.eventBus.on<GameMqttData>().listen((event) {
      if (event.data?.gameId == state.data?.id) {
        //过滤游戏ID
        state.setUpdateFirstResult(event.data!);
        try{
          final isSplitMode = Get.find<LiveRoomNewLogic>().state.roomSplit.value;
          if(isSplitMode){
            //CALL WHEN GET PAYLOAD GAME RESULT FROM SERVER
            endGame(event.data!);
          }
        }catch(e){
          print(e);
        }
      }
    });
    if (StorageService.to.getString("gameId${state.data?.id}").isNotEmpty &&
        state.oddsList.length == 0) {
      String jsonStr = StorageService.to.getString("gameId${state.data?.id}");
      Map map = json.decode(jsonStr);
      List list = map["list"];
      List<GameOddsList> odds = [];
      list.forEach((element) {
        odds.add(GameOddsList.fromJson(element));
      });
      state.setUpdateOddsList(odds);
      state.setUpdateOdds(state.oddsList.first);
      state.gridViewSetting();
      List<String> names = [];
      state.oddsList.forEach((element) {
        names.add(element.name!);
      });
      state.setUpdateOddsLabels(names);
    }
    startCountdownTimer();
    getGameResult();
    getGameOdds();
    if (state.isAnchor == false) {
      getGameOrder();
    }
    state.controller.addListener(() {
      //加载数据
      if (state.controller.position.pixels ==
          state.controller.position.maxScrollExtent) {
        loadingNetData();
      }
    });
  }

  void startCountdownTimer() {
    GameNetWork.shared.getGameTimestamp((s) {
      state.setUpdateCountdownTime(59 - s);
    });
    _timer?.cancel();
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (state.countdownTime.value <= 0) {
        // state.setUpdateCountdownTime(59);
        startCountdownTimer();
      } else {
        state.setUpdateCountdownTime(state.countdownTime.value - 1);
      }
    });
  }

  //获取开奖记录
  getGameResult() {
    GameNetWork.shared
        .getGameResult(state.data?.id ?? 0, state.resultPage)
        .then((value) {
      if (value.data == null) {
        return;
      }
      List list = value.data;
      if (list.length == 0) {
        return;
      }
      for (var i = 0; i < list.length; i++) {
        state.resultList.add(GameDataResult.fromJson(list[i]));
        update();
        if (i == 0 && state.resultPage == 1) {
          state.setUpdateFirstResult(GameDataResult.fromJson(list[i]));
        }
      }
    });
  }

  ///获取投注记录
  getGameOrder() {
    GameNetWork.shared
        .getGameOrder(state.data?.id ?? 0, state.orderPage)
        .then((value) {
      if (value.data == null) {
        return;
      }
      int total = int.parse("${value.data["page"]["total"]}");
      if (state.orderList.length >= total) {
        return;
      }
      List list = value.data["list"];
      if (list.length > 0) {
        list.forEach((element) {
          state.orderList.add(GameOrderList.fromJson(element));
        });
        update();
      }
    });
  }

//显示投注记录,开奖记录
  showRecords(int index) {
    if (state.height == 0) {
      state.bettingShow = false;
      state.prizeDrawsShow = false;
    }
    if (index == 1) {
      state.bettingShow = !state.bettingShow;
      state.prizeDrawsShow = false;
      state.height = state.bettingShow ? 108.dp : 0;
    } else {
      state.prizeDrawsShow = !state.prizeDrawsShow;
      state.bettingShow = false;
      state.height = state.prizeDrawsShow ? 108.dp : 0;
    }
    update();
  }

  ///显示或者隐藏查看更多
  bool isMore() {
    return state.height >= 108.dp;
  }

  //切换
  showToggle(controlWidget, chatBox) {
    Get.back();
    Get.bottomSheet(
        RoomLiveGamePage(
          controlWidget: controlWidget,
          chatBox: chatBox,
          isAnchor: state.isAnchor,
        ),
        barrierColor: Colors.transparent);
    state.resultList.clear();
  }

  ///查看更多记录
  viewMore() {
    state.height = 322.dp;
    update();
  }

  //收起更多记录
  collectMore() {
    state.height = 0;
    update();
  }

  ///刷新
  refreshNetData() {
    if (state.prizeDrawsShow) {
      state.resultList.clear();
      //开奖历史
      state.resultPage = 1;
      getGameResult();
    } else if (state.bettingShow) {
      state.orderList.clear();
      //投注记录
      state.orderPage = 1;
      getGameOrder();
    }
  }

  // ///加载
  loadingNetData() {
    if (state.prizeDrawsShow) {
      //开奖历史
      state.resultPage += 1;
      getGameResult();
    } else if (state.bettingShow) {
      //投注记录
      state.orderPage += 1;
      getGameOrder();
    }
  }

  noDataRefresh() {
    refreshNetData();
    show();
    Future.delayed(Duration(seconds: 2), () {
      dismiss();
    });
  }

  int itemCount() {
    if (state.prizeDrawsShow) {
      //开奖历史
      return state.resultList.length;
    } else if (state.bettingShow) {
      //投注记录
      return state.orderList.length;
    }
    return 0;
  }

  //期数
  String numberIssues(int index) {
    if (state.prizeDrawsShow) {
      //开奖历史
      return (state.resultList[index].issueId ?? "") + "期";
    } else if (state.bettingShow) {
      //投注记录
      return state.orderList.length > index
          ? (state.orderList[index].issueId ?? "") + "期"
          : "";
    }
    return "";
  }

  //开奖记录的定制高度
  double resultHeight() {
    if (state.bettingShow) {
      return 36;
    } else if (state.prizeDrawsShow) {
      if (state.data?.id == 1) {
        return 36;
      } else if (state.data?.id == 2 || state.data?.id == 6) {
        return 58;
      } else if (state.data?.id == 3) {
        return 61;
      } else if (state.data?.id == 4) {
        return 48;
      } else if (state.data?.id == 5) {
        return 68;
      }
    }
    return 0;
  }

  Alignment alignment() {
    if (state.data?.id == 1 || state.data?.id == 4 || state.data?.id == 5) {
      return Alignment.center;
    } else {
      return Alignment.topLeft;
    }
  }

  Widget gameResult(int index) {
    if (state.prizeDrawsShow) {
      //开奖历史
      return state.resultList.length > index
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(
                      0, alignment() == Alignment.center ? 0 : 7, 0, 7),
                  alignment: alignment(),
                  height: resultHeight(),
                  child: Text(
                    numberIssues(index),
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                ),
                RoomGameTools.lotteryRecords(
                    state.resultList[index], state.data!.id!)
              ],
            )
          : Container();
    } else if (state.bettingShow) {
      return state.orderList.length > index
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  numberIssues(index),
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                ),
                Text(
                  state.data?.name ?? "",
                  style: TextStyle(
                      color: AppMainColors.whiteColor70, fontSize: 12.sp),
                ),
                Text(
                  "-${state.orderList[index].betAmount ?? 0.00}",
                  style: TextStyle(
                      color: Color.fromRGBO(120, 255, 166, 1), fontSize: 12.sp),
                ),
                Text(
                  state.orderList[index].status == 1
                      ? "待开奖"
                      : "${state.orderList[index].realAmount ?? 0.00}",
                  style: TextStyle(
                      color: AppMainColors.mainColor, fontSize: 12.sp),
                ),
                Text(
                  state.orderList[index].status == 1 ? "" : "续投",
                  style: TextStyle(
                      color: Color.fromRGBO(238, 255, 135, 1), fontSize: 12.sp),
                ).gestureDetector(
                  onTap: () {
                    var odds = GameOdds(
                        id: state.orderList[index].oddsId,
                        optionId: state.orderList[index].optionId,
                        gameId: state.data!.id,
                        issueId: state.firstResult.value.issueId,
                        odds: state.orderList[index].odds,
                        gameName: state.data?.name,
                        chips: "${state.orderList[index].betAmount}",
                        name: state.orderList[index].oddsName,
                        oddName: state.orderList[index].optionName);
                    betting([odds]);
                  },
                ),
              ],
            )
          : Container();
    }
    return Container();
  }

  ///玩法赔率
  getGameOdds() {
    GameNetWork.shared.getGameOdds(state.data?.id ?? 0).then((value) {
      if (value.data != null) {
        List list = value.data;
        List<GameOddsList> odds = [];
        list.forEach((element) {
          odds.add(GameOddsList.fromJson(element));
        });
        state.setUpdateOddsList(odds);
        state.setUpdateOdds(state.oddsList.first);
        state.gridViewSetting();
        List<String> names = [];
        state.oddsList.forEach((element) {
          names.add(element.name!);
        });
        state.setUpdateOddsLabels(names);
      }
    });
  }

  //选择游戏
  selectedIndex(int index) {
    state.setUpdateSelectedIndex(index);
    if (state.oddsList.length > index) {
      state.setUpdateOdds(state.oddsList[index]);
      state.gridViewSetting();
    }
  }

  Widget yuxiaxie(int id) {
    return state.selectedIndex == 0
        ? Image.asset(
            state.yuxiaxieImgs[id],
            width: 36.dp,
            height: 36.dp,
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                state.yuxiaxieImgs[id],
                width: 28.dp,
                height: 28.dp,
              ),
              Image.asset(
                state.yuxiaxieImgs[id],
                width: 28.dp,
                height: 28.dp,
              ),
              Image.asset(
                state.yuxiaxieImgs[id],
                width: 28.dp,
                height: 28.dp,
              )
            ],
          );
  }

  //选择投注的item
  selectedItemIndex(int index) {
    state.odds.value.odds?[index].selected =
        !state.odds.value.odds![index].selected;
    update();
  }

  ///充值
  recharge() {
    Get.to(() => RechargePage(true))?.then((value) {
      Get.find<UserBalanceLonic>().userBalanceData();
    });
  }

  //投注
  placeBets() {
    List<GameOdds> betOdds = [];
    state.oddsList.forEach((element) {
      element.odds?.forEach((e) {
        if (e.selected == true) {
          e.gameName = state.data?.name;
          e.oddName = element.name;
          e.chips = "${state.chips}";
          e.gameId = state.data?.id;
          e.optionId = element.id;
          e.issueId = state.firstResult.value.issueId;
          betOdds.add(e);
        }
      });
    });
    if (betOdds.length == 0) {
      showToast("请选择投注项");
      return;
    }
    betting(betOdds);
  }

  //投注
  betting(List<GameOdds> betOdds) {
    Get.bottomSheet(
            RoomGameBetPage(
              odds: betOdds,
            ),
            barrierColor: Colors.transparent)
        .then((value) {
      if (value == "userBalance") {
        update();
      }
    });
  }

  Widget chips() {
    if (AppCacheManager.cache.getMultiplier() == null ||
        (AppCacheManager.cache.getMultiplier()?.length ?? 0) == 0) {
      return Image.asset(
        state.chipsImage,
        width: 32.dp,
        height: 32.dp,
        key: state.imegeKey,
      ).gestureDetector(onTap: () {
        selectChips();
      });
    } else {
      return state.mulNum.contains(AppCacheManager.cache.getMultiplier())
          ? Image.asset(
              state.chipsImage,
              width: 32.dp,
              height: 32.dp,
              key: state.imegeKey,
            ).gestureDetector(onTap: () {
              selectChips();
            })
          : itemCustom().gestureDetector(onTap: () {
              selectChips();
            });
    }
  }
  Widget chipsBet() {
    if (AppCacheManager.cache.getMultiplier() == null ||
        (AppCacheManager.cache.getMultiplier()?.length ?? 0) == 0) {
      return Image.asset(
        state.chipsImage,
        width: 32.dp,
        height: 32.dp,
      );
    } else {
      String? mul = AppCacheManager.cache.getMultiplier();
      return state.mulNum.contains(AppCacheManager.cache.getMultiplier())
          ? Image.asset(
        state.chipsImage,
        width: 32.dp,
        height: 32.dp,
      ): Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Image.asset(
              R.mulConfig,
              width: 32,
              height: 32),
          Text(
            mul ?? "",
            style: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold),
          )
        ],
      );
    }
  }
  ///自定义的筹码
  Widget itemCustom() {
    String? mul = AppCacheManager.cache.getMultiplier();
    return Container(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Image.asset(
            R.mulConfig,
            width: 32,
            height: 32,
            key: state.imegeKey,
          ),
          Text(
            mul ?? "",
            style: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  //选择筹码
  selectChips() {
    RenderBox? renderBox =
        state.imegeKey.currentContext?.findAncestorRenderObjectOfType();
    var offset = renderBox?.localToGlobal(Offset.zero);
    Get.bottomSheet(
            ChipWidget(offset!, (text) {
              //自定义筹码返回的数字
              if (text.length > 0) {
                state.chips = double.parse(text);
                state.chipsImage = R.mulConfig;
                AppCacheManager.cache.setMultiplier(text);
                update();
              }
            }),
            barrierColor: Colors.transparent)
        .then((value) {
      //选中的筹码
      if (value != null) {
        if (state.mulNum.contains(value)) {
          for (var i = 0; i < state.mulNum.length; i++) {
            if (state.mulNum[i] == value) {
              state.chips = double.parse("$value");
              state.chipsImage = state.mul[i];
              AppCacheManager.cache.setMultiplier(value);
            }
          }
        } else {
          state.chips = double.parse(value);
          state.chipsImage = R.mulConfig;
          AppCacheManager.cache.setMultiplier(value);
        }
      }
      update();
    });
  }

  String time() {
    return "00:" +
        (state.countdownTime.value >= 10
            ? "${state.countdownTime.value}"
            : "0${state.countdownTime.value}");
  }

  String statetype() {
    return state.countdownTime.value > 5 ? "本期 " : "封盘 ";
  }

  Color timeColor() {
    return state.countdownTime.value > 5
        ? Color.fromRGBO(120, 255, 166, 1)
        : Color.fromRGBO(255, 30, 175, 1);
  }

  //玩法
  showPlay() {
    var view = Container(
      child: ClipRRect(
        // borderRadius: BorderRadius.all(Radius.circular(16.dp)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            height: 272.dp,
            color: Color.fromRGBO(22, 23, 34, 0.9),
            child: SingleChildScrollView(
              child: Html(
                data: state.data?.description ?? "",
                style: {"p": Style(color: Colors.white)}, //文字颜色
              ),
            ).marginOnly(left: 5, right: 5),
          ),
        ),
      ),
    );
    Get.bottomSheet(
        GameHowToPlayPage(view),
        persistent: true,
        barrierColor: Colors.transparent);
  }


  //刷新余额
  showAnimation() {
    Get.find<UserBalanceLonic>().userBalanceData();
  }

  //最近游戏数据
  Widget gameResutl() {
    return Obx(() {
      if (state.countdownTime.value <= 5) {
        if (state.data!.id! == 5) {
          //牛牛
          var data = GameDataResult(number: state.resultNiuNIu());
          return RoomGameTools.gameResutl(data, state.data!.id!)
              .paddingOnly(right: 0.05.dp);
        }
        if (state.resultList.length == 0) return Container();
        var data = state.resultList[Random().nextInt(state.resultList.length)];
        return RoomGameTools.gameResutl(data, state.data!.id!)
            .paddingOnly(right: 16.dp);
      }
      return RoomGameTools.gameResutl(state.firstResult.value, state.data!.id!)
          .paddingOnly(right: state.data!.id! == 5 ? 0.05.dp : 16.dp);
    });
  }

  void prepareAnimBet() {
    print('NEO - oddsList = START');
    AppCacheManager.cache.setTimeBetCoin('${state.roomId}_time_bet',
        '${DateTime.now().microsecondsSinceEpoch}');
    final timeCount = Get.find<LiveRoomNewLogic>().lotteryCount.value;
    AppCacheManager.cache.setTimeCountBetCoin('${state.roomId}_time_count_bet',
        '${timeCount}');
    state.oddsList.forEach((element) {
      if(element.id != state.odds.value.id){
        element.odds?.forEach((item) {
          betArr.forEach((bet) {
            if (bet['oddsId'] == item.id) {
              var amount = bet['betAmount'];
              final listCoins = List.empty(growable: true);
              state.mulNum.forEach((num) {
                listCoins.add(int.tryParse(num));
              });

              // final otherCoin = AppCacheManager.cache.getMultiplier();
              // if (otherCoin != null && otherCoin.isNotEmpty) {
              //   listCoins.add(int.parse(otherCoin));
              // }
              listCoins.sort();
              for (int i = listCoins.length - 1; i >= 0; i--) {
                while (listCoins[i] <= amount && amount > 0) {
                  item.listCoin.add(CoinItem(DateTime.now().microsecondsSinceEpoch,
                      -1, -1, -1, -1, listCoins[i].toDouble()));
                  amount -= listCoins[i];
                }
              }
              AppCacheManager.cache.setBetCoin('${state.roomId}_${item.id}', jsonEncode(item.listCoin));
            }
          });
        });
      }
    });
    print('NEO - oddsList111 = DONE');
    state.actBetAnimType.value = 1;
  }

  void endGame(GameDataResult value){
    //calculate if game is win or lose.
    state.actBetAnimType.value = 0;
    var rs = Map<String, bool>();
    switch(value.gameId){
      case 1:
        rs = checkWin1(value);
        break;
      case 2:
        checkWin2(value);
        break;
      case 3:
        checkWin3(value);
        break;
      case 4:
        checkWin4(value);
        break;
      case 5:
        checkWin5(value);
        break;
      case 6:
        checkWin6(value);
        break;
    }
    if(rs["needRunAnim"] ?? false) {
        if (isSet) return;
        isSet = true;
        userBalanceData((value){
            resetGame(rs["isWin"] ?? false);
            Get.find<UserBalanceLonic>().state
                .setUserBalanceData(value);
            isSet = false;
        });
    }
  }
  Future userBalanceData(callBack) {
    return HttpChannel.channel.userBalance()
      ..then((value) => value.finalize(
          wrapper: WrapperModel(),
          success: (data) {
            callBack.call(UserBalanceData.fromJson(data));
            },
            failure: (e){
              callBack.call(null);
            }
          )
      );
  }
  //一分快三
  Map<String, bool> checkWin1(GameDataResult value) {
    var needRunAnim = false;
    var isWin = false;
    state.oddsList.forEach((element) {
      if (element.id == state.odds.value.id) {
        element.odds?.forEach((item) {
            item.isWining = false;
            if(item.selected && item.listCoin.isNotEmpty){
              needRunAnim = true;
              switch(element.id){
                case 1: //总和
                  if(value.hitSum!=null && value.hitSum!.isNotEmpty &&
                  item.name == value.hitSum){
                      item.isWining = true;
                      isWin = true;
                  }
                  break;
                case 2: //大小
                  if((value.hitSize!=null && value.hitSize!.isNotEmpty ||
                      value.hitParity!=null && value.hitParity!.isNotEmpty) &&
                      (item.name == value.hitSize
                          || item.name == value.hitParity)){
                    item.isWining = true;
                    isWin = true;
                  }
                  break;
                case 3: //单骰
                  if(value.number!=null && value.number!.isNotEmpty &&
                  value.number!.contains(item.name!)){
                    item.isWining = true;
                    isWin = true;
                  }
                  break;
                case 4: //对子
                  if(value.hitPair!=null && value.hitPair!.isNotEmpty &&
                      value.hitPair == item.name){
                    item.isWining = true;
                    isWin = true;
                  }
                  break;
                case 5: //豹子
                  if(value.hitTriple!=null && value.hitTriple!.isNotEmpty &&
                      value.hitTriple == item.name){
                    item.isWining = true;
                    isWin = true;
                  }
                  break;
              }
              print('NEO GAME ID SELECT: id-${element.id}, name-${element.name}, id-item-${item.id}, name-${item.name}, value: ${item.odds}, status: ${item.isWining}');
              print('--------------------------');
            }
        });
      }
    });
    return {"needRunAnim": needRunAnim, "isWin": isWin};
  }
  //一分六合彩
  void checkWin2(GameDataResult value) {
    return null;
  }
  //一分快车
  void checkWin3(GameDataResult value) {
    return null;
  }
  //鱼虾蟹
  void checkWin4(GameDataResult value) {
    return null;
  }
  //百人牛牛
  void checkWin5(GameDataResult value) {
    return null;
  }
  //一分时时彩
  void checkWin6(GameDataResult value) {
    return null;
  }

  bool isSet = false;
  void clearAllCoin() {
    state.oddsList.forEach((element) {
      element.odds?.forEach((item) {
        item.listSavedCoin.clear();
        item.listSavedCoin.addAll(item.listCoin);
        item.listCoin.clear();
        AppCacheManager.cache.clearBetCoin('${state.roomId}_${item.id}');
      });
    });
    Future.delayed(Duration(seconds: 1), (){
      state.actBetAnimType.value = 0;
      state.oddsList.forEach((element) {
        element.odds?.forEach((item) {
          item.isWining = false;
          item.selected = false;
        });
      });
      update();
    });
  }

  void resetGame(bool isWin) {
    state.actBetAnimType.value = isWin ? 2 : 3;
    AssetsAudioPlayer.newPlayer().open(
      Audio("assets/sound/${isWin ? 'win':'lose'}.mp3"),
      autoStart: true,
      showNotification: false,
      playInBackground: PlayInBackground.disabledPause,
    );
    clearAllCoin();
  }
}

class ChipWidget extends StatefulWidget {
  late Offset offset;
  Function(String) onTap;

  ChipWidget(this.offset, this.onTap, {Key? key}) : super(key: key);

  @override
  _ChipWidgetState createState() => _ChipWidgetState();
}

class _ChipWidgetState extends State<ChipWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 214 + AppLayout.safeBarHeight + 60,
      color: Colors.transparent,
      child: Row(
        children: [
          SizedBox(
            width: widget.offset.dx - 44 + 16.dp,
          ),
          Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppMainColors.whiteColor10, width: 1),
                      color: Color.fromRGBO(42, 65, 85, 1),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  width: 88,
                  height: 214,
                  child: CustomScrollView(
                    slivers: [
                      SliverFixedExtentList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                            return (_mul.length - 1) == index
                                ? itemCustom()
                                : Container(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Image.asset(
                                          _mul[index],
                                          width: 32,
                                          height: 32,
                                        )
                                      ],
                                    ),
                                  ).gestureDetector(onTap: () {
                                    if (_mulNum.length > index) {
                                      Get.back(result: _mulNum[index]);
                                    }
                                  });
                          }, childCount: _mul.length),
                          itemExtent: 45),
                      SliverToBoxAdapter(
                          child: Container(
                        height: 40,
                        alignment: Alignment(0, 0),
                        child: Text(
                          "自定义",
                          style: TextStyle(
                              color: Color.fromRGBO(50, 197, 255, 1),
                              fontSize: 12),
                        ),
                      ).gestureDetector(onTap: () {
                        Get.back();
                        Get.dialog(_InputChipsDialog(),
                                barrierColor: Colors.transparent)
                            .then((value) {
                          if (value != null) {
                            widget.onTap(value);
                          }
                        });
                      }))
                    ],
                  )),
              SizedBox(
                height: AppLayout.safeBarHeight + 60,
              )
            ],
          )
        ],
      ),
    );
  }

  ///自定义的筹码
  Widget itemCustom() {
    String? mul = _mulNum.contains(AppCacheManager.cache.getMultiplier())
        ? ""
        : AppCacheManager.cache.getMultiplier();
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Image.asset(
          R.mulConfig,
          width: 32,
          height: 32,
        ),
        Text(
          mul ?? "",
          style: TextStyle(
              color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
        )
      ],
    ).gestureDetector(onTap: () {
      Get.back(result: mul);
    });
  }

  final List<String> _mul = [
    R.mul1,
    R.mul2,
    R.mul5,
    R.mul10,
    R.mul50,
    R.mul100,
    R.mul200,
    R.mul500,
    R.mulConfig,
  ];
  final List<String> _mulNum = [
    "1",
    "2",
    "5",
    "10",
    "50",
    "100",
    "200",
    "500",
  ];
}

class _InputChipsDialog extends Dialog {
  _InputChipsDialog({Key? key}) : super(key: key);
  var inputText = "";

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.85;
    var btnWidth = (MediaQuery.of(context).size.width * 0.85 - 15 * 2 - 25) / 2;
    return Material(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color.fromRGBO(42, 65, 85, 1),
        type: MaterialType.transparency, //透明类型
        child: Center(
          child: SizedBox(
            width: width,
            height: 203.dp,
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(42, 65, 85, 1),
                  borderRadius: BorderRadius.all(Radius.circular(8.dp))),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.dp,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "请输入自定义底分",
                        style: TextStyle(
                            color: Colors.white.withAlpha(50), fontSize: 14.dp),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 44.dp,
                    margin: EdgeInsets.only(left: 16.dp, right: 16.dp),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.1),
                        borderRadius: BorderRadius.all(Radius.circular(4.dp))),
                    child: CustomTextField(
                      keyboardType: TextInputType.number,
                      hintText: "请输入范围在2～10000的数值",
                      hintTextStyle: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 0.4),
                          fontSize: 14.dp),
                      contentPadding: EdgeInsets.only(left: 13, top: 10),
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      inputFormatter: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(6), //限制输入长度
                        FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                      ],
                      onChange: (value) {
                        this.inputText = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40.dp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, //平均分布居中。
                    children: [
                      TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Container(
                            alignment: Alignment(0, 0),
                            width: btnWidth,
                            height: 40.dp,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0.2),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(40.dp / 2))),
                            child: Text(
                              "取消",
                              style: TextStyle(
                                  color: Colors.white.withAlpha(160),
                                  fontSize: 14.dp),
                            ),
                          )),
                      TextButton(
                          //确定按钮
                          onPressed: () {
                            Get.back(result: this.inputText);
                          },
                          child: Container(
                            alignment: Alignment(0, 0),
                            width: btnWidth,
                            height: 40.dp,
                            decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(40.dp / 2)),
                            child: Text(
                              "确定",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.dp),
                            ),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}