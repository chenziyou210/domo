/*
 *  Copyright (C), 2015-2021
 *  FileName: live_new_logic
 *  Author: Tonight丶相拥
 *  Date: 2021/12/7
 *  Description: 
 **/

import 'dart:convert';

import 'package:get/get.dart';
import 'package:star_common/http/http_channel.dart';

import '../../live_room_new_logic.dart';

class LiveRoomWatchList extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final LiveRoomWatchListState state = LiveRoomWatchListState();

  Future liveRoomWatchData() {
    return HttpChannel.channel.getLiveRoomWatchList("${Get.find<LiveRoomNewLogic>().state.roomInfo.value.roomId}")
      ..then((value) => value.finalize(
          wrapper: WrapperModel(),
          success: (data) {
            if (data is List && data.isNotEmpty) {
              state.setRomWatchListData(
                  data.map((e) => LiveRoomWatchListData.fromJson(e)).toList());
            }else{
              state.liveRoomWatchList.value.clear();
            }
          }));
  }

  Future openOrRenew( int type,
      {void Function(String)? failure, void Function()? success}) {
    if(type==0){
      type=2001;
    }else if(type==1){
      type=2002;
    }else{
      type=2003;
    }
    return HttpChannel.channel.openOrRenew("${Get.find<LiveRoomNewLogic>().state.roomInfo.value.roomId}", type)
      ..then((value) => value.finalize(
            wrapper: WrapperModel(),
            success: (data) {
              success?.call();
              if(type==2001){
                Get.find<LiveRoomNewLogic>().state.setGuard(2001);
              }else if(type==2002){
                Get.find<LiveRoomNewLogic>().state.setGuard(2002);
              }else{
                Get.find<LiveRoomNewLogic>().state.setGuard(2003);
              }
            },
            failure: (e) {
              failure?.call(e);
            },
          ));
  }
}

class LiveRoomWatchListData {
  int? userId;
  String? username;
  String? header;
  int? rank;
  int? heat;
  int? watchType;
  int? nobleType;
  int? roomAdmin;

  LiveRoomWatchListData(
      {this.userId,
        this.username,
        this.header,
        this.rank,
        this.heat,
        this.watchType,
        this.nobleType,
        this.roomAdmin});

  LiveRoomWatchListData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    username = json['username'];
    header = json['header'];
    rank = json['rank'];
    heat = json['heat'];
    watchType = json['watchType'];
    nobleType = json['nobleType'];
    roomAdmin = json['roomAdmin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['username'] = this.username;
    data['header'] = this.header;
    data['rank'] = this.rank;
    data['heat'] = this.heat;
    data['watchType'] = this.watchType;
    data['nobleType'] = this.nobleType;
    data['roomAdmin'] = this.roomAdmin;
    return data;
  }
}

class LiveRoomWatchListState {
  RxList<LiveRoomWatchListData> _liveRoomWatchList = RxList();

  RxList<LiveRoomWatchListData> get liveRoomWatchList => _liveRoomWatchList;

  void setRomWatchListData(List<LiveRoomWatchListData> value) {
    _liveRoomWatchList.value = value;
  }
}
