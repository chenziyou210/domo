/*
 *  Copyright (C), 2015-2021
 *  FileName: agora_rtc_listen_model
 *  Author: Tonight丶相拥
 *  Date: 2021/7/28
 *  Description: 
 **/

part of agora_rtc;

mixin _AgoraRtcListenModel {
  void warning(WarningCode warn);
  void joinChannelSuccess(String channel, int uid, int elapsed);
  void userJoined(int uid, int elapsed);
  void userOffline(int uid, UserOfflineReason reason);
  void error(ErrorCode err);
  void leaveChannel(RtcStats stats);
  void rtcStats(RtcStats stats);
  /// 设置远程id
  void leaveChannel1();
}

class AgoraRtcLogic extends GetxController with _AgoraRtcListenModel {

  final AgoraRtcState state = AgoraRtcState();

  @override
  void error(ErrorCode err) {

  }

  @override
  void joinChannelSuccess(String channel, int uid, int elapsed) {

  }

  @override
  void leaveChannel(RtcStats stats) {
    state._setRemoteUid(null);
    // state._setAudience(stats.userCount);
  }

  @override
  void rtcStats(RtcStats stats) {
    // state._setAudience(stats.userCount);
  }

  @override
  void userJoined(int uid, int elapsed) {
    state._setRemoteUid(uid);
    EventBus.instance.notificationListener(name: enterRoomSuccess);
  }

  @override
  void userOffline(int uid, UserOfflineReason reason) {
    state._setRemoteUid(null);
    EventBus.instance.notificationListener(name: liverOffline);
  }

  @override
  void warning(WarningCode warn) {

  }

  @override
  void leaveChannel1() {
    state._setRemoteUid(null);
  }
}

class AgoraRtcState {
  // 远程id
  int? _remoteUid;
  int? get remoteUid => _remoteUid;

  /// 是否有远程用户
  RxBool _hasRemoteUid = false.obs;
  RxBool get hasRemoteUid => _hasRemoteUid;

  /// 设置远程id
  void _setRemoteUid(int? uid){
    _remoteUid = uid;
    _hasRemoteUid.value = _remoteUid != null;
  }
}