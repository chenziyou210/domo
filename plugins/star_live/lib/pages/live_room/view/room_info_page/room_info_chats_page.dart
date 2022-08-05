/*
 *  Copyright (C), 2015-2021
 *  FileName: room_info_page
 *  Author: Tonight丶相拥
 *  Date: 2021/12/9
 *  Description: 
 **/

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/common_widget/live/admin_icon_Widget.dart';
import 'package:star_common/common/common_widget/live/guard_icon_widget.dart';
import 'package:star_common/common/common_widget/live/peerage_widget.dart';
import 'package:star_common/common/shake_widget.dart';
import 'package:star_common/common/storage.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_common/manager/app_manager.dart';
import 'package:star_common/manager/user/config_info_logic.dart';
import 'package:star_live/pages/live_room/view/room_info_page/room_live_game/room_base_game/room_base_game_state.dart';

import '/pages/live_room/view/room_info_page/room_user_info/room_user_info_view.dart';
import '../../live_room_chat_model.dart';
import '../../live_room_enum.dart';
import '../../live_room_new_logic.dart';
import 'room_live_game/room_game_bet/room_game_bet_view.dart';

/**
 * 聊天信息展示区域
 */
class MessageChatsPage extends StatefulWidget {
  MessageChatsPage(this._imController, this._scrollController, this.isAnchor,
      this.getAnchorId, this.name, this.node);

  /// 聊天控制器
  final IMModel _imController;

  /// 聊天滚动器
  final ScrollController _scrollController;

  final bool isAnchor;
  final String Function() getAnchorId;
  final String name;
  final FocusNode node;

  @override
  createState() {
    return _MessageChatsPageState();
  }
}

