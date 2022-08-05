/*
 *  Copyright (C), 2015-2021
 *  FileName: user
 *  Author: Tonight丶相拥
 *  Date: 2021/7/29
 *  Description: 
 **/

part of appmanager;

class AppUser extends CommonNotifierModel  {
  AppUser._();
  void fromJson(Map<String, dynamic> json,
      [bool needSetToken = true, bool needNotification = true]) {
    _fromJson(json, needNotification);
  }

  void _fromJson(Map<String, dynamic> json, [bool needNotification = true]) {
    this.attentionNum = json["attentionNum"];
    this.sendGiftNum = json["sendGiftNum"];
    this.fansNum = json["fansNum"];
    this.signature = json["signature"];
    this.username = json["username"];
    this.header = json["header"];
    this._rank = json["rank"] ?? 0;
    this._userId = json["userId"].toString();
    this._sex = json["sex"];
    this._birthday = json["birthday"];
    this._reward = double.tryParse(json["reward"].toString());
    this._recharge = double.tryParse(json["recharge"].toString());
    this._constellation = json["constellation"];
    this._profession = json["profession"];
    this._hometown = json["hometown"];
    this._feeling = json["feeling"];
    this._chatPassword = json["chatPassword"];
    this._chatUsername = json["chatUsername"];
    this._enableOpenLive = json["openLiveFlag"];
    this.withdrawPasswordFlag = json["withdrawPasswordFlag"] ?? 0;
    this._shortId = json["shortId"];
    this._phone = json["phone"];
    this._freeCoins = json["freeCoins"];
    this._carUrl = json["carUrl"];
    this._nobleLevel = json["nobleType"];
    this._nobleName = json["nobleName"];
    this._roomCover = json["roomCover"];
    this._region = json["region"];
    this._mute = json["mute"];
    this._roomBackground = json["roomBackground"];
    this._receiveGiftNum = json["receiveGiftNum"];
    this._balance = json["balance"];
    this._age = json["age"];
    if (this.hasListeners && needNotification) {
      this.notifyListeners();
    }
  }



  // 更新数据
  void userUpdate(UserInfoModel model) {
    this._birthday = model.birthday;
    this._hometown = model.hometown;
    this._feeling = model.feeling;
    this.header = model.avatar;
    this._profession = model.profession;
    this._sex = model.sex;
    this.signature = model.signature;
    updateState();
  }

  void userUpdateNickName(String name) {
    this.username = name;
    updateState();
  }

  void chargeNobleLevel(int nobleLevel) {
    this._nobleLevel = nobleLevel;
    updateState();
  }

  void chargeCarUrl(String carUrl) {
    this._carUrl = carUrl;
    updateState();
  }

  void userUpdatePhone(String phone) {
    this._phone = phone;
    updateState();
  }

  void updateRoomCover(String roomCover) {
    this._roomCover = roomCover;
    updateState();
  }

  void updateRoomBackground(String roomBackground) {
    this._roomBackground = roomBackground;
    updateState();
  }

  void userUpdateIM(IMRoomAccountEntity entry) {
    // this.birthday = json["birthday"];
    // this.hometown = json["city"];
    // this.feeling = json["emotion"];
    this._chatUsername = entry.chatUsername;
    this._chatPassword = entry.chatPassword;
    updateState();
  }

  void updateData(Map<String, dynamic> json) {
    this._birthday = json["birthday"];
    this._hometown = json["city"];
    this._feeling = json["emotion"];
    this.header = json["header"];
    this.username = json["name"];
    this._profession = json["profession"];
    this._sex = json["sex"];
    this.signature = json["signature"];
    if (this.hasListeners) {
      this.notifyListeners();
    }
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    Map<String, dynamic> json = toJson();
    json["attentionNum"] = this.attentionNum;
    json["sendGiftNum"] = this.sendGiftNum;
    json["fansNum"] = this.fansNum;
    json["signature"] = this.signature;
    json["name"] = this.username;
    json["header"] = this.header;
    json["rank"] = this.rank ?? 0;
    json["userId"] = this._userId;
    json["withdraw"] = this.withdraw ?? 0.0;
    json["sex"] = this._sex;
    json["birthday"] = this._birthday;
    json["reward"] = this._reward;
    json["recharge"] = this._recharge;
    json["profession"] = this._profession;
    json["constellation"] = this._constellation;
    json["profession"] = this._profession;
    json["hometown"] = this._hometown;
    json["feeling"] = this._feeling;
    json["chatUsername"] = this._chatUsername;
    json["chatPassword"] = this._chatPassword;
    json["openLiveFlag"] = this._enableOpenLive;
    json["withdrawPasswordFlag"] = this.withdrawPasswordFlag;
    json["shortId"] = this._shortId;
    json["phone"] = this._phone;
    json["carUrl"] = this._carUrl;
    json["nobleType"] = this._nobleLevel;
    json["nobleName"] = this._nobleName;
    json["roomCover"] = this._roomCover;
    json["roomBackground"] = this._roomBackground;
    json["mute"] = this._mute;
    json["receiveGiftNum"] = this._receiveGiftNum;
    json["balance"] = this._balance;
    json["age"] = this._age;
    return json;
  }



