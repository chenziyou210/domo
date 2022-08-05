/*
 *  Copyright (C), 2015-2021
 *  FileName: agora_rtc
 *  Author: Tonight丶相拥
 *  Date: 2021/7/28
 *  Description: 
 **/

library agora_rtc;

import 'dart:async';

import 'package:alog/alog.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RemoteRtc;
import 'package:agora_rtc_engine/rtc_local_view.dart' as LocalRtc;
import 'package:get/get.dart';
import 'package:star_common/config/config.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:wakelock/wakelock.dart';

import '../pages/surface/surface_logic.dart';

part 'agora_rtc_listen_model.dart';
part 'remote_view.dart';
part 'local_view.dart';

class AgoraRtc {
  static AgoraRtc? _rtc;
  static AgoraRtc get rtc => _rtc ?? _getInstance();

  static AgoraRtc _getInstance() {
    _rtc = AgoraRtc._();
    _rtc!._initializeRtcEngine();
    return _rtc!;
  }

  int? uid;

  AgoraRtc._();

  // 直播引擎
  RtcEngine? _engine;

  // 监听
  _AgoraRtcListenModel? _listener;

  Completer? _lock;

  RtcEngine? getEngine() {
    return _engine;
  }

  // 初始化rtc engine
  Future<void> _initializeRtcEngine() async {
    // 创建engine
    _lock = Completer();
    RtcEngineContext rtcContext = RtcEngineContext(liveAppId);

    _engine = await RtcEngine.createWithContext(rtcContext);

    // await FuRenderManager.manager.setUp(auth, listener: FuRenderParameterStore());
    // _engine = await RtcEngine.createWithConfig(RtcEngineConfig(liveAppId));
    // 设置监听
    _engine!.setEventHandler(RtcEngineEventHandler(warning: (warningCode) {
      _listener?.warning(warningCode);
    }, joinChannelSuccess: (channel, uid, elapsed) {
      _listener?.joinChannelSuccess(channel, uid, elapsed);
    }, userJoined: (uid, elapsed) {
      _listener?.userJoined(uid, elapsed);
    }, userOffline: (uid, reason) {
      _listener?.userOffline(uid, reason);
    }, error: (errorCode) {
      _listener?.error(errorCode);
    }, leaveChannel: (RtcStats stats) {
      _listener?.leaveChannel(stats);
    }, rtcStats: (RtcStats stats) {
      _listener?.rtcStats(stats);
    }));
    // 设置频道场景为直播
    await _engine!.setChannelProfile(ChannelProfile.LiveBroadcasting);
    _lock!.complete();
    _lock = null;
  }

  // 加入频道
  Future<void> addChannel(String channelId, String token, int uid) async {
    if (_lock != null) await _lock!.future;
    this.uid = uid;
    this._updateClientRole(ClientRole.Audience);
    // 开启视频
    await _engine!.enableVideo();
    try {
      // 加入频道,频道名为。
      await _engine!.joinChannel(token, channelId, null, uid);
    } catch (error) {
      Alog.e(error);
    }

    await Wakelock.enable();
  }

  // 开始直播
  Future<void> startLiving(String channelId, String token, int uid) async {
    if (_lock != null) await _lock!.future;
    this.uid = uid;
    this._updateClientRole(ClientRole.Broadcaster);
    await _engine!.enableVideo();
    await _engine!.enableLocalVideo(true);
    await _engine!.enableLocalAudio(true);
    await _engine!.setVideoEncoderConfiguration(VideoEncoderConfiguration(
        dimensions: VideoDimensions(width: 640, height: 360),
        bitrate: 800,
        frameRate: VideoFrameRate.Fps15));
    await _engine!.joinChannel(token, channelId, null, uid);
  }

  int width = 640;
  int height = 360;
  int bitrate = 800;
  VideoFrameRate frameRate = VideoFrameRate.Fps30;

  /// 清晰度设置
  Future<void> setSharpness(
      int width, int height, int bitrate, VideoFrameRate frameRate) async {
    this.width = width;
    this.height = height;
    this.bitrate = bitrate;
    this.frameRate = frameRate;
  }

  /// 切换摄像头
  Future<void> switchCamera() async {
    if (_lock != null) await _lock!.future;
    await _engine!.switchCamera();
  }

  Future<void> muteLocalVideoStream(bool muted) async {
    await _engine!.muteLocalVideoStream(muted);
    await _engine!.enableLocalAudio(!muted);
  }

  // 控制音视频播放
  Future<void> muteVideoStream(bool muted) async {
    if (uid != null) {
      await _engine!.muteRemoteVideoStream(uid!, muted);
      await _engine!.muteRemoteAudioStream(uid!, muted);
    }
  }

  Future<void> setMirror(bool muted) async {
    print("SurfaceState setMirror muted:$muted");
    if (Get.isRegistered<SurfaceLogic>()) {
      Get.find<SurfaceLogic>().state.setMirrorMode(muted);
    }
  }

  /// 开启预览
  Future<void> preview({VoidCallback? cameraCallback}) async {
    if (_lock != null) await _lock!.future;
    await Wakelock.enable();
    await _engine!.enableVideo();
    await _engine!.startPreview();
    await _engine!.enableLocalVideo(true);
    await _engine!.setClientRole(ClientRole.Broadcaster);
    await _engine!
        .setLocalVoiceEqualization(AudioEqualizationBandFrequency.Band4K, 15);

    cameraCallback?.call();
    // if (_lock != null) {
    //   await _lock!.future;
    // }
    // // await Wakelock.enable();
    // await _engine!.enableVideo();
    // await _engine!.enableLocalVideo(true);
    // await _engine!.startPreview();
    // await _engine!.setClientRole(ClientRole.Broadcaster);
    // await _engine!.setLocalVoiceEqualization(AudioEqualizationBandFrequency.Band4K, 15);
    // var handle = await _engine!.getNativeHandle();
    // if (handle != null) {
    //   await AgoraRtcRawdata.registerAudioFrameObserver(handle);
    //   await AgoraRtcRawdata.registerVideoFrameObserver(handle);
    // }
  }

  Future<void> setBeauty(
      {required double lighteningLevel,
      required double smoothnessLevel,
      required double rednessLevel,
      required int index}) async {
    if (_lock != null) await _lock!.future;
    await _engine!.setBeautyEffectOptions(
        true,
        BeautyOptions(
            lighteningContrastLevel: LighteningContrastLevel.values[index],
            lighteningLevel: lighteningLevel,
            smoothnessLevel: smoothnessLevel,
            rednessLevel: rednessLevel));
  }

  // 更新角色
  Future<void> _updateClientRole(ClientRole role) async {
    if (_lock != null) await _lock!.future;
    // LowLatency 低延迟（极速直播）   UltraLowLatency 默认：超低延迟 （互动直播）
    await _engine!.setClientRole(
        role,
        ClientRoleOptions(
            audienceLatencyLevel: AudienceLatencyLevelType.LowLatency));
  }

  // 离开频道
  Future<void> leaveChannel({VoidCallback? leaveCallback}) async {
    if (_lock != null) await _lock!.future;
    await _engine!.leaveChannel();
    await _engine!.enableLocalVideo(false);
    await _engine!.disableVideo();
    await Wakelock.disable();
    _listener?.leaveChannel1();
    leaveCallback?.call();
    // _removeRtcListener();
  }

  // 添加观察者
  void rtcAddListener(_AgoraRtcListenModel listen) {
    _listener = listen;
  }

  // 移除观察者
  void removeRtcListener() {
    _listener = null;
  }
}
