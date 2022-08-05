import '/generated/json/base/json_convert_content.dart';
import '/generated/rank_new_entity.dart';

RankNewEntity $RankNewEntityFromJson(Map<String, dynamic> json) {
  final RankNewEntity rankNewEntity = RankNewEntity();
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    rankNewEntity.userId = userId;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    rankNewEntity.username = username;
  }
  final String? header = jsonConvert.convert<String>(json['header']);
  if (header != null) {
    rankNewEntity.header = header;
  }
  final int? rank = jsonConvert.convert<int>(json['rank']);
  if (rank != null) {
    rankNewEntity.rank = rank;
  }
  final int? totalValue = jsonConvert.convert<int>(json['totalValue']);
  if (totalValue != null) {
    rankNewEntity.totalValue = totalValue;
  }
  final bool? attention = jsonConvert.convert<bool>(json['attention']);
  if (attention != null) {
    rankNewEntity.attention = attention;
  }
  final int? isInvisible = jsonConvert.convert<int>(json['isInvisible']);
  if (isInvisible != null) {
    rankNewEntity.isInvisible = isInvisible;
  }

  final int? state = jsonConvert.convert<int>(json['state']);
  if (state != null) {
    rankNewEntity.isLive = state == 1 ? true : false;
  }

  final int? heat = jsonConvert.convert<int>(json['heat']);
  if (heat != null) {
    rankNewEntity.heat = heat;
  }
  final String? roomId = jsonConvert.convert<String>(json['roomId']) ?? "";
  if (roomId != null) {
    rankNewEntity.roomId = roomId;
  }
  final String? roomCover =
      jsonConvert.convert<String>(json['roomCover']) ?? "";
  if (roomCover != null) {
    rankNewEntity.roomCover = roomCover;
  }
  return rankNewEntity;
}

Map<String, dynamic> $RankNewEntityToJson(RankNewEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userId'] = entity.userId;
  data['username'] = entity.username;
  data['header'] = entity.header;
  data['rank'] = entity.rank;
  data['totalValue'] = entity.totalValue;
  data['attention'] = entity.attention;
  data['heat'] = entity.heat;
  data['isInvisible'] = entity.isInvisible;
  data['roomId'] = entity.roomId;
  data['roomCover'] = entity.roomCover;
  return data;
}
