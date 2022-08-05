import '/generated/json/base/json_convert_content.dart';
import '/generated/car_list_entity.dart';

CarListEntity $CarListEntityFromJson(Map<String, dynamic> json) {
	final CarListEntity carListEntity = CarListEntity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		carListEntity.id = id;
	}
	final String? carName = jsonConvert.convert<String>(json['carName']);
	if (carName != null) {
		carListEntity.carName = carName;
	}
	final String? carStaticUrl = jsonConvert.convert<String>(json['carStaticUrl']);
	if (carStaticUrl != null) {
		carListEntity.carStaticUrl = carStaticUrl;
	}
	final String? carGifUrl = jsonConvert.convert<String>(json['carGifUrl']);
	if (carGifUrl != null) {
		carListEntity.carGifUrl = carGifUrl;
	}
	final int? monthPrice = jsonConvert.convert<int>(json['monthPrice']);
	if (monthPrice != null) {
		carListEntity.monthPrice = monthPrice;
	}
	final int? carBuyState = jsonConvert.convert<int>(json['carBuyState']);
	if (carBuyState != null) {
		carListEntity.carBuyState = carBuyState;
	}
	final String? validityPeriod = jsonConvert.convert<String>(json['validityPeriod']);
	if (validityPeriod != null) {
		carListEntity.validityPeriod = validityPeriod;
	}
	final String? description = jsonConvert.convert<String>(json['description']);
	if (description != null) {
		carListEntity.description = description;
	}
	final int? freeLevelMinimum = jsonConvert.convert<int>(json['freeLevelMinimum']);
	if (freeLevelMinimum != null) {
		carListEntity.freeLevelMinimum = freeLevelMinimum;
	}
	final int? monthRenewalPrice = jsonConvert.convert<int>(json['monthRenewalPrice']);
	if (monthRenewalPrice != null) {
		carListEntity.monthRenewalPrice = monthRenewalPrice;
	}
	final int? type = jsonConvert.convert<int>(json['type']);
	if (type != null) {
		carListEntity.type = type;
	}
	return carListEntity;
}

Map<String, dynamic> $CarListEntityToJson(CarListEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['carName'] = entity.carName;
	data['carStaticUrl'] = entity.carStaticUrl;
	data['carGifUrl'] = entity.carGifUrl;
	data['monthPrice'] = entity.monthPrice;
	data['carBuyState'] = entity.carBuyState;
	data['validityPeriod'] = entity.validityPeriod;
	data['description'] = entity.description;
	data['freeLevelMinimum'] = entity.freeLevelMinimum;
	data['monthRenewalPrice'] = entity.monthRenewalPrice;
	data['type'] = entity.type;
	return data;
}