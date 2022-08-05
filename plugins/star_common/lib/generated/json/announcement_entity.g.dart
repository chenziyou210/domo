import '/generated/json/base/json_convert_content.dart';
import '/generated/announcement_entity.dart';

AnnouncementEntity $AnnouncementEntityFromJson(Map<String, dynamic> json) {
	final AnnouncementEntity announcementEntity = AnnouncementEntity();
	final int? available = jsonConvert.convert<int>(json['available']);
	if (available != null) {
		announcementEntity.available = available;
	}
	final String? content = jsonConvert.convert<String>(json['content']);
	if (content != null) {
		announcementEntity.content = content;
	}
	final String? created = jsonConvert.convert<String>(json['created']);
	if (created != null) {
		announcementEntity.created = created;
	}
	final String? createuser = jsonConvert.convert<String>(json['createuser']);
	if (createuser != null) {
		announcementEntity.createuser = createuser;
	}
	final String? endtime = jsonConvert.convert<String>(json['endtime']);
	if (endtime != null) {
		announcementEntity.endtime = endtime;
	}
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		announcementEntity.id = id;
	}
	final String? jumpPath = jsonConvert.convert<String>(json['jumpPath']);
	if (jumpPath != null) {
		announcementEntity.jumpPath = jumpPath;
	}
	final String? modified = jsonConvert.convert<String>(json['modified']);
	if (modified != null) {
		announcementEntity.modified = modified;
	}
	final String? starttime = jsonConvert.convert<String>(json['starttime']);
	if (starttime != null) {
		announcementEntity.starttime = starttime;
	}
	final int? state = jsonConvert.convert<int>(json['state']);
	if (state != null) {
		announcementEntity.state = state;
	}
	final int? type = jsonConvert.convert<int>(json['type']);
	if (type != null) {
		announcementEntity.type = type;
	}
	final String? updateuser = jsonConvert.convert<String>(json['updateuser']);
	if (updateuser != null) {
		announcementEntity.updateuser = updateuser;
	}
	return announcementEntity;
}

Map<String, dynamic> $AnnouncementEntityToJson(AnnouncementEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['available'] = entity.available;
	data['content'] = entity.content;
	data['created'] = entity.created;
	data['createuser'] = entity.createuser;
	data['endtime'] = entity.endtime;
	data['id'] = entity.id;
	data['jumpPath'] = entity.jumpPath;
	data['modified'] = entity.modified;
	data['starttime'] = entity.starttime;
	data['state'] = entity.state;
	data['type'] = entity.type;
	data['updateuser'] = entity.updateuser;
	return data;
}