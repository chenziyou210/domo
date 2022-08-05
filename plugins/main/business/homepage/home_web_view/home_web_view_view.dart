import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'home_web_view_logic.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';

class HomeWebViewPage extends StatelessWidget {
  // final Completer<WebViewController> _controller =
  //     Completer<WebViewController>();
  // late WebViewController _controll;
  dynamic _controller;
  late final String url;
  HomeWebViewPage({dynamic arguments}) {
    url = arguments["url"];
  }

  @override
  Widget build(BuildContext context) {
    //js 互通
    JavascriptChannel _toastJavascriptChannel(BuildContext context) {
      return JavascriptChannel(
          name: 'Toaster',
          onMessageReceived: (JavascriptMessage message) {
            print(message);
          });
    }

    return GetBuilder<HomeWebViewLogic>(
        init: HomeWebViewLogic(),
        builder: (logic) {
          return Scaffold(
            appBar: DefaultAppBar(
              title: Text(logic.state.title ?? " "),
              centerTitle: true,
            ),
            body: Stack(
              children: [
                WebView(
                  initialUrl: url,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller = webViewController;
                    // _controller.complete(webViewController);
                  },
                  navigationDelegate: (NavigationRequest request) {
                    if (!request.url.startsWith(new RegExp(r'http[s]:\/\/'))) {
                      print('blocking navigation to $request}');
                      return NavigationDecision.prevent;
                    }
                    print('allowing navigation to $request');
                    return NavigationDecision.navigate;
                  },
                  onPageFinished: (url) {
                    _controller
                        .evaluateJavascript("document.title")
                        .then((resulut) {
                      print(resulut);
                      logic.state.title = resulut;
                      logic.update();
                    });
                  },
                ),
              ],
            ),
          );
        });
  }
}
