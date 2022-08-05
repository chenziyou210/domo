import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:star_common/manager/user/user_info.dart';

enum InfoTypes {
  avatar,
  nickname,
  account,
  sex,
  birthday,
  feeling,
  hometown,
  profession,
  signature,
}

class MineEditInfoState {
  final List selectImageTypes = ['拍照', '从相册选择', '取消'];
  final signMaxCount = 32;
  late BuildContext context;
  late TextEditingController signatureTEC;

  MineEditInfoState() {
    signatureTEC = TextEditingController();
  }
}
