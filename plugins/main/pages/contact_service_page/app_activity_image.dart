import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:star_common/base/app_base.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:star_common/common/toast.dart';

class AppActivityImagePage extends StatefulWidget {
  AppActivityImagePage({dynamic arguments}) : this.imageUrl = arguments["url"];
  final String imageUrl;
  @override
  createState() => _AppActivityImagePageState();
}

class _AppActivityImagePageState extends AppStateBase<AppActivityImagePage>
    with Toast {
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  // TODO: implement body
  Widget get body => WebView(
      initialUrl: widget.imageUrl,
      javascriptMode: JavascriptMode.unrestricted,
      javascriptChannels: [
        JavascriptChannel(
            name: "onTap",
            onMessageReceived: (message) {
              Map<String, dynamic> dic = {};
              try {
                dic = jsonDecode(message.message);
              } catch (e) {
                showToast(e.toString());
              }
              if (dic.isEmpty) {
                showToast(intl.invalidateMessage);
                return;
              }
              int type = dic["type"];
              dynamic arguments = dic["arguments"];
              String page = dic["page"];
              _dealWith(type, arguments, page);
            })
      ].toSet());

  void _dealWith(int type, dynamic arguments, String page) {
    if (type == 1) {
      Get.toNamed(page,arguments: arguments);
      // pushViewControllerWithName(page, arguments: arguments);
    } else if (type == 2) {
      Clipboard.setData(ClipboardData(text: arguments.toString()));
      showToast(intl.copySuccess);
    }
  }
}
