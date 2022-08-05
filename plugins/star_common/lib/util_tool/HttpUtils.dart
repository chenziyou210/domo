import 'dart:convert';
import 'dart:io';
import 'package:star_common/common/crypto/crypto.dart';
import 'package:uuid/uuid.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';

class HttpUtils {
  static String KEY = "*6n^GHkjGFVUYsdfcv";
  static String HOST = "";

  static void post(String path, Function callback,
      {required Map<String, dynamic> param,
      required Function errorCallback,
      bool showError = true,
      hiddenLoading = false,}) async {

    try {
      String token = '';
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String udid = Uuid().v1().toString();
      int ts = DateTime.now().toUtc().millisecondsSinceEpoch;
      String uuid = UUID.random((ts / 1000).floor());

      String sTime = ts.toString();
      int time = int.parse(sTime.substring(sTime.length - 3, sTime.length));
      int hash = UUID.hash(uuid);
      int mode1 = (time + hash) % 5;

      String sha = Sha256(mode1)
          .convert(utf8.encode(token + KEY + sTime + uuid + udid))
          .toString();
      int mode2 = (time * hash) % 5;
      sha = Sha256(mode2)
          .convert(utf8.encode(sha + KEY + packageInfo.version + ts.toString()))
          .toString();

      String key1 = sha.substring(mode1, mode1 + 8) + sha.substring(32 - 8, 32);
      int offset = mode2 + 32;
      String key2 =
          sha.substring(offset, offset + 8) + sha.substring(64 - 8, 64);



      Map<String, dynamic> dev = {};
      dev["packageName"] = packageInfo.packageName;
      dev["buildNumber"] = packageInfo.buildNumber;
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isIOS) {
        IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
        dev["model"] = iosDeviceInfo.model;
        dev["product"] = iosDeviceInfo.name;
        dev["isPhysicalDevice"] = iosDeviceInfo.isPhysicalDevice;
        dev["kid"] = iosDeviceInfo.identifierForVendor;
        var systemName = iosDeviceInfo.systemName;
        var systemVersion = iosDeviceInfo.systemVersion;
        dev["sdk"] = (systemName ?? "") + (systemVersion ?? "");
        dev["plat"] = "ios";
      } else if (Platform.isAndroid) {
        AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
        dev["model"] = androidDeviceInfo.model;
        dev["display"] = androidDeviceInfo.display;
        dev["tags"] = androidDeviceInfo.tags;
        dev["product"] = androidDeviceInfo.product;
        dev["isPhysicalDevice"] = androidDeviceInfo.isPhysicalDevice;
        dev["androidId"] = androidDeviceInfo.androidId;
        dev["sdk"] = androidDeviceInfo.version.release;
        dev["plat"] = "and";
      }
      // String body = jsonEncode({"dev": jsonEncode(dev), "data": jsonEncode(param)});
      String body = jsonEncode(param);

      Dio dio = Dio(BaseOptions(
        connectTimeout: 30000,
        receiveTimeout: 30000,
      ));
      String _header = jsonEncode({
        'ts': ts.toString(),
        'uuid': uuid,
        'token': token,
        'ver': packageInfo.version,
        'udid': udid
      });
      String _headstr = xxtea.encryptToString(_header,
          [12, 87, 86, 33, 0, 2, 45, 73, 24, 78, 121, 78, 60, 9, 87, 29]);
      // String _body = xxtea.encryptToString(body, key1);
      // print('encryptString====' + _bdoy);
      Response response =
          // await dio.post(HOST + path, data: _headstr + "#" + _body);
          await dio.post(HOST + path, data:  body);
      // EasyLoading.dismiss();
      if (null != response.data) {
        // String result = xxtea.decryptToString(response.data.toString(), key2);
        String result = response.data;
        print('http ==token=====\n $result');
        print('http ==URL=========\n $path');
        print('http ==请求参数=====\n $param');
        print('http ==token=====\n $token');
        var responseData;
        if (result.isNotEmpty) {
          responseData = jsonDecode(result);
        }
        int code = responseData["code"];
        if (code == 1) {
          var data = responseData["data"];
          if (data != null) {
            var response = jsonDecode(data);
            callback(response);
          } else {
            callback("");
          }
        } else {
          String errStr = responseData["msg"];
          if (showError && errStr.isNotEmpty) {}
          errorCallback(responseData["msg"]);
        }
      }
    } on DioError catch (e) {
      print("http  ==错误信息====== $e");
    }
  }
}
