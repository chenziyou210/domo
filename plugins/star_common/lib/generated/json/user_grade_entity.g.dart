import '/generated/json/base/json_convert_content.dart';
import '/generated/user_grade_entity.dart';

UserGradeEntity $UserGradeEntityFromJson(Map<String, dynamic> json) {
	final UserGradeEntity userGradeEntity = UserGradeEntity();
	final int? userLevel = jsonConvert.convert<int>(json['userLevel']);
	if (userLevel != null) {
		userGradeEntity.userLevel = userLevel;
	}
	final int? nowExperience = jsonConvert.convert<int>(json['nowExperience']);
	if (nowExperience != null) {
		userGradeEntity.nowExperience = nowExperience;
	}
	final int? upgradeExperience = jsonConvert.convert<int>(json['upgradeExperience']);
	if (upgradeExperience != null) {
		userGradeEntity.upgradeExperience = upgradeExperience;
	}
	final List<UserGradeLevelLst>? levelLst = jsonConvert.convertListNotNull<UserGradeLevelLst>(json['levelLst']);
	if (levelLst != null) {
		userGradeEntity.levelLst = levelLst;
	}
	final double? expPer = jsonConvert.convert<double>(json['expPer']);
	if (expPer != null) {
		userGradeEntity.expPer = expPer;
	}
	return userGradeEntity;
}

Map<String, dynamic> $UserGradeEntityToJson(UserGradeEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['userLevel'] = entity.userLevel;
	data['nowExperience'] = entity.nowExperience;
	data['upgradeExperience'] = entity.upgradeExperience;
	data['levelLst'] =  entity.levelLst?.map((v) => v.toJson()).toList();
	data['expPer'] = entity.expPer;
	return data;
}

UserGradeLevelLst $UserGradeLevelLstFromJson(Map<String, dynamic> json) {
	final UserGradeLevelLst userGradeLevelLst = UserGradeLevelLst();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		userGradeLevelLst.id = id;
	}
	final int? created = jsonConvert.convert<int>(json['created']);
	if (created != null) {
		userGradeLevelLst.created = created;
	}
	final int? modified = jsonConvert.convert<int>(json['modified']);
	if (modified != null) {
		userGradeLevelLst.modified = modified;
	}
	final String? createuser = jsonConvert.convert<String>(json['createuser']);
	if (createuser != null) {
		userGradeLevelLst.createuser = createuser;
	}
	final String? updateuser = jsonConvert.convert<String>(json['updateuser']);
	if (updateuser != null) {
		userGradeLevelLst.updateuser = updateuser;
	}
	final String? level = jsonConvert.convert<String>(json['level']);
	if (level != null) {
		userGradeLevelLst.level = level;
	}
	final int? experience = jsonConvert.convert<int>(json['experience']);
	if (experience != null) {
		userGradeLevelLst.experience = experience;
	}
	return userGradeLevelLst;
}

Map<String, dynamic> $UserGradeLevelLstToJson(UserGradeLevelLst entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['created'] = entity.created;
	data['modified'] = entity.modified;
	data['createuser'] = entity.createuser;
	data['updateuser'] = entity.updateuser;
	data['level'] = entity.level;
	data['experience'] = entity.experience;
	return data;
}