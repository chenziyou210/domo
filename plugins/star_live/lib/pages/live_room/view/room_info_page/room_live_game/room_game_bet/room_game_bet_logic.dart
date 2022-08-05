// ignore_for_file: must_be_immutable, avoid_single_cascade_in_expression_statements

import 'dart:async';
import 'dart:convert';

import 'package:alog/alog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';
import 'package:star_common/common/storage.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/cache.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/manager/user/user_balance_logic.dart';
import '../../../../live_room_new_logic.dart';
import '/pages/live_room/view/room_info_page/room_live_game/game_net_work.dart';
import '/pages/live_room/view/room_info_page/room_live_game/room_live_game_state.dart';

import 'room_game_bet_state.dart';

/// @description:
/// @author
/// @date: 2022-06-23 14:30:56
class RoomGameBetLogic extends GetxController with Toast {
  final state = RoomGameBetState();
  List<GameBettingMultiplierData> muItem = [];

  ///倍数数组
  List<GameBettingMultiplierData> get _muItem => state.muItme();

  Timer? _timer;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Get.find<LiveRoomNewLogic>().closeGameBackView = (payload) {
      Get.back();
    };
    this.muItem = _muItem;
    GameNetWork.shared.eventBus.on<GameMqttData>().listen((event) {
      if (state.odds.length == 0) {
        return;
      }
      if (event.data?.gameId == state.odds.first.gameId) {
        state.setUpdateResult(event.data!);
        Future.delayed(Duration(seconds: state.countdownTime.value), () {
          state.updataIssueId(event.data?.nextIssueId ?? "0");
        });
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    startCountdownTimer();
    state.chips = double.parse(state.odds.first.chips!);
    state.betsAmount = state.chips * state.mu * state.odds.length;
    update();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    _timer?.cancel();
  }

  void startCountdownTimer() {
    GameNetWork.shared.getGameTimestamp((s) {
      state.setUpdateCountdownTime(59 - s);
    });
    _timer?.cancel();
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (state.countdownTime.value == 0) {
        startCountdownTimer();
      } else {
        state.setUpdateCountdownTime(state.countdownTime.value - 1);
      }
    });
  }

  String time() {
    return "00:" +
        (state.countdownTime.value >= 10
            ? "${state.countdownTime.value}"
            : "0${state.countdownTime.value}");
  }

  // 期数
  // String issueId() {
  //   return (state.result.value.issueId == null ||
  //           state.result.value.issueId?.length == 0)
  //       ? state.odds.first.issueId ?? ""
  //       : state.result.value.issueId ?? "";
  // }

//投注
  getBetting() {
    if (state.countdownTime.value <= 6) {
      showToast("暂时不可投注!");
      return;
    }
    String issueId = "${(int.parse(state.issueId.value) + 1)}";
    //投注项
    List<Map<String, dynamic>> betArr = [];
    var gameId = state.odds.first.gameId ?? 0;
    var gameName = state.odds.first.gameName ?? "";
    state.odds.forEach((element) {
      betArr.add({
        "betAmount": this.state.chips * state.mu,
        "oddsId": element.id,
        "optionId": element.optionId
      });
    });

    if ((Get.find<UserBalanceLonic>().state.userBalance.value.balance ?? 0.0) ==
            0 ||
        (Get.find<UserBalanceLonic>().state.userBalance.value.balance ?? 0.0) <
            this.state.chips * state.mu * state.odds.length) {
      showToast("余额不足,请先充值");
      return;
    }
    List<String> odds = [];
    state.odds.forEach((element) {
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

            ///投注成功,获取用户信息
            Get.find<UserBalanceLonic>().userBalanceData();
            Get.back(result: "userBalance");
          }));
  }

  //删除投注项
  deleteBet(int index) {
    if (state.odds.length > index) {
      state.odds.removeAt(index);
      if (state.odds.length == 0) {
        Get.back();
        return;
      }
      state.betsAmount = state.chips * state.mu * state.odds.length;
      update();
    }
  }

  ///选中倍数的操作
  void seledetMu(int index) {
    if (index == muItem.length - 1) {
      showMultiplier();
      return;
    }
    for (var i = 0; i < muItem.length; i++) {
      muItem[i].seleted = i == index ? true : false;
      if (muItem[i].seleted && i != muItem.length - 1) {
        state.mu = double.parse(muItem[i].muName!);
        state.betsAmount = state.chips * state.mu * state.odds.length;
      }
    }
    update();
  }

  ///预设倍数
  void setPresetMultiplier(List<String> mus) {
    mus.add("编辑");
    List<GameBettingMultiplierData> list = [];
    for (var i = 0; i < mus.length; i++) {
      list.add(GameBettingMultiplierData(
          seleted: i == 0 ? true : false,
          name: i == mus.length - 1 ? "编辑" : mus[i] + "倍",
          muName: mus[i]));
      if (i == 0) {
        state.mu = double.parse(mus[i]);
        state.betsAmount = state.chips * state.mu * state.odds.length;
      }
    }
    this.muItem = list;
    update();
  }

  //预设倍数弹框
  showMultiplier() {
    List<String> item = [];
    Map<String, TextEditingController> _textControllers = Map();
    if (AppCacheManager.cache.getPresetMul().length == 5) {
      for (var i = 0; i < AppCacheManager.cache.getPresetMul().length; i++) {
        item.add(AppCacheManager.cache.getPresetMul()[i]);
        var texted = TextEditingController();
        texted.text = AppCacheManager.cache.getPresetMul()[i];
        _textControllers["key_multiplier" + state.muItems[i]] = texted;
      }
    } else {
      for (var i = 0; i < state.muItems.length; i++) {
        if (i != state.muItems.length - 1) {
          item.add(state.muItems[i]);
          var texted = TextEditingController();
          texted.text = state.muItems[i];
          _textControllers["key_multiplier" + state.muItems[i]] = texted;
        }
      }
    }
    Get.dialog(_InputMultiplierDialog(item, state.muItems, _textControllers),
            barrierDismissible: true)
        .then((value) {
      if (value != null) {
        setPresetMultiplier(value);
      }
    });
  }
}

