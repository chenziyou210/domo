/*
 *  Copyright (C), 2015-2021
 *  FileName: conversation_model
 *  Author: Tonight丶相拥
 *  Date: 2021/9/29
 *  Description: 
 **/

// import 'package:star_common/base/app_base.dart';
// import 'package:star_common/http/http_channel.dart';
// import 'package:star_common/manager/app_manager.dart';
// import 'package:tencent_im_sdk_plugin/enum/V2TimAdvancedMsgListener.dart';
// import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';
// import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';
// // import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';
//
// class V2TimMessageCustom extends V2TimMessage{
//   V2TimMessageCustom(): super(elemType: -1);
//   bool showTimeSpan = false;
//   V2TimMessageCustom.fromJson(Map<String, dynamic> json)
//       : super.fromJson(json);
// }
//
// class ConversationModel extends AppModel {
//   ConversationModel(bool isFollowed, {required String id,
//     required String conversationId})
//       : viewModel = ConversationViewModel(isFollowed),
//         this._id = id,
//         this._conversationId = conversationId {
//     _v2Tim.getMessageManager().addAdvancedMsgListener(
//         listener: V2TimAdvancedMsgListener(
//           onRecvNewMessage: (message) {
//             var m = V2TimMessageCustom.fromJson(message.toJson());
//             viewModel._sendMessage(m);
//           },
//           onSendMessageProgress: (message, value){
//             var m = V2TimMessageCustom.fromJson(message.toJson());
//             viewModel._sendMessage(m);
//             print("$value ---  message id is ${message.msgID}");
//           }
//         ));
//     _getConversion();
//   }
//
//   late final ConversationViewModel viewModel;
//
//   /// userId
//   final String _id;
//
//   /// 聊天id
//   final String _conversationId;
//
//   /// 最后一条消息
//   String? get _msgId => viewModel._list.length == 0 ? null : viewModel._list.first.msgID;
//
//   /// 管理
//   var _v2Tim = TencentImSDKPlugin.v2TIMManager;
//
//   /// 设置已关注
//   void followed(String id) async{
//     show();
//     HttpChannel.channel.favoriteInsert(id)
//       ..then((value) => value.finalize(
//           wrapper: WrapperModel(),
//         success: (_) {
//           dismiss();
//           viewModel._setIsFollowed();
//         },
//         failure: (e) => showToast(e)
//       ));
//   }
//
//   /// 获取聊天记录
//   Future<void> _getConversion() async {
//     loadMoreMessage();
//   }
//
//   /// 加载更多消息
//   Future<void> loadMoreMessage() async{
//     var listRes = await _v2Tim.getMessageManager()
//         .getC2CHistoryMessageList(
//         userId: this._id,
//         count: 20,
//         lastMsgID: _msgId
//     );
//     if (listRes.code == 0) {
//       List<V2TimMessage> list = listRes.data!;
//       if (list.length == 0) {
//         list = List.empty(growable: true);
//       }
//       var l = list.map((e) => V2TimMessageCustom.fromJson(e.toJson())).toList();
//       l.sort((left, right) => left.timestamp!.compareTo(right.timestamp!));
//       viewModel._setMessage(l);
//     } else {
//       print('conversationID 获取历史消息失败 ${listRes.desc}');
//     }
//     return;
//   }
//
//   void dispose(){
//     _v2Tim.getMessageManager().removeAdvancedMsgListener();
//   }
//
//   /// 发送消息
//   void sendTextMessage(String content) async{
//     var result = await _v2Tim.sendC2CTextMessage(text: content, userId: _id);
//     if (result.code == 0) {
//       var m = V2TimMessageCustom.fromJson(result.data!.toJson());
//       viewModel._sendMessage(m);
//     } else {
//       showToast("send Message error");
//     }
//   }
//
//   /// 发送图片消息
//   void sendImageMessage(String path) async{
//     var result = await _v2Tim.getMessageManager().sendImageMessage(imagePath: path,
//         receiver: _id,
//         groupID: "");
//     if (result.code == 0) {
//       var m = V2TimMessageCustom.fromJson(result.data!.toJson());
//       viewModel._sendMessage(m);
//     } else {
//       showToast("send Message error");
//     }
//   }
// }
//
// class ConversationViewModel extends CommonNotifierModel {
//   ConversationViewModel(this._isFollowed);
//
//   /// 是否关注
//   bool _isFollowed;
//   bool get isFollowed => _isFollowed;
//
//   /// 消息列表
//   List<V2TimMessageCustom> _list = [];
//   List<V2TimMessageCustom> get messageList => _list;
//
//   /// 设置关注
//   void _setIsFollowed(){
//     _isFollowed = true;
//     AppManager.getInstance<AppUser>().addAttention();
//     updateState();
//   }
//
//   void _setMessage(List<V2TimMessageCustom> list){
//     this._list += list;
//     _sortList();
//     updateState();
//   }
//
//   void _sendMessage(V2TimMessageCustom message){
//     this._list.removeWhere((element) => element.msgID == message.msgID);
//     this._list = this._list + [message];
//     _sortList();
//     updateState();
//   }
//
//   void _sortList(){
//     int? timeSpan;
//     this._list.forEach((element) {
//       if (timeSpan == null || element.timestamp! >= timeSpan! + 5 * 60) {
//         element.showTimeSpan = true;
//         timeSpan = element.timestamp;
//       }else {
//         element.showTimeSpan = false;
//       }
//     });
//     // this._list.sort((left, right) => left.timestamp!.compareTo(right.timestamp!));
//   }
// }

/**
 * 1： 单聊
 * 2： 群聊
 *
    // group
    TencentImSDKPlugin.v2TIMManager
    .getMessageManager()
    .getGroupHistoryMessageList(
    groupID: _groupID == null ? "" : _groupID,
    count: 20,
    lastMsgID: _msgID
    )
    .then((listRes) {
    if (listRes.code == 0) {
    print(
    "conversationID listRes.data ${listRes.data!.length} $_groupID ");
    List<V2TimMessage> list = listRes.data!;
    if (list.length == 0) {
    print('conversationID 没有消息啊！！！');
    list = List.empty(growable: true);
    } else {
    // Provider.of<CurrentMessageListModel>(context, listen: false)
    //     .addMessage(conversationID, list);
    }
    // print("conversationID $conversationID 消息数量 ${listRes.data!.length}");
    } else {
    print('conversationID 获取历史消息失败');
    }
    }); */
