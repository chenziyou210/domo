/*
 *  Copyright (C), 2015-2021
 *  FileName: url_page
 *  Author: Tonight丶相拥
 *  Date: 2021/11/30
 *  Description: 
 **/

import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:star_common/common/app_common_widget.dart';

class UrlPage extends StatelessWidget {
  UrlPage({dynamic arguments}) : this.url = arguments["url"];
  final String url;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: DefaultAppBar(),
        body: WebView(
                javascriptMode: JavascriptMode.unrestricted, initialUrl: url)
            .container(color: Colors.white));
  }
}
