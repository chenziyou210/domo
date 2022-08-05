// ignore_for_file: non_constant_identifier_names

import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spring/spring.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/fly_widget.dart';
import 'package:star_common/common/storage.dart';
import 'package:star_common/http/cache.dart';

import '/pages/live_room/view/room_info_page/room_live_game/room_live_game_state.dart';

/// @description:
/// @author
/// @date: 2022-06-20 17:10:52
class RoomBaseGameState {
  RoomBaseGameState() {
    ///Initialize variables
  }
  final SpringController springController = SpringController();

  ///是否是主播
  bool? isAnchor;
  GlobalKey imegeKey = GlobalKey();
  ScrollController controller = ScrollController();
  RxInt selectedIndex = 0.obs;
  setUpdateSelectedIndex(int value) {
    selectedIndex.value = value;
  }

  //筹码图片
  String chipsImage = R.mul2;
  //筹码
  String? roomId;
  double chips = 2.0;
  //增加的高度
  double height = 0;
  RxInt actBetAnimType = 0.obs;
  RxBool holdGame50 = false.obs;
  RxBool pauseOrStart = false.obs;

  ///屏幕的高度
  double widgetHeight = 0;

  ///整个游戏界面的高,不包括记录
  double viewHeight = ScreenUtil().screenHeight - 420.dp;

  ///安全区顶部和顶部高度
  double safeHeight = 0;
  RoomLiveGameList? data;

  ///展示投注
  bool bettingShow = false;

  ///展示开奖
  bool prizeDrawsShow = false;

  ///刷新动画

  final SpringController springCoinsController =
      SpringController(initialAnim: Motion.pause);

  ///开奖记录,页码
  int resultPage = 1;
  //开奖记录
  List<GameDataResult> resultList = [];

  ///投注记录
  int orderPage = 1;

  ///投注项数组
  RxList<GameOddsList> oddsList = <GameOddsList>[].obs;
  setUpdateOddsList(List<GameOddsList> value) {
    oddsList.value = value;
  }


  Rx<GameOddsList> odds = GameOddsList().obs;
  setUpdateOdds(GameOddsList value) {
    odds.value = value;
  }

  ///投注记录
  List<GameOrderList> orderList = [];
  //最近开奖的数据
  Rx<GameDataResult> firstResult = GameDataResult().obs;
  setUpdateFirstResult(GameDataResult value) {
    firstResult.value = value;
  }

  RxList<String> oddsLabels = <String>[].obs;
  setUpdateOddsLabels(List<String> value) {
    oddsLabels.value = value;
  }

  //倒计时时间
  RxInt countdownTime = 0.obs;
  setUpdateCountdownTime(int value) {
    countdownTime.value = value;
  }

  //本期状态
  // RxInt state = 0.obs;

  ///每行几个
  RxInt crossAxisCount = 1.obs;
  setUpdateCrossAxisCount(int value) {
    crossAxisCount.value = value;
  }

  var yuxiaxieImgs = [
    R.fishprawncrabgame61,
    R.fishprawncrabgame62,
    R.fishprawncrabgame63,
    R.fishprawncrabgame64,
    R.fishprawncrabgame65,
    R.fishprawncrabgame66,
  ];

  ///显示区域宽高比例
  RxDouble childAspectRatio = 1.0.obs;
  setUpdateChildAspectRatio(double value) {
    childAspectRatio.value = value;
  }

  List<Color> normalsBg = [
    Color(0xFF3F4963),
    Color(0xFF3F4963),
  ];
  List<Color> selectedBg = [
    Color.fromRGBO(0, 146, 203, 1),
    Color.fromRGBO(50, 197, 255, 1)
  ];
  String resultNiuNIu() {
    return "0_1,0_3,0_1,0_2,0_1,0_2,0_1,0_2,0_3,0_4";
  }

  //设置
  gridViewSetting() {
    if (this.odds.value.odds?.length == 2) {
      setUpdateCrossAxisCount(2);

      setUpdateChildAspectRatio(2.0);
    } else if (this.odds.value.odds?.length == 3) {
      setUpdateCrossAxisCount(3);
      setUpdateChildAspectRatio(1.36);
    } else if (this.odds.value.odds?.length == 4) {
      setUpdateCrossAxisCount(4);
      setUpdateChildAspectRatio(1);
    } else if (this.odds.value.odds?.length == 5) {
      setUpdateCrossAxisCount(5);
      setUpdateChildAspectRatio(1);
    } else if (this.odds.value.odds?.length == 6 ||
        this.odds.value.odds?.length == 7) {
      if (this.data!.id == 4) {
        //鱼虾蟹

        setUpdateCrossAxisCount(3);
        setUpdateChildAspectRatio(1.758);
      } else {
        setUpdateCrossAxisCount(6);
        setUpdateChildAspectRatio(1);
      }
    } else if (this.odds.value.odds?.length == 8) {
      setUpdateCrossAxisCount(4);
      setUpdateChildAspectRatio(1.29);
    } else if (this.odds.value.odds?.length == 10) {
      setUpdateCrossAxisCount(5);
      setUpdateChildAspectRatio(1);
    } else if (this.odds.value.odds?.length == 12 ||
        this.odds.value.odds?.length == 17) {
      setUpdateCrossAxisCount(6);
      setUpdateChildAspectRatio(1);
    } else if ((this.odds.value.odds?.length ?? 0) > 12) {
      setUpdateCrossAxisCount(7);
      setUpdateChildAspectRatio(1);
    }
  }

