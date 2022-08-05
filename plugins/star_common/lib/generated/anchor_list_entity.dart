import '/generated/json/base/json_field.dart';
import '/generated/json/anchor_list_entity.g.dart';


@JsonSerializable()
class AnchorListEntity {

	AnchorListEntity();

	factory AnchorListEntity.fromJson(Map<String, dynamic> json) => $AnchorListEntityFromJson(json);

	Map<String, dynamic> toJson() => $AnchorListEntityToJson(this);

	String? cover;
	String? name;
	String? city;
	int? onlinenum;
	String? labelName;
	int? order;
	int? defaultroom;
	double? timeDeduction;
}
