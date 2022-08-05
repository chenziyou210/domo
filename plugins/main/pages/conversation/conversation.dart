/*
 *  Copyright (C), 2015-2021
 *  FileName: conversation
 *  Author: Tonight丶相拥
 *  Date: 2021/9/28
 *  Description: 
 **/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';

const String _url =
    "https://img2.baidu.com/it/u=1077360284,2857506492&fm=26&fmt=auto&gp=0.jpg";

class ConversationPage extends StatefulWidget {
  ConversationPage({dynamic arguments})
      : this.name = arguments["name"],
        this.id = arguments["id"],
        this.isFollowed = arguments["isFollowed"] ?? false;

  @override
  createState() => _ConversationPageState(id);
  final String name;
  final String id;
  final bool isFollowed;
}

class _ConversationPageState extends AppStateBase<ConversationPage> {
  /// c2c_userId，如果是群聊，组成方式为 group_groupID
  _ConversationPageState(String id) : this.id = "c2c_" + id;

  final String id;

  /// 滚动控制器
  final ScrollController _scroll = ScrollController();

  /// 输入控制器
  final TextEditingController _textController = TextEditingController();

  @override
  // TODO: implement appBar
  PreferredSizeWidget? get appBar =>
      DefaultAppBar(title: Text(widget.name, style: AppStyles.f17w400c0_0_0));

