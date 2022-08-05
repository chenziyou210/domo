import 'dart:math';

import 'package:flutter/material.dart';
import 'package:star_common/common/app_common_widget.dart';

import '../app_images/r.dart';

class CoinItem{
  double w, h, x, y, value;
  final int id;
  CoinItem(this.id, this.w, this.h, this.x, this.y, this.value);

  CoinItem.fromJson(Map<String, dynamic> json):
        id =  json['id'],
        value =  json['value'],
        w =  json['w'],
        h = json['h'],
        x = json['x'],
        y = json['y'];

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'value': value,
        'w': w,
        'h': h,
        'x': x,
        'y': y,
      };
  @override
  String toString() {
    return 'id = $id, x = $x, y = $y, w = $w, h = $h, value = $value';
  }
}

class Fly extends StatefulWidget {
  final Widget child;
  final Widget iconDisplay;
  final double xParentSource, value, yParentSource, xParentDest, yParentDest;
  final BuildContext context;
  final String icon;
  final BoxConstraints constraint;
  final GlobalKey global;
  final GlobalKey globalList;
  final GlobalKey globalCoin;
  final bool reverse;
  final int type;
  final ValueChanged<CoinItem> callback;
  final FlyController controller = FlyController();
  final Duration animationDuration;

  Fly(
      {required key,
      required this.global,
      required this.callback,
      required this.type,
      required this.globalList,
      required this.globalCoin,
      required this.child,
      required this.iconDisplay,
      required this.context,
      required this.icon,
      required this.value,
      required this.constraint,
      this.xParentSource = -1.0,
      this.yParentSource = -1.0,
      this.xParentDest = -1.0,
      this.yParentDest = -1.0,
      this.reverse = false,
      this.animationDuration = const Duration(milliseconds: 300)})
      : super(key: key);

  @override
  _FlyState createState() => _FlyState();
}

