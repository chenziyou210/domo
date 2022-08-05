/// @description:
/// @author
/// @date: 2022-07-22 19:10:44
import 'dart:async';

import 'package:flutter_webview_pro/webview_flutter.dart';

class WebViewGamePageState {
  WebViewGamePageState() {
    ///Initialize variables
  }
  final Completer<WebViewController> controller =
      Completer<WebViewController>();
  late WebViewController controll;
  String? gameId;
  String? url;
}
