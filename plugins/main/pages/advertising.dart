/*
 *  Copyright (C), 2015-2021
 *  FileName: advertising
 *  Author: Tonight丶相拥
 *  Date: 2021/10/18
 *  Description: 
 **/

import 'dart:async';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/abstract_mixin/trtc_mixin.dart';
import 'package:star_common/common/abstract_mixin/chat_salon.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/storage.dart';
import 'package:star_common/manager/user/user_info.dart';
import 'package:star_common/router/router_config.dart';
import 'advertising_model.dart';

class AdvertisingPage extends StatefulWidget {
  @override
  createState() => _AdvertisingPageState();
}

class _AdvertisingPageState extends AppStateBase<AdvertisingPage>
    with ChatSalon, TRTCOperation {
  @override
  // TODO: implement model
  AdvertisingModel get model => super.model as AdvertisingModel;
  var logic = Get.put(AdvertisingViewModel());
  Completer<String> _completer = Completer();
  // bool _completerHasValue = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String token = StorageService.to.getString("token");
    if (token.isEmpty) {
      _completer.complete(AppRoutes.logInNew);
    } else {
      Get.find<UserInfoLogic>().requestUserInfo(
        failure: (e) {
          _completer.complete(AppRoutes.logInNew);
        },
        success: () {
          _completer.complete(AppRoutes.tab);
        },
      );
    }
    // _completer.future.then((value) => _completerHasValue = true);
    _completer.future.timeout(Duration(seconds: model.viewModel.count.value),
        onTimeout: () {
      return _completer.future;
    });
  }

  @override
  // TODO: implement appBar
  PreferredSizeWidget? get appBar => DefaultAppBar(
        leading: SizedBox(),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actions: [
          Obx(() => Text.rich(TextSpan(
                      text: "${model.viewModel.count.value}",
                      style: AppStyles.f14w400c0_0_0,
                      children: [
                        if (model.viewModel.count.value < 6)
                          TextSpan(
                            text: " | ${intl.skip}",
                            style: AppStyles.f14w400c0_0_0,
                          )
                      ])).container(
                      height: 30,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          border: Border.all(color: Colors.black12))))
              .gestureDetector(onTap: () {
                if (model.viewModel.count.value < 6) {
                  model.timerCancel();
                  _onTimerUp();
                }
              })
              .center
              .padding(padding: EdgeInsets.only(right: 8))
        ],
      );

  // @override
  // // TODO: implement bodyColor
  // Color? get bodyColor => Colors.white;

  @override
  // TODO: implement extendBodyBehindAppBar
  bool get extendBodyBehindAppBar => true;

  @override
  AppModel? initializeModel() {
    // TODO: implement initializeModel
    return AdvertisingModel(_onTimerUp)..loadData();
  }

  void _onTimerUp() async {
    var value = await _completer.future;
    // if (value == AppRoutes.tab) {
    //   model.userInfoReport();
    // }
    Get.toNamed(value);
  }

  @override
  // TODO: implement body
  Widget get body {
    return GetBuilder(
        init: logic,
        global: false,
        builder: (c) {
          String banner = logic.splashImage;
          // print('banner === 111' + banner);
          return Stack(alignment: Alignment.center, children: [
            ExtendedImage.network(
              banner,
              fit: BoxFit.cover,
              width: ScreenUtil().screenWidth,
              height: ScreenUtil().screenHeight,
              cache: true,
            ),
            Row(mainAxisSize: MainAxisSize.min, children: [
              Image.asset(
                R.ggFoot,
                fit: BoxFit.cover,
                width: ScreenUtil().screenWidth,
              ),
            ]).position(bottom: 0, left: 0, right: 0),
          ]);
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    model.dispose();
    super.dispose();
  }
}
