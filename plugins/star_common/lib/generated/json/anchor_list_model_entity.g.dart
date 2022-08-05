import '/generated/json/base/json_convert_content.dart';
import '/generated/anchor_list_model_entity.dart';





AnchorListModelEntity $AnchorListModelEntityFromJson(Map<String, dynamic> json) {
	final AnchorListModelEntity anchorListModelEntity = AnchorListModelEntity();

	anchorListModelEntity.channelName = json['channelName'];
	anchorListModelEntity.chatRoomId = json['chatRoomId'];
	anchorListModelEntity.city = json['city'];
	anchorListModelEntity.region = json['region'];
	anchorListModelEntity.closeTime = json['closeTime'];
	anchorListModelEntity.daXiu = json['daXiu'];
	anchorListModelEntity.distance = json['distance'];
	anchorListModelEntity.heat = json['heat'];
	anchorListModelEntity.id = json['id'];
	anchorListModelEntity.lookLevel = json['lookLevel'];
	anchorListModelEntity.onlineNum = json['onlineNum'];
	anchorListModelEntity.openProps = json['openProps'];
	anchorListModelEntity.openTime = json['openTime'];
	anchorListModelEntity.roomCover = json['roomCover'];
	anchorListModelEntity.roomTitle = json['roomTitle'];
	anchorListModelEntity.roomType = json['roomType'];
	anchorListModelEntity.feeType = json['feeType'];
	anchorListModelEntity.seeTryTime = json['seeTryTime'];
	anchorListModelEntity.sort = json['sort'];
	anchorListModelEntity.state = json['state'];
	anchorListModelEntity.ticketAmount = json['ticketAmount'];
	anchorListModelEntity.ticketTreeFlg = json['ticketTreeFlg'];
	anchorListModelEntity.timeDeduction = json['timeDeduction'];
	anchorListModelEntity.userId = json['userId'];
	anchorListModelEntity.username = json['username'];
	anchorListModelEntity.gameName = json['gameName'];
	anchorListModelEntity.rank = json['rank'];
	anchorListModelEntity.header = json['header'];


	return anchorListModelEntity;
}

Map<String, dynamic> $AnchorListModelEntityToJson(AnchorListModelEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['channelName'] = entity.channelName;
	data['chatRoomId'] = entity.chatRoomId;
	data['city'] = entity.city;
	data['region'] = entity.region;
	data['closeTime'] = entity.closeTime;
	data['daXiu'] = entity.daXiu;
	data['distance'] = entity.distance;
	data['heat'] = entity.heat;
	data['id'] = entity.id;
	data['lookLevel'] = entity.lookLevel;
	data['onlineNum'] = entity.onlineNum;
	data['openProps'] = entity.openProps;
	data['openTime'] = entity.openTime;
	data['roomCover'] = entity.roomCover;
	data['roomTitle'] = entity.roomTitle;
	data['roomType'] = entity.roomType;
	data['feeType'] = entity.feeType;
	data['seeTryTime'] = entity.seeTryTime;
	data['sort'] = entity.sort;
	data['state'] = entity.state;
	data['ticketAmount'] = entity.ticketAmount;
	data['ticketTreeFlg'] = entity.ticketTreeFlg;
	data['timeDeduction'] = entity.timeDeduction;
	data['userId'] = entity.userId;
	data['username'] = entity.username;
	data['gameName'] = entity.gameName;
	data['rank'] = entity.rank;
	data['header'] = entity.header;

	return data;
}