///预设倍数
class _InputMultiplierDialog extends Dialog {
  List<String> multiplier;
  List<String> items;
  Map<String, TextEditingController> textControllers = Map();
  _InputMultiplierDialog(this.multiplier, this.items, this.textControllers,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width - 48.dp;
    return StatefulBuilder(builder: (BuildContext context, setState) {
      return Material(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color.fromRGBO(42, 65, 85, 1),
          type: MaterialType.transparency, //透明类型
          child: Center(
              child: SizedBox(
                  width: width,
                  height: 311.dp,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(42, 65, 85, 1),
                        borderRadius: BorderRadius.all(Radius.circular(8.dp))),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15.dp,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 15.dp,
                            ),
                            Text(
                              "预设倍数",
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 0.7),
                                  fontSize: 14.sp),
                            ),
                            Spacer(),
                          ],
                        ),
                        SizedBox(
                          height: 13.dp,
                        ),
                        listIput(),
                        btns(context, setState),
                        SizedBox(
                          height: 13.dp,
                        )
                      ],
                    ),
                  ))));
    });
  }

  Widget btns(BuildContext context, void Function(void Function()) setState) {
    var width = (MediaQuery.of(context).size.width - 48.dp - 36.dp - 25.dp) / 2;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, //平均分布居中。
      children: [
        TextButton(
            onPressed: () {
              AppCacheManager.cache.removePresetMul();
              for (var i = 0; i < textControllers.length; i++) {
                textControllers["key_multiplier" + items[i]]?.text = items[i];
                setState(() {});
              }
            },
            child: Container(
              alignment: Alignment(0, 0),
              width: width,
              height: 40.dp,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.2),
                  borderRadius: BorderRadius.all(Radius.circular(40.dp / 2))),
              child: Text(
                "重设预计",
                style: TextStyle(
                    color: Colors.white.withAlpha(160), fontSize: 14.sp),
              ),
            )),
        TextButton(
            //确定按钮
            onPressed: () {
              List<String> values = [];
              textControllers.forEach((key, value) {
                values.add(value.text.length == 0 ? "0" : value.text);
              });

              Get.back(result: values);
              AppCacheManager.cache.setPresetMul(values);
            },
            child: Container(
              alignment: Alignment(0, 0),
              width: width,
              height: 40.dp,
              decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(40.dp / 2)),
              child: Text(
                "确定",
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),
            )),
      ],
    );
  }

  Widget listIput() {
    return Expanded(
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: multiplier.length,
          itemExtent: 35.dp, //强制高度
          itemBuilder: (BuildContext context, int index) {
            return Container(
                alignment: Alignment(0, 0),
                height: 32.dp,
                margin: EdgeInsets.only(
                    left: 16.dp, right: 16.dp, top: 2, bottom: 2),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Color.fromRGBO(255, 255, 255, 0.1), width: 0.5),
                    borderRadius: BorderRadius.all(Radius.circular(32.dp / 2))),
                child: CustomTextField(
                  //预设倍数输入框
                  textAlign: TextAlign.center,
                  controller: textControllers["key_multiplier" + items[index]],
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white, fontSize: 14.dp),
                  contentPadding: EdgeInsets.only(top: 5),
                  inputFormatter: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(6),
                    FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                  ],
                ));
          }),
    );
  }
}
