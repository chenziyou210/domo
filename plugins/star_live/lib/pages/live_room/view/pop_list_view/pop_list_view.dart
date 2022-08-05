/*
 *  Copyright (C), 2015-2021
 *  FileName: pop_list_view
 *  Author: Tonight丶相拥
 *  Date: 2021/11/4
 *  Description: 
 **/

import 'package:flutter/material.dart';
import 'package:star_common/common/app_common_widget.dart';

class PopScrollMessage extends StatefulWidget {
  PopScrollMessage({required this.end, required this.begin});
  final double begin;
  final double end;
  @override
  createState() => PopScrollMessageState();
}

class PopScrollMessageState extends State<PopScrollMessage> with TickerProviderStateMixin {

  late Animation _animation;
  // late Animation _animation1;
  late AnimationController _controller;
  // late AnimationController _controller1;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 10));
    _animation = Tween(
      begin: widget.begin,
      end: widget.end
    ).animate(AnimationController(vsync: this));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        return Container(
          child: Text("这是一个测试滚动条", style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ))
        );
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
}
