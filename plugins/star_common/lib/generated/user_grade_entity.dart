import '/generated/json/base/json_field.dart';
import '/generated/json/user_grade_entity.g.dart';


@JsonSerializable()
class UserGradeEntity {

	UserGradeEntity();

	factory UserGradeEntity.fromJson(Map<String, dynamic> json) => $UserGradeEntityFromJson(json);

	Map<String, dynamic> toJson() => $UserGradeEntityToJson(this);

	int? userLevel;
	int? nowExperience;
	int? upgradeExperience;
	List<UserGradeLevelLst>? levelLst;
	double? expPer;
}

@JsonSerializable()
class UserGradeLevelLst {

	UserGradeLevelLst();

	factory UserGradeLevelLst.fromJson(Map<String, dynamic> json) => $UserGradeLevelLstFromJson(json);

	Map<String, dynamic> toJson() => $UserGradeLevelLstToJson(this);

	String? id;
	int? created;
	int? modified;
	String? createuser;
	String? updateuser;
	String? level;
	int? experience;
}
