import 'package:flutter/material.dart';

/// @description:
/// @author
/// @date: 2022-06-17 13:27:41
class BindWalletAddressState {
  BindWalletAddressState() {
    ///Initialize variables
  }
  List<BindWalletAddressData> walletAddress = [];
  final controller = TextEditingController();

  ///选中的地址
  var seleData = BindWalletAddressData();
}

class BindWalletAddressData {
  String? walletType;
  String? name;
  String? iconUrl;
  bool isSeladet = false;
  BindWalletAddressData({this.walletType, this.name, this.iconUrl});

  BindWalletAddressData.fromJson(Map<String, dynamic> json) {
    walletType = json['walletType'];
    name = json['name'];
    iconUrl = json['iconUrl'];
  }
}
