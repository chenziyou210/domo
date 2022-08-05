import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:get/get.dart';
import 'package:star_common/common/toast.dart';
class SurfaceState  with Toast{
  RxBool iosIsCaptured = false.obs;

  Rx<VideoMirrorMode> mirror = VideoMirrorMode.Auto.obs;

  setMirrorMode(bool status){
    print("SurfaceState setMirrorMode status:$status");
    if(status){
      mirror.value=VideoMirrorMode.Enabled;
    }else{
      mirror.value=VideoMirrorMode.Disabled;
    }
  }
}
