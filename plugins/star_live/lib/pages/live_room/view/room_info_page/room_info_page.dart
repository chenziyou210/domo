/*
 *  Copyright (C), 2015-2021
 *  FileName: room_info_page
 *  Author: Tonight丶相拥
 *  Date: 2021/12/9
 *  Description: 
 **/

import 'dart:async';

import 'package:alog/alog.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/common_widget/app_dialog.dart';
import 'package:star_common/common/common_widget/live/anchor_card.dart';
import 'package:star_common/common/common_widget/live/danmu_widget.dart';
import 'package:star_common/common/flutter_advanced_switch.dart';
import 'package:star_common/common/storage.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_common/generated/LiveRoomInfoEntity.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/manager/app_manager.dart';
import 'package:star_common/manager/user/config_info_logic.dart';
import 'package:star_common/manager/user/user_balance_logic.dart';
import 'package:star_common/util_tool/stringutils.dart';
import 'package:star_live/pages/alert_widget/live_alert.dart';
import 'package:star_live/pages/live/barrage/barrage.dart';
import 'package:star_live/pages/live_room/view/room_info_page/room_live_game/room_base_game/room_base_game_view.dart';
import 'package:star_live/pages/live_room/view/room_info_page/room_live_game/room_live_game_logic.dart';
import 'package:star_live/pages/live_room/view/room_info_page/room_live_game/room_live_game_state.dart';

import '/pages/live_room/view/online_view/audience_online_view.dart';
import '/pages/live_room/view/room_info_page/room_info_chats_page.dart';
import '/pages/live_room/view/room_info_page/room_live_game/game_net_work.dart';
import '/pages/live_room/view/room_info_page/room_live_game/room_live_game_view.dart';
import '../../../../star_live.dart';
import '../../../contribution_list/contribution_rank.dart';
import '../../../recharge/recharge/recharge_view.dart';
import '../../live_room_chat_model.dart';
import '../../live_room_enum.dart';
import '../../live_room_new_logic.dart';
import '../../mine_backpack/mine_backpack_logic.dart';
import '../charge_view/charge_view.dart';
import '../gift_card/gift_card.dart';
import '../gift_package_view/gift_package_view.dart';
import '../guide_view/guide_widget.dart';
import '../svga/SVAGPlayer.dart';
import 'room_user_info/room_user_info_view.dart';

class RoomInfoPage extends StatefulWidget {
  RoomInfoPage(this.imController,
      {this.imRoomId = "",
      required this.roomId,
      required this.player,
      required this.onTap});

  final String imRoomId;
  final ValueChanged<String> onTap;
  final String Function() roomId;
  final IMModel imController;
  final SVGAPlayer player;
  late _RoomInfoPage page;

  @override
  State createState() {
    page = _RoomInfoPage();
    return page;
  }
}

VoidCallback? controllEventBack;
RoomInfoPage? controllWidget;

class _RoomInfoPage extends AppStateBase<RoomInfoPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin, Toast {
  /// 房间控制器
  LiveRoomNewLogic get _roomController => Get.find<LiveRoomNewLogic>();
  final _barrageController = ValueNotifier<bool>(false);

  /// Determines current state.
  late Function(bool)? callBackbarrageController;

  /// 聊天滚动器
  final ScrollController _scrollController = ScrollController();

  /// 房间信息
  LiveRoomInfoEntity? get _roomModel => _roomController.state.roomInfo.value;

  /// 节点
  final FocusNode _node = FocusNode();
  final TextEditingController _textController = TextEditingController();

  /// 主播id
  String? get _roomId =>
      _roomController.state.rooms[_roomController.state.roomIndex.value].id;

  final myBackpackLogic = Get.find<MineBackpackLogic>();

  var _barrageKey;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  bool _isDisposed = false;

  double _widthAndHeight = 80;

  RxInt _count = 30.obs;

  int gifId = 1;
  int gifType = 1;
  int gifNumber = 0;
  int gifComboCount = 0;
  int _bufferGiftNum = 0;


  var resubscribe;
  late StreamSubscription<bool> keyboardSubscription;

