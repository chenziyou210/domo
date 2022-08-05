import '/generated/json/base/json_convert_content.dart';

import '../im_room_account.dart';

IMRoomAccountEntity $IMRoomAccountEntityFromJson(Map<String, dynamic> json) {
  final IMRoomAccountEntity iMRoomAccountEntity = IMRoomAccountEntity();
  final bool? canLogin = jsonConvert.convert<bool>(json['canLogin']);
  if (canLogin != null) {
    iMRoomAccountEntity.canLogin = canLogin;
  }

  final String? chatUsername =
      jsonConvert.convert<String>(json['chatUsername']);
  if (canLogin != null) {
    iMRoomAccountEntity.chatUsername = chatUsername;
  }

  final String? chatPassword =
      jsonConvert.convert<String>(json['chatPassword']);
  if (canLogin != null) {
    iMRoomAccountEntity.chatPassword = chatPassword;
  }

  final String? chatUuid = jsonConvert.convert<String>(json['chatUuid']);
  if (canLogin != null) {
    iMRoomAccountEntity.chatUuid = chatUuid;
  }

  return iMRoomAccountEntity;
}

Map<String, dynamic> $IMRoomAccountEntityToJson(IMRoomAccountEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['canLogin'] = entity.canLogin;
  data['chatUsername'] = entity.chatUsername;
  data['chatPassword'] = entity.chatPassword;
  data['chatUuid'] = entity.chatUuid;
  return data;
}
