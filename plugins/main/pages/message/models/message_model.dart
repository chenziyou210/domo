// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

MessageModel messageModelFromJson(Map<String, dynamic> json) =>
    MessageModel.fromJson(json);

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  MessageModel({
    this.content,
    this.title,
    this.updateTime,
  });

  String? content;
  String? title;
  String? updateTime;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        content: json["content"],
        title: json["title"],
        updateTime: json["updateTime"],
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "title": title,
        "updateTime": updateTime,
      };
}
