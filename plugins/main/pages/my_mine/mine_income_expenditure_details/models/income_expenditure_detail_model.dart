// To parse this JSON data, do
//
//     final incomeExpenditureDetails = incomeExpenditureDetailsFromJson(jsonString);

import 'dart:convert';

IncomeExpenditureDetails incomeExpenditureDetailsFromJson(
        Map<String, dynamic> json) =>
    IncomeExpenditureDetails.fromJson(json);

String incomeExpenditureDetailsToJson(IncomeExpenditureDetails data) =>
    json.encode(data.toJson());

class IncomeExpenditureDetails {
  IncomeExpenditureDetails({
    this.pageNum,
    this.pageSize,
    this.pages,
    this.totalAmount,
    this.data,
  });

  int? pageNum;
  int? pageSize;
  int? pages;
  int? totalAmount;
  List<Detail>? data;

  factory IncomeExpenditureDetails.fromJson(Map<String, dynamic> json) =>
      IncomeExpenditureDetails(
        pageNum: json["pageNum"],
        pageSize: json["pageSize"],
        pages: json["pages"],
        totalAmount: json["totalAmount"],
        data: List<Detail>.from(json["data"].map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pageNum": pageNum,
        "pageSize": pageSize,
        "pages": pages,
        "totalAmount": totalAmount,
        "data": List<dynamic>.from(data ?? [].map((x) => x.toJson())),
      };
}

class Detail {
  Detail({
    this.itemName,
    this.type,
    this.consumeType,
    this.consumeTitle,
    this.coin,
    this.consumeTime,
  });

  String? itemName;
  int? type;
  int? consumeType;
  String? consumeTitle;
  String? coin;
  String? consumeTime;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        itemName: json["itemName"],
        type: json["type"],
        consumeType: json["consumeType"],
        consumeTitle: json["consumeTitle"],
        coin: json["coin"],
        consumeTime: json["consumeTime"],
      );

  Map<String, dynamic> toJson() => {
        "itemName": itemName,
        "type": type,
        "consumeType": consumeType,
        "consumeTitle": consumeTitle,
        "coin": coin,
        "consumeTime": consumeTime,
      };
}
