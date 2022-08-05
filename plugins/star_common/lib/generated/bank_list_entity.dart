import '/generated/json/base/json_field.dart';
import '/generated/json/bank_list_entity.g.dart';

@JsonSerializable()

///绑定的银行卡列表
class BankListEntity {
  BankListEntity();

  factory BankListEntity.fromJson(Map<String, dynamic> json) =>
      $BankListEntityFromJson(json);

  Map<String, dynamic> toJson() => $BankListEntityToJson(this);

  String? id;
  int? state;
  String? userId;
  String? purseChannel;
  String? name;
  String? bankname;
  String? cardNumber;
  String? accountob;
  String? remark;
  int? available;
  int? created;
  int? modified;
  String? bankIcon;
}

///绑定的钱包数据列表
class BindWalletListEntity {
  String? createTime;
  int? id;
  String? updateTime;
  int? userId;
  String? walletAddress;
  String? walletIcon;
  String? walletType;
  String? walletName;
  BindWalletListEntity(
      {this.createTime,
      this.id,
      this.updateTime,
      this.userId,
      this.walletAddress,
      this.walletIcon,
      this.walletType,
      this.walletName});

  BindWalletListEntity.fromJson(Map<String, dynamic> json) {
    createTime = json['createTime'];
    id = json['id'];
    updateTime = json['updateTime'];
    userId = json['userId'];
    walletAddress = json['walletAddress'];
    walletIcon = json['walletIcon'];
    walletType = json['walletType'];
    walletName = json['walletName'];
  }
}

///绑定的银行卡列表
class BankListData {
  int? bankId;
  String? name;
  String? bankName;
  int? id;
  String? accountOpenBank;
  String? bankIcon;
  String? cardNumber;

  BankListData(
      {this.bankId,
      this.name,
      this.bankName,
      this.id,
      this.accountOpenBank,
      this.bankIcon,
      this.cardNumber});

  BankListData.fromJson(Map<String, dynamic> json) {
    bankId = json['bankId'];
    name = json['name'];
    bankName = json['bankName'];
    id = json['id'];
    accountOpenBank = json['accountOpenBank'];
    bankIcon = json['bankIcon'];
    cardNumber = json['cardNumber'];
  }
}
