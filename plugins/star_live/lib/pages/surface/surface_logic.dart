import 'package:mmoo_forbidshot/mmoo_forbidshot.dart';
import 'package:get/get.dart';

import 'surface_state.dart';

class SurfaceLogic extends GetxController {
  final SurfaceState state = SurfaceState();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }


  initCapture() async {
    bool? isCapture = await FlutterForbidshot.iosIsCaptured;
    state.iosIsCaptured.value = isCapture ?? false;
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initCapture();
  }
}