  ///筹码图片
  final List<String> mul = [
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

  ///筹码
  final List<String> mulNum = [
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

//游戏数据
class GameDataResult {
  int? gameId;
  String? issueId;
  String? nextIssueId;

  ///号码
  String? number;

  ///大小
  String? hitSize;

  ///单双
  String? hitParity;

  ///和值
  String? hitSum;
  String? hitGySize;
  String? hitGyParity;
  String? hitGySum;
  String? hitGjSize;
  String? hitGjParity;
  String? hitGjSizeParity;
  String? hitPair;
  String? hitTriple;
  String? issueTime;
  String? createTime;
  String? updateTime;
  String? blue1;

  ///是否开奖 状态 1开盘中 2封盘中 3已开奖 4已派奖
  int? state;

  ///蓝方 -1输 0平 1赢 ,牛牛没有平
  String? hitWinLose;
  String? hitDragonTiger;

  ///蓝方牛
  String? hitBlue;

  ///红方牛
  String? hitRed;

  ///生肖
  String? hitSx;

  ///蓝波.绿波,红波
  String? hitColor;
  GameDataResult({
    this.gameId,
    this.issueId,
    this.number,
    this.state,
    this.hitSize,
    this.hitParity,
    this.hitSum,
    this.hitPair,
    this.hitTriple,
    this.issueTime,
    this.createTime,
    this.updateTime,
    this.blue1,
    this.hitWinLose,
    this.hitDragonTiger,
    this.hitBlue,
    this.hitRed,
    this.hitSx,
    this.hitColor,
    this.hitGySize,
    this.hitGyParity,
    this.hitGySum,
    this.hitGjSize,
    this.hitGjParity,
    this.hitGjSizeParity,
  });

  GameDataResult.fromJson(Map<String, dynamic> json) {
    LinkedHashMap<String, dynamic> map = new LinkedHashMap(
            equals: (a, b) => a.toLowerCase() == b.toLowerCase(),
            hashCode: (key) => key.toLowerCase().hashCode
    );

    map.addAll(json);
    gameId = map ["gameId"];
    issueId = map['issueId'] is int ? "${map['issueId']}" : map['issueId'];
    nextIssueId = map['NextIssueId'] is int ? "${map['NextIssueId']}" : map['NextIssueId'];
    number = map['number'];
    state = map['state'] is String ? int.parse(map['state']) : map['state'];
    hitSize = map['hitSize'];
    hitParity = map['hitParity'];
    hitSum = map['hitSum'];
    hitPair = map['hitPair'];
    hitTriple = map['hitTriple'];
    issueTime = map['issueTime'];
    createTime = map['createTime'];
    updateTime = map['updateTime'];
    blue1 = map['blue1'];
    hitWinLose = map['hitWinLose'];
    hitDragonTiger = map['hitDragonTiger'];
    hitBlue = map['hitBlue'];
    hitRed = map['hitRed'];
    hitSx = map['hitSx'];
    hitColor = map['hitColor'];
    hitGySize = map['hitGySize'];
    hitGyParity = map['hitGyParity'];
    hitGySum = map['hitGySum'];
    hitGjSize = map['hitGjSize'];
    hitGjParity = map['hitGjParity'];
    hitGjSizeParity = map['hitGjSizeParity'];
  }
}

class GameOddsList {
  int? id;
  String? name;
  // String? description;
  List<GameOdds>? odds;
  GameOddsList({this.id, this.name, this.odds});
  GameOddsList.fromJson(Map<String, dynamic> map) {
    LinkedHashMap<String, dynamic> json = new LinkedHashMap(
        equals: (a, b) => a.toLowerCase() == b.toLowerCase(),
        hashCode: (key) => key.toLowerCase().hashCode
    );
    print('NEO GAME: $map');
    json.addAll(map);
    id = json['id'];
    name = json['name'];
    if (json['odds'] != null) {
      odds = <GameOdds>[];
      json['odds'].forEach((v) {
        final game = new GameOdds.fromJson(v);
        final roomId = StorageService.to.getString("roomId");
        final txtTime = AppCacheManager.cache.getTimeBetCoin('${roomId}_time_bet');
        final txtCountTime = AppCacheManager.cache.getTimeCountBetCoin('${roomId}_time_count_bet');
        if(txtTime == null || txtTime.length==0
            || txtCountTime == null || txtCountTime.length == 0){
          odds!.add(game);
          return;
        }
        int time = int.parse(txtTime);
        final date = DateTime.fromMicrosecondsSinceEpoch(time).add(Duration(seconds: int.parse(txtCountTime)));
        final dateNow = DateTime.now();
        final isRememberReset = AppCacheManager.cache.isRememberGameResult();
        if(!isRememberReset && date.isAfter(dateNow)){
          final data = AppCacheManager.cache.getBetCoin('${roomId}_${game.id}');
          if(data != null && data.length > 0){
            List ls = jsonDecode(data);
            List<CoinItem> lsCoin = List.empty(growable: true);
            ls.forEach((element) {
              lsCoin.add(CoinItem.fromJson(element));
            });
            game.listCoin = lsCoin.obs;
            game.selected = true;
          }
        }else{
          AppCacheManager.cache.clearBetCoin('${roomId}_${game.id}');
        }
        odds!.add(game);
      });
    }
  }
}

class GameOdds {
  int? id;
  int? gameId;
  int? optionId;
  RxList<CoinItem> listCoin = List<CoinItem>.empty(growable: true).obs;
  List<CoinItem> listSavedCoin = List<CoinItem>.empty(growable: true);
  double? odds;
  bool selected = false;
  bool isWining = false;
  GlobalKey global = GlobalKey();
  ///游戏名称
  String? gameName;
  ///期数
  String? issueId;
  ///GameOddsList 的 name
  String? oddName;
  ///筹码
  String? chips;
  String? name;
  GameOdds({
    this.id,
    this.odds,
    this.gameId,
    this.issueId,
    this.gameName,
    this.oddName,
    this.chips,
    this.name,
    this.optionId,
  });
  GameOdds.fromJson(Map<String, dynamic> map) {
    LinkedHashMap<String, dynamic> json = new LinkedHashMap(
        equals: (a, b) => a.toLowerCase() == b.toLowerCase(),
        hashCode: (key) => key.toLowerCase().hashCode
    );
    json.addAll(map);
    id = json['id'];
    odds =
        (json['odds'] is int) ? double.parse("${json['odds']}") : json['odds'];
    name = json['name'];
    chips = json['chips'];
    gameId = json["gameId"];
    optionId = json["optionId"];
    gameName = json["gameName"];
    issueId = json["issueId"];
    oddName = json["oddName"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['chips'] = this.chips;
    data['gameId'] = this.gameId;
    data['optionId'] = this.optionId;
    data['gameName'] = this.gameName;
    data['issueId'] = this.issueId;
    data['oddName'] = this.oddName;
    data['odds'] = this.odds;
    return data;
  }
}

class GameOrderList {
  ///期号
  String? issueId;

  ///投注号码
  String? number;
  String? orderSn;
  String? userId;
  String? roomId;
  String? agentId;

  ///游戏ID
  int? gameId;

  ///游戏名字
  String? gameName;

  int? optionId;

  ///游戏子类名字
  String? optionName;
  int? oddsId;
  String? oddsName;
  double? odds;

  ///1投注成功 2已经派奖
  int? status;

  ///投注输赢的结果
  String? betResult;

  ///投注金额
  double? betAmount;

  ///中奖金额
  double? profitAmount;
  double? realAmount;
  String? conferTime;
  String? createTime;
  String? updateTime;

  GameOrderList(
      {this.issueId,
      this.number,
      this.orderSn,
      this.userId,
      this.roomId,
      this.agentId,
      this.gameId,
      this.gameName,
      this.optionId,
      this.optionName,
      this.oddsId,
      this.oddsName,
      this.odds,
      this.status,
      this.betResult,
      this.betAmount,
      this.profitAmount,
      this.realAmount,
      this.conferTime,
      this.createTime,
      this.updateTime});

  GameOrderList.fromJson(Map<String, dynamic> map) {
    LinkedHashMap<String, dynamic> json = new LinkedHashMap(
        equals: (a, b) => a.toLowerCase() == b.toLowerCase(),
        hashCode: (key) => key.toLowerCase().hashCode
    );
    json.addAll(map);
    issueId = json['issueId'];
    number = json['number'];
    orderSn = json['orderSn'];
    userId = json['userId'];
    roomId = json['roomId'];
    agentId = json['agentId'];
    gameId = json['gameId'];
    gameName = json['gameName'];
    optionId = json['optionId'];
    optionName = json['optionName'];
    oddsId = json['oddsId'];
    oddsName = json['oddsName'];
    odds = json['odds'];
    status = json['status'];
    betResult = json['betResult'];
    betAmount = json['betAmount'] is int
        ? double.parse("${json['betAmount']}")
        : json['betAmount'];
    profitAmount = json['profitAmount'] is int
        ? double.parse("${json['profitAmount']}")
        : json['profitAmount'];
    realAmount = json['realAmount'] is int
        ? double.parse("${json['realAmount']}")
        : json['realAmount'];
    conferTime = json['conferTime'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
  }
}