  @override
  void initState() {
    super.initState();
    controllWidget = widget;
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      print('Neo keyboard : $visible');
      _roomController.state.keyboardShow.value = visible;
    });

    _roomController.setupAnimToastLuck(this);
    callBackbarrageController = (v) {
      print('NEO callBackbarrageController: $v');
      _barrageController.value = v;
    };
    widget.imController.setUp(_scrollToTop, (value) {
      _roomController.setCoins(value);
    });
    _roomController.callBackView = (payload) {
      Future.delayed(Duration(milliseconds: 100), () {
        alertLevelUp(
            context: context,
            num: payload["uRank"],
            content: "恭喜您用户等级提升至Lv${payload["uRank"]}");
      });
    };

    _roomController.danmuBackView = (e) {
      Future.delayed(Duration(milliseconds: 100), () {
        this.widget.imController.chats.onFocus();
        _barrageController.value = true;
        _node.requestFocus();
      });
    };

    _node.addListener(_textFiledState);
    _barrageController.addListener(() {
      Alog.e("danmu:${_barrageController.value} ${getHintText()}",
          tag: "danmuController");
      getHintText();
    });
    myBackpackLogic.loadPackageList();
    _barrageKey = GlobalKey<BarrageState>();
    WidgetsBinding.instance.addPostFrameCallback(_addListener);

    var lastCloseDate = StorageService.to.getString("closetime");
    if (lastCloseDate.isNotEmpty &&
        DateTime.now().day == int.parse(lastCloseDate)) {
      _roomController.todayHasClose = true;
    } else {
      //第二天或者说第一次还没存储时间
      _roomController.todayHasClose = false;
    }
    _roomController.countdown(() {
      showFirstRechargeAward(context);
    });
    _roomController.startLotteryCountdown();
  }



  void startTrySeeCountdown() {
    _roomController.trySeetimer?.cancel();
    _roomController.trySeetimer = Timer.periodic(Duration(seconds: 1), (_) {
      if (_isDisposed) return;
      _roomController.state.trySecs.value--;
      if (_roomController.state.trySecs.value <= 0) {
        _roomController.trySeetimer?.cancel();
        _roomController.state.setShowPayPopup(true);
        return;
      }
    });
  }

  void startCountdown() {
    if (!widget.imController.chats.isBatter.value) {
      widget.imController.chats.setIsBatter(true);
      _count.value = 30;
      _roomController.roomTimer?.cancel();
      _roomController.roomTimer = Timer.periodic(Duration(seconds: 1), (_) {
        if (_count.value <= 0 || !widget.imController.chats.isBatter.value) {
          stopCountdown();
          return;
        }
        _count.value--;
      });
    }
  }

  void stopCountdown() {
    _roomController.roomTimer?.cancel();
    widget.imController.chats.setIsBatter(false);
    gifComboCount = 0;
    _count.value = 0;
    _roomController.roomTimer = null;
  }

  void _addListener(_) {
    widget.imController.intl = intl;
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(0,
          duration: Duration(milliseconds: 100), curve: Curves.easeIn);
    }
  }

  void _textFiledState() {
    if (_node.hasFocus) {
      widget.imController.chats.onFocus();
    } else {
      widget.imController.chats.unFocus();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _isDisposed = true;
    keyboardSubscription.cancel();
    _node.removeListener(_textFiledState);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      key: Key("D"),
      children: [
        Padding(
          padding: EdgeInsets.only(top: AppLayout.statusBarHeight),
          child: body,
        ),
        Obx(() {
          return _roomController.state.roomInfo.value.isNameCardOpen == 1 &&
                  !_roomController.state.roomSplit.value
              ? Positioned(
                  top: 140.dp,
                  right: 4.dp,
                  child: Container(
                    child: Image.asset(R.icAnchorCard),
                    width: 88.dp,
                    height: 88.dp,
                  ).gestureDetector(onTap: () {
                    show();
                    HttpChannel.channel.getNameCard(
                        "${Get.find<LiveRoomNewLogic>().state.roomInfo.value.roomId}")
                      ..then(
                        (value) => value.finalize(
                            wrapper: WrapperModel(),
                            success: (data) {
                              dismiss();
                              AnchorCardInfo info =
                                  AnchorCardInfo.fromJson(data);
                              alertViewController(AnchorCard(_roomModel!, info),
                                  barrierDismissible: true, context: context);
                            },
                            failure: (e) {
                              dismiss();
                              showToast(e);
                            }),
                      );
                    // return completer.future;
                  }))
              : Container();
        }),
        Container(child: widget.player),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(
                top: AppLayout.statusBarHeight + 100.dp,
                left: 16.dp,
                right: 16.dp),
            child: Container(
              child: Obx(() {
                if (widget.imController.chats.playState.value == -1) {
                  return Container();
                }

                if (widget.imController.chats.danmu.isNotEmpty) {
                  if (_roomController.state.topBarrage == 0) {
                    _roomController.state.topBarrage = 60;
                  } else {
                    _roomController.state.topBarrage = 0;
                  }
                  print(
                      'NEO   _roomController.state.topBarrage: ${_roomController.state.topBarrage}');
                }
                print(
                    'NEO   here: ${widget.imController.chats.danmu.isNotEmpty}');
                while (widget.imController.chats.danmu.isNotEmpty) {
                  ChatModel chat = widget.imController.chats.danmu.removeLast();
                  Alog.e(chat.toString(), tag: "chat11");
                  print('NEO   here1: ${_roomController.state.topBarrage}');
                  _barrageKey.currentState?.addBarrage(DanmuWidget(
                      chat.head,
                      chat.name,
                      chat.nobleLevel,
                      chat.level,
                      chat.adminFlag,
                      chat.guardLevel,
                      chat.content));
                }
                return Wrap(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 120.dp,
                      child: Barrage(
                        top: _roomController.state.topBarrage.dp,
                        key: _barrageKey,
                        showCount: 1,
                        randomOffset: 0,
                      ),
                    )
                  ],
                );
              }),
            ),
          ),
        ),
        Positioned(
          child: Obx(() {
            if (widget.imController.chats.isOnFocus.value) {
              Widget child = CustomTextField(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8.dp, vertical: 8.dp),
                node: _node,
                hintText: widget.imController.chats.hintText.value,
                textInputAction: TextInputAction.send,
                controller: _textController,
                maxLength: _barrageController.value ? 15 : 50,
                textAlignVertical: TextAlignVertical.bottom,
                fillColor: Colors.white.withOpacity(0.10),
                submit: (text) {
                  if (text.isEmpty) {
                    unFocus();
                    widget.imController.chats.unFocus();
                    return;
                  }
                  sendText("${widget.imController.headMessage} $text");
                  widget.imController.chats.unFocus();
                  unFocus();
                  _textController.clear();
                },
                hintTextStyle: TextStyle(
                    fontWeight: w_400,
                    color: Colors.white.withOpacity(0.70),
                    fontSize: 12.sp),
                style: TextStyle(
                    fontWeight: w_400, color: Colors.white, fontSize: 12.sp),
              );
              return Obx(() {
                var v = widget.imController.chats.messageState.value;
                var type = v.type;
                if (v.ex != null) {
                  widget.imController.headMessage = "@${v.ex["name"]}";
                }
                if (type == MessageType.call) {
                  child = Row(children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 8),
                        child: CustomText("@${v.ex["name"]}",
                            fontSize: 12, color: Colors.white)),
                    child.expanded()
                  ]).clipRRect(radius: BorderRadius.circular(0));
                } else if (type == MessageType.reply) {
                  child = Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        child,
                        SizedBox(height: 8),
                        CustomText("${v.ex["name"]}: ${v.ex["content"]}",
                            fontSize: 12, color: Colors.white)
                      ]);
                } else {
                  child = child;
                }
                return AnimatedPadding(
                    padding: MediaQuery.of(context).viewInsets,
                    duration: Duration(milliseconds: 100),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 6, 8, 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white.withOpacity(0.10),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              AdvancedSwitch(
                                callBack: callBackbarrageController,
                                width: 40.dp,
                                height: 22.dp,
                                activeImage:
                                    AssetImage(R.icSwitchDanmuOn),
                                inactiveImage:
                                    AssetImage(R.icSwitchDanmuOff),
                              ),
                              child.expanded(),
                            ],
                          ),
                        ).expanded(),
                        Container(
                                padding: EdgeInsets.fromLTRB(14, 4, 14, 4),
                                height: 32.dp,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.dp),
                                    gradient: LinearGradient(
                                        colors:
                                            AppMainColors.commonBtnGradient)),
                                child: CustomText("发送",
                                    fontSize: 12.sp, color: Colors.white))
                            .gestureDetector(onTap: () {
                          if (_textController.text.isEmpty) {
                            unFocus();
                            widget.imController.chats.unFocus();
                            return;
                          } else {
                            sendText(
                              "${widget.imController.headMessage} ${_textController.text}",
                            );
                            widget.imController.chats.unFocus();
                            unFocus();
                            _textController.clear();
                          }
                        }),
                        SizedBox(width: 12),
                      ],
                    ).container(
                      color: AppMainColors.blickColor90,
                    ));
              });
            }
            return SizedBox.shrink();
          }),
          bottom: 0,
          left: 0,
          right: 0,
        ),
        if (!_roomController.state.roomSplit.value &&
            !_roomController.state.keyboardShow.value)
          Positioned(
            bottom: 180 + AppLayout.safeBarHeight,
            right: 16,
            child: Obx(() {
              if (_roomController.state.roomInfo.value.roomType == 4 &&
                  _roomController.state.autoShowGame) {
                _roomController.state.autoShowGame = false;
                Future.delayed(Duration(milliseconds: 200), () {
                  _showGame();
                });
              }
              return  _roomController.state.roomInfo.value.gameId!= null &&  !_roomController.state.roomSplit.value
                  ? Column(
                      children: [
                        Image.asset(
                            _roomController.gameMap[
                                _roomController.state.roomInfo.value.gameId],
                            width: 56.dp,
                            height: 56.dp,
                            fit: BoxFit.fill),
                        SizedBox(height: 6.dp,),
                        CustomText(
                            _roomController.lotteryCount.value > 9
                                ? "00:${_roomController.lotteryCount.value}"
                                : _roomController.lotteryCount.value > 5
                                ? "00:0${_roomController.lotteryCount.value}"
                                : "开奖中",
                            fontSize: 12.dp,
                            fontWeight: w_500,
                            color: Colors.white),
                      ],
                    ).gestureDetector(onTap: () {
                      _showGame();
                    })
                  : Container();
            }),
          ),
        Positioned(
          child: Obx(() {
            var isBatter = widget.imController.chats.isBatter.value;
            if (!_roomController.state.roomSplit.value  && isBatter) {
              return Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    child: Container(
                      width: _widthAndHeight,
                      height: _widthAndHeight,
                      decoration: BoxDecoration(
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(R.zbjBatter),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText("${_count.value}s",
                              fontSize: 12, color: AppMainColors.whiteColor70),
                          SizedBox(height: 6),
                          CustomText("礼物连击", fontSize: 12, color: Colors.white),
                          SizedBox(height: 6),
                        ],
                      ),
                    ).gestureDetector(onTap: () {
                      setState(() {
                        _widthAndHeight = 70;
                      });
                      const timeout = const Duration(milliseconds: 200);
                      Timer(timeout, () {
                        setState(() {
                          _widthAndHeight = 80;
                        });
                        if (_count.value == 0) {
                          return;
                        }
                        sendGift(context);
                      });
                    })),
              );
            } else {
              Future.delayed(Duration(milliseconds: 200), () {
                stopCountdown();
              });
              return Container();
            }
          }),
          bottom: 40 + AppLayout.safeBarHeight,
          right: 6,
        ),
      ],
    );
  }

  void sendText(String msg) {
    int rank = AppManager.getInstance<AppUser>().rank ?? 0;
    if (rank <
        int.parse(
            "${Get.find<ConfigInfoLonic>().state.configInfo.value.sysRoomSpeaking?.sysRoomSpeaking}")) {
      showToast(
          "达到等级Lv${Get.find<ConfigInfoLonic>().state.configInfo.value.sysRoomSpeaking?.sysRoomSpeaking}才可发言");
      return;
    }

    if (AppManager.getInstance<AppUser>().mute == 1) {
      showToast("您已被禁言");
      return;
    }

    if (_roomController.state.banFlag.value) {
      showToast("您已被禁言");
      return;
    }

    if (!_barrageController.value) {
      widget.imController.sendText(msg, isDanmu: _barrageController.value);

      return;
    }

    if (myBackpackLogic.hasHorn() > 0) {
      myBackpackLogic.bagUseItem(3001, 1, () {
        widget.imController.sendText(msg, isDanmu: _barrageController.value);
      });
    } else {
      myBackpackLogic.sendScreenMsg(0, _textController.text, _roomId, () {
        widget.imController.sendText(msg, isDanmu: _barrageController.value);
      });
    }
  }

