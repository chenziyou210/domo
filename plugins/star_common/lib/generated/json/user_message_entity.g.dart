import '/generated/json/base/json_convert_content.dart';
import '/generated/user_message_entity.dart';

UserMessageEntity $UserMessageEntityFromJson(Map<String, dynamic> json) {
	final UserMessageEntity userMessageEntity = UserMessageEntity();
	final int? attentionNum = jsonConvert.convert<int>(json['attentionNum']);
	if (attentionNum != null) {
		userMessageEntity.attentionNum = attentionNum;
	}
	final String? birthday = jsonConvert.convert<String>(json['birthday']);
	if (birthday != null) {
		userMessageEntity.birthday = birthday;
	}
	final String? constellation = jsonConvert.convert<String>(json['constellation']);
	if (constellation != null) {
		userMessageEntity.constellation = constellation;
	}
	final int? fansNum = jsonConvert.convert<int>(json['fansNum']);
	if (fansNum != null) {
		userMessageEntity.fansNum = fansNum;
	}
	final String? feeling = jsonConvert.convert<String>(json['feeling']);
	if (feeling != null) {
		userMessageEntity.feeling = feeling;
	}
	final String? header = jsonConvert.convert<String>(json['header']);
	if (header != null) {
		userMessageEntity.header = header;
	}
	final String? hometown = jsonConvert.convert<String>(json['hometown']);
	if (hometown != null) {
		userMessageEntity.hometown = hometown;
	}
	final bool? isAttrntion = jsonConvert.convert<bool>(json['isAttrntion']);
	if (isAttrntion != null) {
		userMessageEntity.isAttrntion = isAttrntion;
	}
	final String? memberId = jsonConvert.convert<String>(json['memberId']);
	if (memberId != null) {
		userMessageEntity.memberId = memberId;
	}
	final String? profession = jsonConvert.convert<String>(json['profession']);
	if (profession != null) {
		userMessageEntity.profession = profession;
	}
	final int? rank = jsonConvert.convert<int>(json['rank']);
	if (rank != null) {
		userMessageEntity.rank = rank;
	}
	final int? reward = jsonConvert.convert<int>(json['reward']);
	if (reward != null) {
		userMessageEntity.reward = reward;
	}
	final int? sendOut = jsonConvert.convert<int>(json['sendOut']);
	if (sendOut != null) {
		userMessageEntity.sendOut = sendOut;
	}
	final String? signature = jsonConvert.convert<String>(json['signature']);
	if (signature != null) {
		userMessageEntity.signature = signature;
	}
	final String? userId = jsonConvert.convert<String>(json['userId']);
	if (userId != null) {
		userMessageEntity.userId = userId;
	}
	final String? name = jsonConvert.convert<String>(json['username']);
	if (name != null) {
		userMessageEntity.name = name;
	}
	return userMessageEntity;
}

Map<String, dynamic> $UserMessageEntityToJson(UserMessageEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['attentionNum'] = entity.attentionNum;
	data['birthday'] = entity.birthday;
	data['constellation'] = entity.constellation;
	data['fansNum'] = entity.fansNum;
	data['feeling'] = entity.feeling;
	data['header'] = entity.header;
	data['hometown'] = entity.hometown;
	data['isAttrntion'] = entity.isAttrntion;
	data['memberId'] = entity.memberId;
	data['profession'] = entity.profession;
	data['rank'] = entity.rank;
	data['reward'] = entity.reward;
	data['sendOut'] = entity.sendOut;
	data['signature'] = entity.signature;
	data['userId'] = entity.userId;
	data['username'] = entity.name;
	return data;
}