class _MessageChatsPageState extends AppStateBase<MessageChatsPage> with Toast {
  /// 房间控制器
  LiveRoomNewLogic get _roomController => Get.find<LiveRoomNewLogic>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _roomController.state.roomSplit.value
        ? _splitRoomInfoView()
        : Stack(
            children: [
              Column(
                children: [
                  Container(
                      height: 120.dp,
                      width: this.width,
                      child: Obx(() {
                        return ListView.separated(
                            reverse: true,
                            padding: EdgeInsets.zero,
                            controller: widget._scrollController,
                            itemBuilder: (cellContext, index) {
                              var model =
                                  widget._imController.chats.chats[index];
                              if (model.type == TextType.gift) {
                                _roomController.state.setGifNum(model.num ?? 1);
                                print("objectmodel: ${model.toString()}");
                                return Container(
                                  child: Row(children: [
                                    ListRanking(
                                        rankNum: model.contributeSort ?? 3,
                                        gifUrl: model.giftPic ?? "",
                                        gifType: model.giftype ?? 1,
                                        child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CircleAvatar(
                                                //头像半径
                                                radius: 16.dp,
                                                //头像图片 -> NetworkImage网络图片，AssetImage项目资源包图片, FileImage本地存储图片
                                                backgroundImage: NetworkImage(
                                                    model.head ?? ""),
                                              ).marginOnly(
                                                  top: 4.dp,
                                                  left: 4.dp,
                                                  bottom: 4.dp),
                                              SizedBox(width: 4.dp),
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomText(
                                                      _roomController.interception("${model.name}",4),
                                                      fontSize: 12.sp,
                                                      fontWeight: w_500,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(height: 2.dp),
                                                    CustomText(
                                                        "${model.content}",
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontSize: 10.sp,
                                                        fontWeight: w_400,
                                                        color: AppMainColors
                                                            .whiteColor70)
                                                  ]),
                                            ])),
                                    SizedBox(width: 8.dp),
                                    CustomText("X",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: w_500,
                                            color: Colors.white)),
                                    CustomText("${model.num}",
                                        style: TextStyle(
                                            fontSize: 24.sp,
                                            fontWeight: w_500,
                                            color: Colors.white))
                                  ]),
                                );
                              } else {
                                return Container(height: 0);
                              }
                            },
                            separatorBuilder: (_, __) => SizedBox(height: 0),
                            itemCount: widget._imController.chats.chats.length);
                      })),
                  body,
                ],
              ),
              Obx(() {
                return Offstage(
                    offstage: widget._imController.chats.count <= 0,
                    child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.dp, vertical: 4.dp),
                            child: CustomText("${intl.someOneMentionedMe}",
                                fontSize: 10.sp,
                                fontWeight: w_400,
                                color: Color.fromARGB(255, 233, 88, 178)))
                        .intervalButton(onTap: () {
                      var m = widget._imController.chats.chats
                          .where((p0) => p0.key != null);
                      if (m.length > 0) {
                        var m1 = m.last.key;
                        if (m1!.currentContext != null)
                          _getLocation(m1.currentContext!);
                        m.last.key = null;
                        widget._imController.subtractCount();
                      }
                    }));
              }).position(bottom: 0),
            ],
          );
  }

  //Fix bug: It's too long
  double getChatHeight() {
    double headeH = 170 + AppLayout.statusBarHeight;
    double bottomH = 30 + AppLayout.safeBarHeight;

    return ScreenUtil().screenHeight - bottomH - headeH;
  }

  @override
  Widget get body => Container(
        width: this.width,
        height: _roomController.state.roomSplit.value ? null : 200.dp,
        alignment: Alignment.bottomCenter,
        child: Obx(
          () {
            return ShaderMask(
              shaderCallback: (Rect rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black
                  ],
                  stops: [
                    0.0,
                    0.1,
                    0.95,
                    1.0,
                  ], // 10% purple, 80% transparent, 10% purple
                ).createShader(rect);
              },
              blendMode: BlendMode.dstOut,
              child: ListView.separated(
                  reverse: true,
                  padding: EdgeInsets.zero,
                  controller: widget._scrollController,
                  itemBuilder: (cellContext, index) {
                    var model = widget._imController.chats.chats[index];
                    print("chat:" + model.toString());
                    if (model.type == TextType.bootomIm) {
                      return _MessageWidget(
                        nobleLevel: model.nobleLevel ?? 0,
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                                fontWeight: w_500,
                                fontSize: 12.sp,
                                color: Colors.white),
                            children: [
                              WidgetSpan(
                                  child: Image.asset(
                                R.bqXtGfxt,
                                width: 28.dp,
                                height: 14.dp,
                                fit: BoxFit.fill,
                              )),
                              //Image.asset(AppImages.messageBet)
                              WidgetSpan(
                                child: SizedBox(width: 4.dp),
                              ),
                              TextSpan(
                                text: "${model.name}",
                                style: TextStyle(color: Color(0xFFEEFF87)),
                              ),

                              TextSpan(
                                text: "在",
                              ),

                              TextSpan(
                                text: "${model.gameName}",
                                style: TextStyle(color: Color(0xFF78FFA6)),
                              ),

                              TextSpan(
                                text: "玩法中，已成功下注了",
                              ),

                              TextSpan(
                                text: "${model.gmBet}元",
                                style: TextStyle(color: Color(0xFF78FFA6)),
                              ),
                              WidgetSpan(
                                child: SizedBox(width: 4.dp),
                              ),
                              WidgetSpan(
                                  child: Container(
                                      height: 14.dp,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: AppMainColors
                                                  .commonBtnGradient),
                                          borderRadius:
                                              BorderRadius.circular(7.dp)),
                                      padding: EdgeInsets.only(left: 4.dp),
                                      child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CustomText("${intl.getTogether}",
                                                fontSize: 10.sp,
                                                color: Colors.white),
                                            Image.asset(
                                                R.icArrowFollowBet,
                                                height: 12.dp,
                                                width: 12.dp,
                                                color: Colors.white),
                                          ])).gestureDetector(onTap: () {
                                    ///投注按钮点击事件
                                    ///
                                    final List<GameOdds> betOdds = [];
                                    betOdds.addAll(model.betInfo!);
                                    if (!widget.isAnchor &&
                                        model.betInfo != null &&
                                        betOdds.length > 0) {
                                      betOdds.forEach((element) {
                                        //重新赋值期数
                                        if (StorageService.to
                                            .getString(
                                                "issueId${element.gameId}")
                                            .isNotEmpty) {
                                          element.issueId = StorageService.to
                                              .getString(
                                                  "issueId${element.gameId}");
                                        }
                                      });
                                      Get.bottomSheet(
                                          RoomGameBetPage(
                                            odds: betOdds,
                                          ),
                                          barrierColor: Colors.transparent);
                                    }
                                  }),
                                  alignment: PlaceholderAlignment.middle)
                            ],
                          ),
                        ),
                      );
                    } else if (model.type == TextType.winLotteryMsg) {
                      return _MessageWidget(
                        nobleLevel: 2001,
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                                fontWeight: w_500,
                                fontSize: 12.sp,
                                color: Colors.white),
                            children: [
                              WidgetSpan(
                                  child: Image.asset(
                                    R.bqXtZj,
                                    width: 28.dp,
                                    height: 14.dp,
                                    fit: BoxFit.fill,
                                  ),
                                  alignment: PlaceholderAlignment.middle),
                              // Image.asset(AppImages.messageBet),

                              WidgetSpan(
                                child: SizedBox(width: 4.dp),
                              ),
                              TextSpan(
                                text: "恭喜",
                              ),

                              TextSpan(
                                text: "${model.name}",
                                style: TextStyle(color: Color(0xFFEEFF87)),
                              ),

                              TextSpan(
                                text: "在",
                              ),

                              TextSpan(
                                text: "${model.gameName}",
                                style: TextStyle(color: Color(0xFF78FFA6)),
                              ),

                              TextSpan(
                                text: ",中了",
                              ),

                              TextSpan(
                                text: "${model.gmBet}元",
                                style: TextStyle(color: Color(0xFF78FFA6)),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (model.type == TextType.initializeMessage) {
                      return _MessageWidget(
                        nobleLevel: model.nobleLevel ?? 0,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: widget.isAnchor
                                      ? "${Get.find<ConfigInfoLonic>().state.configInfo.value.sysRoomNotice?.anchorNotice}"
                                      : "${Get.find<ConfigInfoLonic>().state.configInfo.value.sysRoomNotice?.userNotice}",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: w_500,
                                      color: AppMainColors.roomNotification))
                            ],
                          ),
                        ),
                      );
                    } else if (model.type == TextType.gift) {
                      return Container();
                    }
                    Widget child = model.isFee == 1
                        ? Container()
                        : RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          UserLevelView(model.level!),
                                          PeerageWidget(model.nobleLevel, 4),
                                          GuardIconWidget(model.guardLevel, 4),
                                          AdminIconWidget(model.adminFlag),
                                          SizedBox(width: model.level!>0||model.adminFlag==1?4.dp:0),
                                          Flexible(
                                              child: CustomText("${model.name}",
                                                      softWrap: true,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight: w_500,
                                                          color: Color(
                                                              0xFFEEFF87)))
                                                  .marginOnly(right: 4.dp)),
                                        ]).gestureDetector(
                                        onTap: () => _userInfo(model))),
                                TextSpan(
                                    text:
                                        "${_getString(model.type, model.content)}",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: w_500,
                                        color: Colors.white))
                              ],
                            ),
                          );

                    /// 聊天、 关注、进入直播间
                    if (model.messageType == MessageType.reply) {
                      child = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          child,
                          SizedBox(height: 4.dp),
                          Container(
                            padding: EdgeInsets.only(left: 4.dp) +
                                EdgeInsets.symmetric(vertical: 4.dp),
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                                        width: 1,
                                        color: Color.fromARGB(
                                            255, 233, 88, 178)))),
                            child: CustomText(intl.quote,
                                fontSize: 10.sp,
                                fontWeight: w_500,
                                color: Color.fromARGB(255, 233, 88, 178)),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  color: Color.fromARGB(255, 154, 231,
                                      255), //rgba(1, 154, 231, 1)
                                  fontSize: 12.sp,
                                  fontWeight: w_500),
                              children: [
                                TextSpan(text: "${model.ex["name"]}"),
                                TextSpan(
                                    text: ":" + (model.ex["content"] ?? ""),
                                    style: TextStyle(
                                        color: Colors.white, fontWeight: w_400))
                              ],
                            ),
                          )
                        ],
                      ).marginOnly(bottom: 5);
                    }
                    return _MessageWidget(
                            child: child,
                            key: model.key,
                            nobleLevel: model.type == TextType.conversation
                                ? model.nobleLevel ?? 0
                                : 0)
                        .gestureDetector(
                      onTap: () {
                        //   if (model.type == TextType.attention) {
                        //     return;
                        //   }
                        //   if (AppManager.getInstance<AppUser>().mute == 1) {
                        //     showToast("${intl.muting}");
                        //     return;
                        //   }
                        //
                        //   if (_roomController.state.banFlag.value) {
                        //     showToast("${intl.muting}");
                        //     return;
                        //   }
                        //
                        //   var user = AppManager.getInstance<AppUser>();
                        //   if (model.userId == user.userId &&
                        //       model.userId.isNotEmpty) {}
                        //   widget.node.requestFocus();
                        //   String content = model.content;
                        //   if (model.messageType == MessageType.call) {
                        //     content = "@${model.ex["name"]}: " + content;
                        //   }
                        //   widget._imController.chats.onReply(
                        //       model.userId, model.name ?? "", model.content);
                      },
                    );
                  },
                  separatorBuilder: (_, __) => SizedBox(height: 0),
                  itemCount: widget._imController.chats.chats.length),
            );
          },
        ),
      );

  String _getString(TextType type, String defaultContent) {
    if (TextType.attention == type) {
      return intl.attentionLivingRoom;
    } else if (TextType.enterLiveRoom == type) {
      return intl.enterLivingRoom;
    }
    return defaultContent;
  }

  /// 用户信息
  void _userInfo(ChatModel model) async {
    if (model.userId == AppManager.getInstance<AppUser>().userId) {
      return;
    }

    _showUserInfo(
        int.parse(model.userId), widget.node, widget._imController.chats);
  }

  _showUserInfo(
      int userId, FocusNode node, LiveRoomChatViewModel chatViewModel) {
    Get.bottomSheet(RoomUserInfoPage(userId, widget.isAnchor),
            barrierColor: Colors.transparent)
        .then((value) {
      if (value != null) {
        if (value["event"] == "call") {
          //@TA
          Future.delayed(Duration(milliseconds: 100), () {
            node.requestFocus();
          });
          chatViewModel.onCall(value["id"], value["userName"]);
        }
      }
    });
  }

  void _getLocation(BuildContext cellContext) {
    RenderBox box = cellContext.findRenderObject() as RenderBox;
    var x =
        box.localToGlobal(Offset.zero, ancestor: context.findRenderObject()) &
            box.size;
    double offset = x.top;
    if (x.top < 0) offset = -offset;
    widget._scrollController.animateTo(offset + widget._scrollController.offset,
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  _splitRoomInfoView() {
    return Stack(
      children: [body],
    );
  }
}

/**
 * 公聊皮肤，进入直播间和关注直播间
 * nobleLevel >1004,表示贵族。2001是中奖的皮肤。nobleLevel < 1004,表示普通皮肤
 */
class _MessageWidget extends StatelessWidget {
  _MessageWidget({required this.child, this.key, required this.nobleLevel});

  final Widget child;
  final GlobalKey? key;
  final int nobleLevel;

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
        child: Align(
                // key: key,
                alignment: Alignment.centerLeft,
                child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: nobleLevel > 1004
                                ? nobleLevel == 2001
                                    ? AppMainColors.winningSkin
                                    : AppMainColors.ChatSkin
                                : AppMainColors.normalSkin),
                        border: Border.all(
                          color: nobleLevel > 1004
                              ? nobleLevel == 2001
                                  ? AppMainColors.winningPushColor
                                  : AppMainColors.chatSkinborderColor
                              : Colors.transparent,
                          width: 1.dp,
                        ),
                        borderRadius: BorderRadius.circular(12.dp)),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.67),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.dp, vertical: 2.dp),
                    child: child))
            .marginOnly(bottom: 5.dp),
        key: key);
  }
}

///送礼物左侧效果。
class ListRanking extends StatelessWidget {
  ListRanking(
      {required this.child, required this.rankNum, required this.gifUrl, required this.gifType});

  final Widget child;
  final int rankNum;
  final String gifUrl;
  final int gifType;

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
        child: Container(
            child: Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            Row(
              children: [
                Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: [
                    Image.asset(
                        rankNum == 0
                            ? R.rankingOne
                            : rankNum == 1
                                ? R.rankingTwo
                                : rankNum == 2
                                    ? R.rankingThree
                                    : R.rankingList,
                        width: 130.dp,
                        height: 40.dp),
                    child
                  ],
                ),
                Container(
                  width: 18.dp,
                )
              ],
            ),
            gifType==4?
            Shake(
              key: Key('${DateTime.now().microsecond}'),
              enable: true,
              child: ExtendedImage.network(gifUrl,
                  width: 48.dp, height: 48.dp, fit: BoxFit.fill),
            ):ExtendedImage.network(gifUrl,
                width: 48.dp, height: 48.dp, fit: BoxFit.fill),
          ],
        )).marginOnly(bottom: 5.dp),
        key: key);
  }
}