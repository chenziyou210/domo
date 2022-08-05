/*
 *  Copyright (C), 2015-2021
 *  FileName: switch_way
 *  Author: Tonight丶相拥
 *  Date: 2021/12/15
 *  Description: 
 **/

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:dart_ping_ios/dart_ping_ios.dart';
import 'package:star_common/http/error_deal.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/manager/app_manager.dart';
import 'package:httpplugin/http_config/http_config.dart';

class SwitchWayPage extends StatefulWidget {
  @override
  createState() => _SwitchWayPageState();
}

class _SwitchWayPageState extends AppStateBase<SwitchWayPage> {
  GlobalSettingModel get model1 => AppManager.getInstance<GlobalSettingModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _index = model1.viewModel.index;
  }

  @override
  // TODO: implement appBar
  PreferredSizeWidget? get appBar => DefaultAppBar(
      title: CustomText("${intl.switchWay}",
          fontSize: 16.dp,
          fontWeight: w_500,
          color: Color.fromARGB(255, 34, 40, 49)));

  @override
  // TODO: implement body
  Widget get body => Container(
      padding: EdgeInsets.symmetric(horizontal: 16) + EdgeInsets.only(top: 32),
      child: Row(children: [
        Wrap(
                spacing: 27.dp,
                children: model1.viewModel.routes.map((e) {
                  int index = model1.viewModel.routes.indexOf(e);
                  var uri = Uri.parse("${e.name}");

                  Widget child = _PingItem(
                          name: "${intl.circuit}${e.id}",
                          path: uri.host,
                          delay: intl.delay)
                      .container(margin: EdgeInsets.all(4));
                  if (this._index == index) {
                    child = Stack(children: [
                      CustomGradientBorderContainer(
                          strokeWidth: 4,
                          radius: 10,
                          gradient: LinearGradient(
                              transform: GradientRotation(pi / 4),
                              colors: [
                                // Color.fromARGB(255, 170, 60, 243),
                                // Color.fromARGB(255, 116, 77, 247)
                                Color.fromARGB(255, 84, 222, 248),
                                Color.fromARGB(255, 133, 189, 247),
                                Color.fromARGB(255, 235, 121, 239),
                                Color.fromARGB(255, 244, 167, 153),
                                Color.fromARGB(255, 248, 196, 55)
                              ]),
                          child: child),
                      Positioned(
                          child: Image.asset(R.routesSelected),
                          bottom: 4,
                          right: 4)
                    ]);
                  }
                  return child.gestureDetector(onTap: () {
                    this._index = index;
                    var ip = "${uri.scheme}://${uri.host}";
                    var port = "${uri.port}";
                    model1.viewModel.setIndex(index, ip, port);
                    HttpChannel.channel.updateMidBuffer(
                        config: HttpConfig(
                            ip: ip,
                            port: port,
                            maxSlave: 8,
                            errorDeal: CustomErrorDeal(),
                            statusCodeIgnoreRetry: [401, 403],
                            maxLongRunningSlave: 5,
                            slaveCloseTime: 600,
                            enableOauth: false,
                            enableRedirect: false));
                    setState(() {});
                  });
                }).toList())
            .expanded()
      ]));

  int _index = -1;
}

class _PingItem extends StatefulWidget {
  _PingItem({required this.name, required this.path, required this.delay});
  final String name;
  final String path;
  final String delay;
  @override
  createState() => _PingItemState();
}

class _PingItemState extends State<_PingItem> {
  late StreamSubscription _s;
  int? _delay;
  late Ping _ping;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isIOS) {
      DartPingIOS.register();
    }
    _ping = Ping(widget.path, count: 99999);
    _s = _ping.stream.listen((event) {
      var d = event.response?.time?.inMilliseconds;
      if (event.error == null && d != null) {
        this._delay = d;
        _ping.stop();
        _s.cancel();
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _ping.stop();
    _s.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      CustomText("${widget.name}",
          fontSize: 16.dp, fontWeight: w_500, color: Colors.black),
      SizedBox(height: 16),
      RichText(
          text: TextSpan(
              text: "${widget.delay}",
              style: TextStyle(
                  fontSize: 12.dp,
                  fontWeight: w_400,
                  color: Color.fromARGB(255, 95, 94, 94)),
              children: [
            if (this._delay != null)
              TextSpan(
                  style: TextStyle(
                      color: this._delay! > 120
                          ? Color.fromARGB(255, 228, 31, 39)
                          : Color.fromARGB(255, 18, 195, 132)),
                  text: "${this._delay}ms")
          ]))
    ]).container(
        width: 92.dp - 8.dp,
        height: 92.dp - 8.dp,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(6)));
  }
}

/*
* CustomGradientBorderContainer(
          strokeWidth: 4,
          radius: 10,
          gradient: LinearGradient(
              transform: GradientRotation(pi / 4),
              colors: [
                Color.fromARGB(255, 170, 60, 243),
                Color.fromARGB(255, 116, 77, 247)
              ]
          ),
          child: Image.asset(image).marginAll(4))*/
