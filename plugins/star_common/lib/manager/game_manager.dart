/*
 *  Copyright (C), 2015-2021
 *  FileName: game_manager
 *  Author: Tonight丶相拥
 *  Date: 2021/11/24
 *  Description: 
 **/

part of appmanager;


class Game {
  Game._();

  List<GameModel> _games = [];
  List<GameModel> get games => _games;

  final List<String> _showGames = [
    "RedGreenVioletGame",
    "Fast5DGame",
    "FishPrawnCrabGame",
    "DiceGame"
  ];

  final List<String> _type1GameName = [
    "RacingGame"
  ];

  final List<String> _type2GameName = [
    "BaccaratGame"
  ];

  /// 初始化游戏
  void initializeGame(Map<String, dynamic> json){
    var keys = json.keys;
    keys = keys.where((element) => _showGames.contains(element)
      || _type1GameName.contains(element) || _type2GameName.contains(element));
    _games = keys.map((e) {
      /// 手动分类
      if (_showGames.contains(e))
        return GameModel.fromJson(json[e]);
      else if (_type1GameName.contains(e))
        return GameModel1.fromJson(json[e]);
      else
        return Game2Model.fromJson(json[e]);
    }).toList();
  }

  /// 设置当前数据
  /// 进入直播间拉取结果
  void setCurrentData(Map<String, dynamic> json){
    lottery(json);
  }

  /// 开奖
  void lottery(Map<String, dynamic> json){
    var keys = json.keys;
    var lst = games.where((element) => keys.contains(element.gameName)).toList();
    lst.forEach((element) {
      element._setData(json[element.gameName]);
    });
  }
}

class GameModel extends GetxController {
  GameModel({required this.gameName,
    required this.description,
    required this.gamePlays, required this.gameNameLan});

  final int type = 0;

  /// 游戏名称
  final String gameName;
  final String gameNameLan;
  /// 游戏描述
  final String description;
  /// 游戏玩法选项
  final List<PlayOption> gamePlays;

  /// 开奖间隔
  int? periodTime;
  /// 固定显示
  late bool showFlag;
  /// 开奖倒计时
  RxInt _count1 = 0.obs;
  RxInt get count1 => _count1;
  Timer? _countTimer;
  Timer? _gameTimeOut;
  set count(int count){
    if (_gameTimeOut != null) {
      _gameTimeOut?.cancel();
      _gameTimeOut = null;
    }
    _count1.value = count;
    if (_countTimer == null)
      _countTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        _count1--;
        if (_count1.value <= 0) {
          timer.cancel();
          _countTimer?.cancel();
          _countTimer = null;
          /// 游戏超时  主动拉取
          _gameTimeOut = Timer(Duration(seconds: 5), (){
            EventBus.instance.notificationListener(name: gameTimeOut);
          });
        }
      });
  }
  /// 期号
  dynamic lastPeriodTime;
  //// 上期结果
  RxString _lastGameResult = "".obs;
  RxString get lastGameResult => _lastGameResult;
  // /// 下注
  // List<RxList<int>> _bets;
  // List<RxList<int>> get bets => _bets;

  /// 下注倍数
  RxInt _betNum = 5.obs;
  RxInt get betNum => _betNum;
  bool _isCustom = false;
  bool get isCustom => _isCustom;

  RxString lotteryPeriodTime = "".obs;
  
  /// 选中位置
  RxInt _index = 0.obs;
  RxInt get index => _index;
  
  factory GameModel.fromJson(Map<String, dynamic> json){
    String gameName = json["gameName"];
    String description = json["explain"] ?? "";
    String gameLan = json["gameNameLan"] ?? "";
    String showFlag = (json["showFlag"] ?? "0").toString();
    List g = json["gamePlays"] ?? [];
    List<PlayOption> gamePlays = g.map((e) => PlayOption.fromJson(e)).toList();
    return GameModel(gameName: gameName,
      description: description,
      gameNameLan: gameLan,
      gamePlays: gamePlays)..showFlag = showFlag == "1";
  }

  /// 设置数据
  void _setData(Map<String, dynamic> json){
    var s = json["lastGameResultStr"];
    if (s == null)
      return;
    this.lastPeriodTime = json["currentPeriodTime"];
    this.periodTime = int.tryParse(json["periodTime"].toString());
    this.count = int.parse(json["counter"].toString());
    this._lastGameResult.value = s;

    var s1 = json["lastPeriodTime"];
    lotteryPeriodTime.value = s1.toString();
    if (s1 == null)
      return;
    if(showFlag)
    EventBus.instance.notificationListener(name: gameName, parameter: {
      "result": _lastGameResult.value,
      "gameName": gameName,
      "lastPeriodTime": s1
    });
  }

  /// 选中玩法
  void tapIndex(int index){
    int row = _index.value;
    gamePlays[row]._tapIndex(index);
    // if (_bets[row].contains(index)) {
    //   _bets[row].remove(index);
    // }else {
    //   _bets[row].add(index);
    //   var m = this.gamePlays[row].options[index];
    //   var c = m.conflict;
    //   if (c.length == 0)
    //     return;
    //   /// 互斥
    //   for (int i = 0; i < this.gamePlays.length; i ++) {
    //     var m = this.gamePlays[i];
    //     for (int j = 0; j < m.options.length; j ++) {
    //       var e1 = this.gamePlays[i].options[j];
    //       var s = e1.betPic;
    //       if (c.contains(s)) {
    //         _bets[i].remove(j);
    //       }
    //     }
    //   }
    // }
  }

  /// tab
  void tapOption(int index){
    _index.value = index;
  }

  /// 选中倍率
  void changeMultiple(int mul, bool isCustom){
    this._betNum.value = mul;
    this._isCustom = !isCustom;
  }

  /// 提交下注
  Map<String, dynamic>? submit(String id){
    Map<String, dynamic> result = {};
    result["gameName"] = gameName;
    result["periodTime"] = lastPeriodTime;
    result["anchorId"] = id;
    var l = gamePlays.where((element) {
      // int index = gamePlays.indexOf(element);
      // var bets = _bets[index];
      // element.selectIndexes = bets;
      return element.selectIndexes.isNotEmpty;
    }).map((e) => e.selectIndexes.map((e1) => {
      "gamePlay": e.options[e1].gamePlay,
      "betNum": _betNum.value,
      "betValue": e.options[e1].betValue
    }).toList()).toList();
    if (l.length == 0) {
      return null;
    }
    /// 具体数据
    result["betList"] = l.reduce((value, element) => value + element);
    return result;
  }

  @override
  // TODO: implement onDelete
  InternalFinalCallback<void> get onDelete {
    _index.value = 0;
    // this._bets = List.generate(gamePlays.length,
    //   (index) => <int>[].obs);
    // this.gamePlays.forEach((element) {
    //   element._onClean();
    //   // element.selectIndexes = <int>[].obs;
    // });
    clear();
    return super.onDelete;
  }

  void clear(){
    this.gamePlays.forEach((element) {
      element._onClean();
      // element.selectIndexes = <int>[].obs;
    });
  }
}

