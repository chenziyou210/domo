import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:star_common/common/app_common_widget.dart';

HomeSearchModel searchModelFromJson(String str) =>
    HomeSearchModel.fromJson(json.decode(str));

String searchModelToJson(HomeSearchModel data) => json.encode(data.toJson());

class HomeSearchModel {
  HomeSearchModel({
    this.header,
    this.rank,
    this.roomId,
    this.sex,
    this.signature,
    this.state,
    this.userId,
    this.username,
  });

  String? header;
  String? username;
  String? signature;
  int? rank;
  int? roomId;
  int? sex;
  int? state;
  int? userId;

  factory HomeSearchModel.fromJson(Map<String, dynamic> json) =>
      HomeSearchModel(
        header: json["header"],
        rank: json["rank"],
        roomId: json["roomId"],
        sex: json["sex"],
        signature: json["signature"],
        state: json["state"],
        userId: json["userId"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "header": header,
        "rank": rank,
        "roomId": roomId,
        "sex": sex,
        "signature": signature,
        "state": state,
        "userId": userId,
        "username": username,
      };
}

class HomeSearchViewState {
  HomeSearchViewState() {
    ///Initialize variables
  }

  late var myController = TextEditingController(); //输入监听
  final focusNode = FocusNode(); //焦点
  final RxString inputText = "".obs;
  final RxBool isSearch = false.obs;
  final List<HomeSearchModel> searchList = []; //模糊匹配使用
  // late HomeSearchModel searchModel ; //精确匹配

  Color searchTextColor() {
    bool change = this.inputText.value.length > 0;
    return change ? AppMainColors.mainColor : AppMainColors.whiteColor40;
  }
}
