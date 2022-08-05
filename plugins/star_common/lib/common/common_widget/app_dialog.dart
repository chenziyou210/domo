import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';

const EdgeInsets _defaultInsetPadding =
    EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0);

class AppDialog extends Dialog {
  String? title;
  Widget content;
  String? cancelText;
  String? confirmText;
  EdgeInsets? insetPadding;
  void Function()? cancel;
  void Function()? confirm;

  AppDialog(this.content,
      {String? title,
      void Function()? cancel,
      void Function()? confirm,
      this.insetPadding,
      this.cancelText,
      this.confirmText})
      : super(insetPadding: insetPadding) {
    this.title = title ?? "温馨提示";
    this.cancel = cancel ?? () {};
    this.confirm = confirm ?? () {};
    insetPadding = _defaultInsetPadding;
  }

  @override
  Color? get backgroundColor => AppMainColors.commonPopupBg;

  @override
  Widget? get child => Container(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      decoration: BoxDecoration(
          color: AppMainColors.commonPopupBg,
          borderRadius: BorderRadius.circular(8.dp)),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title ?? "温馨提示",
              style: TextStyle(
                  fontSize: 16.dp, fontWeight: w_500, color: Colors.white),
            ),
            SizedBox(
              height: 16.dp,
            ),
            content,
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
                        child: CustomText(cancelText ?? "退出",
                            fontWeight: w_400,
                            fontSize: 16.dp,
                            color: Colors.white))
                    .gestureDetector(onTap: () {
                  Get.back();
                  cancel?.call();
                }).expanded(),
                SizedBox(width: 24.dp),
                Container(
                        padding: EdgeInsets.symmetric(vertical: 9.dp),
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: AppMainColors.commonBtnGradient),
                            borderRadius: BorderRadius.circular(20.dp)),
                        alignment: Alignment.center,
                        child: CustomText(confirmText ?? "确定",
                            fontWeight: w_400,
                            fontSize: 16.dp,
                            color: Colors.white))
                    .gestureDetector(onTap: () {
                  confirm?.call();
                }).expanded(),
              ],
            )
          ]));
}
