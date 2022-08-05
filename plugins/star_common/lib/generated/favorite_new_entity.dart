import 'dart:convert';
import '/generated/json/base/json_field.dart';
import '/generated/json/favorite_new_entity.g.dart';

@JsonSerializable()
class FavoriteNewEntity {

	String? header;
	String? memberid;
	int? rank;
	String? userId;
	String? username;
  
  FavoriteNewEntity();

  factory FavoriteNewEntity.fromJson(Map<String, dynamic> json) => $FavoriteNewEntityFromJson(json);

  Map<String, dynamic> toJson() => $FavoriteNewEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}