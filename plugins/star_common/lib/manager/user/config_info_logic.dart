/*
 *  Copyright (C), 2015-2021
 *  FileName: live_new_logic
 *  Author: Tonight丶相拥
 *  Date: 2021/12/7
 *  Description: 
 **/

import 'package:get/get.dart';
import 'package:star_common/http/http_channel.dart';

class ConfigInfoLonic extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getConfigInfoData();
  }

  final ConfigInfoState state = ConfigInfoState();

  Future getConfigInfoData() {
    return HttpChannel.channel.configInfo()
      ..then((value) => value.finalize(
          wrapper: WrapperModel(),
          success: (data) {
            state.setUserBalanceData(ConfigInfoData.fromJson(data));
          }));
  }
}

class ConfigInfoData {
  SysHelpH5? sysHelpH5;
  SysRoomSpeaking? sysRoomSpeaking;
  SysRoomNotice? sysRoomNotice;

  ConfigInfoData({this.sysHelpH5, this.sysRoomSpeaking, this.sysRoomNotice});

  ConfigInfoData.fromJson(Map<String, dynamic> json) {
    sysHelpH5 = json['sys_help_h5'] != null
        ? new SysHelpH5.fromJson(json['sys_help_h5'])
        : null;
    sysRoomSpeaking = json['sys_room_speaking'] != null
        ? new SysRoomSpeaking.fromJson(json['sys_room_speaking'])
        : null;
    sysRoomNotice = json['sys_room_notice'] != null
        ? new SysRoomNotice.fromJson(json['sys_room_notice'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sysHelpH5 != null) {
      data['sys_help_h5'] = this.sysHelpH5!.toJson();
    }
    if (this.sysRoomSpeaking != null) {
      data['sys_room_speaking'] = this.sysRoomSpeaking!.toJson();
    }
    if (this.sysRoomNotice != null) {
      data['sys_room_notice'] = this.sysRoomNotice!.toJson();
    }
    return data;
  }
}

class SysHelpH5 {
  String? sysHelpH5;
  String? nobleInfo;
  String? watchInfo;

  SysHelpH5({this.sysHelpH5, this.nobleInfo, this.watchInfo});

  SysHelpH5.fromJson(Map<String, dynamic> json) {
    sysHelpH5 = json['sys_help_h5'];
    nobleInfo = json['noble_info'];
    watchInfo = json['watch_info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sys_help_h5'] = this.sysHelpH5;
    data['noble_info'] = this.nobleInfo;
    data['watch_info'] = this.watchInfo;
    return data;
  }
}

class SysRoomSpeaking {
  String? sysRoomSpeaking;

  SysRoomSpeaking({this.sysRoomSpeaking});

  SysRoomSpeaking.fromJson(Map<String, dynamic> json) {
    sysRoomSpeaking = json['sys_room_speaking'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sys_room_speaking'] = this.sysRoomSpeaking;
    return data;
  }
}

class SysRoomNotice {
  String? anchorNotice;
  String? sysRoomNotice;
  String? userNotice;

  SysRoomNotice({this.anchorNotice, this.sysRoomNotice, this.userNotice});

  SysRoomNotice.fromJson(Map<String, dynamic> json) {
    anchorNotice = json['anchor_notice'];
    sysRoomNotice = json['sys_room_notice'];
    userNotice = json['user_notice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['anchor_notice'] = this.anchorNotice;
    data['sys_room_notice'] = this.sysRoomNotice;
    data['user_notice'] = this.userNotice;
    return data;
  }
}


class ConfigInfoState {
  Rx<ConfigInfoData> _configInfo = ConfigInfoData().obs;
  Rx<ConfigInfoData> get configInfo => _configInfo;

  void setUserBalanceData(ConfigInfoData value) {
    _configInfo.value = value;
  }
}
