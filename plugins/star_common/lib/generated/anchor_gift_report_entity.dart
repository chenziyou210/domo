import 'dart:convert';
import '/generated/json/base/json_field.dart';
import '/generated/json/anchor_gift_report_entity.g.dart';

@JsonSerializable()
class AnchorGiftReportEntity {

	double? coins;
	String? created;
	String? num;
	String? picurl;
  
  AnchorGiftReportEntity();

  factory AnchorGiftReportEntity.fromJson(Map<String, dynamic> json) => $AnchorGiftReportEntityFromJson(json);

  Map<String, dynamic> toJson() => $AnchorGiftReportEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}