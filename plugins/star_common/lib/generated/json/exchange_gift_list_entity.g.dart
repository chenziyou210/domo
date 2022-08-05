import '/generated/json/base/json_convert_content.dart';
import '/generated/exchange_gift_list_entity.dart';

ExchangeGiftListEntity $ExchangeGiftListEntityFromJson(Map<String, dynamic> json) {
	final ExchangeGiftListEntity exchangeGiftListEntity = ExchangeGiftListEntity();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		exchangeGiftListEntity.id = id;
	}
	final int? point = jsonConvert.convert<int>(json['point']);
	if (point != null) {
		exchangeGiftListEntity.point = point;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		exchangeGiftListEntity.name = name;
	}
	final String? picUrl = jsonConvert.convert<String>(json['picUrl']);
	if (picUrl != null) {
		exchangeGiftListEntity.picUrl = picUrl;
	}
	return exchangeGiftListEntity;
}

Map<String, dynamic> $ExchangeGiftListEntityToJson(ExchangeGiftListEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['point'] = entity.point;
	data['name'] = entity.name;
	data['picUrl'] = entity.picUrl;
	return data;
}