import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:star_common/manager/app_manager.dart';
import '../../choose_area_code/area_code_model.dart';

class MinePhoneApproveState {
  late TextEditingController phoneTEC;
  late TextEditingController codeTEC;
  late BuildContext context;

  final codeText = '点击发送'.obs;
  final codeStatus = true.obs;
  final approveStatus = false.obs;
  final phone = ''.obs;
  Rx<AreaCodeModel> area = AreaCodeModel(name: "中国", tel: "86").obs;

  MinePhoneApproveState() {
    final AppUser user = AppManager.getInstance<AppUser>();
    phoneTEC = TextEditingController();
    codeTEC = TextEditingController();
    phone.value = user.phone ?? '';
  }
}
