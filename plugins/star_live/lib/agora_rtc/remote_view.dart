/*
 *  Copyright (C), 2015-2021
 *  FileName: remote_view
 *  Author: Tonight丶相拥
 *  Date: 2021/7/28
 *  Description: 
 **/

part of agora_rtc;

class RemoteView extends StatelessWidget {
  final logic = Get.put(SurfaceLogic());
  final state = Get.find<SurfaceLogic>().state;

  RemoteView({required this.uid, required this.channel}) {
    // FlutterForbidshot.setAndroidForbidOn();
  }

  final int uid;
  final String channel;

  @override
  Widget build(BuildContext context) {
    // logic.initCapture();
    // return Obx(() {
    //   if (!state.iosIsCaptured.value) {
    //     VideoMirrorMode mirrorMode = state.mirror.value;
    //     return RemoteRtc.SurfaceView(
    //       uid: uid,
    //       channelId: channel,
    //       mirrorMode: mirrorMode,
    //     );
    //   }
    //   return Container(
    //     decoration: BoxDecoration(color: Colors.black),
    //   );
    // });
    VideoMirrorMode mirrorMode = state.mirror.value;
    return RemoteRtc.SurfaceView(
      uid: uid,
      channelId: channel,
      mirrorMode: mirrorMode,
    );
  }
}
