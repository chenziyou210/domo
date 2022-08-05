import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_live/pages/live_room/mine_backpack/mine_backpack_logic.dart';
import 'package:extended_image/extended_image.dart';

class AppUpGradeDialog extends Dialog {
  final String? carUrl;
  final int? level;
  final String? carName;
  final int? carId;
  final String? CarSvgaUrl;

  AppUpGradeDialog(
      this.carUrl, this.level, this.carName, this.carId, this.CarSvgaUrl)
      : super() {}

  // @override
  Color? get backgroundColor => Colors.transparent;

  final logic = Get.find<MineBackpackLogic>();

  @override
  Widget? get child => Stack(
      alignment : AlignmentDirectional.topCenter,
        children: [
         Container(
             padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
             decoration: BoxDecoration(
                 color: AppMainColors.commonPopupBg,
                 borderRadius: BorderRadius.circular(8.dp)),
             child:  Column(
                 mainAxisSize: MainAxisSize.min,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   SizedBox(height: 80,),
                  CustomText(
                   "升级提示",
                   style: TextStyle(
                       fontSize: 16.dp,
                       fontWeight: w_500,
                       color: Colors.white),
                  ),
                  SizedBox(
                   height: 16.dp,
                  ),
                  CustomText(
                   "恭喜您成长等级达到Lv$level，获得$carName座驾，是否立即使用座驾？下次进直播间即可展示。",
                   style: TextStyle(
                       fontSize: 14.dp,
                       fontWeight: w_500,
                       color: AppMainColors.whiteColor70),
                  ),
                  SizedBox(
                   height: 24.dp,
                  ),
                  Row(
                   mainAxisSize: MainAxisSize.max,
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                    Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 9.dp),
                        decoration: BoxDecoration(
                            color: AppMainColors.whiteColor20,
                            borderRadius:
                            BorderRadius.circular(20.dp)),
                        alignment: Alignment.center,
                        child: CustomText("关闭",
                            fontWeight: w_400,
                            fontSize: 16.dp,
                            color: Colors.white))
                        .gestureDetector(onTap: () {
                      SmartDialog.dismiss();
                    }).expanded(),
                    SizedBox(width: 24.dp),
                    Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 9.dp),
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: AppMainColors
                                    .commonBtnGradient),
                            borderRadius:
                            BorderRadius.circular(20.dp)),
                        alignment: Alignment.center,
                        child: CustomText("使用",
                            fontWeight: w_400,
                            fontSize: 16.dp,
                            color: Colors.white))
                        .gestureDetector(onTap: () {
                         logic.useCar(carId ?? 0, CarSvgaUrl ?? "");
                          SmartDialog.dismiss();
                    }).expanded(),
                   ],
                  )
                 ])).marginOnly(top: 90),

          ExtendedImage.network(
              carUrl!,
              width: 180.dp,
              enableLoadState: false,
              height: 180.dp,
              fit: BoxFit.fill),
        ],
      );
}
