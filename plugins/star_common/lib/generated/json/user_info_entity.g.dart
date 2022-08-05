import '/generated/user_info_entity.dart';
import 'base/json_convert_content.dart';

UserInfoEntity $UserInfoEntityFromJson(Map<String, dynamic> json) {
	final UserInfoEntity userInfoEntity = UserInfoEntity();
	final String? header = jsonConvert.convert<String>(json['header']);
	if (header != null) {
		userInfoEntity.header = header;
	}
	final String? username = jsonConvert.convert<String>(json['username']);
	if (username != null) {
		userInfoEntity.username = username;
	}
	final dynamic? rank = jsonConvert.convert<dynamic>(json['rank']);
	if (rank != null) {
		userInfoEntity.rank = rank;
	}
	final int? attentionNum = jsonConvert.convert<int>(json['attentionNum']);
	if (attentionNum != null) {
		userInfoEntity.attentionNum = attentionNum;
	}
	final int? fansNum = jsonConvert.convert<int>(json['fansNum']);
	if (fansNum != null) {
		userInfoEntity.fansNum = fansNum;
	}
	final String? memberId = jsonConvert.convert<String>(json['memberId']);
	if (memberId != null) {
		userInfoEntity.memberId = memberId;
	}
	final String? profession = jsonConvert.convert<String>(json['profession']);
	if (profession != null) {
		userInfoEntity.profession = profession;
	}
	final dynamic? hometown = jsonConvert.convert<dynamic>(json['hometown']);
	if (hometown != null) {
		userInfoEntity.hometown = hometown;
	}
	final dynamic? feeling = jsonConvert.convert<dynamic>(json['feeling']);
	if (feeling != null) {
		userInfoEntity.feeling = feeling;
	}
	final String? signature = jsonConvert.convert<String>(json['signature']);
	if (signature != null) {
		userInfoEntity.signature = signature;
	}
	final dynamic? sendOut = jsonConvert.convert<dynamic>(json['sendOut']);
	if (sendOut != null) {
		userInfoEntity.sendOut = sendOut;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		userInfoEntity.name = name;
	}
	final dynamic? id = jsonConvert.convert<dynamic>(json['id']);
	if (id != null) {
		userInfoEntity.id = id;
	}
	final int? sex = jsonConvert.convert<int>(json['sex']);
	if (sex != null) {
		userInfoEntity.sex = sex;
	}
	final String? birthday = jsonConvert.convert<String>(json['birthday']);
	if (birthday != null) {
		userInfoEntity.birthday = birthday;
	}
	final dynamic? rogerThat = jsonConvert.convert<dynamic>(json['rogerThat']);
	if (rogerThat != null) {
		userInfoEntity.rogerThat = rogerThat;
	}
	final String? constellation = jsonConvert.convert<String>(json['constellation']);
	if (constellation != null) {
		userInfoEntity.constellation = constellation;
	}
	return userInfoEntity;
}

Map<String, dynamic> $UserInfoEntityToJson(UserInfoEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['header'] = entity.header;
	data['username'] = entity.username;
	data['rank'] = entity.rank;
	data['attentionNum'] = entity.attentionNum;
	data['fansNum'] = entity.fansNum;
	data['memberId'] = entity.memberId;
	data['profession'] = entity.profession;
	data['hometown'] = entity.hometown;
	data['feeling'] = entity.feeling;
	data['signature'] = entity.signature;
	data['sendOut'] = entity.sendOut;
	data['name'] = entity.name;
	data['id'] = entity.id;
	data['sex'] = entity.sex;
	data['birthday'] = entity.birthday;
	data['rogerThat'] = entity.rogerThat;
	data['constellation'] = entity.constellation;
	return data;
}