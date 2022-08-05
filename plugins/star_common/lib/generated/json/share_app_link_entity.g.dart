import '/generated/json/base/json_convert_content.dart';
import '/generated/share_app_link_entity.dart';

ShareAppLinkEntity $ShareAppLinkEntityFromJson(Map<String, dynamic> json) {
	final ShareAppLinkEntity shareAppLinkEntity = ShareAppLinkEntity();
	final String? codeUrl = jsonConvert.convert<String>(json['codeUrl']);
	if (codeUrl != null) {
		shareAppLinkEntity.codeUrl = codeUrl;
	}
	final String? downloadUrl = jsonConvert.convert<String>(json['downloadUrl']);
	if (downloadUrl != null) {
		shareAppLinkEntity.downloadUrl = downloadUrl;
	}
	return shareAppLinkEntity;
}

Map<String, dynamic> $ShareAppLinkEntityToJson(ShareAppLinkEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['codeUrl'] = entity.codeUrl;
	data['downloadUrl'] = entity.downloadUrl;
	return data;
}