  @override
  // TODO: implement bodyColor
  Color? get bodyColor => AppColors.c243_243_243;

//   @override
//   // TODO: implement scaffold
//   Widget get scaffold => ChangeNotifierProvider.value(value: model.viewModel,
//       child: super.scaffold);
//
//   @override
//   // TODO: implement body
//   Widget get body => Container(
//     child: Column(
//       children: [
//         SelectorCustom<ConversationViewModel, bool>(
//             builder: (value) {
//               return Offstage(
//                   offstage: value,
//                   child: Container(
//                       height: 54,
//                       color: AppColors.c165_59_227.withOpacity(0.1),
//                       padding: EdgeInsets.symmetric(horizontal: 14),
//                       child: Row(
//                           children: [
//                             Expanded(child: Text(intl.followEachOtherToBecomeFriends,
//                                 style: AppStyles.f14w500c165_59_227)),
//                             SizedBox(width: 8),
//                             GestureDetector(
//                                 onTap: (){
//                                   model.followed(widget.id);
//                                 },
//                                 child: Container(
//                                   height: 28,
//                                   width: 64.5,
//                                   alignment: Alignment.center,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(14),
//                                       gradient: LinearGradient(colors: [
//                                         AppColors.c184_58_243,
//                                         AppColors.c105_80_251
//                                       ])
//                                   ),
//                                   child: Text(intl.follow, style: AppStyles.f14w500c255_255_255),
//                                 )
//                             )
//                           ]
//                       )
//                   )
//               );
//             },
//             selector: (c) => c.isFollowed),
//         Expanded(child: ConversationRefreshWidget(
//             scrollController: _scroll,
//             primary: false,
//             onRefresh: (c) async{
//               await model.loadMoreMessage();
//               c.refreshCompleted();
//             },
//             children: [
//               SliverExpanded(),
//               SelectorCustom<ConversationViewModel, List<V2TimMessageCustom>>(
//                 builder: (messages) {
//                   return SliverList(
//                       delegate: SliverChildBuilderDelegate((context, index) {
//                         var message = messages[index];
//                         return _Message(message);
//                       }, childCount: messages.length)
//                   );
//                 },
//                 selector: (c) => c.messageList)
//             ]
//         )),
//         Container(
//           // height: 52,
//           color: Colors.white,
//           padding: EdgeInsets.symmetric(
//             horizontal: 14,
//             vertical: 20
//           ),
//           child: Row(
//             children: [
//               GestureDetector(
//                 onTap: (){
//                   showCupertinoModalPopup(context: context, builder: (_) {
//                     return CupertinoActionSheet(
//                         cancelButton: CupertinoActionSheetAction(
//                             onPressed: (){
//                               popViewController();
//                             },
//                             child: Text(intl.cancel)),
//                         actions: [
//                           CupertinoActionSheetAction(
//                               onPressed: () {
//                                 popViewController(intl.gallery);
//                               },
//                               child: Text(intl.gallery)),
//                           CupertinoActionSheetAction(
//                               onPressed: (){
//                                 popViewController(intl.camera);
//                               },
//                               child: Text(intl.camera))
//                         ]
//                     );
//                   }).then((value) async{
//                     if (value != null) {
//                       XFile? xFile;
//                       if (value == intl.gallery) {
//                         var result = await Permission.photos.request();
//                         if (!result.isGranted)
//                           return;
//                         xFile =  await ImagePicker().pickImage(source: ImageSource.gallery);
//                       }else if (value == intl.camera) {
//                         var result = await Permission.camera.request();
//                         if (!result.isGranted)
//                           return;
//                         xFile =  await ImagePicker().pickImage(source: ImageSource.camera);
//                       }
//                       if (xFile != null) {
//                         model.sendImageMessage(xFile.path);
//                       }
//                     }
//                   });
//                 },
//                 child: Image.asset(AppImages.function_more)
//               ),
//               SizedBox(width: 8),
//               Expanded(
//                 child: Container(
//                   height: 36,
//                   decoration: BoxDecoration(
//                     color: AppColors.c239_239_239,
//                     borderRadius: BorderRadius.circular(18)
//                   ),
//                   child: CustomTextField(
//                     controller: _textController,
//                     textAlignVertical: TextAlignVertical.top,
//                     submit: (text) {
//                       _sendText(text);
//                     },
//                     textInputAction: TextInputAction.send
//                   )
//                 )
//               ),
//               SizedBox(width: 8),
//               GestureDetector(
//                 onTap: (){
//                   _sendText(_textController.text);
//                 },
//                 child: Image.asset(AppImages.send),
//               )
//             ]
//           )
//         )
//       ]
//     )
//   );
//
//   /// 发送消息
//   void _sendText(String text){
//     if (text.isEmpty) {
//       return;
//     }
//     _textController.clear();
//     model.sendTextMessage(text);
//   }
//
//   @override
//   AppModel? initializeModel() {
//     // TODO: implement initializeModel
//     return ConversationModel(widget.isFollowed,
//         id: widget.id,
//         conversationId: id);
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     model.dispose();
//   }
//
//   @override
//   // TODO: implement model
//   ConversationModel get model => super.model as ConversationModel;
// }
//
// class _TextMessageLeft extends StatelessWidget {
//   _TextMessageLeft(this.content);
//   final Radius _radius = Radius.circular(12);
//   final String content;
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     var size = MediaQuery.of(context).size;
//     return Container(
//         constraints: BoxConstraints(
//             maxWidth: size.width * 0.6,
//             minWidth: 0,
//             minHeight: 50
//         ),
//         child: Container(
//           // alignment: Alignment.centerLeft,
//             padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(content, style: AppStyles.f16w400c0_0_0)
//                 ]
//             ),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                     bottomLeft: _radius,
//                     bottomRight: _radius,
//                     topRight: _radius
//                 ),
//                 color: Colors.white
//             )
//         )
//     );
//   }
// }
//
// class _TextMessageRight extends StatelessWidget {
//   _TextMessageRight(this.content);
//   final Radius _radius = Radius.circular(12);
//   final String content;
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     var size = MediaQuery.of(context).size;
//     return Container(
//         constraints: BoxConstraints(
//             maxWidth: size.width * 0.6,
//             minWidth: 20,
//             minHeight: 50
//         ),
//         child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                     bottomLeft: _radius,
//                     topLeft: _radius,
//                     bottomRight: _radius
//                 ),
//                 color: AppColors.cMessageBackground,
//                 gradient: LinearGradient(colors: [
//                   AppColors.cMessageLeft,
//                   AppColors.cMessageRight])
//             ),
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(content, style: AppStyles.f16w400c255_255_255)
//                 ]
//             )
//         )
//     );
//   }
// }
//
// class _Avatar extends StatelessWidget {
//   _Avatar(this.url);
//   final String url;
//   final double _sizeWidth = 36;
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(_sizeWidth / 2),
//       child: ExtendedImage.network(_url,
//           enableLoadState: false,
//           width: _sizeWidth,
//           height: _sizeWidth,
//           fit: BoxFit.cover)
//     );
//   }
// }
//
// class _MessageLeft extends StatelessWidget {
//   _MessageLeft(this.message);
//   final V2TimMessage message;
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     Widget child = SizedBox();
//     if (message.elemType == MessageElemType.V2TIM_ELEM_TYPE_TEXT) {
//       child = _TextMessageLeft(message.textElem!.text!);
//     }else if (message.elemType == MessageElemType.V2TIM_ELEM_TYPE_IMAGE){
//       child = _ImageMessage(message);
//     }
//     return Container(
//         margin: EdgeInsets.symmetric(vertical: 10),
//         child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _Avatar(message.faceUrl ?? _url),
//               SizedBox(width: 10),
//               child
//             ]
//         )
//     );
//   }
// }
//
// class _MessageRight extends StatelessWidget {
//   _MessageRight(this.message);
//   final V2TimMessage message;
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     Widget child = SizedBox();
//     if (message.elemType == MessageElemType.V2TIM_ELEM_TYPE_TEXT) {
//       child = _TextMessageRight(message.textElem!.text!);
//     }else if (message.elemType == MessageElemType.V2TIM_ELEM_TYPE_IMAGE){
//       child = _ImageMessage(message);
//     }
//     return Container(
//         margin: EdgeInsets.symmetric(vertical: 10),
//         child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               // Spacer(),
//               child,
//               SizedBox(width: 10),
//               _Avatar(message.faceUrl ?? _url)
//             ]
//         )
//     );
//   }
// }
//
// class _Message extends StatelessWidget {
//   _Message(this._message);
//   final V2TimMessageCustom _message;
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     Widget widget = Container();
//     if (_message.isSelf!) {
//       widget = _MessageRight(_message);
//     }else {
//       widget = _MessageLeft(_message);
//     }
//
//     if (_message.showTimeSpan) {// _message.showTimeSpan
//       widget = Column(
//         children: [
//           SizedBox(height: 10),
//           Row(
//             children: [
//               Expanded(
//                   child: Text(
//                     _getMessageTime(),
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 10,
//                       color: Colors.black87,
//                       height: 1.6,
//                     ),
//                   ))
//             ],
//           ),
//           widget
//         ]
//       );
//     }
//     return widget;
//   }
//
//   String _getMessageTime() {
//     String time = '';
//     int timestamp = _message.timestamp! * 1000;
//     DateTime timeDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
//     DateTime now = DateTime.now();
//
//     if (now.day == timeDate.day) {
//       time =
//       "${timeDate.hour.toString().padLeft(2, '0')}:${timeDate.minute.toString().padLeft(2, '0')}:${timeDate.second.toString().padLeft(2, '0')}";
//     } else {
//       time =
//       "${timeDate.month.toString().padLeft(2, '0')}-${timeDate.day.toString().padLeft(2, '0')} ${timeDate.hour.toString().padLeft(2, '0')}:${timeDate.minute.toString().padLeft(2, '0')}:${timeDate.second.toString().padLeft(2, '0')}";
//     }
//     return time;
//   }
// }
//
// class _ImageMessage extends StatefulWidget {
//   _ImageMessage(this.message);
//   final V2TimMessage message;
//   @override
//   createState() => _ImageMessageState();
// }
//
// class _ImageMessageState extends State<_ImageMessage> {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Column(
//       children: widget.message.imageElem!.imageList!.map(
//             (e) {
//           if (e!.type == 2) {
//             if (e.url != null) {
//               return ExtendedImage.network(
//                   e.url!,
//                 enableLoadState: false
//               );
//             } else {
//               return Image.file(new File(widget.message.imageElem!.path!));
//             }
//           } else {
//             return Container();
//           }
//         },
//       ).toList(),
//     );
//   }
}
