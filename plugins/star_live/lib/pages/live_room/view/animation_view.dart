/*
 *  Copyright (C), 2015-2021
 *  FileName: animation_view
 *  Author: Tonight丶相拥
 *  Date: 2021/11/27
 *  Description: 
 **/

import 'package:flutter/material.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/i18n/i18n.dart';

class AnimatedGroupModel {
  AnimatedGroupModel(this.animate, this.interval);
  final Animatable<double> animate;
  final Interval interval;
  late Animation<double> animation;
}

class CommonController {
  CommonController({required AnimationController controller,
    required List<AnimatedGroupModel> models}):
  this._models = models, this.controller = controller {
    _models.forEach((e) => e.animation = e.animate.animate(
        CurvedAnimation(parent: controller,
            curve: e.interval)));
  }
  /// 动画控制器
  final AnimationController controller;

  final List<AnimatedGroupModel> _models;

  double get _value => _models.map((e) => e.animation.value)
      .reduce((value, element) => value + element);

  void dispose(){
    controller.dispose();
  }
}

class LotteryController extends CommonController {
  final String name;
  LotteryController(AnimationController controller,
    List<AnimatedGroupModel> models, this.name): super(controller: controller, models: models) {
    EventBus.instance.addListener(_listener, name: name);
  }
  //
  // /// 动画控制器
  // final AnimationController _controller;
  //
  // final List<AnimatedGroupModel> _models;
  //
  // double get _value => _models.map((e) => e.animation.value)
  //   .reduce((value, element) => value + element);

  /// 开奖结果
  String? _result;
  List<String>? _results;
  List<String> get _lotteryResult {
    if (_result == null) {
      return [];
    }else if (_results == null || _results!.length == 0) {
      _result = _result!.split("+")[0];
      _results = _result!.split(",");
    }
    return _results!;
  }

  /// 名称
  String? _gameName;
  /// 上期开奖
  dynamic _lastPeriodTime;

  /// 添加监听
  void _listener(dynamic arguments){
    _result = arguments["result"];
    if (_result == null)
      return;
    _gameName = arguments["gameName"];
    _lastPeriodTime = arguments["lastPeriodTime"];
    _results = null;
    controller.reset();
    controller.forward();
  }

  /// 移除监听
  void removeListener() {
    EventBus.instance.removeListener(_listener, name: name);
    super.dispose();
    // _controller.dispose();
  }
}

class LivingRoomAnimationView extends AnimatedWidget {
  LivingRoomAnimationView(this.model, this.top): super(listenable: model.controller);
  final LotteryController model;
  final double top;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Positioned(
      left: 1000 - model._value,
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.black.withOpacity(0.26)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomText("${model._gameName}",
                  fontSize: 12.sp,
                  fontWeight: w_400,
                  color: Color.fromARGB(255, 251, 210, 0),//rgba(251, 210, 0, 1)
                ),
                CustomText("${AppInternational.of(context).dn}: ${model._lastPeriodTime}",
                  fontSize: 14.sp, fontWeight: w_400,
                  color: Colors.white,
                )
              ]
            ).container(
              // padding: EdgeInsets.only(bottom: 4),
              // decoration: BoxDecoration(
              //   border: Border(bottom: BorderSide(
              //     color: Colors.white
              //   ))
              // )
            ),
            SizedBox(height: 4.dp),
          ]
        ),
      ),
      top: this.top);
  }
}

class CommonAnimationWidget extends AnimatedWidget {
  CommonAnimationWidget(this.model, this.top, {required this.childBuilder, this.isBottom: false}): super(listenable: model.controller);
  final CommonController model;
  final double top;
  final Widget Function(BuildContext) childBuilder;
  final bool isBottom;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Positioned(
      left: 1000 - model._value,
      child: childBuilder(context),
      top: isBottom ? null : top,
      bottom: isBottom ? top : null,
    );
  }
}