import 'dart:convert';
import '/generated/json/base/json_field.dart';
import '/generated/json/audience_online_entity.g.dart';

@JsonSerializable()
class AudienceOnlineEntity {

  int? adminFlag;
  int? banFlag;
	String? header;
	String? memberid;
	int? rank;
	int? onlineNum;
	String? userId;
	String? username;
  
  AudienceOnlineEntity();

  factory AudienceOnlineEntity.fromJson(Map<String, dynamic> json) => $AudienceOnlineEntityFromJson(json);

  Map<String, dynamic> toJson() => $AudienceOnlineEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}