import 'dart:convert';
import '/generated/json/base/json_field.dart';
import '/generated/json/upgrade_entity.g.dart';

@JsonSerializable()
class UpgradeEntity {

	String? createTime;
	int? flag;
	int? forceUpgrade;
	int? id;
	String? lastforceVersionName;
	String? platform;
	String? releaseNotes;
	String? updateTime;
	String? url;
	String? versionName;
	int? versionNameInt;
  
  UpgradeEntity();

  factory UpgradeEntity.fromJson(Map<String, dynamic> json) => $UpgradeEntityFromJson(json);

  Map<String, dynamic> toJson() => $UpgradeEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}