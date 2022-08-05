import '/generated/json/base/json_convert_content.dart';
import '/generated/charge_record_entity.dart';

ChargeRecordEntity $ChargeRecordEntityFromJson(Map<String, dynamic> json) {
	final ChargeRecordEntity chargeRecordEntity = ChargeRecordEntity();
	final String? createTime = jsonConvert.convert<String>(json['createTime']);
	if (createTime != null) {
		chargeRecordEntity.createTime = createTime;
	}
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		chargeRecordEntity.id = id;
	}
	final double? money = jsonConvert.convert<double>(json['money']);
	if (money != null) {
		chargeRecordEntity.money = money;
	}
	final String? paySource = jsonConvert.convert<String>(json['paySource']);
	if (paySource != null) {
		chargeRecordEntity.paySource = paySource;
	}
	final int? payStatus = jsonConvert.convert<int>(json['payStatus']);
	if (payStatus != null) {
		chargeRecordEntity.payStatus = payStatus;
	}
	final String? remark = jsonConvert.convert<String>(json['remark']);
	if (remark != null) {
		chargeRecordEntity.remark = remark;
	}
	return chargeRecordEntity;
}

Map<String, dynamic> $ChargeRecordEntityToJson(ChargeRecordEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['createTime'] = entity.createTime;
	data['id'] = entity.id;
	data['money'] = entity.money;
	data['paySource'] = entity.paySource;
	data['payStatus'] = entity.payStatus;
	data['remark'] = entity.remark;
	return data;
}