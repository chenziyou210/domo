import '/generated/json/base/json_convert_content.dart';
import '/generated/anchor_label_entity.dart';

AnchorLabelEntity $AnchorLabelEntityFromJson(Map<String, dynamic> json) {
	final AnchorLabelEntity anchorLabelEntity = AnchorLabelEntity();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		anchorLabelEntity.id = id;
	}
	final int? created = jsonConvert.convert<int>(json['created']);
	if (created != null) {
		anchorLabelEntity.created = created;
	}
	final int? modified = jsonConvert.convert<int>(json['modified']);
	if (modified != null) {
		anchorLabelEntity.modified = modified;
	}
	final String? createuser = jsonConvert.convert<String>(json['createuser']);
	if (createuser != null) {
		anchorLabelEntity.createuser = createuser;
	}
	final String? updateuser = jsonConvert.convert<String>(json['updateuser']);
	if (updateuser != null) {
		anchorLabelEntity.updateuser = updateuser;
	}
	final int? available = jsonConvert.convert<int>(json['available']);
	if (available != null) {
		anchorLabelEntity.available = available;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		anchorLabelEntity.name = name;
	}
	final int? seqNo = jsonConvert.convert<int>(json['seqNo']);
	if (seqNo != null) {
		anchorLabelEntity.seqNo = seqNo;
	}
	final int? enable = jsonConvert.convert<int>(json['enable']);
	if (enable != null) {
		anchorLabelEntity.enable = enable;
	}
	return anchorLabelEntity;
}

Map<String, dynamic> $AnchorLabelEntityToJson(AnchorLabelEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['created'] = entity.created;
	data['modified'] = entity.modified;
	data['createuser'] = entity.createuser;
	data['updateuser'] = entity.updateuser;
	data['available'] = entity.available;
	data['name'] = entity.name;
	data['seqNo'] = entity.seqNo;
	data['enable'] = entity.enable;
	return data;
}