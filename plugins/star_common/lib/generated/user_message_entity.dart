import 'dart:convert';
import '/generated/json/base/json_field.dart';
import '/generated/json/user_message_entity.g.dart';

@JsonSerializable()
class UserMessageEntity {

	int? attentionNum;
	String? birthday;
	String? constellation;
	int? fansNum;
	String? feeling;
	String? header;
	String? hometown;
	bool? isAttrntion;
	String? memberId;
	String? profession;
	int? rank;
	int? reward;
	int? sendOut;
	String? signature;
	String? userId;
	@JSONField(name: "username")
	String? name;
  
  UserMessageEntity();

  factory UserMessageEntity.fromJson(Map<String, dynamic> json) => $UserMessageEntityFromJson(json);

  Map<String, dynamic> toJson() => $UserMessageEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}