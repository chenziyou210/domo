import '/generated/json/base/json_convert_content.dart';
import '/generated/lottery_record_entity.dart';

LotteryRecordEntity $LotteryRecordEntityFromJson(Map<String, dynamic> json) {
	final LotteryRecordEntity lotteryRecordEntity = LotteryRecordEntity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		lotteryRecordEntity.id = id;
	}
	final String? created = jsonConvert.convert<String>(json['created']);
	if (created != null) {
		lotteryRecordEntity.created = created;
	}
	final int? available = jsonConvert.convert<int>(json['available']);
	if (available != null) {
		lotteryRecordEntity.available = available;
	}
	final String? gameResultStr = jsonConvert.convert<String>(json['gameResultStr']);
	if (gameResultStr != null) {
		lotteryRecordEntity.gameResultStr = gameResultStr;
	}
	final String? gameResultStrPic = jsonConvert.convert<String>(json['gameResultStrPic']);
	if (gameResultStrPic != null) {
		lotteryRecordEntity.gameResultStrPic = gameResultStrPic;
	}
	final String? gameName = jsonConvert.convert<String>(json['gameName']);
	if (gameName != null) {
		lotteryRecordEntity.gameName = gameName;
	}
	final String? periodTime = jsonConvert.convert<String>(json['periodTime']);
	if (periodTime != null) {
		lotteryRecordEntity.periodTime = periodTime;
	}
	return lotteryRecordEntity;
}

Map<String, dynamic> $LotteryRecordEntityToJson(LotteryRecordEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['created'] = entity.created;
	data['available'] = entity.available;
	data['gameResultStr'] = entity.gameResultStr;
	data['gameResultStrPic'] = entity.gameResultStrPic;
	data['gameName'] = entity.gameName;
	data['periodTime'] = entity.periodTime;
	return data;
}