// To parse this JSON data, do
//
//     final gameRecord = gameRecordFromJson(jsonString);

import 'dart:convert';

GameRecord gameRecordFromJson(Map<String, dynamic> json) =>
    GameRecord.fromJson(json);

String gameRecordToJson(GameRecord data) => json.encode(data.toJson());

class GameRecord {
  GameRecord({
    this.sumWinMoney,
    this.record,
    this.sumBetMoney,
  });

  double? sumWinMoney;
  List<Record>? record;
  double? sumBetMoney;

  factory GameRecord.fromJson(Map<String, dynamic> json) => GameRecord(
        sumWinMoney: json["sumWinMoney"].toDouble(),
        record:
            List<Record>.from(json["record"].map((x) => Record.fromJson(x))),
        sumBetMoney: json["sumBetMoney"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "sumWinMoney": sumWinMoney,
        "record": List<dynamic>.from(record ?? [].map((x) => x.toJson())),
        "sumBetMoney": sumBetMoney,
      };
}

class Record {
  Record({
    this.companyName,
    this.companyId,
    this.icon,
    this.betCnt,
    this.bet,
    this.win,
  });

  String? companyName;
  String? companyId;
  String? icon;
  String? betCnt;
  String? bet;
  String? win;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        companyName: json["companyName"],
        companyId: json["companyId"],
        icon: json["icon"],
        betCnt: json["betCnt"],
        bet: json["bet"],
        win: json["win"],
      );

  Map<String, dynamic> toJson() => {
        "companyName": companyName,
        "companyId": companyId,
        "icon": icon,
        "betCnt": betCnt,
        "bet": bet,
        "win": win,
      };
}
