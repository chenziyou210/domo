/*
 *  Copyright (C), 2015-2021
 *  FileName: string_extension
 *  Author: Tonight丶相拥
 *  Date: 2021/12/17
 *  Description: 
 **/

extension StringExtension on String {
  String get getDateTime {
    /// 是否为空
    if (this.isEmpty) return this;

    /// 毫秒
    int? value;
    try {
      value = int.parse(this);
    } catch (_) {}

    /// 时间
    DateTime? time;
    if (value == null) {
      try {
        time = DateTime.parse(this);
      } catch (_) {}
    } else {
      try {
        time = DateTime.fromMillisecondsSinceEpoch(value);
        if (time.isAfter(DateTime.now())) {
          time = DateTime.fromMicrosecondsSinceEpoch(value);
        }
      } catch (_) {}
    }
    if (time == null) return this;

    /// 返回时间
    return time.toIso8601String().replaceAll("T", " ").split(".").first;
  }
}

/// 时间格式化
/// 2022-07-31 13:13:40
/// mm/dd hh:m
String dateTimeWithString(String dateString) {
  // dateTimeTodayWithString(dateString);
  if (dateString.isEmpty) return "";
  DateTime dateTime = DateTime.parse(dateString);
  // var dateStr =
  //     "${DateTime.fromMillisecondsSinceEpoch(timeStamp).toString().replaceAll("T", " ").split(".")[0]}";
  String hour = dateTime.hour.toString().padLeft(2, "0");
  String minute = dateTime.minute.toString().padLeft(2, "0");
  return '${dateTime.month}/${dateTime.day} ${hour}:${minute}';
}

/// 时间格式化
/// 2022-07-31 13:13:40
///
String dateTimeTodayWithString(String dateString) {
  if (dateString.isEmpty) return "";
  try {
    DateTime dateTime = DateTime.parse(dateString);
    var now = DateTime.now();
    Duration dur = DateTime.now().timeZoneOffset;
    // 先去除当前时差 --
    now = now.subtract(dur);
    // 加上北京时间的时区
    Duration utc8 = Duration(hours: 8);
    now = now.add(utc8);
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    // final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final aDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    String hour = dateTime.hour.toString().padLeft(2, "0");
    String minute = dateTime.minute.toString().padLeft(2, "0");
    if (aDate == today) {
      return '${hour}:${minute}';
    } else if (aDate == yesterday) {
      return '昨天 ${hour}:${minute}';
    } else {
      return '${dateTime.month}月${dateTime.day}日 ${hour}:${minute}';
    }
  } catch (e) {
    return dateString;
  }
}
