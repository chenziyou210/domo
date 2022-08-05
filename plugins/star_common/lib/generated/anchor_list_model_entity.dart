import '/generated/json/base/json_field.dart';
import '/generated/json/anchor_list_model_entity.g.dart';


@JsonSerializable()
class AnchorListModelEntity {

	AnchorListModelEntity({this.channelName,
		this.chatRoomId,
		this.city,
		this.region,
		this.closeTime,
		this.daXiu,
		this.distance,
		this.heat,
		this.id,
		this.lookLevel,
		this.onlineNum,
		this.openProps,
		this.openTime,
		this.roomCover,
		this.roomTitle,
		this.roomType,
		this.feeType,
		this.seeTryTime,
		this.sort,
		this.state,
		this.ticketAmount,
		this.ticketTreeFlg,
		this.timeDeduction,
		this.userId,
		this.username,
		this.gameName,
	  this.barType,
	  this.header,
		this.rank});

	factory AnchorListModelEntity.fromJson(Map<String, dynamic> json) => $AnchorListModelEntityFromJson(json);

	Map<String, dynamic> toJson() => $AnchorListModelEntityToJson(this);

	String? channelName;
	String? chatRoomId;
	String? city;
	String? region;
	String? closeTime;
	bool? daXiu;
	double? distance;
	int? heat;
	String? id;
	int? lookLevel;
	int? onlineNum;
	bool? openProps;
	String? openTime;
	String? roomCover;
	String? roomTitle;
	int? roomType;
	int? feeType;
	int? seeTryTime;
	int? sort;
	int? state;
	int? ticketAmount;
	int? ticketTreeFlg;
	int? timeDeduction;
	String? userId;
	String? username;
	String? gameName;
	String? header;
	int ? barType;
	int ? rank;


}

