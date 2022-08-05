import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'web_view_game_page_logic.dart';
import 'web_view_game_page_state.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';

/// @description:
/// @author
/// @date: 2022-07-22 19:10:44
class WebViewGamePagePage extends StatelessWidget {
  final WebViewGamePageLogic logic = Get.put(WebViewGamePageLogic());
  final WebViewGamePageState state = Get.find<WebViewGamePageLogic>().state;

  WebViewGamePagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);


    // var instanceWebController;
    // _controller.future.then((data) {
    //   instanceWebController = data;
    // });
    state.gameId = Get.arguments["gameId"];
    state.url = Get.arguments["url"];
    return Scaffold(body: Builder(builder: (BuildContext context) {
      return GetBuilder<WebViewGamePageLogic>(
        init: logic,
        builder: ((controller) {
          return Stack(
            children: [
              SafeArea(
                child: WebView(
                  initialUrl: state.url,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    state.controll = webViewController;
                    state.controller.complete(webViewController);
                  },
                  navigationDelegate: (NavigationRequest request) {
                    if (!request.url.startsWith(new RegExp(r'http[s]:\/\/'))) {
                      return NavigationDecision.prevent;
                    }
                    return NavigationDecision.navigate;
                  },
                ),
              ),
              InkWell(
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(left: 10, top: mq.padding.top),
                  child: Text(
                    "返回",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
                onTap: () {
                  print('返回上级页面');
                  Get.back();
                },
              ),
            ],
          );
        }),
      );
    }));
  }
}
