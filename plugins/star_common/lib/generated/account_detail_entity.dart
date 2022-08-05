import 'dart:convert';
import '/generated/json/base/json_field.dart';
import '/generated/json/account_detail_entity.g.dart';

@JsonSerializable()
class AccountDetailEntity {

  String? coin;
	String? receiveUsername;
	String? consumeTime;
	String? giftName;
  int? type;
	int? consumeType;
  bool status = false;
  
  AccountDetailEntity();

  factory AccountDetailEntity.fromJson(Map<String, dynamic> json) => $AccountDetailEntityFromJson(json);

  Map<String, dynamic> toJson() => $AccountDetailEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}