class PlayOption {
  PlayOption({required this.playName,
    required this.gamePlay,
    required this.options,
    this.showOption: true});
  /// 玩法名称
  final String playName;
  /// 玩法id
  final String gamePlay;
  /// 玩法选项
  final List<_OptionDetail> options;
  /// 选中下标
  RxList<int> selectIndexes = <int>[].obs;
  final bool showOption;

  void _tapIndex(int index){
    if (selectIndexes.contains(index)) {
      selectIndexes.remove(index);
    }else {
      selectIndexes.add(index);
      var m = options[index];
      var c = m.conflict;
      if (c.length == 0)
        return;
      /// 互斥
      selectIndexes.removeWhere((e1) => c.contains(options[e1].betPic));
    }
  }
  
  void _onClean(){
    selectIndexes.value = <int>[];
  }
  
  void _onSync(List<int> value){
    selectIndexes.value = value;
  }

  factory PlayOption.fromJson(Map<String, dynamic> json){
    String playName = json["playName"];
    String gamePlay = json["gamePlay"];
    List o = json["options"] ?? [];
    bool show = json["show"] ?? true;
    List<_OptionDetail> options = o.map((e) => _OptionDetail.fromJson(e)).toList();
    return PlayOption(playName: playName, gamePlay: gamePlay,
      options: options, showOption: show);
  }
}

class _OptionDetail {
  _OptionDetail({required this.betValue, required this.betPic,
    required this.lossRate, required this.gamePlay,
    required this.conflict});
  /// 下注id
  final String betValue;
  /// 图片
  final String betPic;
  /// 赔率
  final String lossRate;
  /// 玩法id
  final String gamePlay;
  /// 互斥
  final List<String> conflict;

  factory _OptionDetail.fromJson(Map<String, dynamic> json){
    String betValue = json["betValue"];
    String betPic = json["betPic"];
    String lossRate = json["lossRate"];
    String gamePlay = json["gamePlay"];
    String conflict = json["conflict"] ?? "";
    List<String> _con = conflict.isEmpty ? [] : conflict.split(",");
    return _OptionDetail(betValue: betValue, betPic: betPic, lossRate: lossRate,
        gamePlay: gamePlay, conflict: _con);
  }
}

