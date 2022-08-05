import '/generated/json/base/json_field.dart';
import '/generated/json/user_info_entity.g.dart';

import 'json/im_room_account_entity.g.dart';


@JsonSerializable()
class IMRoomAccountEntity {

	IMRoomAccountEntity();

	factory IMRoomAccountEntity.fromJson(Map<String, dynamic> json) => $IMRoomAccountEntityFromJson(json);

	Map<String, dynamic> toJson() => $IMRoomAccountEntityToJson(this);

	bool? canLogin;
	String? chatPassword;
	String? chatUsername;
	String? chatUuid;
}
