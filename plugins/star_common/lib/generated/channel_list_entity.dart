import '/generated/json/base/json_field.dart';
import '/generated/json/channel_list_entity.g.dart';


@JsonSerializable()
class ChannelListEntity {

	ChannelListEntity();

	factory ChannelListEntity.fromJson(Map<String, dynamic> json) => $ChannelListEntityFromJson(json);

	Map<String, dynamic> toJson() => $ChannelListEntityToJson(this);

	String? name;
	String? pic;
	List<ChannelListDate>? date;
}

@JsonSerializable()
class ChannelListDate {

	ChannelListDate();

	factory ChannelListDate.fromJson(Map<String, dynamic> json) => $ChannelListDateFromJson(json);

	Map<String, dynamic> toJson() => $ChannelListDateToJson(this);

	String? id;
	int? created;
	int? modified;
	String? createuser;
	String? updateuser;
	int? available;
	double? diamond;
	double? amount;
	int? state;
	String? channelType;
}