class GameModel1 extends GameModel {
  GameModel1({required this.plays,
    required String gameName,
    required String gameNameLan,
    required String description
  }): super(gamePlays: [], gameName: gameName,
      description: description, gameNameLan: gameNameLan);

  final List<Game1Plays> plays;
  final int type = 1;

  factory GameModel1.fromJson(Map<String, dynamic> json){
    String gameName = json["gameName"];
    String description = json["explain"] ?? "";
    String gameLan = json["gameNameLan"] ?? "";
    String showFlag = (json["showFlag"] ?? "0").toString();
    List g = json["gamePlays"] ?? [];
    List<Game1Plays> gamePlays = g.map((e) => Game1Plays.fromJson(e)).toList();

    return GameModel1(
      plays: gamePlays,
      gameName: gameName,
      gameNameLan: gameLan,
      description: description
    )..showFlag = showFlag == "1";
  }

  @override
  void tapIndex(int index) {
    plays[this.index.value].onTapIndex(index);
  }

  @override
  // TODO: implement onDelete
  InternalFinalCallback<void> get onDelete {
    return super.onDelete;
  }

  @override
  void clear(){
    this.plays.forEach((element) {
      if (element.isTab) {
        // element._index.value = 0;
      }else {
        element._selectIndexes.value = [];
      }
      element._indexes = [];
      element.options.forEach((element) {
        element._onClean();
      });
    });
  }

  @override
  Map<String, dynamic>? submit(String id) {
    Map<String, dynamic> result = {};
    result["gameName"] = gameName;
    result["periodTime"] = lastPeriodTime;
    result["anchorId"] = id;

    var ll = plays.map((e){
      if (e.isTab)
        return e.options;
      else {
        return e.options.where((element) {
          int index = e.options.indexOf(element);
          return e.selectIndexes.contains(index);
        }).toList();
      }
    }).reduce((value, element) => value + element);
    var l = ll.where((element) {
      // int index = gamePlays.indexOf(element);
      // var bets = _bets[index];
      // element.selectIndexes = bets;
      return element.selectIndexes.isNotEmpty;
    }).map((e) => e.selectIndexes.map((e1) => {
      "gamePlay": e.options[e1].gamePlay,
      "betNum": _betNum.value,
      "betValue": e.options[e1].betValue
    }).toList()).toList();
    if (l.length == 0) {
      return null;
    }
    /// 具体数据
    result["betList"] = l.reduce((value, element) => value + element);
    return result;
  }

  /// 上一排结果
  RxString _racingGameResult = "".obs;
  RxString get racingGameResult => _racingGameResult;
  /// 计算结果
  RxString _racingGameResult1 = "".obs;
  RxString get racingGameResult1 => _racingGameResult1;

  @override
  void _setData(Map<String, dynamic> json) async{
    _racingGameResult1.value = "";
    for(int i = 0; i <= 9; i ++) {
      List<int> r = List.generate(10, (index) => math.Random().nextInt(9) + 1);
      _racingGameResult.value = r.join(",");
      await Future.delayed(Duration(milliseconds: 100));
    }
    await Future.delayed(Duration(milliseconds: 100));
    String result = json["lastGameResultStr"];
    List<String> r1 = result.split("+");
    if (r1.length < 2)
      return;
    json["lastGameResultStr"] = r1[0] + "+" + r1[1].split(",").map((e) => "_" + e).join(",");
    super._setData(json);
    List<String> r = this._lastGameResult.value.split("+");
    _racingGameResult.value = r[0];
    _racingGameResult1.value = r[1];
  }
}

class Game1Plays {
  Game1Plays({required this.tabName, required this.options,
    required this.selectType,
    required this.tabType});
  final String tabName;
  final String tabType;
  final String selectType;

  bool get isTab => selectType != "1";
  final List<PlayOption> options;

  RxInt _index = 0.obs;
  RxInt get index => _index;
  /// option
  RxList<int> _selectIndexes = <int>[].obs;
  RxList<int> get selectIndexes => _selectIndexes;
  
  List<int> _indexes = [];

  /// 选中选项
  void onTap(int index){
    if(isTab) {
      _index.value = index;
    }else {
      if (_selectIndexes.contains(index)) {
        _selectIndexes.remove(index);
        if (index != 0) {
          options[index]._onClean();
        }
        if (_selectIndexes.length == 0) {
          options[0]._onClean();
          _indexes = [];
        }
      }else {
        _selectIndexes.add(index);
        options[index]._onSync(_indexes);
      }
    }
  }

  /// 选中下标
  void onTapIndex(int index){
    if (isTab) {
      options[_index.value]._tapIndex(index);
    }else {
      if (_selectIndexes.isEmpty)
        return;
      options[0]._tapIndex(index);
      _indexes = options[0].selectIndexes.toList();
      for(int i = 1; i < options.length; i ++) {
        options[i]._onSync(_indexes);
      }
    }
  }

