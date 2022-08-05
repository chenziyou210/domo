import 'dart:convert';
import '/generated/json/base/json_field.dart';
import '/generated/json/announcement_entity.g.dart';

@JsonSerializable()
class AnnouncementEntity {

	int? available;
	String? content;
	String? created;
	String? createuser;
	String? endtime;
	String? id;
	String? jumpPath;
	String? modified;
	String? starttime;
	int? state;
	int? type;
	String? updateuser;
  
  AnnouncementEntity();

  factory AnnouncementEntity.fromJson(Map<String, dynamic> json) => $AnnouncementEntityFromJson(json);

  Map<String, dynamic> toJson() => $AnnouncementEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}