class CheckVersionData {
  late String createTime; //"yyyy-MM-dd HH:mm:ss",
  late String createUser; //"",
  late int deviceType; //0, 安卓=0 ios=1
  late String downloadUrl; //"",版本下载地址(无需页面填写自动生成展示即可)
  late int id; //0,
  late int isEnable; //0,是否启用（0：否 1：是）
  late int isForce; //0,是否强更新 0=否 1=是
  late String remark; //"",版本描述
  late String updateTime; //"yyyy-MM-dd HH:mm:ss",
  late String updateUser; //"",
  late String versionName; //"",版本名称
  late String versionNo; //""版本号

  CheckVersionData({
    this.createTime = '',
    this.createUser = '',
    this.deviceType = -1,
    this.downloadUrl = '',
    this.id = -1,
    this.isEnable = -1,
    this.isForce = 1,
    this.remark = '',
    this.updateTime = '',
    this.updateUser = '',
    this.versionName = '',
    this.versionNo = '1.0.0',
  });

  CheckVersionData.fromJson(Map<String, dynamic> json) {
    this.createTime = json['createTime'] ?? '';
    this.createUser = json['createUser'] ?? '';
    this.deviceType = json['deviceType'] ?? -1;
    this.downloadUrl = json['downloadUrl'] ?? '';
    this.id = json['id'] ?? -1;
    this.isEnable = json['isEnable'] ?? -1;
    this.isForce = json['isForce'] ?? 1;
    this.remark = json['remark'] ?? '';
    this.updateTime = json['updateTime'] ?? '';
    this.updateUser = json['updateUser'] ?? '';
    this.versionName = json['versionName'] ?? '';
    this.versionNo = json['versionNo'] ?? '1.0.0';
  }
}
