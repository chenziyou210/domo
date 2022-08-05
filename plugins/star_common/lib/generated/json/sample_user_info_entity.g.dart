import '/generated/json/base/json_convert_content.dart';
import '/generated/sample_user_info_entity.dart';

SampleUserInfoEntity $SampleUserInfoEntityFromJson(Map<String, dynamic> json) {
  final SampleUserInfoEntity sampleUserInfoEntity = SampleUserInfoEntity();
  sampleUserInfoEntity.city = json['city'];
  sampleUserInfoEntity.fansNum = json['fansNum'];
  sampleUserInfoEntity.follow = json['follow'];
  sampleUserInfoEntity.attentionNum = json['attentionNum'];
  sampleUserInfoEntity.header = json['header'];
  sampleUserInfoEntity.rank = json['rank'];
  sampleUserInfoEntity.sendGiftNum = json['sendGiftNum'];
  sampleUserInfoEntity.signature = json['signature'];
  sampleUserInfoEntity.username = json['username'];
  sampleUserInfoEntity.heat = json['heat'];
  sampleUserInfoEntity.sex = json['sex'];
  sampleUserInfoEntity.shortId = json['shortId'];
  sampleUserInfoEntity.birthday = json['birthday'];
  sampleUserInfoEntity.totalHeat = json['totalHeat'];
  sampleUserInfoEntity.heat = json['heat'];
  sampleUserInfoEntity.receivedGiftNum = json['receivedGiftNum'];

  sampleUserInfoEntity.totalHeat = json['totalHeat'];
  sampleUserInfoEntity.profession = json['profession'];
  sampleUserInfoEntity.emotion = json['emotion'];
  sampleUserInfoEntity.age = json['age'];
  sampleUserInfoEntity.nobleType = json['nobleType'] ?? 0;
  sampleUserInfoEntity.openLiveFlag = json['openLiveFlag'];
  sampleUserInfoEntity.adminFlag = json['adminFlag'];
  sampleUserInfoEntity.speakBan = json['speakBan'];
  sampleUserInfoEntity.watchType = json['watchType'];
  sampleUserInfoEntity.rankUserList = json['rankUserList'];
  sampleUserInfoEntity.state = json['state'] ?? 0;
  return sampleUserInfoEntity;
}

Map<String, dynamic> $SampleUserInfoEntityToJson(SampleUserInfoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['city'] = entity.city;
  data['fansNum'] = entity.fansNum;
  data['follow'] = entity.follow;
  data['attentionNum'] = entity.attentionNum;
  data['header'] = entity.header;
  data['rank'] = entity.rank;
  data['sendGiftNum'] = entity.sendGiftNum;
  data['signature'] = entity.signature;
  data['username'] = entity.username;
  data['heat'] = entity.heat;
  data['sex'] = entity.sex;
  data['shortId'] = entity.shortId;
  data['birthday'] = entity.birthday;
  data['totalHeat'] = entity.totalHeat;
  data['heat'] = entity.heat;
  data['receivedGiftNum'] = entity.receivedGiftNum;

  data['totalHeat'] = entity.totalHeat;
  data['profession'] = entity.profession;
  data['emotion'] = entity.emotion;
  data['age'] = entity.age;
  data['nobleType'] = entity.nobleType;
  data['openLiveFlag'] = entity.openLiveFlag;
  data['adminFlag'] = entity.adminFlag;
  data['speakBan'] = entity.speakBan;
  data['watchType'] = entity.watchType;
  data['rankUserList'] = entity.rankUserList;
  data['state'] = entity.state;
  return data;
}
