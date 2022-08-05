import '/generated/json/base/json_convert_content.dart';
import '/generated/anchor_gift_report_entity.dart';

AnchorGiftReportEntity $AnchorGiftReportEntityFromJson(Map<String, dynamic> json) {
	final AnchorGiftReportEntity anchorGiftReportEntity = AnchorGiftReportEntity();
	final double? coins = jsonConvert.convert<double>(json['coins']);
	if (coins != null) {
		anchorGiftReportEntity.coins = coins;
	}
	final String? created = jsonConvert.convert<String>(json['created']);
	if (created != null) {
		anchorGiftReportEntity.created = created;
	}
	final String? num = jsonConvert.convert<String>(json['num']);
	if (num != null) {
		anchorGiftReportEntity.num = num;
	}
	final String? picurl = jsonConvert.convert<String>(json['picurl']);
	if (picurl != null) {
		anchorGiftReportEntity.picurl = picurl;
	}
	return anchorGiftReportEntity;
}

Map<String, dynamic> $AnchorGiftReportEntityToJson(AnchorGiftReportEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['coins'] = entity.coins;
	data['created'] = entity.created;
	data['num'] = entity.num;
	data['picurl'] = entity.picurl;
	return data;
}