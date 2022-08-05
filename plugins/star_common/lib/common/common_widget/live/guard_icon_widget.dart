import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';

import '../../../app_images/r.dart';

/**
 * 周守护等类型
 */
class GuardIconWidget extends StatelessWidget {
  const GuardIconWidget(
    this.watchType, this.marginLeft,{
    Key? key,
  }) : super(key: key);

  final int? watchType;
  final int marginLeft;

  @override
  Widget build(BuildContext context) {
    if (watchType == null || watchType==0) {
      return Container();
    } else {
      return Image.asset(
        getGuardPath(),
        width: 16.dp,
        height: 16.dp,
      ).marginOnly(left: marginLeft.dp);
    }
  }

  String getGuardPath() {
    switch (watchType) {
      case 2001:
        return R.icWeeklyGuard;
      case 2002:
        return R.icMonthlyGuard;
      case 2003:
        return R.icYearlyGuard;
    }
    return R.icWeeklyGuard;
  }
}
