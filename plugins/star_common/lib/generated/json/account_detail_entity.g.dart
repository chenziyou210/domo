import '/generated/json/base/json_convert_content.dart';
import '/generated/account_detail_entity.dart';

AccountDetailEntity $AccountDetailEntityFromJson(Map<String, dynamic> json) {
	final AccountDetailEntity accountDetailEntity = AccountDetailEntity();
	final String? coin = jsonConvert.convert<String>(json['coin']);
	if (coin != null) {
		accountDetailEntity.coin = coin;
	}
	final String? consumeTime = jsonConvert.convert<String>(json['consumeTime']);
	if (consumeTime != null) {
		accountDetailEntity.consumeTime = consumeTime;
	}
	final int? consumeType = jsonConvert.convert<int>(json['consumeType']);
	if (consumeType != null) {
		accountDetailEntity.consumeType = consumeType;
	}
	final String? giftName = jsonConvert.convert<String>(json['giftName']);
	if (giftName != null) {
		accountDetailEntity.giftName = giftName;
	}
	final int? type = jsonConvert.convert<int>(json['type']);
	if (type != null) {
		accountDetailEntity.type = type;
	}
	final String? receiveUsername = jsonConvert.convert<String>(json['receiveUsername']);
	if (receiveUsername != null) {
		accountDetailEntity.receiveUsername = receiveUsername;
	}
	return accountDetailEntity;
}

Map<String, dynamic> $AccountDetailEntityToJson(AccountDetailEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['coin'] = entity.coin;
	data['consumeTime'] = entity.consumeTime;
	data['consumeType'] = entity.consumeType;
	data['giftName'] = entity.giftName;
	data['receiveUsername'] = entity.receiveUsername;
	data['type'] = entity.type;
	return data;
}