import 'package:get/get.dart';
import 'package:spring/spring.dart';
import 'package:star_common/common/common_widget/components/components_view.dart';

/// @description:
/// @author  austin
/// @date: 2022-06-10 13:21:23
// ignore_for_file: prefer_collection_literals, unnecessary_this, unnecessary_new

class RechargeState {
  RechargeState() {
    ///Initialize variables
  }
  RxString contents = "充值大回馈,力度超前,优惠多多 ".obs;
  setUpdateContents(String value) {
    contents.value = value;
  }

  ///刷新金币
  final SpringController springCoinsController =
      SpringController(initialAnim: Motion.pause);

  ///刷新钻石动画
  final SpringController springDrinksCoinsController =
      SpringController(initialAnim: Motion.pause);
  RxList<RechargeData> rechargeList = <RechargeData>[].obs;
  setUpdateRechargeList(List<RechargeData> value) {
    rechargeList.value = value;
  }

  // List<RechargeRunningLightData> marqueeData = [];

  int selectedIndex = 1;
}

class RechargeData {
  List<RechargeChannelList>? channelList;
  String? name;
  String? payTypeNo;
  String? iconUrl;

  RechargeData({this.channelList, this.name, this.payTypeNo, this.iconUrl});

  RechargeData.fromJson(Map<String, dynamic> json) {
    if (json['channelList'] != null) {
      channelList = <RechargeChannelList>[];
      json['channelList'].forEach((v) {
        channelList!.add(new RechargeChannelList.fromJson(v));
      });
    }
    name = json['name'];
    payTypeNo = json['payTypeNo'];
    iconUrl = json['iconUrl'];
  }
}

class RechargeChannelList {
  int? minAmount;
  String? merchantCode;
  int? isFix;
  String? fixAmount;
  String? channelName;
  int? maxAmount;
  int? channelId;

  RechargeChannelList(
      {this.minAmount,
      this.merchantCode,
      this.isFix,
      this.fixAmount,
      this.channelName,
      this.maxAmount,
      this.channelId});

  RechargeChannelList.fromJson(Map<String, dynamic> json) {
    minAmount = json['minAmount'];
    merchantCode = json['merchantCode'];
    isFix = json['isFix'];
    fixAmount = json['fixAmount'];
    channelName = json['channelName'];
    maxAmount = json['maxAmount'];
    channelId = json['channelId'];
  }
}

///跑马灯模型
class RechargeRunningLightData {
  int? id;
  String? title;
  String? content;
  String? startTime;
  String? endTime;
  String? jumpPath;
  int? type;

  RechargeRunningLightData(
      {this.id,
      this.title,
      this.content,
      this.startTime,
      this.endTime,
      this.jumpPath,
      this.type});

  RechargeRunningLightData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    jumpPath = json['jumpPath'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['jumpPath'] = this.jumpPath;
    data['type'] = this.type;
    return data;
  }
}

class BannerInfo {
  // 命名函数
  BannerInfo(
      {this.id,
      this.pic,
      this.url,
      this.urlType,
      this.picType,
      this.position,
      this.duration,
      this.startTime,
      this.endTime});
  int? id;
  String? pic;
  String? url;

  int? picType;
  int? position;
  int? duration;
  String? startTime;
  String? endTime;

  //链接类型 0：内链，1：外链，2：APP页面内跳转, 3:三方游戏跳转
  int? urlType;

  BannerInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pic = json['pic'];
    url = json['url'];
    urlType = json['urlType'];
    picType = json['picType'];
    position = json['position'];
    duration = json['duration'];
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['pic'] = this.pic;
    data['url'] = this.url;
    data['urlType'] = this.urlType;
    data['picType'] = this.picType;
    data['position'] = this.position;
    data['duration'] = this.duration;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;

    return data;
  }
}
