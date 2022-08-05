import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';

class PayLiveDialog extends Dialog {
  late BuildContext context;

  PayLiveDialog(BuildContext context) {
    this.context = context;
  }

  @override
  Color? get backgroundColor => AppMainColors.commonPopupBg;

  @override
  Widget? get child =>
      Container(
          height: 198.dp,
          padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
          decoration: BoxDecoration(
              color: AppMainColors.commonPopupBg,
              borderRadius: BorderRadius.circular(8.dp)),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: [
            CustomText(
              "付费直播",
              style: TextStyle(
                  fontSize: 16.dp, fontWeight: w_500, color: Colors.white),
            ),
            SizedBox(
              height: 16.dp,
            ),
            CustomText(
              "主播开启了付费直播，9钻/分钟，是否付费进入直播间 ？",
              style: TextStyle(
                  fontSize: 14.dp, fontWeight: w_400, color: Colors.white70),
            ),
            SizedBox(
              height: 36.dp,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(vertical: 9.dp),
                    decoration: BoxDecoration(
                        color: AppMainColors.whiteColor20,
                        borderRadius: BorderRadius.circular(20.dp)),
                    alignment: Alignment.center,
                    child: CustomText("退出",
                        fontWeight: w_400,
                        fontSize: 16.dp,
                        color: Colors.white))
                    .gestureDetector(onTap: () {
                  Get.back();
                }).expanded(),
                SizedBox(width: 24.dp),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 9.dp),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: AppMainColors.commonBtnGradient),
                        borderRadius: BorderRadius.circular(20.dp)),
                    alignment: Alignment.center,
                    child: CustomText("确定",
                        fontWeight: w_400,
                        fontSize: 16.dp,
                        color: Colors.white))
                    .gestureDetector(onTap: () {
                  //todo 确定
                }).expanded(),
              ],
            )
          ]));
}
