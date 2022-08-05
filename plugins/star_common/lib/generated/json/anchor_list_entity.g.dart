import '/generated/json/base/json_convert_content.dart';
import '/generated/anchor_list_entity.dart';

AnchorListEntity $AnchorListEntityFromJson(Map<String, dynamic> json) {
	final AnchorListEntity anchorListEntity = AnchorListEntity();
	final String? cover = jsonConvert.convert<String>(json['cover']);
	if (cover != null) {
		anchorListEntity.cover = cover;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		anchorListEntity.name = name;
	}
	final String? city = jsonConvert.convert<String>(json['city']);
	if (city != null) {
		anchorListEntity.city = city;
	}
	final int? onlinenum = jsonConvert.convert<int>(json['onlineNum']);
	if (onlinenum != null) {
		anchorListEntity.onlinenum = onlinenum;
	}
	final String? labelName = jsonConvert.convert<String>(json['labelName']);
	if (labelName != null) {
		anchorListEntity.labelName = labelName;
	}
	final int? order = jsonConvert.convert<int>(json['order']);
	if (order != null) {
		anchorListEntity.order = order;
	}
	final int? defaultroom = jsonConvert.convert<int>(json['defaultroom']);
	if (defaultroom != null) {
		anchorListEntity.defaultroom = defaultroom;
	}
	final double? timeDeduction = jsonConvert.convert<double>(json['timeDeduction']);
	if (timeDeduction != null) {
		anchorListEntity.timeDeduction = timeDeduction;
	}
	return anchorListEntity;
}

Map<String, dynamic> $AnchorListEntityToJson(AnchorListEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['cover'] = entity.cover;
	data['name'] = entity.name;
	data['city'] = entity.city;
	data['onlinenum'] = entity.onlinenum;
	data['labelName'] = entity.labelName;
	data['order'] = entity.order;
	data['defaultroom'] = entity.defaultroom;
	data['timeDeduction'] = entity.timeDeduction;
	return data;
}