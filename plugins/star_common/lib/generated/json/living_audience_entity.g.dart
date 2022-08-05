import '/generated/json/base/json_convert_content.dart';
import '/generated/living_audience_entity.dart';

LivingAudienceEntity $LivingAudienceEntityFromJson(Map<String, dynamic> json) {
  final LivingAudienceEntity livingAudienceEntity = LivingAudienceEntity();
  livingAudienceEntity.header = json['header'];
  livingAudienceEntity.rank = json['rank'];
  livingAudienceEntity.sex = json['sex'];
  livingAudienceEntity.signature = json['signature'];
  livingAudienceEntity.userId = json['userId'];
  livingAudienceEntity.username = json['username'];
  livingAudienceEntity.adminFlag = json['adminFlag'];
  livingAudienceEntity.banFlag = json['banFlag'];
  livingAudienceEntity.nobleType = json['nobleType'];
  livingAudienceEntity.watchType = json['watchType'];
  if (json['heat'] is double) {
    double doubleH = json['heat'];
    String heattt = doubleH.toStringAsFixed(0);
    livingAudienceEntity.heat = int.tryParse(heattt) ?? 0;
  } else {
    livingAudienceEntity.heat = json['heat'] ?? 0;
  }

  livingAudienceEntity.joinTime = json['joinTime'] ?? 0;
  return livingAudienceEntity;
}

Map<String, dynamic> $LivingAudienceEntityToJson(LivingAudienceEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['header'] = entity.header;
  data['rank'] = entity.rank;
  data['sex'] = entity.sex;
  data['signature'] = entity.signature;
  data['userId'] = entity.userId;
  data['username'] = entity.username;
  data['adminFlag'] = entity.adminFlag;
  data['banFlag'] = entity.banFlag;
  data['nobleType'] = entity.nobleType;
  data['watchType'] = entity.watchType;
  data['heat'] = entity.heat;
  data['joinTime'] = entity.joinTime;
  return data;
}
