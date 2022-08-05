import '/generated/json/base/json_convert_content.dart';
import '/generated/package_gift_entity.dart';

PackageGiftEntity $PackageGiftEntityFromJson(Map<String, dynamic> json) {
	final PackageGiftEntity packageGiftEntity = PackageGiftEntity();
	final dynamic? id = jsonConvert.convert<dynamic>(json['id']);
	if (id != null) {
		packageGiftEntity.id = id;
	}
	final String? bagpackGiftId = jsonConvert.convert<String>(json['bagpackGiftId']);
	if (bagpackGiftId != null) {
		packageGiftEntity.bagpackGiftId = bagpackGiftId;
	}
	final String? userId = jsonConvert.convert<String>(json['userId']);
	if (userId != null) {
		packageGiftEntity.userId = userId;
	}
	final int? giftId = jsonConvert.convert<int>(json['giftId']);
	if (giftId != null) {
		packageGiftEntity.giftId = giftId;
	}
	final String? giftName = jsonConvert.convert<String>(json['giftName']);
	if (giftName != null) {
		packageGiftEntity.giftName = giftName;
	}
	final String? giftImg = jsonConvert.convert<String>(json['giftImg']);
	if (giftImg != null) {
		packageGiftEntity.giftImg = giftImg;
	}
	final String? giftGifUrl = jsonConvert.convert<String>(json['giftGifUrl']);
	if (giftGifUrl != null) {
		packageGiftEntity.giftGifUrl = giftGifUrl;
	}
	final int? remainQuantity = jsonConvert.convert<int>(json['remainQuantity']);
	if (remainQuantity != null) {
		packageGiftEntity.remainQuantity = remainQuantity;
	}
	return packageGiftEntity;
}

Map<String, dynamic> $PackageGiftEntityToJson(PackageGiftEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['bagpackGiftId'] = entity.bagpackGiftId;
	data['userId'] = entity.userId;
	data['giftId'] = entity.giftId;
	data['giftName'] = entity.giftName;
	data['giftImg'] = entity.giftImg;
	data['giftGifUrl'] = entity.giftGifUrl;
	data['remainQuantity'] = entity.remainQuantity;
	return data;
}