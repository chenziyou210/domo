import '/generated/json/base/json_field.dart';
import '/generated/json/anchor_label_entity.g.dart';


@JsonSerializable()
class AnchorLabelEntity {

	AnchorLabelEntity();

	factory AnchorLabelEntity.fromJson(Map<String, dynamic> json) => $AnchorLabelEntityFromJson(json);

	Map<String, dynamic> toJson() => $AnchorLabelEntityToJson(this);

	String? id;
	int? created;
	int? modified;
	String? createuser;
	String? updateuser;
	int? available;
	String? name;
	int? seqNo;
	int? enable;
}
