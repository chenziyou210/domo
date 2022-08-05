import '/generated/json/base/json_convert_content.dart';
import '/generated/bank_list_entity.dart';

BankListEntity $BankListEntityFromJson(Map<String, dynamic> json) {
	final BankListEntity bankListEntity = BankListEntity();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		bankListEntity.id = id;
	}
	final int? state = jsonConvert.convert<int>(json['state']);
	if (state != null) {
		bankListEntity.state = state;
	}
	final String? userId = jsonConvert.convert<String>(json['userId']);
	if (userId != null) {
		bankListEntity.userId = userId;
	}
	final String? purseChannel = jsonConvert.convert<String>(json['purseChannel']);
	if (purseChannel != null) {
		bankListEntity.purseChannel = purseChannel;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		bankListEntity.name = name;
	}
	final String? bankname = jsonConvert.convert<String>(json['bankname']);
	if (bankname != null) {
		bankListEntity.bankname = bankname;
	}
	final String? cardNumber = jsonConvert.convert<String>(json['cardNumber']);
	if (cardNumber != null) {
		bankListEntity.cardNumber = cardNumber;
	}
	final String? accountob = jsonConvert.convert<String>(json['accountob']);
	if (accountob != null) {
		bankListEntity.accountob = accountob;
	}
	final String? remark = jsonConvert.convert<String>(json['remark']);
	if (remark != null) {
		bankListEntity.remark = remark;
	}
	final int? available = jsonConvert.convert<int>(json['available']);
	if (available != null) {
		bankListEntity.available = available;
	}
	final int? created = jsonConvert.convert<int>(json['created']);
	if (created != null) {
		bankListEntity.created = created;
	}
	final int? modified = jsonConvert.convert<int>(json['modified']);
	if (modified != null) {
		bankListEntity.modified = modified;
	}
	final String? bankIcon = jsonConvert.convert<String>(json['bankIcon']);
	if (bankIcon != null) {
		bankListEntity.bankIcon = bankIcon;
	}
	return bankListEntity;
}

Map<String, dynamic> $BankListEntityToJson(BankListEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['state'] = entity.state;
	data['userId'] = entity.userId;
	data['purseChannel'] = entity.purseChannel;
	data['name'] = entity.name;
	data['bankname'] = entity.bankname;
	data['cardNumber'] = entity.cardNumber;
	data['accountob'] = entity.accountob;
	data['remark'] = entity.remark;
	data['available'] = entity.available;
	data['created'] = entity.created;
	data['modified'] = entity.modified;
	data['bankIcon'] = entity.bankIcon;
	return data;
}