import '/generated/json/base/json_convert_content.dart';
import '/generated/bet_record_entity.dart';

BetRecordEntity $BetRecordEntityFromJson(Map<String, dynamic> json) {
	final BetRecordEntity betRecordEntity = BetRecordEntity();
	final String? available = jsonConvert.convert<String>(json['available']);
	if (available != null) {
		betRecordEntity.available = available;
	}
	final String? betJson = jsonConvert.convert<String>(json['betJson']);
	if (betJson != null) {
		betRecordEntity.betJson = betJson;
	}
	final double? coins = jsonConvert.convert<double>(json['coins']);
	if (coins != null) {
		betRecordEntity.coins = coins;
	}
	final String? created = jsonConvert.convert<String>(json['created']);
	if (created != null) {
		betRecordEntity.created = created;
	}
	final double? gainMoney = jsonConvert.convert<double>(json['gainMoney']);
	if (gainMoney != null) {
		betRecordEntity.gainMoney = gainMoney;
	}
	final String? gameName = jsonConvert.convert<String>(json['gameName']);
	if (gameName != null) {
		betRecordEntity.gameName = gameName;
	}
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		betRecordEntity.id = id;
	}
	final String? liveRoomId = jsonConvert.convert<String>(json['liveRoomId']);
	if (liveRoomId != null) {
		betRecordEntity.liveRoomId = liveRoomId;
	}
	final String? periodTime = jsonConvert.convert<String>(json['periodTime']);
	if (periodTime != null) {
		betRecordEntity.periodTime = periodTime;
	}
	final String? userId = jsonConvert.convert<String>(json['userId']);
	if (userId != null) {
		betRecordEntity.userId = userId;
	}
	final int? settlement = jsonConvert.convert<int>(json['settlement']);
	if (settlement != null) {
		betRecordEntity.settlement = settlement;
	}
	return betRecordEntity;
}

Map<String, dynamic> $BetRecordEntityToJson(BetRecordEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['available'] = entity.available;
	data['betJson'] = entity.betJson;
	data['coins'] = entity.coins;
	data['created'] = entity.created;
	data['gainMoney'] = entity.gainMoney;
	data['gameName'] = entity.gameName;
	data['id'] = entity.id;
	data['liveRoomId'] = entity.liveRoomId;
	data['periodTime'] = entity.periodTime;
	data['userId'] = entity.userId;
	data['settlement'] = entity.settlement;
	return data;
}