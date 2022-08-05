import '/generated/json/base/json_convert_content.dart';
import '/generated/system_bank_entity.dart';

SystemBankEntity $SystemBankEntityFromJson(Map<String, dynamic> json) {
	final SystemBankEntity systemBankEntity = SystemBankEntity();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		systemBankEntity.id = id;
	}
	final String? bankName = jsonConvert.convert<String>(json['bankName']);
	if (bankName != null) {
		systemBankEntity.bankName = bankName;
	}
	final String? shortBankName = jsonConvert.convert<String>(json['shortBankName']);
	if (shortBankName != null) {
		systemBankEntity.shortBankName = shortBankName;
	}
	final String? thirdBankId = jsonConvert.convert<String>(json['thirdBankId']);
	if (thirdBankId != null) {
		systemBankEntity.thirdBankId = thirdBankId;
	}
	final int? available = jsonConvert.convert<int>(json['available']);
	if (available != null) {
		systemBankEntity.available = available;
	}
	final int? created = jsonConvert.convert<int>(json['created']);
	if (created != null) {
		systemBankEntity.created = created;
	}
	return systemBankEntity;
}

Map<String, dynamic> $SystemBankEntityToJson(SystemBankEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['bankName'] = entity.bankName;
	data['shortBankName'] = entity.shortBankName;
	data['thirdBankId'] = entity.thirdBankId;
	data['available'] = entity.available;
	data['created'] = entity.created;
	return data;
}