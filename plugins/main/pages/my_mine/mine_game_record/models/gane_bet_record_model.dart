// To parse this JSON data, do
//
//     final gameBetRecord = gameBetRecordFromJson(jsonString);

import 'dart:convert';

GameBetRecord gameBetRecordFromJson(Map<String, dynamic> json) =>
    GameBetRecord.fromJson(json);

String gameBetRecordToJson(GameBetRecord data) => json.encode(data.toJson());

class GameBetRecord {
  GameBetRecord({
    this.bet,
    this.createTime,
    this.gameName,
    this.win,
  });

  String? bet;
  String? createTime;
  String? gameName;
  String? win;

  factory GameBetRecord.fromJson(Map<String, dynamic> json) => GameBetRecord(
        bet: json["bet"],
        createTime: json["createTime"],
        gameName: json["gameName"],
        win: json["win"],
      );

  Map<String, dynamic> toJson() => {
        "bet": bet,
        "createTime": createTime,
        "gameName": gameName,
        "win": win,
      };
}
