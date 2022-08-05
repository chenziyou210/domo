import '/generated/json/base/json_convert_content.dart';
import '/generated/favorite_entity.dart';

FavoriteEntity $FavoriteEntityFromJson(Map<String, dynamic> json) {
	final FavoriteEntity favoriteEntity = FavoriteEntity();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		favoriteEntity.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		favoriteEntity.name = name;
	}
	final String? header = jsonConvert.convert<String>(json['header']);
	if (header != null) {
		favoriteEntity.header = header;
	}
	final int? rank = jsonConvert.convert<int>(json['rank']);
	if (rank != null) {
		favoriteEntity.rank = rank;
	}
	final String? signature = jsonConvert.convert<String>(json['signature']);
	if (signature != null) {
		favoriteEntity.signature = signature;
	}
	return favoriteEntity;
}

Map<String, dynamic> $FavoriteEntityToJson(FavoriteEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['header'] = entity.header;
	data['rank'] = entity.rank;
	data['signature'] = entity.signature;
	return data;
}