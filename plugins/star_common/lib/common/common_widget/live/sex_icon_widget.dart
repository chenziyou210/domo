import 'package:flutter/material.dart';
import 'package:star_common/common/app_common_widget.dart';

import '../../../app_images/r.dart';

/**
 * 管理图标
 */
class SexIconWidget extends StatelessWidget {
  const SexIconWidget(
    this.sex, {
    Key? key,
  }) : super(key: key);

  final int? sex;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      sex == 0 ? R.comSexBoy : R.comSexGirl,
      width: 14.dp,
      height: 14.dp,
    );
  }
}
