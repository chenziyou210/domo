import '/generated/json/base/json_convert_content.dart';
import '/generated/app_activity_entity.dart';

AppActivityEntity $AppActivityEntityFromJson(Map<String, dynamic> json) {
	final AppActivityEntity appActivityEntity = AppActivityEntity();
	final String? mobilePic = jsonConvert.convert<String>(json['mobilePic']);
	if (mobilePic != null) {
		appActivityEntity.mobilePic = mobilePic;
	}
	final String? pic = jsonConvert.convert<String>(json['pic']);
	if (pic != null) {
		appActivityEntity.pic = pic;
	}
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		appActivityEntity.id = id;
	}
	return appActivityEntity;
}

Map<String, dynamic> $AppActivityEntityToJson(AppActivityEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['mobilePic'] = entity.mobilePic;
	data['pic'] = entity.pic;
	data['id'] = entity.id;
	return data;
}