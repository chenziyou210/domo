/*
 *  Copyright (C), 2015-2021
 *  FileName: datetime_extension
 *  Author: Tonight丶相拥
 *  Date: 2021/8/2
 *  Description: 
 **/

part of utiltool;

extension DateTimeExtension on DateTime {
  String toFormatString(DateTimeFormat format){
    String value;
    switch (format) {
      case DateTimeFormat.yyyy_MM_dd:
        value = "${this.year}" + "-"
            + "${this.month.toStringAsFixed1(2)}" + "-" +
            "${this.day.toStringAsFixed1(2)}";
        break;
      case DateTimeFormat.yyyy_MM_dd_HH_mm_ss:
        value = "${this.year}" + "-"
            + "${this.month.toStringAsFixed1(2)}" + "-"
            + "${this.day.toStringAsFixed1(2)}" + " "
            + "${this.hour.toStringAsFixed1(2)}" + ":"
            + "${this.minute.toStringAsFixed1(2)}" + ":"
            + "${this.second.toStringAsFixed1(2)}";
        break;
      case DateTimeFormat.yyyy_MM_ddTHH_mm_ss:
        value = this.toIso8601String();
        break;
    }
    return value;
  }

  // String 转 DateTime
  static DateTime fromString(String timeStr, [String split = "-"]){
    List<int> values = timeStr.split(split).map((e) => int.parse(e)).toList();
    return DateTime(values[0], values[1], values[2]);
  }
}

enum DateTimeFormat {
  yyyy_MM_dd,
  yyyy_MM_ddTHH_mm_ss,
  yyyy_MM_dd_HH_mm_ss
}

// mixin _EnumMixin<T> {
//   T get rawValue;
//   String get description;
// }

extension DatetimeFormatExtension on DateTimeFormat {
  String get rawValue {
    String value;
    switch(this) {
      case DateTimeFormat.yyyy_MM_ddTHH_mm_ss:
        value = "yyyy-MM-ddTHH:mm:ss";
        break;
      case DateTimeFormat.yyyy_MM_dd:
        value = "yyyy-MM-dd";
        break;
      case DateTimeFormat.yyyy_MM_dd_HH_mm_ss:
        value = "yyyy-MM-dd HH:mm:ss";
        break;
      default:
        value = this.toString();
        break;
    }
    return value;
  }

  String get description {
    String value;
    switch(this) {
      case DateTimeFormat.yyyy_MM_ddTHH_mm_ss:
        value = "yyyy-MM-ddTHH:mm:ss";
        break;
      case DateTimeFormat.yyyy_MM_dd:
        value = "yyyy-MM-dd";
        break;
      case DateTimeFormat.yyyy_MM_dd_HH_mm_ss:
        value = "yyyy-MM-dd HH:mm:ss";
        break;
      default:
        value = this.toString();
        break;
    }
    return value;
  }
}