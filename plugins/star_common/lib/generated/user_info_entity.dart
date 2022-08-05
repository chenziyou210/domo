import '/generated/json/base/json_field.dart';
import '/generated/json/user_info_entity.g.dart';


@JsonSerializable()
class UserInfoEntity {

	UserInfoEntity();

	factory UserInfoEntity.fromJson(Map<String, dynamic> json) => $UserInfoEntityFromJson(json);

	Map<String, dynamic> toJson() => $UserInfoEntityToJson(this);

	String? header;
	String? username;
	dynamic rank;
	int? attentionNum;
	int? fansNum;
	String? memberId;
	String? profession;
	dynamic hometown;
	dynamic feeling;
	String? signature;
	dynamic sendOut;
	String? name;
	dynamic id;
	int? sex;
	String? birthday;
	dynamic rogerThat;
	String? constellation;
}
