/*
 *  Copyright (C), 2015-2021
 *  FileName: account_security
 *  Author: Tonight丶相拥
 *  Date: 2021/11/12
 *  Description: 
 **/

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';

import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:star_common/router/router_config.dart';

class AccountSecurityPage extends StatefulWidget {
  @override
  createState() => _AccountSecurityPageState();
}

class _AccountSecurityPageState extends AppStateBase<AccountSecurityPage> {
  final _device = DeviceInfoPlugin();
  Completer<String> _completer = Completer();
  final TextStyle _style =
      TextStyle(fontWeight: w_400, fontSize: 12, color: Colors.black);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isIOS) {
      _device.iosInfo.then((value) {
        _completer.complete(
            "${value.model} ${value.systemName}${value.systemVersion}");
      });
    } else {
      _device.androidInfo.then((value) {
        _completer
            .complete("${value.board} ${value.brand} ${value.version.sdkInt}");
      });
    }
  }

  @override
  // TODO: implement appBar
  PreferredSizeWidget? get appBar => DefaultAppBar(
      title: CustomText("${intl.accountSecurity}",
          fontWeight: w_400, fontSize: 17, color: Colors.black));

  @override
  // TODO: implement body
  Widget get body => FutureBuilder<String>(
      builder: (_, snapShot) {
        if (snapShot.connectionState != ConnectionState.done) {
          return SizedBox();
        }
        return Column(children: [
          SizedBox(height: 8),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              color: Colors.white,
              child: Column(children: [
                InkWellRow(
                    children: [
                      CustomText("${intl.modifyLoginPassword}", style: _style),
                      Spacer(),
                      Image.asset(R.forward)
                    ],
                    onTap: () {
                      Get.toNamed(AppRoutes.changeLogInPassword);
                      // pushViewControllerWithName(AppRoutes.changeLogInPassword);
                    }).sizedBox(height: 50),
                CustomDivider(),
                InkWellRow(children: [
                  CustomText("${intl.changePaymentPassword}", style: _style),
                  Spacer(),
                  Image.asset(R.forward)
                ], onTap: () {})
                    .sizedBox(height: 50),
                CustomDivider(),
                Row(children: [
                  CustomText("${intl.logInToTheDevice}", style: _style),
                  Spacer(),
                  CustomText("${snapShot.data}",
                      fontWeight: w_400,
                      fontSize: 11,
                      color: Color.fromARGB(255, 153, 153, 153))
                ]).sizedBox(height: 50)
              ]))
        ]);
      },
      future: _completer.future);
}
