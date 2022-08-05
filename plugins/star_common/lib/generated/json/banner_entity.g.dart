import '/generated/json/base/json_convert_content.dart';
import '/generated/banner_entity.dart';

BannerEntity $BannerEntityFromJson(Map<String, dynamic> json) {
	final BannerEntity bannerEntity = BannerEntity();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		bannerEntity.id = id;
	}
	final String? pic = jsonConvert.convert<String>(json['pic']);
	if (pic != null) {
		bannerEntity.pic = pic;
	}
	final String? url = jsonConvert.convert<String>(json['url']);
	if (url != null) {
		bannerEntity.url = url;
	}
	final int? type = jsonConvert.convert<int>(json['picType']);
	if (type != null) {
		bannerEntity.type = type;
	}
	final int? duration = jsonConvert.convert<int>(json['duration']);
	if (duration != null) {
		bannerEntity.duration = duration;
	}
	return bannerEntity;
}

Map<String, dynamic> $BannerEntityToJson(BannerEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['pic'] = entity.pic;
	data['url'] = entity.url;
	data['picType'] = entity.type;
	data['duration'] = entity.duration;
	return data;
}