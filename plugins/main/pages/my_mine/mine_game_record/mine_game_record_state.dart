import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'models/game_record_model.dart';
import 'models/gane_bet_record_model.dart';

enum GameRecordType { today, yesterday }

enum LoadType {
  refreshData,
  loadingData,
  loadMoreData,
  noMoreData,
  noData,
}

class MineGameRecordState {
  final List<String> titles = ["今日", "昨日"];
  late RefreshController todayRefreshController = RefreshController();
  late RefreshController yesterdayRefreshController = RefreshController();
  late RefreshController betRefreshController = RefreshController();
  late BuildContext context;
  late Record record;
  int page = 1;
  int type = 1;
  LoadType loadType = LoadType.loadingData;

  GameRecord todayGameRecord = GameRecord();
  GameRecord yesterdayGameRecord = GameRecord();
  List<Record> todayRecordList = [];
  List<Record> yesterdayRecordList = [];
  List<GameBetRecord> betRecordList = [];
  bool onLoading = true;

  MineGameRecordState() {
    ///Initialize variables
  }
}
