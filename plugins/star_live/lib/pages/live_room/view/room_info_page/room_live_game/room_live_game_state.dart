import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// @description:
/// @author
/// @date: 2022-06-20 15:58:22
class RoomLiveGameState {
  RxBool visible = true.obs;
  RoomLiveGameState() {
    visible = true.obs;

    ///Initialize variables
  }
  RxList<RoomLiveGameList> gameList = <RoomLiveGameList>[].obs;
  setUpdataGameList(List<RoomLiveGameList> value) {
    gameList.value = value;
  }

  String? roomId;
  TabController? tabController;

  ///是否是主播
  bool? isAnchor;

  RxList<GameListData> gameListData = <GameListData>[].obs;
  setUpdateGameListData(List<GameListData> value) {
    gameListData.value = value;
  }
}

class RoomLiveGameList {
  int? id;
  String? name;
  String? intro;

  ///玩法
  String? description;
  String? icon;
  int? interval;
  int? close;
  RoomLiveGameList(
      {this.id,
      this.name,
      this.intro,
      this.description,
      this.interval,
      this.close,
      this.icon});

  RoomLiveGameList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    intro = json['intro'];
    description = json['description'];
    interval = json['interval'];
    close = json['close'];
    icon = json["icon"];
  }

  @override
  String toString() {
    return 'RoomLiveGameList{id: $id, name: $name, intro: $intro, description: $description, icon: $icon, close: $close}';
  }
}

class GameListData {
  List<GameData>? game;
  String? name;
  String? iconUrl;
  int? categoryId;
  bool isSeledet = false;

  GameListData({this.game, this.name, this.iconUrl, this.categoryId,required this.isSeledet});

  GameListData.fromJson(Map<String, dynamic> json) {
    if (json['game'] != null) {
      game = <GameData>[];
      json['game'].forEach((v) {
        game!.add(new GameData.fromJson(v));
      });
    }
    name = json['name'];
    iconUrl = json['iconUrl'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.game != null) {
      data['game'] = this.game!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['iconUrl'] = this.iconUrl;
    data['categoryId'] = this.categoryId;
    return data;
  }

  @override
  String toString() {
    return 'GameListData{game: $game, name: $name, iconUrl: $iconUrl, categoryId: $categoryId, isSeledet: $isSeledet}';
  }
}

class GameData {
  int? gameId;
  String? gameIconUrl;
  String? gameName;
  int? gameCompanyId;

  GameData({this.gameId, this.gameIconUrl, this.gameName, this.gameCompanyId});

  GameData.fromJson(Map<String, dynamic> json) {
    gameId = json['gameId'];
    gameIconUrl = json['gameIconUrl'];
    gameName = json['gameName'];
    gameCompanyId = json['gameCompanyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gameId'] = this.gameId;
    data['gameIconUrl'] = this.gameIconUrl;
    data['gameName'] = this.gameName;
    data['gameCompanyId'] = this.gameCompanyId;
    return data;
  }
}
