import '/generated/json/base/json_convert_content.dart';
import '/generated/living_time_slot_entity.dart';

LivingTimeSlotEntity $LivingTimeSlotEntityFromJson(Map<String, dynamic> json) {
	final LivingTimeSlotEntity livingTimeSlotEntity = LivingTimeSlotEntity();
	final String? closetime = jsonConvert.convert<String>(json['closetime']);
	if (closetime != null) {
		livingTimeSlotEntity.closetime = closetime;
	}
	final String? created = jsonConvert.convert<String>(json['created']);
	if (created != null) {
		livingTimeSlotEntity.created = created;
	}
	final int? state = jsonConvert.convert<int>(json['state']);
	if (state != null) {
		livingTimeSlotEntity.state = state;
	}
	return livingTimeSlotEntity;
}

Map<String, dynamic> $LivingTimeSlotEntityToJson(LivingTimeSlotEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['closetime'] = entity.closetime;
	data['created'] = entity.created;
	data['state'] = entity.state;
	return data;
}