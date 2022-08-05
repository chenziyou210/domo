import '/generated/json/base/json_convert_content.dart';
import '/generated/channel_list_entity.dart';

ChannelListEntity $ChannelListEntityFromJson(Map<String, dynamic> json) {
	final ChannelListEntity channelListEntity = ChannelListEntity();
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		channelListEntity.name = name;
	}
	final String? pic = jsonConvert.convert<String>(json['pic']);
	if (pic != null) {
		channelListEntity.pic = pic;
	}
	final List<ChannelListDate>? date = jsonConvert.convertListNotNull<ChannelListDate>(json['date']);
	if (date != null) {
		channelListEntity.date = date;
	}
	return channelListEntity;
}

Map<String, dynamic> $ChannelListEntityToJson(ChannelListEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['name'] = entity.name;
	data['pic'] = entity.pic;
	data['date'] =  entity.date?.map((v) => v.toJson()).toList();
	return data;
}

ChannelListDate $ChannelListDateFromJson(Map<String, dynamic> json) {
	final ChannelListDate channelListDate = ChannelListDate();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		channelListDate.id = id;
	}
	final int? created = jsonConvert.convert<int>(json['created']);
	if (created != null) {
		channelListDate.created = created;
	}
	final int? modified = jsonConvert.convert<int>(json['modified']);
	if (modified != null) {
		channelListDate.modified = modified;
	}
	final String? createuser = jsonConvert.convert<String>(json['createuser']);
	if (createuser != null) {
		channelListDate.createuser = createuser;
	}
	final String? updateuser = jsonConvert.convert<String>(json['updateuser']);
	if (updateuser != null) {
		channelListDate.updateuser = updateuser;
	}
	final int? available = jsonConvert.convert<int>(json['available']);
	if (available != null) {
		channelListDate.available = available;
	}
	final double? diamond = jsonConvert.convert<double>(json['diamond']);
	if (diamond != null) {
		channelListDate.diamond = diamond;
	}
	final double? amount = jsonConvert.convert<double>(json['amount']);
	if (amount != null) {
		channelListDate.amount = amount;
	}
	final int? state = jsonConvert.convert<int>(json['state']);
	if (state != null) {
		channelListDate.state = state;
	}
	final String? channelType = jsonConvert.convert<String>(json['channelType']);
	if (channelType != null) {
		channelListDate.channelType = channelType;
	}
	return channelListDate;
}

Map<String, dynamic> $ChannelListDateToJson(ChannelListDate entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['created'] = entity.created;
	data['modified'] = entity.modified;
	data['createuser'] = entity.createuser;
	data['updateuser'] = entity.updateuser;
	data['available'] = entity.available;
	data['diamond'] = entity.diamond;
	data['amount'] = entity.amount;
	data['state'] = entity.state;
	data['channelType'] = entity.channelType;
	return data;
}