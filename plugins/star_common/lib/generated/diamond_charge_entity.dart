import '/generated/json/base/json_field.dart';
import '/generated/json/diamond_charge_entity.g.dart';


@JsonSerializable()
class DiamondChargeEntity {

	DiamondChargeEntity();

	factory DiamondChargeEntity.fromJson(Map<String, dynamic> json) => $DiamondChargeEntityFromJson(json);

	Map<String, dynamic> toJson() => $DiamondChargeEntityToJson(this);

	String? id;
	int? created;
	int? modified;
	String? createuser;
	String? updateuser;
	int? available;
	int? diamond;
	int? amount;
}
