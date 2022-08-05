import '/generated/json/base/json_field.dart';
import '/generated/json/favorite_entity.g.dart';


@JsonSerializable()
class FavoriteEntity {

	FavoriteEntity();

	factory FavoriteEntity.fromJson(Map<String, dynamic> json) => $FavoriteEntityFromJson(json);

	Map<String, dynamic> toJson() => $FavoriteEntityToJson(this);

	String? id;
	String? name;
	String? header;
	int? rank;
	String? signature;
}
