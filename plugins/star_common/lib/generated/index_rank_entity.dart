import '/generated/json/base/json_field.dart';
import '/generated/json/index_rank_entity.g.dart';


@JsonSerializable()
class IndexRankEntity {

	IndexRankEntity();

	factory IndexRankEntity.fromJson(Map<String, dynamic> json) => $IndexRankEntityFromJson(json);

	Map<String, dynamic> toJson() => $IndexRankEntityToJson(this);

	String? userId;
	String? username;
	String? header;
	int? rank;
	int? totalValue;
	bool? attention;
}
