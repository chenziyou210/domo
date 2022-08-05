/*
 *  Copyright (C), 2015-2021
 *  FileName: log_out
 *  Author: Tonight丶相拥
 *  Date: 2021/12/20
 *  Description: 
 **/

import 'package:flutter/material.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';
import 'package:star_common/i18n/i18n.dart';

import '../../app_images/r.dart';

class LogOutWidget extends AlertDialog {
  LogOutWidget({required this.onCancel, required this.onLogOut});
  final VoidCallback onCancel;
  final VoidCallback onLogOut;

  @override
  // TODO: implement contentPadding
  EdgeInsetsGeometry get contentPadding => EdgeInsetsDirectional.zero;

  @override
  // TODO: implement backgroundColor
  Color? get backgroundColor => Colors.transparent;

  @override
  // TODO: implement content
  Widget? get content => Container(
    height: 308 + 35.7,
    child: Stack(
      alignment: Alignment.center,
      children: [
        // Container(),
        Positioned(child: Container(
            // width: 308,
            // height: 162,
          padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                color: Colors.white
            ),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 56),
                  contentDescription.sizedBox(width: 200),
                  SizedBox(height: 24),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                            width: 116,
                            height: 44,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(
                                    color: Color.fromARGB(255, 186, 186, 186)
                                )
                            ),
                            alignment: Alignment.center,
                            child: leftButton
                        ).cupertinoButton(
                            onTap: onCancel
                        ),
                        SizedBox(width: 16),
                        // Spacer(),
                        Container(
                            width: 116,
                            height: 44,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                gradient: LinearGradient(
                                    colors: AppColors.buttonGradientColors
                                )
                            ),
                            alignment: Alignment.center,
                            child: rightButton
                        ).cupertinoButton(
                            onTap: onLogOut
                        ),
                      ]
                  ),
                  SizedBox(height: 20)
                ]
            )
        ).clipRRect(radius: BorderRadius.circular(10)), top: 35.7),
        Positioned(child: logo, top: 0)
      ]
    )
  );

  Widget get logo => Image.asset(R.logOutLogo);

  Widget get rightButton => CustomText("${AppInternational.current.logOut}",
    fontSize: 16.sp, fontWeight: w_500,
    color: Color.fromARGB(255, 34, 40, 49),
  );

  Widget get leftButton => CustomText("${AppInternational.current.cancel}",
    fontSize: 16.sp, fontWeight: w_500,
    color: Color.fromARGB(255, 34, 40, 49),
  );

  Widget get contentDescription => CustomText("${AppInternational.current.isLogOut}",
    fontSize: 16.sp,
    fontWeight: w_400,
    color: Colors.black,
    textAlign: TextAlign.center
  );

  @override
  // TODO: implement elevation
  double? get elevation => 0;
}