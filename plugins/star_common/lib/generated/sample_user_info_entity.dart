import '/generated/json/base/json_field.dart';
import '/generated/json/sample_user_info_entity.g.dart';

@JsonSerializable()
class SampleUserInfoEntity {
  SampleUserInfoEntity();

  factory SampleUserInfoEntity.fromJson(Map<String, dynamic> json) =>
      $SampleUserInfoEntityFromJson(json);

  Map<String, dynamic> toJson() => $SampleUserInfoEntityToJson(this);

  ///家乡
  String? city;

  ///粉丝数
  int? fansNum;

  ///是否关注 true:已关注 false:未关注
  bool? follow;

  ///关注数
  int? attentionNum;

  ///头像地址
  String? header;

  ///等级
  int? rank;

  ///送出礼物数
  int? sendGiftNum;
  int? receivedGiftNum;

  ///个性签名
  String? signature;

  ///昵称
  String? username;

  ///火力值
  int? heat;

  ///用户短id
  String? shortId;

  ///性别 0男1女
  int? sex;

  int? totalHeat;

  ///职业
  String? profession;

  ///情感
  String? emotion;

  ///年龄
  int? age;

  ///生日
  String? birthday;

  ///是否是管理员，管理员标志 0:不是管理员 1:管理员
  int? adminFlag;

  ///是否被禁言
  int? speakBan;

  ///贵族等级
  int nobleType = 0;

  ///是否能开直播 0=否 1=是
  int openLiveFlag = 0;

  ///主播状态(1:直播 2:离线 3:禁用)
  int state = 0;

  ///守护等级 0 默认 1
  /// "2001","周守护"
  /// "2002","月守护"
  /// "2003","年守护"
  int watchType = 0;

  List? rankUserList;

  // //生日
  // String? birthday;
  // //生日
  // String? hometown;

  // /// 情感
  // String? feeling;
}
