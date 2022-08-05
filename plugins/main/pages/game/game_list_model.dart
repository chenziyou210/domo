class GameList {
  List<GameItem>? game;
  String? name;
  String? iconUrl;
  int? categoryId;

  GameList({this.game, this.name, this.iconUrl, this.categoryId});

  GameList.fromJson(Map<String, dynamic> json) {
    if (json['game'] != null) {
      game = <GameItem>[];
      json['game'].forEach((v) {
        game!.add(new GameItem.fromJson(v));
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
}

class GameItem {
  String? gameId;
  String? gameIconUrl;
  String? gameName;
  int? gameCompanyId;

  GameItem({this.gameId, this.gameIconUrl, this.gameName, this.gameCompanyId});

  GameItem.fromJson(Map<String, dynamic> json) {
    gameId = json['gameId'].toString();
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
