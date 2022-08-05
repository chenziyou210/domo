import 'package:flutter/cupertino.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/config/app_layout.dart';

class MineGameRecordContentItem extends StatelessWidget {
  const MineGameRecordContentItem(
      {required this.title,
      required this.value,
      required this.valueColor,
      Key? key})
      : super(key: key);

  final String title;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      AppLayout.text70White12(title),
      SizedBox(height: 4.dp),
      Text(value, style: TextStyle(color: valueColor, fontSize: 12.sp, fontFamily: 'Number')),
    ]);
  }
}
