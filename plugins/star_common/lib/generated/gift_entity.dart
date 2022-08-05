import '/generated/json/base/json_field.dart';
import '/generated/json/gift_entity.g.dart';


@JsonSerializable()
class GiftEntity {

	GiftEntity();

	factory GiftEntity.fromJson(Map<String, dynamic> json) => $GiftEntityFromJson(json);

	Map<String, dynamic> toJson() => $GiftEntityToJson(this);

	int? id;
	int? coins;
	String? name;
	String? picUrl;
	String? gifUrl;
	int? grade; //普通礼物的等级，1：初级 2：中级 3：高级
	int? levelLimit; //礼物等级限制 type 为等级礼物时才需设置  当 0 不显示礼物限制  当type=2 并且levelLimit！=0 的时候显示礼物限制
	int? type; //礼物类型 1：普通礼物 2：等级礼物 3：守护礼物  当tyoe=3 的时候显示守护礼物
}
