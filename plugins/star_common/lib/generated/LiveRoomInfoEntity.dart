class LiveRoomInfoEntity {
  int? coins;
  int? feeTyp;
  int? feeType;
  String? gameIcon;
  int? gameId;
  String? gameName;
  int? guardCount;
  String? header;
  int? heat;
  bool? isFollowed;
  int? isNameCardOpen;
  String? roomBackground;
  String? roomCover;
  int? roomId;
  int? roomType;
  int? seeTryTime;
  int? ticketAmount;
  int? timeDeduction;
  String? title;
  String? userId;
  String? username;
  String? shareAddress;
  String? shortId;

  LiveRoomInfoEntity(
      {this.coins,
        this.feeTyp,
        this.feeType,
        this.gameIcon,
        this.gameId,
        this.gameName,
        this.guardCount,
        this.header,
        this.heat,
        this.isFollowed,
        this.isNameCardOpen,
        this.roomBackground,
        this.roomCover,
        this.roomId,
        this.roomType,
        this.seeTryTime,
        this.ticketAmount,
        this.timeDeduction,
        this.shareAddress,
        this.title,
        this.userId,
        this.username,
        this.shortId,
      });

  LiveRoomInfoEntity.fromJson(Map<String, dynamic> json) {
    coins = json['coins'];
    feeTyp = json['feeTyp'];
    feeType = json['feeType'];
    gameIcon = json['gameIcon'];
    gameId = json['gameId'];
    gameName = json['gameName'];
    guardCount = json['guardCount'];
    header = json['header'];
    heat = json['heat'];
    isFollowed = json['isFollowed'];
    isNameCardOpen = json['isNameCardOpen'];
    roomBackground = json['roomBackground'];
    roomCover = json['roomCover'];
    roomId = json['roomId'];
    roomType = json['roomType'];
    seeTryTime = json['seeTryTime'];
    ticketAmount = json['ticketAmount'];
    timeDeduction = json['timeDeduction'];
    title = json['title'];
    userId = json['userId'];
    username = json['username'];
    shareAddress = json['shareAddress'];
    shortId = json['shortId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coins'] = this.coins;
    data['feeTyp'] = this.feeTyp;
    data['feeType'] = this.feeType;
    data['gameIcon'] = this.gameIcon;
    data['gameId'] = this.gameId;
    data['gameName'] = this.gameName;
    data['guardCount'] = this.guardCount;
    data['header'] = this.header;
    data['heat'] = this.heat;
    data['isFollowed'] = this.isFollowed;
    data['isNameCardOpen'] = this.isNameCardOpen;
    data['roomBackground'] = this.roomBackground;
    data['roomCover'] = this.roomCover;
    data['roomId'] = this.roomId;
    data['roomType'] = this.roomType;
    data['seeTryTime'] = this.seeTryTime;
    data['ticketAmount'] = this.ticketAmount;
    data['timeDeduction'] = this.timeDeduction;
    data['title'] = this.title;
    data['userId'] = this.userId;
    data['username'] = this.username;
    data['shareAddress'] = this.shareAddress;
    data['shortId'] = this.shortId;
    return data;
  }
}