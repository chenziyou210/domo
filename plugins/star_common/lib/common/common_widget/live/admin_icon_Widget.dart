import 'package:alog/alog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';

import '../../../app_images/r.dart';

/**
 * 管理图标
 */
class AdminIconWidget extends StatelessWidget {
  const AdminIconWidget(
    this.adminFlag, {
    Key? key,
  }) : super(key: key);

  final int? adminFlag;

  @override
  Widget build(BuildContext context) {
    if (adminFlag == 1) {
      return Image.asset(
        R.icAdministrator,
        width: 20.dp,
        height: 20.dp,
      ).marginOnly(left: 4.dp);
    } else {
      return Container();
    }
  }
}
