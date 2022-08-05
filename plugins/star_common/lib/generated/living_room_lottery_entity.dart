import 'dart:convert';
import '/generated/json/base/json_field.dart';
import '/generated/json/living_room_lottery_entity.g.dart';

@JsonSerializable()
class LivingRoomLotteryEntity {

	String? lastGameResultStr;
	int? currentPeriodTime;
	String? gameName;
	int? periodTime;
	int? lastPeriodTime;
	int? counter;
	int? timestamp;
  
  LivingRoomLotteryEntity();

  factory LivingRoomLotteryEntity.fromJson(Map<String, dynamic> json) => $LivingRoomLotteryEntityFromJson(json);

  Map<String, dynamic> toJson() => $LivingRoomLotteryEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}