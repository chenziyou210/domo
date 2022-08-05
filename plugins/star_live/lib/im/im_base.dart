/*
 *  Copyright (C), 2015-2021
 *  FileName: im_base
 *  Author: Tonight丶相拥
 *  Date: 2021/11/18
 *  Description: 
 **/

import 'package:star_common/base/app_base.dart';
import 'package:im_flutter_sdk/im_flutter_sdk.dart';

// class ImBase {
//   /// 初始化sdk
//   Future<void> initialize({required String appKey, EMPushConfig? pushConfig}) async {
//     EMOptions options = EMOptions(appKey: appKey)..pushConfig = pushConfig;
//     await EMClient.getInstance.init(options);
//     return;
//   }
//
//   /// 登录
//   Future<void> logIn({required String password, required String name}) async {
//     await EMClient.getInstance.login(name, password);
//     return;
//   }
//
//   /// 退出登录
//   Future<void> logOut() async{
//     await EMClient.getInstance.logout();
//     return;
//   }
//
//   /// 当前登录这名字
//   String? get currentUser => EMClient.getInstance.currentUsername;
// }

class ImConversationList extends CommonNotifierModel {
  /// 会话列表
  List<EMConversation> _conversation = [];
  List<EMConversation> get conversation => _conversation;

  /// 获取会话列表
  Future<void> getConversationList() async {
    try {
      _conversation =
          await EMClient.getInstance.chatManager.loadAllConversations();
    } on EMError catch (_) {}
    updateState();
    return;
  }
}

class ImConversation extends CommonNotifierModel {
  ImConversation(this._id) {
    EMClient.getInstance.chatManager.getConversation(this._id).then((value) {
      _conv = value;
    });
  }

  /// 聊天id
  final String _id;

  /// 聊天消息
  List<EMMessage> _message = [];
  List<EMMessage> get message => _message;

  /// 聊天
  EMConversation? _conv;

  /// 加载信息
  Future<void> loadMessage() async {
    try {
      // emId: 会话对应环信id, 如果是群组或者聊天室，则为群组id或者聊天室id
      _message = await _conv?.loadMessages() ?? [];
    } on EMError catch (_) {}
    updateState();
  }

  /// 加载更多消息
  Future<void> loadMoreMessage() async {
    if (_message.length == 0) {
      return loadMessage();
    }
    var message =
        await _conv?.loadMessages(startMsgId: _message.last.msgId) ?? [];
    _message += message;
    updateState();
  }

  /// 发送消息
  Future<void> sendMessage({String event: "hjnLiveMessage"}) async {
    EMClient.getInstance.chatManager.sendMessage(
        EMMessage.createCustomSendMessage(
            username: EMClient.getInstance.currentUsername ?? "", event: ""));
  }
}
