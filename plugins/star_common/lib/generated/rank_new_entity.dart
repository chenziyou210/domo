import '/generated/json/base/json_field.dart';
import '/generated/json/rank_new_entity.g.dart';

@JsonSerializable()
class RankNewEntity {
  RankNewEntity();

  factory RankNewEntity.fromJson(Map<String, dynamic> json) =>
      $RankNewEntityFromJson(json);

  Map<String, dynamic> toJson() => $RankNewEntityToJson(this);

  String? userId;
  String? username;
  String? header;
  int? rank;
  int? heat;
  int? totalValue;
  bool? attention;
  bool? isLive;
  String? heatString; //自定义转string
  int? isInvisible;
  String? roomId;
  String? roomCover;
  //CUSTOM
  bool? isAnchor;
  @override
  String toString() {
    return 'RankNewEntity{userId: $userId, username: $username, header: $header, rank: $rank, heat: $heat, totalValue: $totalValue, attention: $attention, isLive: $isLive, heatString: $heatString, isInvisible: $isInvisible, roomId: $roomId, roomCover: $roomCover}';
  }
}
