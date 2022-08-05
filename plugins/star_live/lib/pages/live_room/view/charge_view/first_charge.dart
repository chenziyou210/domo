class FirstChargeRewardEntity {
  AwardInfo? awardInfo;
  int? rechargeMoney;

  FirstChargeRewardEntity({this.awardInfo, this.rechargeMoney});

  FirstChargeRewardEntity.fromJson(Map<String, dynamic> json) {
    awardInfo = json['awardInfo'] != null
        ? new AwardInfo.fromJson(json['awardInfo'])
        : null;
    rechargeMoney = json['rechargeMoney'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.awardInfo != null) {
      data['awardInfo'] = this.awardInfo!.toJson();
    }
    data['rechargeMoney'] = this.rechargeMoney;
    return data;
  }

  @override
  String toString() {
    return 'FirstChargeRewardEntity{awardInfo: $awardInfo, rechargeMoney: $rechargeMoney}';
  }
}

class AwardInfo {
  List<Gift>? gift;
  String? diamond;
  String? bonus;
  List<Tool>? tool;

  AwardInfo({this.gift, this.diamond, this.bonus, this.tool});

  AwardInfo.fromJson(Map<String, dynamic> json) {
    if (json['gift'] != null) {
      gift = <Gift>[];
      json['gift'].forEach((v) {
        gift!.add(new Gift.fromJson(v));
      });
    }
    diamond = json['diamond'];
    bonus = json['bonus'];
    if (json['tool'] != null) {
      tool = <Tool>[];
      json['tool'].forEach((v) {
        tool!.add(new Tool.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.gift != null) {
      data['gift'] = this.gift!.map((v) => v.toJson()).toList();
    }
    data['diamond'] = this.diamond;
    data['bonus'] = this.bonus;
    if (this.tool != null) {
      data['tool'] = this.tool!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'AwardInfo{gift: $gift, diamond: $diamond, bonus: $bonus, tool: $tool}';
  }
}

class Gift {
  String? giftIcon;
  int? coins;
  String? giftName;
  int? num;
  int? giftTag;

  Gift({this.giftIcon, this.coins, this.giftName, this.num, this.giftTag});

  Gift.fromJson(Map<String, dynamic> json) {
    giftIcon = json['giftIcon'];
    coins = json['coins'];
    giftName = json['giftName'];
    num = json['num'];
    giftTag = json['giftTag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['giftIcon'] = this.giftIcon;
    data['coins'] = this.coins;
    data['giftName'] = this.giftName;
    data['num'] = this.num;
    data['giftTag'] = this.giftTag;
    return data;
  }

  @override
  String toString() {
    return 'Gift{giftIcon: $giftIcon, coins: $coins, giftName: $giftName, num: $num, giftTag: $giftTag}';
  }
}

class Tool {
  String? itemName;
  int? itemTag;
  String? itemIcon;
  int? num;

  Tool({this.itemName, this.itemTag, this.itemIcon, this.num});

  Tool.fromJson(Map<String, dynamic> json) {
    itemName = json['itemName'];
    itemTag = json['itemTag'];
    itemIcon = json['itemIcon'];
    num = json['num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemName'] = this.itemName;
    data['itemTag'] = this.itemTag;
    data['itemIcon'] = this.itemIcon;
    data['num'] = this.num;
    return data;
  }
}