class _FlyState extends State<Fly> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  double xSource = 0, ySource = 0, newSize = 0, scale = 0, xDest = 0, yDest = 0,
      xDest2 = 0, yDest2 = 0;
  int x = 0, y = 0;

  @override
  void initState() {
    animationController =
        AnimationController(duration: widget.animationDuration, vsync: this);
    widget.controller.setState(this);

    if (widget.xParentSource == -1) {
      try {
        RenderBox? box =
        widget.global.currentContext?.findRenderObject() as RenderBox?;
        if (box == null) return;
        Offset? position =
        box.localToGlobal(Offset.zero); //this is global position

        RenderBox? box1 =
        widget.globalList.currentContext?.findRenderObject() as RenderBox?;
        if (box1 == null) return;
        Offset? position1 =
        box1.localToGlobal(Offset.zero); //this is global position

        RenderBox? box2 = widget.context.findRenderObject() as RenderBox?;
        if (box2 == null) return;
        Offset? position2 =
        box2.localToGlobal(Offset.zero); //this is global position

        RenderBox? box3 =
        widget.globalCoin.currentContext?.findRenderObject() as RenderBox?;
        if (box3 == null) return;
        Offset? position3 =
        box3.localToGlobal(Offset.zero); //this i

        scale = box1.size.height / 3 / 32.dp;
        newSize = 32.dp * scale;
        var rng = Random();

        xSource = position.dx - position2.dx;
        ySource = position.dy - position2.dy;
        x = rng.nextInt((box1.size.width - newSize * 1.5).toInt());
        y = rng.nextInt((box1.size.height - newSize * 1.5).toInt());
        xDest = position1.dx - position2.dx + x;
        yDest = position1.dy - position2.dy + y;

        xDest2 = position3.dx - position2.dx - (newSize - 16.dp)/2;
        yDest2 = position3.dy - position2.dy  - (newSize - 16.dp)/2;

        // print('NEO - newSize = ${newSize}');
        // print('NEO - w = ${box1.size.width}');
        // print('NEO - h = ${box1.size.height}');
        // print('NEO - top = ${position2.dy}');
        // print('NEO - left = ${position2.dx}');
        // print('NEO - width = ${widget.constraint.maxWidth}');
        // print('NEO - height = ${widget.constraint.maxHeight}');
        // print('NEO - xSource = $xSource');
        // print('NEO - ySource = $ySource');
        // print('NEO - xDest = $xDest');
        // print('NEO - yDest = $yDest');
        // print('NEO - xDest2 = $xDest2');
        // print('NEO - yDest2 = $yDest2');

        if(widget.type > 1 && widget.xParentDest > -1){
          xDest = position1.dx - position2.dx + widget.xParentDest;
          yDest = position1.dy - position2.dy + widget.yParentDest;
        }

        if (xSource > 0 && ySource > 0 && xDest > 0 && yDest > 0) {
          if (widget.type > 0) {
            widget.controller.fly();
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      xSource = widget.xParentSource;
      ySource = widget.yParentSource;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('NEO widget.type - ${widget.type}');
      switch(widget.type){
        case 1: return _flyIcon();
        case 2: return _recallIcon();
        case 3: return _alphaIcon();
      }
    print('NEO widget.ty1pe - ${widget.type}');
      return Container();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Widget _recallIcon() {
    final Animation<double> offsetAnimation =
    Tween(begin: yDest, end: yDest2)
        .animate(CurvedAnimation(
          curve: Curves.linear,
          parent: animationController,
      ))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          //animationController.reset();
        }
      });
    final Animation<double> offsetAnimation1 =
    Tween(begin: xDest, end: xDest2)
        .animate(CurvedAnimation(
        curve: Curves.linear,
        parent: animationController,
    ));
    final Animation<double> scaleAnimation =
    Tween(begin: 1.0, end: 16.dp/newSize).
    animate(CurvedAnimation(
        curve: Curves.linear,
        parent: animationController)
    );

    return AnimatedBuilder(
      animation: offsetAnimation,
      builder: (context, child) {
        return AnimatedBuilder(
          animation: offsetAnimation1,
          builder: (context, child) {
            return AnimatedBuilder(
              animation: scaleAnimation,
              builder: (context, child)
            {
              return Container(
                alignment: Alignment.topLeft,
                child: Stack(
                  children: [
                    Positioned(
                        child:
                        Container(child: Stack(children: [
                          widget.child,
                          if(widget.icon == R.mulConfig)
                            Text(
                              '${widget.value.toInt()}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold),
                            )
                        ],).transformScale(scaleAnimation.value),
                            width: newSize,
                            height: newSize),
                        top: offsetAnimation.value,
                        left: offsetAnimation1.value),
                    Positioned(
                        child: widget.iconDisplay,
                        top: ySource,
                        left: xSource),
                  ],
                ),
              );
            });
          },
        );
      },
    );
  }
  Widget _alphaIcon() {
    final Animation<double> offsetAnimation =
    Tween(begin: 300.0, end: 0.0).animate(animationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          //animationController.reset();
        }
      });

    return AnimatedBuilder(
      animation: offsetAnimation,
      builder: (context, child) {
        return Container(
          alignment: Alignment.topLeft,
          child: Stack(
            children: [
              Positioned(
                  child:
                  Container(child: widget.child,
                      width: newSize,
                      height: newSize).opacity(offsetAnimation.value / 300.0),
                  top: yDest,
                  left: xDest),
              Positioned(
                  child: widget.iconDisplay,
                  top: ySource,
                  left: xSource),
            ],
          ),
        );
      },
    );
  }
  Widget _flyIcon() {
    final Animation<double> offsetAnimation =
    Tween(begin: ySource, end: yDest)
        .animate(CurvedAnimation(
          curve: Curves.linear,
          parent: animationController,
        ))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (!widget.reverse) {
            animationController.reset();
            widget.callback.call(CoinItem(
                DateTime.now().microsecondsSinceEpoch,
                newSize,
                newSize,
                x.toDouble(),
                y.toDouble(),
                widget.value));
            return;
          }
        }
      });
    final Animation<double> offsetAnimation1 =
    Tween(begin: xSource, end: xDest)
        .animate(CurvedAnimation(
      curve: Curves.linear,
      parent: animationController,
    ));

    final Animation<double> scaleAnimation =
    Tween(begin: 1.0, end: scale)
        .animate(CurvedAnimation(
      curve: Curves.linear,
      parent: animationController,
    ));

    return AnimatedBuilder(
      animation: offsetAnimation,
      builder: (context, child) {
        return AnimatedBuilder(
          animation: offsetAnimation1,
          builder: (context, child) {
            return AnimatedBuilder(
              animation: scaleAnimation,
              builder: (context, child) {
                return Container(
                  alignment: Alignment.topLeft,
                  child: Stack(
                    children: [
                      Positioned(
                          child:
                          widget.child.transformScale(scaleAnimation.value),
                          top: offsetAnimation.value,
                          left: offsetAnimation1.value),
                      Positioned(
                          child: widget.iconDisplay,
                          top: ySource,
                          left: xSource),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class FlyController {
  late _FlyState _state;

  void setState(_FlyState state) {
    _state = state;
  }

  Future<void> fly() {
    return _state.animationController.forward(from: 0.0);
  }
}
