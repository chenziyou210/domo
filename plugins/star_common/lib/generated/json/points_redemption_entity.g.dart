import '/generated/json/base/json_convert_content.dart';
import '/generated/points_redemption_entity.dart';

PointsRedemptionEntity $PointsRedemptionEntityFromJson(Map<String, dynamic> json) {
	final PointsRedemptionEntity pointsRedemptionEntity = PointsRedemptionEntity();
	final dynamic? id = jsonConvert.convert<dynamic>(json['id']);
	if (id != null) {
		pointsRedemptionEntity.id = id;
	}
	final String? exchangeRecordId = jsonConvert.convert<String>(json['exchangeRecordId']);
	if (exchangeRecordId != null) {
		pointsRedemptionEntity.exchangeRecordId = exchangeRecordId;
	}
	final String? userId = jsonConvert.convert<String>(json['userId']);
	if (userId != null) {
		pointsRedemptionEntity.userId = userId;
	}
	final String? giftId = jsonConvert.convert<String>(json['giftId']);
	if (giftId != null) {
		pointsRedemptionEntity.giftId = giftId;
	}
	final String? giftName = jsonConvert.convert<String>(json['giftName']);
	if (giftName != null) {
		pointsRedemptionEntity.giftName = giftName;
	}
	final String? giftImg = jsonConvert.convert<String>(json['giftImg']);
	if (giftImg != null) {
		pointsRedemptionEntity.giftImg = giftImg;
	}
	final int? quantity = jsonConvert.convert<int>(json['quantity']);
	if (quantity != null) {
		pointsRedemptionEntity.quantity = quantity;
	}
	final int? rewardPointAmount = jsonConvert.convert<int>(json['rewardPointAmount']);
	if (rewardPointAmount != null) {
		pointsRedemptionEntity.rewardPointAmount = rewardPointAmount;
	}
	final int? totalPointAmount = jsonConvert.convert<int>(json['totalPointAmount']);
	if (totalPointAmount != null) {
		pointsRedemptionEntity.totalPointAmount = totalPointAmount;
	}
	final int? createTime = jsonConvert.convert<int>(json['createTime']);
	if (createTime != null) {
		pointsRedemptionEntity.createTime = createTime;
	}
	final int? updateTime = jsonConvert.convert<int>(json['updateTime']);
	if (updateTime != null) {
		pointsRedemptionEntity.updateTime = updateTime;
	}
	return pointsRedemptionEntity;
}

Map<String, dynamic> $PointsRedemptionEntityToJson(PointsRedemptionEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['exchangeRecordId'] = entity.exchangeRecordId;
	data['userId'] = entity.userId;
	data['giftId'] = entity.giftId;
	data['giftName'] = entity.giftName;
	data['giftImg'] = entity.giftImg;
	data['quantity'] = entity.quantity;
	data['rewardPointAmount'] = entity.rewardPointAmount;
	data['totalPointAmount'] = entity.totalPointAmount;
	data['createTime'] = entity.createTime;
	data['updateTime'] = entity.updateTime;
	return data;
}