import '/generated/json/banner_entity.g.dart';

import '/generated/json/base/json_field.dart';

@JsonSerializable()
class BannerEntity {

	BannerEntity();

	factory BannerEntity.fromJson(Map<String, dynamic> json) => $BannerEntityFromJson(json);

	Map<String, dynamic> toJson() => $BannerEntityToJson(this);

	String? id;
	String? pic;
	String? url;
	@JSONField(name: "picType")
	int? type;
	int? duration;
}
/// {"id":"0fe36fb3-3373-4f01-93d1-1248c1f2a457","pic":"","url":"","picType":0,"duration":0}