
import 'package:get/get.dart';

class OpenGuideState {

  Rx<LiveRoomWatchUserData> _data = LiveRoomWatchUserData().obs;
  Rx<LiveRoomWatchUserData> get data => _data;
  List<String > openFee = ['999','3333','33333'];
  List<String > guardTitle = ['周·守护','月·守护','真爱年·守护'];
  List<String > renewalFee = ['799','2666','26666'];

  setDetails(LiveRoomWatchUserData data){
    _data.value=data;
  }

  OpenGuideState() {
    ///Initialize variables
  }

}

class LiveRoomWatchUserData {
  String? expireTime;
  int? type;

  LiveRoomWatchUserData({this.expireTime, this.type});

  LiveRoomWatchUserData.fromJson(Map<String, dynamic> json) {
    expireTime = json['expireTime'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expireTime'] = this.expireTime;
    data['type'] = this.type;
    return data;
  }
}