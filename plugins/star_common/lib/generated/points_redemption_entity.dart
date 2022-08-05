import 'dart:convert';
import '/generated/json/base/json_field.dart';
import '/generated/json/points_redemption_entity.g.dart';

@JsonSerializable()
class PointsRedemptionEntity {

	dynamic id;
	String? exchangeRecordId;
	String? userId;
	String? giftId;
	String? giftName;
	String? giftImg;
	int? quantity;
	int? rewardPointAmount;
	int? totalPointAmount;
	int? createTime;
	int? updateTime;
  
  PointsRedemptionEntity();

  factory PointsRedemptionEntity.fromJson(Map<String, dynamic> json) => $PointsRedemptionEntityFromJson(json);

  Map<String, dynamic> toJson() => $PointsRedemptionEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}