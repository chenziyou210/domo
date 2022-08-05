import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @description:
/// @author
/// @date: 2022-05-31 18:29:10
class MineChargeAndWithdrawState {
  late int pageIndex = 1;
  late bool loadMore = true;
  late final RefreshController chargeController = RefreshController();
  late final RefreshController withdrawController = RefreshController();
  // List? data = null;
  MineChargeAndWithdrawState() {}
  final List<String> titles = ["提现记录", "充值记录"];

  ///充值记录
  List<RechargeRecordData> rechargeRecordList = [];

  ///提现记录
  List<WithdrawalRecordsData> withdrawalRecordsList = [];
}

///充值记录
class RechargeRecordData {
  String? orderNo;
  String? createTime;
  String? orderStatus;
  String? payTypeNo;
  int? userId;
  double? rechargeMoney;
  String? iconUrl;
  RechargeRecordData(
      {this.orderNo,
      this.createTime,
      this.orderStatus,
      this.payTypeNo,
      this.userId,
      this.rechargeMoney,
      this.iconUrl});

  RechargeRecordData.fromJson(Map<String, dynamic> json) {
    orderNo = json['orderNo'];
    createTime = json['createTime'];
    orderStatus = json['orderStatus'];
    payTypeNo = json['payTypeNo'];
    userId = json['userId'];
    rechargeMoney = (json['rechargeMoney'] is int)
        ? double.parse("${json['rechargeMoney']}")
        : json['rechargeMoney'];
    iconUrl = json["iconUrl"];
  }
}

class WithdrawalRecordsData {
  String? orderNo;
  double? money;
  String? createTime;
  double? actuallyMoney;
  String? withdrawType;
  String? orderStatus;
  String? iconUrl;
  int? userId;

  WithdrawalRecordsData(
      {this.orderNo,
      this.money,
      this.createTime,
      this.actuallyMoney,
      this.withdrawType,
      this.orderStatus,
      this.iconUrl,
      this.userId});

  WithdrawalRecordsData.fromJson(Map<String, dynamic> json) {
    orderNo = (json['orderNo'] is int)
        ? double.parse("${json['orderNo']}")
        : json['orderNo'];
    money = json['money'];
    createTime = json['createTime'];
    actuallyMoney = (json['actuallyMoney'] is int)
        ? double.parse("$json['actuallyMoney']")
        : json['actuallyMoney'];
    withdrawType = json['withdrawType'];
    orderStatus = json['orderStatus'];
    iconUrl = json['iconUrl'];
    userId = json['userId'];
  }
}
