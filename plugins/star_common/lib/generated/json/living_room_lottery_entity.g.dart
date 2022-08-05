import '/generated/json/base/json_convert_content.dart';
import '/generated/living_room_lottery_entity.dart';

LivingRoomLotteryEntity $LivingRoomLotteryEntityFromJson(Map<String, dynamic> json) {
	final LivingRoomLotteryEntity livingRoomLotteryEntity = LivingRoomLotteryEntity();
	final String? lastGameResultStr = jsonConvert.convert<String>(json['lastGameResultStr']);
	if (lastGameResultStr != null) {
		livingRoomLotteryEntity.lastGameResultStr = lastGameResultStr;
	}
	final int? currentPeriodTime = jsonConvert.convert<int>(json['currentPeriodTime']);
	if (currentPeriodTime != null) {
		livingRoomLotteryEntity.currentPeriodTime = currentPeriodTime;
	}
	final String? gameName = jsonConvert.convert<String>(json['gameName']);
	if (gameName != null) {
		livingRoomLotteryEntity.gameName = gameName;
	}
	final int? periodTime = jsonConvert.convert<int>(json['periodTime']);
	if (periodTime != null) {
		livingRoomLotteryEntity.periodTime = periodTime;
	}
	final int? lastPeriodTime = jsonConvert.convert<int>(json['lastPeriodTime']);
	if (lastPeriodTime != null) {
		livingRoomLotteryEntity.lastPeriodTime = lastPeriodTime;
	}
	final int? counter = jsonConvert.convert<int>(json['counter']);
	if (counter != null) {
		livingRoomLotteryEntity.counter = counter;
	}
	final int? timestamp = jsonConvert.convert<int>(json['timestamp']);
	if (timestamp != null) {
		livingRoomLotteryEntity.timestamp = timestamp;
	}
	return livingRoomLotteryEntity;
}

Map<String, dynamic> $LivingRoomLotteryEntityToJson(LivingRoomLotteryEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['lastGameResultStr'] = entity.lastGameResultStr;
	data['currentPeriodTime'] = entity.currentPeriodTime;
	data['gameName'] = entity.gameName;
	data['periodTime'] = entity.periodTime;
	data['lastPeriodTime'] = entity.lastPeriodTime;
	data['counter'] = entity.counter;
	data['timestamp'] = entity.timestamp;
	return data;
}