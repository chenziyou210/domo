import 'dart:convert';
import '/generated/json/base/json_field.dart';
import '/generated/json/app_activity_entity.g.dart';

@JsonSerializable()
class AppActivityEntity {

  String? mobilePic;
  String? pic;
  String? id;
  
  AppActivityEntity();

  factory AppActivityEntity.fromJson(Map<String, dynamic> json) => $AppActivityEntityFromJson(json);

  Map<String, dynamic> toJson() => $AppActivityEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}