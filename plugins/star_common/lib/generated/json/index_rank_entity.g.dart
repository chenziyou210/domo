import '/generated/json/base/json_convert_content.dart';
import '/generated/index_rank_entity.dart';

IndexRankEntity $IndexRankEntityFromJson(Map<String, dynamic> json) {
	final IndexRankEntity indexRankEntity = IndexRankEntity();
	final String? userId = jsonConvert.convert<String>(json['userId']);
	if (userId != null) {
		indexRankEntity.userId = userId;
	}
	final String? username = jsonConvert.convert<String>(json['username']);
	if (username != null) {
		indexRankEntity.username = username;
	}
	final String? header = jsonConvert.convert<String>(json['header']);
	if (header != null) {
		indexRankEntity.header = header;
	}
	final int? rank = jsonConvert.convert<int>(json['rank']);
	if (rank != null) {
		indexRankEntity.rank = rank;
	}
	final int? totalValue = jsonConvert.convert<int>(json['totalValue']);
	if (totalValue != null) {
		indexRankEntity.totalValue = totalValue;
	}
	final bool? attention = jsonConvert.convert<bool>(json['attention']);
	if (attention != null) {
		indexRankEntity.attention = attention;
	}
	return indexRankEntity;
}

Map<String, dynamic> $IndexRankEntityToJson(IndexRankEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['userId'] = entity.userId;
	data['username'] = entity.username;
	data['header'] = entity.header;
	data['rank'] = entity.rank;
	data['totalValue'] = entity.totalValue;
	data['attention'] = entity.attention;
	return data;
}