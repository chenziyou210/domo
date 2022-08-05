import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';

import '../../../app_images/r.dart';

/**
 * 贵族图标
 */
class PeerageWidget extends StatelessWidget {
  PeerageWidget( this.type,this.marginLeft, {Key? key, }) : super(key: key);
  final int? type;
  final int marginLeft;

  @override
  Widget build(BuildContext context) {
    if (type != null && type! > 1000 && type! < 1008) {
      return Image.asset(
        getTitleNoble(type),
        width: 28.dp,
        height: 14.dp,
      ).marginOnly(left: marginLeft.dp);
    } else {
      return Container();
    }
  }

  String getTitleNoble(int? type) {
    switch (type) {
      case 1001:
        return R.bqGzYouxia;
      case 1002:
        return R.bqGzQishi;
      case 1003:
        return R.bqGzZijue;
      case 1004:
        return R.bqGzBojue;
      case 1005:
        return R.bqGzHoujue;
      case 1006:
        return R.bqGzGongjue;
      case 1007:
        return R.bqGzGuowang;
      default:
        return R.bqGzYouxia;
    }
  }
}
