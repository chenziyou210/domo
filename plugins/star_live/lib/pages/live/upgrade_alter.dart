/*
 *  Copyright (C), 2015-2021
 *  FileName: upgrade_alter
 *  Author: Tonight丶相拥
 *  Date: 2021/12/22
 *  Description: 
 **/

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/config/config.dart';
import 'package:star_common/http/cache.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:install_plugin_v2/install_plugin_v2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:star_common/i18n/i18n.dart';
import 'package:star_common/generated/upgrade_entity.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class UpgradeAlter extends AlertDialog with Toast {
  UpgradeAlter(this._entity, {this.onNotNow});
  final UpgradeEntity _entity;
  final VoidCallback? onNotNow;
  
  @override
  // TODO: implement contentPadding
  EdgeInsetsGeometry get contentPadding => EdgeInsets.zero;

  AppInternational get _intl => AppInternational.current;

  final _UpgradeLogic _controller = _UpgradeLogic();

  @override
  // TODO: implement backgroundColor
  Color? get backgroundColor => Colors.transparent;

  @override
  // TODO: implement elevation
  double? get elevation => 0;
  
  @override
  // TODO: implement content
  Widget? get content => Stack(
    alignment: Alignment.center,
    children: [
      Image.asset(R.updateAlterBackground),
      Positioned(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          [RichText(text: TextSpan(
            children: [
              TextSpan(
                text: "${_intl.newVersionPreemptiveExperience}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: w_bold,
                  color: Colors.black
                )
              ),
              WidgetSpan(
                child: Image.asset(R.appNew)
                  .padding(padding: EdgeInsets.only(left: 4)),
                alignment: PlaceholderAlignment.middle
              )
            ]
          ), textAlign: TextAlign.center)].row(
            mainAxisAlignment: MainAxisAlignment.center
          ),
          SizedBox(height: 16),
          [Text("${_entity.releaseNotes ?? ""}"),
          SizedBox(height: 8),
          CustomText("${_intl.versionNumber} : V${_entity.versionName}",
            fontSize: 12,
            fontWeight: w_400,
            color: Color.fromARGB(255, 208, 142, 101)
          )].column(
            crossAxisAlignment: CrossAxisAlignment.start
          ).singleScrollView().expanded(),
          SizedBox(height: 8),
          Align(
            child: Obx((){
              var count = _controller._count.value;
              if (_controller._amount == 0 && count == 0) {
                return SizedBox();
              }
              var cache = AppCacheManager.cache;
              var size = cache.renderSize(count * 1.0);
              var amount = cache.renderSize(_controller._amount * 1.0);
              return Text.rich(TextSpan(
                  text: "${size.cacheSize}${size.unit}",
                  style: TextStyle(
                      fontSize: 14, fontWeight: w_400,
                      color: Color.fromARGB(255, 231, 184, 103)
                  ),
                  children: [
                    TextSpan(
                        text: " / ${amount.cacheSize}${amount.unit}",
                        style: TextStyle(
                            color: Colors.black
                        )
                    )
                  ]
              ));
            }),
            alignment: Alignment.centerRight,
          ),
          SizedBox(height: 4),
          Obx((){
            var count = _controller._count.value;
            if (_controller._amount == 0 && count == 0) {
              return SizedBox();
            }
            return CustomPaint(
                size: Size.fromHeight(6),
                painter: LineProgressPainter(colors: [
                  Color.fromARGB(255, 231, 184, 103),
                  Color.fromARGB(255, 231, 184, 103)
                ],
                    color: Color.fromARGB(255, 67, 79, 91),//rgba(67, 79, 91, 1)
                    percent: _controller._count.value / _controller._amount,
                    radius: BorderRadius.circular(3)
                )
            );
          }),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 94,
                height: 35,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 246, 108, 53),
                  borderRadius: BorderRadius.circular(17.5)
                ),
                child: CustomText("${_intl.update}",
                  fontSize: 12,
                  fontWeight: w_400,
                  color: Colors.white
                )
              ).cupertinoButton(onTap: () async{
                if (_controller._cancelToken != null) {
                  showToast("${_intl.downloading}");
                  return;
                }else if (Platform.isIOS){
                  launch("itms-apps://itunes.apple.com/app/88888888?mt=8");
                  return;
                }
                var requestResult = await Permission.storage.request();
                if (!requestResult.isGranted)
                  return;
                // requestResult = await Permission.requestInstallPackages.request();
                // if (!requestResult.isGranted)
                //   return;
                Directory dir;
                if (Platform.isIOS) {
                  dir = await getApplicationSupportDirectory();
                }else {
                  dir = (await getExternalStorageDirectory())!;
                }
                var path = dir.path + "/$appName" + "/${_entity.versionName}.apk";
                // var result = await OpenFile.open(path);
                // print("the open file result is: ${result.type}");
                // return;
                File file = File(path);
                if (file.existsSync()) {
                  await InstallPlugin.installApk(path, appName);
                  return;
                }
                var result = await HttpChannel.channel.downloadApk(_entity.url!, savePath: path,
                  process: (count, amount){
                  _controller._count.value = count;
                  _controller._amount = amount;
                }, cancelToken: (token) {
                  _controller._cancelToken = token;
                });
                if (result.isSuccess){
                  showToast("${_intl.downloadSuccess}");
                  _controller._cancelToken = null;
                  await InstallPlugin.installApk(path, appName);
                }else {
                  showToast("${_intl.downloadFailure}");
                  _controller._cancelToken = null;
                }
              }),
              if (_entity.forceUpgrade != 1)
                SizedBox(width: 38),
              if (_entity.forceUpgrade != 1)
                Container(
                    width: 94,
                    height: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17.5),
                      border: Border.all(color: Color.fromARGB(255, 246, 108, 53))
                    ),
                    child: CustomText("${_intl.notNow}",
                        fontSize: 12,
                        fontWeight: w_400,
                        color: Color.fromARGB(255, 246, 108, 53)
                    )
                ).cupertinoButton(onTap: (){
                  if (_controller._cancelToken != null) {
                    showToast("${_intl.downloading}");
                    return;
                  }
                  onNotNow?.call();
                })
            ]
          ),
          SizedBox(height: 24)
        ]
      ), height: 262, left: 16, right: 16, bottom: 0)
    ]
  ).sizedBox(width: 280, height: 434);
}

class _UpgradeLogic extends GetxController {
  RxInt _count = 0.obs;
  int _amount = 0;
  int? _cancelToken;
}