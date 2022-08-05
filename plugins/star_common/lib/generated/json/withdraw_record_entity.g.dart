import '/generated/json/base/json_convert_content.dart';
import '/generated/withdraw_record_entity.dart';

WithdrawRecordEntity $WithdrawRecordEntityFromJson(Map<String, dynamic> json) {
	final WithdrawRecordEntity withdrawRecordEntity = WithdrawRecordEntity();
	final String? accountob = jsonConvert.convert<String>(json['accountob']);
	if (accountob != null) {
		withdrawRecordEntity.accountob = accountob;
	}
	final int? available = jsonConvert.convert<int>(json['available']);
	if (available != null) {
		withdrawRecordEntity.available = available;
	}
	final String? bankname = jsonConvert.convert<String>(json['bankname']);
	if (bankname != null) {
		withdrawRecordEntity.bankname = bankname;
	}
	final String? bindBankId = jsonConvert.convert<String>(json['bindBankId']);
	if (bindBankId != null) {
		withdrawRecordEntity.bindBankId = bindBankId;
	}
	final String? cardNumber = jsonConvert.convert<String>(json['cardNumber']);
	if (cardNumber != null) {
		withdrawRecordEntity.cardNumber = cardNumber;
	}
	final String? created = jsonConvert.convert<String>(json['created']);
	if (created != null) {
		withdrawRecordEntity.created = created;
	}
	final String? examRemark = jsonConvert.convert<String>(json['examRemark']);
	if (examRemark != null) {
		withdrawRecordEntity.examRemark = examRemark;
	}
	final int? examState = jsonConvert.convert<int>(json['examState']);
	if (examState != null) {
		withdrawRecordEntity.examState = examState;
	}
	final String? examTime = jsonConvert.convert<String>(json['examTime']);
	if (examTime != null) {
		withdrawRecordEntity.examTime = examTime;
	}
	final String? examUsername = jsonConvert.convert<String>(json['examUsername']);
	if (examUsername != null) {
		withdrawRecordEntity.examUsername = examUsername;
	}
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		withdrawRecordEntity.id = id;
	}
	final String? modified = jsonConvert.convert<String>(json['modified']);
	if (modified != null) {
		withdrawRecordEntity.modified = modified;
	}
	final double? money = jsonConvert.convert<double>(json['money']);
	if (money != null) {
		withdrawRecordEntity.money = money;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		withdrawRecordEntity.name = name;
	}
	final String? payRemark = jsonConvert.convert<String>(json['payRemark']);
	if (payRemark != null) {
		withdrawRecordEntity.payRemark = payRemark;
	}
	final int? payState = jsonConvert.convert<int>(json['payState']);
	if (payState != null) {
		withdrawRecordEntity.payState = payState;
	}
	final String? payTime = jsonConvert.convert<String>(json['payTime']);
	if (payTime != null) {
		withdrawRecordEntity.payTime = payTime;
	}
	final int? state = jsonConvert.convert<int>(json['state']);
	if (state != null) {
		withdrawRecordEntity.state = state;
	}
	final String? userId = jsonConvert.convert<String>(json['userId']);
	if (userId != null) {
		withdrawRecordEntity.userId = userId;
	}
	return withdrawRecordEntity;
}

Map<String, dynamic> $WithdrawRecordEntityToJson(WithdrawRecordEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['accountob'] = entity.accountob;
	data['available'] = entity.available;
	data['bankname'] = entity.bankname;
	data['bindBankId'] = entity.bindBankId;
	data['cardNumber'] = entity.cardNumber;
	data['created'] = entity.created;
	data['examRemark'] = entity.examRemark;
	data['examState'] = entity.examState;
	data['examTime'] = entity.examTime;
	data['examUsername'] = entity.examUsername;
	data['id'] = entity.id;
	data['modified'] = entity.modified;
	data['money'] = entity.money;
	data['name'] = entity.name;
	data['payRemark'] = entity.payRemark;
	data['payState'] = entity.payState;
	data['payTime'] = entity.payTime;
	data['state'] = entity.state;
	data['userId'] = entity.userId;
	return data;
}