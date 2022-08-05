/*
 *  Copyright (C), 2015-2021
 *  FileName: custom_divider
 *  Author: Tonight丶相拥
 *  Date: 2021/7/16
 *  Description: 
 **/

part of appcommon;

class CustomDivider extends Divider {
  CustomDivider({
    Key? key,
    double? height,
    double? thickness,
    double? indent,
    double? endIndent,
    Color? color,
  }) :this._thickness = thickness,
        super(key: key, height: height ?? 1,
          indent: indent,
          endIndent: endIndent,
          color: color ?? Color.fromARGB(255, 245, 245, 245));
  final double? _thickness;
  @override
  // TODO: implement thickness
  double? get thickness => _thickness ?? this.height;
}