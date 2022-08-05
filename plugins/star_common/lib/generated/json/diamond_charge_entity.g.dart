import '/generated/json/base/json_convert_content.dart';
import '/generated/diamond_charge_entity.dart';

DiamondChargeEntity $DiamondChargeEntityFromJson(Map<String, dynamic> json) {
	final DiamondChargeEntity diamondChargeEntity = DiamondChargeEntity();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		diamondChargeEntity.id = id;
	}
	final int? created = jsonConvert.convert<int>(json['created']);
	if (created != null) {
		diamondChargeEntity.created = created;
	}
	final int? modified = jsonConvert.convert<int>(json['modified']);
	if (modified != null) {
		diamondChargeEntity.modified = modified;
	}
	final String? createuser = jsonConvert.convert<String>(json['createuser']);
	if (createuser != null) {
		diamondChargeEntity.createuser = createuser;
	}
	final String? updateuser = jsonConvert.convert<String>(json['updateuser']);
	if (updateuser != null) {
		diamondChargeEntity.updateuser = updateuser;
	}
	final int? available = jsonConvert.convert<int>(json['available']);
	if (available != null) {
		diamondChargeEntity.available = available;
	}
	final int? diamond = jsonConvert.convert<int>(json['diamond']);
	if (diamond != null) {
		diamondChargeEntity.diamond = diamond;
	}
	final int? amount = jsonConvert.convert<int>(json['amount']);
	if (amount != null) {
		diamondChargeEntity.amount = amount;
	}
	return diamondChargeEntity;
}

Map<String, dynamic> $DiamondChargeEntityToJson(DiamondChargeEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['created'] = entity.created;
	data['modified'] = entity.modified;
	data['createuser'] = entity.createuser;
	data['updateuser'] = entity.updateuser;
	data['available'] = entity.available;
	data['diamond'] = entity.diamond;
	data['amount'] = entity.amount;
	return data;
}