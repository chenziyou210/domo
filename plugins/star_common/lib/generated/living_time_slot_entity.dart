import 'dart:convert';
import '/generated/json/base/json_field.dart';
import '/generated/json/living_time_slot_entity.g.dart';

@JsonSerializable()
class LivingTimeSlotEntity {

	String? closetime;
	String? created;
	int? state;
  
  LivingTimeSlotEntity();

  factory LivingTimeSlotEntity.fromJson(Map<String, dynamic> json) => $LivingTimeSlotEntityFromJson(json);

  Map<String, dynamic> toJson() => $LivingTimeSlotEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}