//到游戏界面
  showGame(RoomLiveGameList data, Widget controlWidget, Widget chatBox,
      Widget chatWidget) {
    bottomSheetCallBack?.call(true);
    Get.bottomSheet(
            RoomBaseGamePage(
              data: data,
              controlWidget: controlWidget,
              chatWidget: chatWidget,
              chatBox: chatBox,
              roomId: StorageService.to.getString("roomId"),
              isAnchor: false,
              callShowChat: (callBack) {
                _roomController.callShowChat = callBack;
              },
              // callheight: (height) {
              //   Alog.i("游戏弹框高度:" + "$height");
              // },
            ),
            barrierColor: Colors.transparent,
            isDismissible: false,
            isScrollControlled: true)
        .then((value) {
      Alog.i(value);
      bottomSheetCallBack?.call(false);
    });
  }

  String getHintText() {
    String text = "${intl.sayHi}~";
    if (_barrageController.value == true) {
      if (myBackpackLogic.hasHorn() > 0) {
        // 背包有喇叭
        text = "已开启弹幕评论，1喇叭/条";
      } else {
        text = "已开启弹幕评论，10钻石/条";
      }
    } else if (widget.imController.chats.messageState.value.type ==
        MessageType.$default) {
      text = "${intl.sayHi}~";
    }
    widget.imController.chats.setHintText(text);
    return text;
  }

  Widget getBody() {
    if (_roomController.state.roomInfoEmpty.value) {
      return SizedBox();
    }
    // final bottom = _roomController.state.roomSplit.value
    //     ? 0.0
    //     : 30 + AppLayout.safeBarHeight;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          headSection(),
          Spacer(),
          Obx(() => watchList()),
        ],
      ).marginSymmetric(horizontal: 10.dp),
      if (!_roomController.state.roomSplit.value)
        contributeAndGuard().marginOnly(left: 10.dp, bottom: 10.dp),
      if (!_roomController.state.roomSplit.value) _roomController.gameResult(),
      if (!_roomController.state.roomSplit.value &&
          _roomController.state.globalNotice.value)
        Obx(() => _roomController.luckyAlert(
            context, _roomController.state.roomglobalNotice,
            onTap: widget.onTap)),
      !_roomController.state.roomSplit.value
          ? Spacer()
          : SizedBox(height: 10.dp),
      if (!_roomController.state.roomSplit.value)
        MessageChatsPage(
                widget.imController,
                _scrollController,
                false,
                () => _roomId!,
                _roomController.state.roomInfo.value.username ?? "",
                _node)
            .paddingOnly(
          left: 12.dp,
          right: _roomController.state.roomSplit.value ? 180.dp : 0.0,
        ),
      Container(
        margin: EdgeInsets.only(
            left: 12.dp,
            right: 12.dp,
            top: _roomController.state.roomSplit.value ? 390.dp : 0,
            bottom: _roomController.state.roomSplit.value
                ? 0
                : 10.dp + MediaQuery.of(context).padding.bottom),
        child: Obx(() {
          if (_roomController.state.roomSplit.value) {
            return SizedBox();
          }
          return bottom(context);
        }),
      ),
    ]);
  }

  _msgWidgetInSplitMode() {
    return MessageChatsPage(
        widget.imController,
        _scrollController,
        false,
        () => _roomId!,
        _roomController.state.roomInfo.value.username ?? "",
        _node);
  }

  @override
  Widget get body => Obx(() => getBody().paddingOnly(
      bottom: _roomController.state.roomSplit.value ? 0.dp : 10.dp));

  Widget headSection() {
    print(_roomModel.toString());
    return Row(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(width: 2),
      ExtendedImage.network(_roomModel?.header ?? "",
              width: 28.dp, height: 28.dp, fit: BoxFit.fill)
          .clipRRect(radius: BorderRadius.circular(14.dp)),
      SizedBox(width: 4),
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
                _roomController.interception("${_roomModel?.username}",5),
                fontSize: 10.dp, fontWeight: w_500, color: Colors.white),
            CustomText("ID:${_roomModel?.shortId}",
                fontSize: 8.dp,
                fontWeight: w_400,
                color: AppMainColors.whiteColor70)
          ]),
      SizedBox(width: 6),
      Obx(() {
        bool isAttention = _roomController.state.isFollowing.value;
        if (isAttention) {
          return Container();
        } else {
          return Image.asset(R.icFollow,
                  fit: BoxFit.fill, width: 24.dp, height: 24.dp)
              .gestureDetector(onTap: () {
            String userId = _roomController.state.roomInfo.value.userId!;
            _roomController.follow(userId);
          });
        }
      }).paddingOnly(right: 2),
    ])
        .container(
            height: 32.dp,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: AppMainColors.anchorGradient),
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(16.dp),
            ))
        .gestureDetector(onTap: () {
      _roomController.userInfo(_roomModel?.userId ?? "").then((value) {
        customShowModalBottomSheet(
                context: context,
                builder: (_) {
                  return LiveAlertWidget(value, _roomId!,
                      isLiveOwner: false,
                      anchorId: _roomId!,
                      showCallButton: true,
                      userId: _roomModel?.userId ?? "");
                },
                fixedOffsetHeight: 320.dp + AppLayout.safeBarHeight,
                isScrollControlled: false,
                barrierColor: Colors.transparent,
                backgroundColor: Colors.transparent)
            .then((value) {
          if (value != null && value is bool) {
            if (value) {
              _roomController.following();
            } else {
              _roomController.cancelFollowing();
            }
          } else if (value != null && value is Map) {
            int rank = AppManager.getInstance<AppUser>().rank ?? 0;
            if (rank <
                int.parse(
                    "${Get.find<ConfigInfoLonic>().state.configInfo.value.sysRoomSpeaking?.sysRoomSpeaking}")) {
              showToast(
                  "达到等级Lv${Get.find<ConfigInfoLonic>().state.configInfo.value.sysRoomSpeaking?.sysRoomSpeaking}才可发言");
              return;
            }

            if (AppManager.getInstance<AppUser>().mute == 1) {
              showToast("您已被禁言");
              return;
            }

            if (_roomController.state.banFlag.value) {
              showToast("您已被禁言");
              return;
            }

            Future.delayed(Duration(milliseconds: 100), () {
              _node.requestFocus();
            });
            widget.imController.chats.onCall(
                //@TA
                _roomController.state.roomInfo.value.userId ?? "",
                _roomController.state.roomInfo.value.username ?? "");
          }
        });
      });
    });
  }

  Widget watchNum(int index, int? heat) {
    return Container(
        width: 23.dp,
        height: 10.dp,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: getGradient(index),
          borderRadius: BorderRadius.circular(6.dp),
        ),
        child: watchNumText(index, heat));
  }

  LinearGradient getGradient(int index) {
    if (index % 4 == 0) {
      return LinearGradient(
          colors: [Color(0xFFF9C43A), Color(0xFFFFECA8), Color(0xFFFDC52A)]);
    } else if (index % 4 == 1) {
      return LinearGradient(
          colors: [Color(0xFFA9B1B4), Color(0xFFE9EEF2), Color(0xFFB0BAC3)]);
    } else if (index % 4 == 2) {
      return LinearGradient(
          colors: [Color(0xFFD4A979), Color(0xFFFFE6D1), Color(0xFFD79B65)]);
    } else if (index % 4 == 3) {
      return LinearGradient(colors: [Color(0x99000000), Color(0x99000000)]);
    }
    return LinearGradient(colors: [Colors.white]);
  }

  Widget watchNumText(int index, int? heat) {
    String numText = StringUtils.showNmberOver10k(heat);

    if (index % 4 == 0) {
      return CustomText(numText,
          style: TextStyle(
            fontWeight: w_500,
            color: Color(0xFF906A08),
            fontSize: 6.sp,
          ));
    } else if (index % 4 == 1) {
      return CustomText(numText,
          style: TextStyle(
              fontWeight: w_500, color: Color(0xFF384D53), fontSize: 6.sp));
    } else if (index % 4 == 2) {
      return CustomText(numText,
          style: TextStyle(
              fontWeight: w_500, color: Color(0xFF795234), fontSize: 6.sp));
    } else if (index % 4 == 3) {
      return CustomText(numText,
          style: TextStyle(
              fontWeight: w_500, color: Color(0xFFFFFFFF), fontSize: 6.sp));
    }
    return Container();
  }

  /// 右侧在线列表
  Widget watchList() {
    int length = _roomController.state.audiences.length;
    // 展示前对数组进行排序
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 42.dp,
          constraints: BoxConstraints(
            maxWidth: 130.dp,
          ),
          alignment: Alignment.centerRight,
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: ((context, index) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  ExtendedImage.network(
                          _roomController.state.audiences[index].header!,
                          width: 28.dp,
                          height: 28.dp,
                          fit: BoxFit.cover)
                      .clipRRect(radius: BorderRadius.circular(14.dp)),
                  watchNum(index, _roomController.state.audiences[index].heat)
                      .position(top: 28.dp)
                ],
              ).paddingAll(2.dp).gestureDetector(onTap: () {
                if (_roomController.state.audiences[index].userId.toString() ==
                    AppManager.getInstance<AppUser>().userId) {
                  return;
                }
                Get.bottomSheet(
                        RoomUserInfoPage(
                            _roomController.state.audiences[index].userId!,
                            false),
                        barrierColor: Colors.transparent)
                    .then((value) {
                  if (value != null) {
                    if (value["event"] == "call") {
                      //@TA
                      Future.delayed(Duration(milliseconds: 100), () {
                        _node.requestFocus();
                      });
                      widget.imController.chats
                          .onCall(value["id"], value["userName"]);
                    }
                  }
                });
              });
            }),
            itemCount: length,
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(width: 2.dp),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.dp, vertical: 7.dp),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(16.dp)),
          child: Obx(() {
            return CustomText("${_roomController.state.audience.value}人",
                fontWeight: w_400, color: Colors.white, fontSize: 10.sp);
          }),
        ).gestureDetector(onTap: () {
          customShowModalBottomSheet(
              context: context,
              builder: (_) {
                // if (widget.isAnchor)
                //   return AnchorOnlineView(_roomId!, widget.imController);
                return AudienceOnlineView(_roomId!, false);
              },
              fixedOffsetHeight: this.height * 0.5,
              isScrollControlled: false,
              barrierColor: Colors.transparent,
              backgroundColor: Colors.transparent);
        }),
      ],
    );
  }

  Widget contributeAndGuard() {
    return Column(
      children: [
        Row(children: [
          CupertinoButton(
              child: Container(
                padding: EdgeInsets.only(left: 8, right: 4),
                height: 20.dp,
                decoration: BoxDecoration(
                    gradient:
                        LinearGradient(colors: AppMainColors.fireGradient),
                    borderRadius: BorderRadius.circular(10.dp)),
                child: Row(children: [
                  Image.asset(
                    R.icFire,
                    width: 12.dp,
                    height: 12.dp,
                  ),
                  SizedBox(width: 5.dp),
                  Obx(() {
                    return CustomText("${_roomController.state.firepower}",
                        fontSize: 12.dp,
                        fontWeight: w_400,
                        color: Colors.white);
                  }),
                  SizedBox(width: 5.dp),
                  Image.asset(R.icRightArrow,
                      width: 12.dp, height: 12.dp)
                ]),
              ),
              onPressed: () {
                customShowModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return ContributionRankPage(
                        false,
                        _roomModel?.userId ?? "",
                      );
                    },
                    fixedOffsetHeight: 477.dp,
                    isScrollControlled: false,
                    barrierColor: Colors.transparent,
                    backgroundColor: Colors.transparent);
              },
              padding: EdgeInsets.zero),
          SizedBox(width: 8.dp),
          CupertinoButton(
              child: Container(
                padding: EdgeInsets.only(left: 8, right: 4),
                height: 20.dp,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10.dp)),
                child: Row(children: [
                  Obx(() {
                    return CustomText("守护${_roomController.state.watchPower}人",
                        fontSize: 10.dp,
                        fontWeight: w_400,
                        color: Colors.white);
                  }),
                  SizedBox(width: 4),
                  Image.asset(R.icRightArrow,
                      width: 12.dp, height: 12.dp)
                ]),
              ),
              onPressed: () {
                customShowModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return GuardWidget(false);
                    },
                    fixedOffsetHeight: height * 0.8,
                    isScrollControlled: false,
                    barrierColor: Colors.transparent,
                    backgroundColor: Colors.transparent);
              },
              padding: EdgeInsets.zero),
          Spacer(),
          Container(
            // width: context.width - 16,
            height: 20.dp,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12)),
                color: Colors.black.withOpacity(0.4)),
            child: Row(
              children: [
                Image.asset(
                  R.zbjJtZuo,
                  width: 12.dp,
                  height: 12.dp,
                ),
                SizedBox(
                  width: 4,
                ),
                CustomText("${intl.recommended}",
                    fontSize: 10.dp, color: Colors.white)
              ],
            ).paddingOnly(left: 6, right: 8),
          ).gestureDetector(onTap: () {
            Scaffold.of(context).openEndDrawer();
          }),
        ]),
        Obx(() {
          if (_roomController.state.feeType != 0) {
            if (_roomController.state.payWatchTime.value == 0) {
              startTrySeeCountdown();
            }
            return Row(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 1.dp, horizontal: 4.dp),
                  decoration: BoxDecoration(
                      color: AppMainColors.blackColor60,
                      border: Border.all(
                          color: AppMainColors.whiteColor60, width: 0.5.dp),
                      borderRadius: BorderRadius.circular(2.dp)),
                  child: Obx(() {
                    return CustomText(
                        _roomController.state.feeType == 1
                            ? "${_roomController.state.roomInfo.value.timeDeduction}钻/分钟"
                            : "${_roomController.state.roomInfo.value.ticketAmount}钻/场",
                        fontWeight: w_400,
                        color: AppMainColors.whiteColor70,
                        fontSize: 10.sp);
                  }),
                ),
                SizedBox(width: 3.5.dp),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 1.dp, horizontal: 4.dp),
                  decoration: BoxDecoration(
                      color: AppMainColors.trySeeColor60,
                      border: Border.all(
                          color: AppMainColors.whiteColor60, width: 0.5.dp),
                      borderRadius: BorderRadius.circular(2.dp)),
                  child: CustomText(
                      _roomController.state.trySecs.value > 0
                          ? "试看倒计时${_roomController.state.trySecs.value}秒"
                          : _roomController.state.payWatchTime.value == 2
                              ? "已付费整场"
                              : "已观看${_roomController.state.timeWatched.value}分钟",
                      fontWeight: w_400,
                      color: AppMainColors.whiteColor70,
                      fontSize: 10.sp),
                ),
              ],
            );
          } else {
            return Container();
          }
        })
      ],
    );
  }

  Widget bottom(context) {
    return Row(children: [
      CupertinoButton(
          padding: EdgeInsets.zero,
          child: Container(
            height: 32.dp,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10.dp),
            decoration: BoxDecoration(
                color: AppMainColors.blackColor30,
                borderRadius: BorderRadius.circular(16.dp)),
            child: CustomText("${intl.sayHi}~",
                fontWeight: w_400,
                color: AppMainColors.whiteColor70,
                fontSize: 12.sp),
          ),
          onPressed: () {
            getHintText();
            int rank = AppManager.getInstance<AppUser>().rank ?? 0;
            if (rank <
                int.parse(
                    "${Get.find<ConfigInfoLonic>().state.configInfo.value.sysRoomSpeaking?.sysRoomSpeaking}")) {
              showToast(
                  "达到等级Lv${Get.find<ConfigInfoLonic>().state.configInfo.value.sysRoomSpeaking?.sysRoomSpeaking}才可发言");
              return;
            }

            if (AppManager.getInstance<AppUser>().mute == 1) {
              showToast("您已被禁言");
              return;
            }

            if (_roomController.state.banFlag.value) {
              showToast("您已被禁言");
              return;
            }

            if (_roomController.state.roomSplit.value) {
              _roomController.state.roomSplit.value = false;
              Get.back();
            }
            // if (_roomController.state.roomSplit.value) {
            //   _roomController.state.showChat = true;
            //   _roomController.callShowChat?.call(true);
            // }
            Future.delayed(Duration(milliseconds: 100), () {
              this.widget.imController.chats.onFocus();
              _node.requestFocus();
            });
          }).expanded(),
      SizedBox(width: 20.dp),
      _CircleItem(
        child: Image.asset(R.icShare),
      ).cupertinoButton(onTap: () {
        // if (_roomController.state.showChat) {
        //   controllWidget?.imController.chats.unFocus();
        //   FocusManager.instance.primaryFocus?.unfocus();
        //   Future.delayed(Duration(milliseconds: 100), () {
        //     _roomController.state.showChat = false;
        //     _roomController.callShowChat?.call(false);
        //   });
        // }
        // if (_roomController.state.roomSplit.value) {
        //   Get.offNamed(AppRoutes.appShare, arguments: {"code": _roomId});
        // } else {
        //   pushViewControllerWithName(AppRoutes.appShare,
        //       arguments: {"code": _roomId});
        // }
        Share.share(
            _roomController.state.roomInfo.value.shareAddress.toString());
      }),
      SizedBox(width: 6.dp),
      _CircleItem(
        child: Image.asset(R.icRecharge),
      ).cupertinoButton(onTap: () {
        Get.to(() => RechargePage(true));
      }),
      SizedBox(width: 6.dp),
      _CircleItem(
        child: Image.asset(R.icGame),
      ).cupertinoButton(onTap: () async {
        Future.delayed(Duration.zero).then((value) {
          if (_roomController.state.showChat) {
            controllWidget?.imController.chats.unFocus();
            FocusManager.instance.primaryFocus?.unfocus();
            Future.delayed(Duration(milliseconds: 100), () {
              _roomController.state.showChat = false;
              _roomController.callShowChat?.call(false);
            });
          } else {
            if (_roomController.state.roomSplit.value) {
              Get.back();
            }
            Get.bottomSheet(
                RoomLiveGamePage(
                  controlWidget: bottom(context),
                  chatBox: _msgWidgetInSplitMode(),
                  isAnchor: false,
                ),
                barrierColor: Colors.transparent);
          }
        });
      }),
      SizedBox(width: 6.dp),
      _CircleItem(
        child: Image.asset(R.icPresent),
      ).cupertinoButton(onTap: () {
        if (_bufferGiftNum > 0) {
          return;
        }
        controllWidget?.imController.chats.unFocus();
        FocusManager.instance.primaryFocus?.unfocus();
        Future.delayed(Duration(milliseconds: 100), () {
          _roomController.state.showChat = false;
          _roomController.callShowChat?.call(false);
        });
        Get.bottomSheet(
                GiftPackageView(
                    roomId: _roomId,
                    gifts: _roomController.state.gifts,
                    privilegeGifts: _roomController.state.privilegedGift),
                barrierColor: Colors.transparent,
                backgroundColor: Colors.transparent)
            .then((value) {
          if (_bufferGiftNum > 0) {
            return;
          }
          if (value != null && value is GiftModel) {
            if (gifId != value.id ||
                gifType != value.type ||
                gifNumber != value.number) {
              stopCountdown();
              gifId = value.id;
              gifType = value.type;
              gifNumber = value.number;
            }
            sendGift(context);
          }
        });
      }),
      SizedBox(width: 6.dp),
      _CircleItem(
        child: Image.asset(R.icClose),
      ).cupertinoButton(onTap: () {
        //退出直播间
        if (_roomController.state.showChat) {
          controllWidget?.imController.chats.unFocus();
          FocusManager.instance.primaryFocus?.unfocus();
          Future.delayed(Duration(milliseconds: 100), () {
            _roomController.state.showChat = false;
            _roomController.callShowChat?.call(false);
          });
        } else {
          Navigator.of(context).maybePop();
        }
      }),
    ]);
  }

  void showFirstRechargeAward(BuildContext context) {
    _roomController.getFirstChargeReward().then((value) {
      if (value != null)
        alertViewController(
            LiveChargeView(
              value,
              onTap: () {
                Get.back();
                _roomController.todayHasClose = true;
                StorageService.to
                    .setString("closetime", DateTime.now().day.toString());
              },
              onCharge: () {
                Get.to(() => RechargePage(true));
              },
            ),
            context: context);
    });
  }

  void brushGiftRequest(
      int gifId, int giftNum, int type, int comboCount, bool isBatter,
      {required void Function() success,
      required void Function(String) failure}) {
    Alog.e(_roomId, tag: "imRoomId");
    HttpChannel.channel
        .brushGift(
            roomId: _roomId!,
            giftId: gifId.toString(),
            giftNum: giftNum.toString(),
            comboCount: comboCount,
            type: type)
        .then((result) => result.finalize(
            wrapper: WrapperModel(),
            failure: (e) {
              showToast(e);
              failure(e);
            },
            success: (data) {
              Get.find<UserBalanceLonic>().userBalanceData();
              if (!isBatter) {
                startCountdown();
              }
              success();
            }));
  }

  var beginBrushGift = false;

  void sendGift(BuildContext context) {
    var userCoins =
        Get.find<UserBalanceLonic>().state.userBalance.value.coinBalance;
    var gifPrice;
    List giftList = gifType == 1 || gifType == 4
        ? _roomController.state.gifts
        : _roomController.state.privilegedGift;
    giftList.forEach((element) {
      if (gifId == element.id) {
        gifPrice = element.coins;
      }
    });
    if (gifNumber <= 0) {
      showToast("礼物数量不可小于 0");
    }
    if (widget.imController.chats.isBatter.value) {
      if (_bufferGiftNum > 0 &&
          !beginBrushGift &&
          (_bufferGiftNum + gifPrice * gifNumber) > (userCoins ?? 0)) {
        showToast("钻石不足");
        return;
      }
      gifComboCount += 1;
      brushGift(gifId, gifNumber, gifType, gifComboCount, true);
    } else {
      print("object111111$gifPrice $gifNumber $userCoins");
      if (gifPrice * gifNumber > userCoins) {
        // showToast("钻石不足");
        _showTipDialog(context);
        return;
      }
      brushGift(gifId, gifNumber, gifType, gifComboCount, false);
    }
  }

  _showTipDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AppDialog(
          CustomText(
            "很抱歉，当前钻石钱包余额不足，请前往充值或兑换",
            style: TextStyle(
                fontSize: 14.sp, fontWeight: w_400, color: Colors.white70),
          ),
          cancelText: "取消",
          confirmText: "前往充值",
          confirm: () {
            Get.back();
            Get.to(() => RechargePage(true));
          },
        );
      },
    );
  }

  void brushGift(
      int sendId, int giftNum, int type, int comboCount, bool isBatter) {
    int requestCount = (comboCount + 1) * giftNum;
    if (isBatter &&
        !beginBrushGift &&
        widget.imController
            .sendAdvanceGift(sendId, giftNum, requestCount, gifType)) {
      _bufferGiftNum += giftNum;
      if (_roomController.bufferGiftTimer == null) {
        int bufferGiftNum = _bufferGiftNum;
        _roomController.bufferGiftTimer =
            Timer.periodic(Duration(milliseconds: 300), (timer) {
          if (bufferGiftNum != _bufferGiftNum) {
            bufferGiftNum = _bufferGiftNum;
            return;
          }
          beginBrushGift = true;
          int bufferCount = requestCount + bufferGiftNum - giftNum;
          brushGiftRequest(sendId, bufferGiftNum, type, bufferCount, isBatter,
              success: () {
            Alog.e(
                "请求brushGift_buffer：$bufferGiftNum bufferCount:$bufferCount");
          }, failure: (e) {
            Alog.e("请求brushGift_buffer失败还原连击数gifComboCount:$gifComboCount"
                " comboCount:$comboCount=>${gifComboCount - (bufferGiftNum ~/ giftNum)}");
            if (sendId == gifId && gifComboCount >= comboCount) {
              gifComboCount -= bufferGiftNum ~/ giftNum;
            }
          });
          _bufferGiftNum = 0;
          timer.cancel();
          beginBrushGift = false;
          _roomController.bufferGiftTimer = null;
        });
      }
    } else {
      brushGiftRequest(sendId, giftNum, type, requestCount, isBatter,
          success: () {
        widget.imController
            .sendAdvanceGift(sendId, giftNum, requestCount, gifType);
        Alog.e("请求brushGift：$giftNum requestCount:$requestCount");
      }, failure: (e) {
        Alog.e("请求brushGift_buffer失败还原连击数gifComboCount:$gifComboCount"
            " comboCount:$comboCount=>${gifComboCount - (requestCount / giftNum - 1 - comboCount).toInt()}");
        if (sendId == gifId && gifComboCount >= comboCount) {
          gifComboCount -= (requestCount / giftNum - 1 - comboCount).toInt();
        }
      });
    }
  }

  Widget inputField(BuildContext context) {
    Widget child = CustomTextField(
      contentPadding: EdgeInsets.symmetric(horizontal: 8.dp, vertical: 8.dp),
      node: _node,
      hintText: widget.imController.chats.hintText.value,
      textInputAction: TextInputAction.send,
      controller: _textController,
      textAlignVertical: TextAlignVertical.bottom,
      fillColor: Colors.white.withOpacity(0.10),
      submit: (text) {
        if (text.isEmpty) {
          unFocus();
          widget.imController.chats.unFocus();
          return;
        }
        sendText("${widget.imController.headMessage} $text");
        widget.imController.chats.unFocus();
        unFocus();
        _textController.clear();
      },
      hintTextStyle: TextStyle(
          fontWeight: w_400,
          color: Colors.white.withOpacity(0.70),
          fontSize: 14.sp),
      style: TextStyle(fontWeight: w_400, color: Colors.white, fontSize: 14.sp),
    );
    var v = controllWidget?.imController.chats.messageState.value;
    var type = v?.type;
    if (v?.ex != null) {
      controllWidget?.imController.headMessage = "@${v?.ex?["name"]}";
    }
    if (type == MessageType.call) {
      child = Row(children: [
        Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 8.dp),
            child: CustomText("@${v?.ex?["name"]}",
                fontSize: 14.sp, color: Colors.white)),
        child.expanded()
      ]).clipRRect(radius: BorderRadius.circular(0));
    } else if (type == MessageType.reply) {
      child = Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            child,
            SizedBox(height: 8),
            CustomText("${v?.ex?["name"]}: ${v?.ex?["content"]}",
                fontSize: 14.sp, color: Colors.white)
          ]);
    } else {
      child = child;
    }

    return AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets,
        duration: Duration(milliseconds: 100),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(10, 6, 8, 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white.withOpacity(0.10),
              ),
              child: Row(
                children: [
                  AdvancedSwitch(
                    callBack: callBackbarrageController,
                    width: 40.dp,
                    height: 22.dp,
                    activeImage: AssetImage(R.icSwitchDanmuOn),
                    inactiveImage: AssetImage(R.icSwitchDanmuOff),
                  ),
                  child.expanded(),
                ],
              ),
            ).expanded(),
            Container(
                    width: 56.dp,
                    height: 32.dp,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.dp),
                        gradient: LinearGradient(
                            colors: AppMainColors.commonBtnGradient)),
                    child:
                        CustomText("发送", fontSize: 14.sp, color: Colors.white))
                .gestureDetector(onTap: () {
              if (controllWidget?.page._textController.text.isEmpty ?? false) {
                if (_roomController.state.showChat) {
                  _roomController.state.showChat = false;
                  _roomController.callShowChat?.call(false);
                } else {
                  unFocus();
                }
                controllWidget?.imController.chats.unFocus();
                return;
              } else {
                sendText(
                    "${controllWidget?.imController.headMessage} ${_textController.text}");
                controllWidget?.imController.chats.unFocus();
                if (_roomController.state.showChat) {
                  _roomController.state.showChat = false;
                  _roomController.callShowChat?.call(false);
                } else {
                  unFocus();
                }
                controllWidget?.page._textController.clear();
              }
            }),
            SizedBox(width: 11.dp),
          ],
        ).container(
          color: AppMainColors.blickColor90,
        ));
  }

  void alertLevelUp({
    required context,
    double bottom = 49,
    double left = 16,
    required int num,
    required String content,
  }) {
    showStyledToast(
      context: context,
      pos: StyledToastPos.pos(Alignment.bottomLeft, offset: bottom.dp),
      widget: Wrap(children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            width: left.dp,
          ),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                padding: EdgeInsets.all(4.dp),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _selectBgAlert(num),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.dp),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.dp, horizontal: 2.dp),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: _selectBgIcon(num),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.dp),
                            )),
                        child: Row(
                          children: [
                            Image.asset(
                              _selectIconAlert(num),
                              fit: BoxFit.fitHeight,
                              height: 12.dp,
                              width: 12.dp,
                            ),
                            SizedBox(
                              width: 4.dp,
                            ),
                            Text(
                              "$num",
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      width: 6.dp,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 2.dp),
                      child: Text(
                        content,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Color(0xFF101010),
                        ),
                      ),
                    )
                  ],
                )),
          ]),
        ])
      ]),
    );
  }

  _selectBgAlert(int num) {
    if (num < 11) return [Color(0xFFFFFFFF), Color(0xFFDAC181)];
    if (num < 21) return [Color(0xFFFFFFFF), Color(0xFF699CE9)];
    if (num < 31) return [Color(0xFFFFFFFF), Color(0xFF47D3A7)];
    if (num < 41) return [Color(0xFFFFFFFF), Color(0xFFB07AF4)];
    if (num < 51) return [Color(0xFFFFFFFF), Color(0xFFF66CFB)];
    return [Color(0xFFFFFFFF), Color(0xFFFE7878)];
  }

  _selectBgIcon(int num) {
    if (num < 11) return Color(0xFFDAC181);
    if (num < 21) return Color(0xFF699CE9);
    if (num < 31) return Color(0xFF47D3A7);
    if (num < 41) return Color(0xFFB07AF4);
    if (num < 51) return Color(0xFFF66CFB);
    return [Color(0xFFFFFFFF), Color(0xFFFE7878)];
  }

  _selectIconAlert(int num) {
    if (num < 11) return R.lv10;
    if (num < 21) return R.lv20;
    if (num < 31) return R.lv30;
    if (num < 41) return R.lv40;
    if (num < 51) return R.lv50;
    return R.lv60;
  }

  void _showGame() {
    stopCountdown();
    var list = Get.put(RoomLiveGameLogic()).state.gameList;
    if (list.length > 0)
      list.forEach((element) {
        if (element.id == _roomController.state.roomInfo.value.gameId) {
          showGame(
            element,
            bottom(context),
            _msgWidgetInSplitMode(),
            inputField(context),
          );
        }
      });
  }
}

class _CircleItem extends StatelessWidget {
  _CircleItem({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(width: 36.dp, height: 36.dp, child: child);
  }
}
