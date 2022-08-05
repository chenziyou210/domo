import 'dart:async';

import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:hjnzb/pages/game/jump_game_logic.dart';

import 'package:star_common/manager/user/user_balance_logic.dart';

class WebViewGamePage extends StatefulWidget {
  WebViewGamePage({dynamic arguments})
      : this.url = arguments["url"],
        // this.gameCompanyId = arguments["gameCompanyId"],
        this.gameId = arguments["gameId"];
  final String url;
  // final int gameCompanyId;
  final String gameId;
  @override
  WebViewGameState createState() => WebViewGameState();
}

class WebViewGameState extends State<WebViewGamePage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  late WebViewController _controll;
  final logic = Get.find<JumpGameLogic>();
  @override
  void initState() {
    // TODO: implement initState
    print('进入游戏界面');
    logic.gameTransferInOut(widget.gameId);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print('离开游戏界面');
    logic.gameTransferIn(widget.gameId);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    MediaQueryData mq = MediaQuery.of(context);

    var instanceWebController;
    _controller.future.then((data) {
      instanceWebController = data;
    });
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        return Stack(
          children: [
            SafeArea(
              child: WebView(
                initialUrl: widget.url,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controll = webViewController;
                  _controller.complete(webViewController);
                },
                navigationDelegate: (NavigationRequest request) {
                  if (!request.url.startsWith(new RegExp(r'http[s]:\/\/'))) {
                    print('blocking navigation to $request}');
                    return NavigationDecision.prevent;
                  }
                  print('allowing navigation to $request');
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
                  style: TextStyle(color: Colors.white, fontWeight: w_500),
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
  }
}
