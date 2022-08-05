import '/generated/json/base/json_convert_content.dart';
import '/generated/audience_online_entity.dart';

AudienceOnlineEntity $AudienceOnlineEntityFromJson(Map<String, dynamic> json) {
	final AudienceOnlineEntity audienceOnlineEntity = AudienceOnlineEntity();
	final int? adminFlag = jsonConvert.convert<int>(json['adminFlag']);
	if (adminFlag != null) {
		audienceOnlineEntity.adminFlag = adminFlag;
	}
	final int? banFlag = jsonConvert.convert<int>(json['banFlag']);
	if (banFlag != null) {
		audienceOnlineEntity.banFlag = banFlag;
	}
	final String? header = jsonConvert.convert<String>(json['header']);
	if (header != null) {
		audienceOnlineEntity.header = header;
	}
	final String? memberid = jsonConvert.convert<String>(json['memberid']);
	if (memberid != null) {
		audienceOnlineEntity.memberid = memberid;
	}
	final int? rank = jsonConvert.convert<int>(json['rank']);
	if (rank != null) {
		audienceOnlineEntity.rank = rank;
	}
	final String? userId = jsonConvert.convert<String>(json['userId']);
	if (userId != null) {
		audienceOnlineEntity.userId = userId;
	}
	final String? username = jsonConvert.convert<String>(json['username']);
	if (username != null) {
		audienceOnlineEntity.username = username;
	}
	final int? onlineNum = jsonConvert.convert<int>(json['onlineNum']);
	if (username != null) {
		audienceOnlineEntity.onlineNum = onlineNum;
	}
	return audienceOnlineEntity;
}

Map<String, dynamic> $AudienceOnlineEntityToJson(AudienceOnlineEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['adminFlag'] = entity.adminFlag;
	data['banFlag'] = entity.banFlag;
	data['header'] = entity.header;
	data['memberid'] = entity.memberid;
	data['rank'] = entity.rank;
	data['userId'] = entity.userId;
	data['username'] = entity.username;
	data['onlineNum'] = entity.onlineNum;
	return data;
}