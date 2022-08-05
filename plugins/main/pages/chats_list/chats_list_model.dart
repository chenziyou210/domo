/*
 *  Copyright (C), 2015-2021
 *  FileName: chats_list_model
 *  Author: Tonight丶相拥
 *  Date: 2021/9/30
 *  Description: 
 **/

import 'package:star_common/base/app_base.dart';
// import 'package:tencent_im_sdk_plugin/models/v2_tim_conversation.dart';
// import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';

class ChatsListModel extends AppModel {
  /// 视图模型
  final ChatsListViewModel viewModel = ChatsListViewModel();

  /// nextSeq	分页拉取的游标，第一次默认取传 0，后续分页拉传上一次分页拉取成功回调里的 nextSeq
  String? _nextSeq;

  /// 刷新聊天
  Future<void> refreshChats() async {
    // var result = await TencentImSDKPlugin.v2TIMManager.getConversationManager()
    //     .getConversationList(nextSeq: "0", count: 20);
    // if (result.data != null) {
    //   var values = result.data!.conversationList ?? [];
    //   viewModel._setChatsList(values.cast<V2TimConversation>());
    //   _setNextSeq(result.data!.nextSeq);
    // }
  }

  /// 加载更多聊天
  Future<void> loadMoreChats() async {
    // var result = await TencentImSDKPlugin.v2TIMManager.getConversationManager()
    //     .getConversationList(nextSeq: _nextSeq ?? "0", count: 20);
    // if (result.data != null) {
    //   var values = result.data!.conversationList ?? [];
    //   viewModel._addChatsList(values.cast<V2TimConversation>());
    //   _setNextSeq(result.data!.nextSeq);
    // }
  }

  void _setNextSeq(String? nextSeq) {
    _nextSeq = nextSeq;
  }
}

class ChatsListViewModel extends CommonNotifierModel {
  /// 聊天列表
  // List<V2TimConversation> _chatsList = [];
  // List<V2TimConversation> get chatsList => _chatsList;
  //
  // /// 设置聊天列表
  // void _setChatsList(List<V2TimConversation> values){
  //   _chatsList = values;
  //   updateState();
  // }
  //
  // /// 添加聊天列表
  // void _addChatsList(List<V2TimConversation> values){
  //   _chatsList += values;
  //   updateState();
  // }
}

/// 1.注册
/// 2.首页banner
/// 3.直播间信息
/// 4.聊天优化，
/// 5.钱包-充值提现相关
/// 6.首页搜素页面
/// 7.直播间未关注退出提示
/// 8.开直播入口
/// 9.主播详情页(与普通用户一致)