  factory Game1Plays.fromJson(Map<String, dynamic> json){
    String tabName = json["tabName"] ?? "";
    String tabType = json["tabType"];
    String selectType = json["selectType"];
    List g = json["options"] ?? [];
    List<PlayOption> gamePlays = [];
    if (g.length > 0 && !g[0].containsKey("options")) {
      gamePlays = [
        {
          "playName": "",
          "gamePlay": "",
          "options": g,
          "show": false
        }
      ].map((e) => PlayOption.fromJson(e)).toList();
    }else {
      gamePlays = g.map((e) => PlayOption.fromJson(e)).toList();
    }
    return Game1Plays(
      tabName: tabName,
      tabType: tabType,
      selectType: selectType,
      options: gamePlays
    );
  }
}

class Game2Model extends GameModel {
  Game2Model({required String gameName,
    required String gameNameLan,
    required String description,
    required this.optionDetails
  }): super(
    gameNameLan: gameNameLan,
    gameName: gameName,
    gamePlays: [],
    description: description
  );

  @override
  // TODO: implement type
  int get type => 2;

  /// 选项
  final List<_OptionDetail1> optionDetails;

  factory Game2Model.fromJson(Map<String, dynamic> json){
    String gameName = json["gameName"];
    String description = json["explain"] ?? "";
    String gameLan = json["gameNameLan"] ?? "";
    String showFlag = (json["showFlag"] ?? "0").toString();
    List g = json["gamePlays"] ?? [];
    List<List> g1 = g.map((e) => e["options"] as List).toList();
    List<_OptionDetail1> d = g1.reduce((value, element) =>
      value + element).map((e) =>
      _OptionDetail1.fromJson(e)).toList();
    return Game2Model(gameName: gameName,
        gameNameLan: gameLan,
        description: description,
        optionDetails: d)..showFlag = showFlag == "1";
  }

  @override
  void tapIndex(int index) {
    // TODO: implement tapIndex
    this.optionDetails[index].addBet(this.betNum.value);
  }

  @override
  void _setData(Map<String, dynamic> json) {
    // TODO: implement _setData
    String? value = json["lastGameResultStr"];
    if (value == null)
      return;
    List<String> values = value.split("+");
    String mid = values[1] + ",," + values[2];
    json["lastGameResultStr"] = mid;
    super._setData(json);
    _midValue.value = values[1];
    _mid1Value.value = values[2];
    _leftValue.value = values[0];
    _rightValue.value = values[3];
  }

  RxString _leftValue = "".obs;
  RxString get leftValue => _leftValue;
  RxString _rightValue = "".obs;
  RxString get rightValue => _rightValue;
  RxString _midValue = "".obs;
  RxString get midValue => _midValue;

  RxString _mid1Value = "".obs;
  RxString get mid1Value => _mid1Value;

  @override
  Map<String, dynamic>? submit(String id) {
    Map<String, dynamic> result = {};
    result["gameName"] = gameName;
    result["periodTime"] = lastPeriodTime;
    result["anchorId"] = id;
    var l = this.optionDetails.where((element) {
      return element._bet.value > 0;
    }).map((e) => {
      "gamePlay": e.gamePlay,
      "betNum": e._bet.value,
      "betValue": e.betValue
    }).toList();
    if (l.length == 0) {
      return null;
    }
    /// 具体数据
    result["betList"] = l;
    return result;
  }

  @override
  void clear() {
    this.optionDetails.forEach((element) {
      element.clean();
    });
  }
}

class _OptionDetail1 extends _OptionDetail {
  _OptionDetail1({required String betPic,
    required String betValue,
    required String gamePlay,
    required String lossRate,
    required List<String> conflict
  }): super(betPic: betPic,
    betValue: betValue,
    gamePlay: gamePlay,
    conflict: conflict,
    lossRate: lossRate
  );

  RxInt _bet = 0.obs;
  RxInt get bet => _bet;

  factory _OptionDetail1.fromJson(Map<String, dynamic> json) {
    String betValue = json["betValue"];
    String betPic = json["betPic"];
    String lossRate = json["lossRate"];
    String gamePlay = json["gamePlay"];
    String conflict = json["conflict"] ?? "";
    List<String> _con = conflict.isEmpty ? [] : conflict.split(",");
    return _OptionDetail1(
      betValue: betValue,
      betPic: betPic,
      gamePlay: gamePlay,
      conflict: _con,
      lossRate: lossRate
    );
  }

  void clean(){
    _bet.value = 0;
  }

  void addBet(int value){
    _bet.value = _bet.value + value;
  }
}