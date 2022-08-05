import '/generated/json/base/json_field.dart';
import '/generated/json/system_bank_entity.g.dart';


@JsonSerializable()
class SystemBankEntity {

	SystemBankEntity();

	factory SystemBankEntity.fromJson(Map<String, dynamic> json) => $SystemBankEntityFromJson(json);

	Map<String, dynamic> toJson() => $SystemBankEntityToJson(this);

	String? id;
	String? bankName;
	String? shortBankName;
	String? thirdBankId;
	int? available;
	int? created;
}
