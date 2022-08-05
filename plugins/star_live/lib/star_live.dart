
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

ValueChanged<double>? heighSheetCallBack;
ValueChanged<bool>? bottomSheetCallBack;
class StarLive {
  static const MethodChannel _channel = MethodChannel('star_live');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
