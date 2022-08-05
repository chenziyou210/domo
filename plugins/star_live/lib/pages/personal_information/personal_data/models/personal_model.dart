// To parse this JSON data, do
//
//     final personalModel = personalModelFromJson(json);

import 'dart:convert';

PersonalModel personalModelFromJson(Map<String, dynamic> json) => PersonalModel.fromJson(json);

String personalModelToJson(PersonalModel data) => json.encode(data.toJson());

class PersonalModel {
  PersonalModel({
    this.adminFlag,
    this.age,
    this.attentionNum,
    this.birthday,
    this.city,
    this.emotion,
    this.fansNum,
    this.follow,
    this.header,
    this.heat,
    this.nobleType,
    this.openLiveFlag,
    this.profession,
    this.rank,
    this.rankUserList,
    this.receivedGiftNum,
    this.sendGiftNum,
    this.sex,
    this.shortId,
    this.signature,
    this.speakBan,
    this.state,
    this.totalHeat,
    this.username,
    this.watchType,
  });

  int? adminFlag;
  int? age;
  int? attentionNum;
  String? birthday;
  String? city;
  String? emotion;
  int? fansNum;
  bool? follow;
  String? header;
  int? heat;
  int? nobleType;
  int? openLiveFlag;
  String? profession;
  int? rank;
  List<dynamic>? rankUserList;
  int? receivedGiftNum;
  int? sendGiftNum;
  int? sex;
  String? shortId;
  String? signature;
  int? speakBan;
  int? state;
  int? totalHeat;
  String? username;
  int? watchType;

  factory PersonalModel.fromJson(Map<String, dynamic> json) => PersonalModel(
    adminFlag: json["adminFlag"],
    age: json["age"],
    attentionNum: json["attentionNum"],
    birthday: json["birthday"],
    city: json["city"],
    emotion: json["emotion"],
    fansNum: json["fansNum"],
    follow: json["follow"],
    header: json["header"],
    heat: json["heat"],
    nobleType: json["nobleType"],
    openLiveFlag: json["openLiveFlag"],
    profession: json["profession"],
    rank: json["rank"],
    rankUserList: List<dynamic>.from(json["rankUserList"].map((x) => x)),
    receivedGiftNum: json["receivedGiftNum"],
    sendGiftNum: json["sendGiftNum"],
    sex: json["sex"],
    shortId: json["shortId"],
    signature: json["signature"],
    speakBan: json["speakBan"],
    state: json["state"],
    totalHeat: json["totalHeat"],
    username: json["username"],
    watchType: json["watchType"],
  );

  Map<String, dynamic> toJson() => {
    "adminFlag": adminFlag,
    "age": age,
    "attentionNum": attentionNum,
    "birthday": birthday,
    "city": city,
    "emotion": emotion,
    "fansNum": fansNum,
    "follow": follow,
    "header": header,
    "heat": heat,
    "nobleType": nobleType,
    "openLiveFlag": openLiveFlag,
    "profession": profession,
    "rank": rank,
    "rankUserList": List<dynamic>.from(rankUserList ?? [].map((x) => x)),
    "receivedGiftNum": receivedGiftNum,
    "sendGiftNum": sendGiftNum,
    "sex": sex,
    "shortId": shortId,
    "signature": signature,
    "speakBan": speakBan,
    "state": state,
    "totalHeat": totalHeat,
    "username": username,
    "watchType": watchType,
  };
}
