import '/generated/json/base/json_field.dart';
import '/generated/json/lottery_record_entity.g.dart';


@JsonSerializable()
class LotteryRecordEntity {

	LotteryRecordEntity();

	factory LotteryRecordEntity.fromJson(Map<String, dynamic> json) => $LotteryRecordEntityFromJson(json);

	Map<String, dynamic> toJson() => $LotteryRecordEntityToJson(this);

	int? id;
	String? created;
	int? available;
	String? gameResultStr;
	String? gameResultStrPic;
	String? gameName;
	String? periodTime;
}
