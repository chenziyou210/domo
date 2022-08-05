// To parse this JSON data, do
//
//     final mineBagModel = mineBagModelFromJson(jsonString);

import 'dart:convert';

MineBagModel mineBagModelFromJson(Map<String, dynamic> json) => MineBagModel.fromJson(json);

String mineBagModelToJson(MineBagModel data) => json.encode(data.toJson());

class MineBagModel {
  MineBagModel({
    this.itemTag,
    this.num,
    this.picUrl,
    this.itemName,
  });

  int? itemTag;
  int? num;
  String? picUrl;
  String? itemName;

  factory MineBagModel.fromJson(Map<String, dynamic> json) => MineBagModel(
    itemTag: json["itemTag"],
    num: json["num"],
    picUrl: json["picUrl"],
    itemName: json["itemName"],
  );

  Map<String, dynamic> toJson() => {
    "itemTag": itemTag,
    "num": num,
    "picUrl": picUrl,
    "itemName": itemName,
  };
}
