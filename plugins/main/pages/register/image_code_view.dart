/*
 *  Copyright (C), 2015-2021
 *  FileName: image_code_view
 *  Author: Tonight丶相拥
 *  Date: 2021/12/7
 *  Description: 
 **/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/http/config.dart';

class VerificationCodeAlter extends Dialog {
  VerificationCodeAlter(
      {required this.imageVerification,
      required this.confirm,
      required this.refresh,
      required this.hintText,
      this.onConfirm,
      this.onUuidChange});

  final String imageVerification;
  final String refresh;
  final String confirm;
  final String hintText;
  final void Function(String)? onConfirm;
  final void Function(String)? onUuidChange;

  /// 输入管理
  final TextEditingController _verificationCode = TextEditingController();
  final TextStyle _style = TextStyle(
      fontSize: 17.dp,
      fontWeight: w_500,
      color: Color.fromARGB(255, 34, 34, 44));

  @override
  // TODO: implement child
  Widget? get child => Container(
      width: 343.dp,
      height: 243.dp,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(R.securityVerification),
          SizedBox(width: 4),
          CustomText("$imageVerification",
              fontSize: 16.dp, fontWeight: w_600, color: Colors.black)
        ]),
        SizedBox(height: 16),
        Row(children: [
          CustomTextField(
            controller: _verificationCode,
            hintText: hintText,
            hintTextStyle: _style,
            style: _style,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black12)),
          ).sizedBox(width: 144.dp, height: 65.dp),
          Spacer(),
          WebVerifyCodeImage(
            refresh: refresh,
            url: "$baseUrl:$port/api/app/enter/captcha.jpg",
            onUuidChange: (uid) {
              this.onUuidChange?.call(uid);
            },
          )
        ]),
        Spacer(),
        CupertinoButton(
            minSize: 46.dp,
            padding: EdgeInsets.zero,
            child: Container(
                width: 311.dp,
                height: 46.dp,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 84, 120, 248),
                    borderRadius: BorderRadius.circular(23.dp)),
                alignment: Alignment.center,
                child: CustomText("$confirm",
                    fontWeight: w_500, fontSize: 16.dp, color: Colors.white)),
            onPressed: () {
              String text = _verificationCode.text;
              if (text.isEmpty) {
                return;
              }
              this.onConfirm?.call(text);
            })
      ]).padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16)));
}