  void addAttention() {
    this.attentionNum = (this.attentionNum ?? 0) + 1;
    updateState();
  }

///全局禁言更新
  void upDataMute(int mute) {
    this._mute = mute;
    updateState();
  }

  ///用户等级变更
  void upDataRank(int rank) {
    this._rank = rank;
    updateState();
  }

  void removeAttention() {
    if (this.attentionNum != null && this.attentionNum! > 0) {
      this.attentionNum = this.attentionNum! - 1;
      updateState();
    }
  }


  void chargeUserFreeCoins(int freeCoins) {
    this._freeCoins = freeCoins;
    updateState();
  }

  void chargeUserWithdrawPasswordFlag(int flag) {
    this.withdrawPasswordFlag = flag;
    updateState();
  }

  void logOut() {
    this.fromJson({}, true, false);
  }

  void updateMoney(Map<String, dynamic> json) {
    var key = "coins";
    if (json.containsKey(key))
      this._coins = double.tryParse(json[key].toString()) ?? this.coins;
    key = "lockMoney";
    if (json.containsKey(key))
      this._lockMoney =
          double.tryParse(json[key].toString()) ?? this._lockMoney;
    updateState();
  }

  // bool get isExpire => DateTime.now().isAfter(_expire ?? DateTime.now().subtract(Duration(days: 1)));

  // 关注
  int? attentionNum;
  // 送出礼物
  int? sendGiftNum;
  // 粉丝
  int? fansNum;

  // // 钱包
  // double? wallet;
  // 签名
  String? signature;
  // 名称
  String? username;
  // 头像
  String? header;

  // 等级
  int? _rank;
  int? get rank => _rank;

  // 用户id
  String? _userId;
  String? get userId => _userId;

  // 提现
  double? withdraw;

  /// 签名 生成UserSig
  String? _userSig;
  String? get userSig => _userSig;
  String? studioToken;

  /// 性别
  int? _sex;
  int? get sex => _sex;

  /// 生日
  String? _birthday;
  String? get birthday => _birthday;

  /// 账户id
  String? _accountId;
  String? get accountId => _accountId;

  /// 可提现余额
  double? _coins;
  double? get coins => _coins;

  /// 不可提现余额
  double? _lockMoney;
  double? get lockMoney => _lockMoney;

  /// 酬金
  double? _reward;
  double? get reward => _reward;

  /// 充值
  double? _recharge;
  double? get recharge => _recharge;

  /// 未知字段
  double? _guestLoss;
  double? get guestLoss => _guestLoss;

  /// 星座
  String? _constellation;
  String? get constellation => _constellation;

  /// 职业
  String? _profession;
  String? get profession => _profession;

  /// 城镇
  String? _hometown;
  String? get hometown => _hometown;

  /// 情感
  String? _feeling;
  String? get feeling => _feeling;

  /// 送出
  int? _sendOut;
  int? get sendOut => _sendOut;

  String? _hxPassword;
  String? get hxPassword => _hxPassword;
  int? _enableOpenLive;
  bool get enableOpenLive => _enableOpenLive != null && _enableOpenLive == 1;
  String? withdrawPassword;
  bool get withdrawIsNull =>
      withdrawPassword == null || withdrawPassword!.isEmpty;

  String? _chatUsername;
  String? get chatUsername => _chatUsername;

  String? _chatPassword;
  String? get chatPassword => _chatPassword;

  ///是否有提现密码 0:否 1:是
  int? withdrawPasswordFlag;

  /// 用户短ID,用于显示
  String? _shortId;
  String? get shortId => _shortId;

  /// 手机号
  String? _phone;
  String? get phone => _phone;

   int? _freeCoins;

  ///赠送钻石数
  int? get freeCoins => _freeCoins;

  /// 坐骑gif
  String? _carUrl;
  String? get carUrl => _carUrl;

  /// 主播专用
  String? _roomCover;
  String? get roomCover => _roomCover;

  String? _roomBackground;
  String? get roomBackground => _roomBackground;

  /// 用户地区
  String? _region;
  String? get region => _region;

  /// 贵族等级
  int? _nobleLevel;
  int? get nobleLevel => _nobleLevel;

  /// 贵族名称
  String? _nobleName;
  String? get nobleName => _nobleName;

  /// 全局禁言字段
  int? _mute;
  int? get mute => _mute;

  /// 收到的礼物
  int? _receiveGiftNum;
  int? get receiveGiftNum => _receiveGiftNum;

  /// 余额
  double? _balance;
  double? get balance => _balance;

  /// 年龄
  int? _age;
  int? get age => _age;
}




