// To parse this JSON data, do
//
//     final customerModel = customerModelFromJson(jsonString);

import 'dart:convert';

CustomerModel customerModelFromJson(Map<String, dynamic> json) =>
    CustomerModel.fromJson(json);

String customerModelToJson(CustomerModel data) => json.encode(data.toJson());

class CustomerModel {
  CustomerModel({
    this.icon,
    this.title,
    this.url,
    this.remark,
  });

  String? icon;
  String? title;
  String? url;
  String? remark;

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        icon: json["icon"],
        title: json["title"],
        url: json["url"],
        remark: json["remark"],
      );

  Map<String, dynamic> toJson() => {
        "icon": icon,
        "title": title,
        "url": url,
        "remark": remark,
      };
}
