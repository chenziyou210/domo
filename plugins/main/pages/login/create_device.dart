/*
 *  Copyright (C), 2015-2022
 *  FileName: create_device
 *  Author: Tonight丶相拥
 *  Date: 2022/3/8
 *  Description: 
 **/

import 'dart:io';
import 'package:flutter/foundation.dart';
// import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:star_common/common/toast.dart';
import 'package:package_info_plus/package_info_plus.dart';
// import 'package:package_info_plus_platform_interface/package_info_platform_interface.dart';
import 'package:unique_ids/unique_ids.dart';
import 'package:device_info_plus/device_info_plus.dart';
// import 'package:local_ip/local_ip.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
// import 'package:sim_info/sim_info.dart';

class CreateDevice with Toast {
  void createDevice() async {
    var packageInfo = await PackageInfo.fromPlatform();
    Map<String, String?> dev = new Map<String, String?>();
    dev["packageName"] = packageInfo.packageName;
    dev["buildNumber"] = packageInfo.buildNumber;
    dev["jailbreakDetection"] =
        (await FlutterJailbreakDetection.jailbroken) ? "1" : "0";
    // dev["localIp"] = await LocalIp.ip;
    // dev["mcc"] = await SimInfo.getMobileCountryCode;
    // dev["carrierName"] = await SimInfo.getCarrierName;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (kIsWeb) {
      dev["plat"] = "web";
      // dev["plat"] = "and";
      // dev["androidId"] = "888";
    } else if (Platform.isIOS) {
      // var result = await PackageInfoPlatform.instance.getPlistInfo();
      // var uid = result["CustomDeviceUUID"];
      // if (uid != null)
      //   showToast("the customUUID is $uid");
      // else
      //   showToast("the customUUID is Null");
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      dev["model"] = iosDeviceInfo.model;
      dev["product"] = iosDeviceInfo.name;
      dev["isPhysicalDevice"] = iosDeviceInfo.isPhysicalDevice.toString();
      // var value = await FlutterKeychain.get(key: "gopayIdentifierForVendor");
      // if (value != null) {
      //   dev["iosId"] = value;
      // } else {
      //   dev["iosId"] = iosDeviceInfo.identifierForVendor;
      //   await FlutterKeychain.put(key: "gopayIdentifierForVendor", value: dev["iosId"]!);
      // }
      dev["kid"] = (await UniqueIds.uuid) ?? "unknown"; //await getIosId();
      dev["sdk"] = iosDeviceInfo.systemName! + iosDeviceInfo.systemVersion!;
      dev["plat"] = "ios";
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      dev["model"] = androidDeviceInfo.model;
      dev["display"] = androidDeviceInfo.display;
      dev["tags"] = androidDeviceInfo.tags;
      dev["product"] = androidDeviceInfo.product;
      dev["isPhysicalDevice"] = androidDeviceInfo.isPhysicalDevice.toString();
      dev["androidId"] = androidDeviceInfo.androidId;
      dev["sdk"] = androidDeviceInfo.version.release;
      dev["plat"] = "android";
    }
    print("the dev is $dev --- ");
  }
}
