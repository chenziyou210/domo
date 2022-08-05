import 'dart:convert';
import '/generated/json/base/json_field.dart';
import '/generated/json/car_list_entity.g.dart';

@JsonSerializable()
class CarListEntity {

	late int id;
	late String carName;
	late String carStaticUrl;
	late String carGifUrl;
	late int monthPrice;
	late String description;
	late String validityPeriod;
	late int monthRenewalPrice;
	late int freeLevelMinimum;
	late int carBuyState;
	late int type;

  CarListEntity();

  factory CarListEntity.fromJson(Map<String, dynamic> json) => $CarListEntityFromJson(json);

  Map<String, dynamic> toJson() => $CarListEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}