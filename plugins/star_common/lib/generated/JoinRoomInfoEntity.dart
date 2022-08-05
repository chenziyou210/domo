class JoinRoomInfoEntity {
  int? adminFlag;
  int? banFlag;
  String? channelName;
  String? channelToken;
  int? channelUid;
  String? chatRoomId;
  int? guard;
  int? trySecs;

  JoinRoomInfoEntity(
      {this.adminFlag,
        this.banFlag,
        this.channelName,
        this.channelToken,
        this.channelUid,
        this.chatRoomId,
        this.guard,
        this.trySecs});

  JoinRoomInfoEntity.fromJson(Map<String, dynamic> json) {
    adminFlag = json['adminFlag'];
    banFlag = json['banFlag'];
    channelName = json['channelName'];
    channelToken = json['channelToken'];
    channelUid = json['channelUid'];
    chatRoomId = json['chatRoomId'];
    guard = json['guard'];
    trySecs = json['trySecs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adminFlag'] = this.adminFlag;
    data['banFlag'] = this.banFlag;
    data['channelName'] = this.channelName;
    data['channelToken'] = this.channelToken;
    data['channelUid'] = this.channelUid;
    data['chatRoomId'] = this.chatRoomId;
    data['guard'] = this.guard;
    data['trySecs'] = this.trySecs;
    return data;
  }
}