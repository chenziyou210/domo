import 'package:get/get.dart';
import 'package:spring/spring.dart';
import 'package:star_common/http/cache.dart';

import '../room_base_game/room_base_game_state.dart';

/// @description:
/// @author
/// @date: 2022-06-23 14:30:56
class RoomGameBetState {
  RoomGameBetState() {
    ///Initialize variables
  }
  RxString issueId = "0".obs;
  updataIssueId(String value) {
    issueId.value = value;
  }

  Rx<GameDataResult> result = GameDataResult().obs;
  setUpdateResult(GameDataResult value) {
    result.value = value;
  }

  ///刷新金币动画
  final SpringController springCoinsController =
      SpringController(initialAnim: Motion.pause);
  List<GameOdds> odds = [];
  //倍数
  double mu = 1.0;
  List<String> muItems = ["1", "2", "5", "10", "20", "0"];

  List<GameBettingMultiplierData> muItme() {
    List<GameBettingMultiplierData> list = [];
    var items = AppCacheManager.cache.getPresetMul();
    if (items.length > 0) {
      for (var i = 0; i < items.length; i++) {
        list.add(GameBettingMultiplierData(
            seleted: i == 0 ? true : false,
            name: i == items.length - 1 ? "编辑" : items[i] + "倍",
            muName: items[i]));
        if (i == 0) {
          this.mu = double.parse(items[i]);
        }
      }
      return list;
    } else {
      for (var i = 0; i < muItems.length; i++) {
        list.add(GameBettingMultiplierData(
            seleted: i == 0 ? true : false,
            name: i == muItems.length - 1 ? "编辑" : muItems[i] + "倍",
            muName: muItems[i]));
        if (i == 0) {
          this.mu = double.parse(muItems[i]);
        }
      }
      return list;
    }
  }

  ///投注金额
  double betsAmount = 0.0;

  ///筹码
  double chips = 0.0;
  //倒计时时间
  RxInt countdownTime = 0.obs;
  setUpdateCountdownTime(int value) {
    countdownTime.value = value;
  }
}

class GameBettingMultiplierData {
  ///选中
  bool seleted = false;

  ///显示的名字
  String? name;

  ///实际的倍数
  String? muName;
  GameBettingMultiplierData({
    required this.seleted,
    this.muName,
    this.name,
  });
}
