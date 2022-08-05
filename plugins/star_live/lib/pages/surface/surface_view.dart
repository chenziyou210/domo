import 'package:flutter/material.dart';
import 'package:mmoo_forbidshot/mmoo_forbidshot.dart';
import 'package:get/get.dart';

import 'surface_logic.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart';

class SurfacePage extends StatelessWidget {
  final logic = Get.put(SurfaceLogic());
  final state = Get.find<SurfaceLogic>().state;

  SurfacePage(){
    // FlutterForbidshot.setAndroidForbidOn();
  }

  @override
  Widget build(BuildContext context) {
    // logic.initCapture();
    // return Obx(() {
    //   if(!state.iosIsCaptured.value){
    //     VideoMirrorMode mirrorMode = state.mirror.value;
    //     return SurfaceView(mirrorMode: mirrorMode);
    //   }
    //   return Container(decoration: BoxDecoration(color: Colors.black),);
    // });

    VideoMirrorMode mirrorMode = state.mirror.value;
    return SurfaceView(mirrorMode: mirrorMode);
  }
}
