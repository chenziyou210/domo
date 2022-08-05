import '/generated/json/base/json_convert_content.dart';
import '/generated/favorite_new_entity.dart';

FavoriteNewEntity $FavoriteNewEntityFromJson(Map<String, dynamic> json) {
	final FavoriteNewEntity favoriteNewEntity = FavoriteNewEntity();
	final String? header = jsonConvert.convert<String>(json['header']);
	if (header != null) {
		favoriteNewEntity.header = header;
	}
	final String? memberid = jsonConvert.convert<String>(json['memberid']);
	if (memberid != null) {
		favoriteNewEntity.memberid = memberid;
	}
	final int? rank = jsonConvert.convert<int>(json['rank']);
	if (rank != null) {
		favoriteNewEntity.rank = rank;
	}
	final String? userId = jsonConvert.convert<String>(json['userId']);
	if (userId != null) {
		favoriteNewEntity.userId = userId;
	}
	final String? username = jsonConvert.convert<String>(json['username']);
	if (username != null) {
		favoriteNewEntity.username = username;
	}
	return favoriteNewEntity;
}

Map<String, dynamic> $FavoriteNewEntityToJson(FavoriteNewEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['header'] = entity.header;
	data['memberid'] = entity.memberid;
	data['rank'] = entity.rank;
	data['userId'] = entity.userId;
	data['username'] = entity.username;
	return data;
}