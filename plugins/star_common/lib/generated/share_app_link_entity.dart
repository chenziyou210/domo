import 'dart:convert';
import '/generated/json/base/json_field.dart';
import '/generated/json/share_app_link_entity.g.dart';

@JsonSerializable()
class ShareAppLinkEntity {

  String? codeUrl;
  String? downloadUrl;

  ShareAppLinkEntity();

  factory ShareAppLinkEntity.fromJson(Map<String, dynamic> json) => $ShareAppLinkEntityFromJson(json);

  Map<String, dynamic> toJson() => $ShareAppLinkEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}