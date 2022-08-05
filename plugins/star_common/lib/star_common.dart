
import 'dart:async';

import 'package:flutter/services.dart';

class StarCommon {
  static const MethodChannel _channel = MethodChannel('star_common');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
