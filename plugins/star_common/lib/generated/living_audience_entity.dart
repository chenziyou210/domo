import '/generated/json/base/json_field.dart';
import '/generated/json/living_audience_entity.g.dart';

@JsonSerializable()
class LivingAudienceEntity {
  LivingAudienceEntity();

  factory LivingAudienceEntity.fromJson(Map<String, dynamic> json) =>
      $LivingAudienceEntityFromJson(json);

  Map<String, dynamic> toJson() => $LivingAudienceEntityToJson(this);

  String? header;
  int? rank;
  int? sex;
  String? signature;
  int? userId;
  int? adminFlag;
  int? banFlag;
  int? nobleType;
  int? watchType;
  int? heat;
  int? joinTime;
  String? username;
}
