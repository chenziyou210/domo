import '/generated/json/base/json_convert_content.dart';
import '/generated/gift_entity.dart';

GiftEntity $GiftEntityFromJson(Map<String, dynamic> json) {
	final GiftEntity giftEntity = GiftEntity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		giftEntity.id = id;
	}
	final int? coins = jsonConvert.convert<int>(json['coins']);
	if (coins != null) {
		giftEntity.coins = coins;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		giftEntity.name = name;
	}
	final String? picUrl = jsonConvert.convert<String>(json['picUrl']);
	if (picUrl != null) {
		giftEntity.picUrl = picUrl;
	}
	final String? gifUrl = jsonConvert.convert<String>(json['gifUrl']);
	if (gifUrl != null) {
		giftEntity.gifUrl = gifUrl;
	}
	final int? levelLimit = jsonConvert.convert<int>(json['levelLimit']);
	if (coins != null) {
		giftEntity.levelLimit = levelLimit;
	}
	final int? grade = jsonConvert.convert<int>(json['grade']);
	if (coins != null) {
		giftEntity.grade = grade;
	}
	final int? type = jsonConvert.convert<int>(json['type']);
	if (coins != null) {
		giftEntity.type = type;
	}
	return giftEntity;
}

Map<String, dynamic> $GiftEntityToJson(GiftEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['coins'] = entity.coins;
	data['name'] = entity.name;
	data['picUrl'] = entity.picUrl;
	data['gifUrl'] = entity.gifUrl;
	data['levelLimit'] = entity.levelLimit;
	data['grade'] = entity.grade;
	data['type'] = entity.type;
	return data;
}