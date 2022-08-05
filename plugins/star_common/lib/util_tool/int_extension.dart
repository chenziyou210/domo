/*
 *  Copyright (C), 2015-2021
 *  FileName: int_extension
 *  Author: Tonight丶相拥
 *  Date: 2021/8/2
 *  Description: 
 **/

part of utiltool;

extension IntExtension on int {
  String toStringAsFixed1(int fractionDigits, [String fixed = "0"]) {
    var v = "$this";
    if (v.length < fractionDigits) {
      v = List.generate(fractionDigits - v.length, (index) => fixed).join() + v;
    }
    return v;
  }
}