/*
 *  Copyright (C), 2015-2021
 *  FileName: live_room_new
 *  Author: Tonight丶相拥
 *  Date: 2021/12/9
 *  Description: 
 **/

import 'dart:async';

import 'package:alog/alog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/storage.dart';
import 'package:star_common/generated/anchor_list_model_entity.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_live/agora_rtc/agora_rtc.dart';
import 'package:star_live/pages/live_room/view/room_info_page/room_live_game/game_net_work.dart';
import 'package:star_live/star_live.dart';

import '../alert_widget/live_exit_alert.dart';
import '/pages/live_room/live_room_chat_model.dart';
import '/pages/live_room/view/end_draw/end_draw_new.dart';
import '/pages/live_room/view/room_info_page/room_live_game/game_net_work.dart';
import '/pages/live_room/view/svga/SVAGPlayer.dart';
import 'anchor_ends_new.dart';
import 'live_room_new_logic.dart';
import 'view/live_room_view/live_room_view.dart';
import 'view/room_info_page/living_show_popup.dart';
import 'view/room_info_page/room_info_page.dart';
import 'view/top_view.dart';

class AudienceNewPage extends StatefulWidget {
  AudienceNewPage({dynamic arguments})
      : this.roomIndex = arguments["index"],
        this.rooms = arguments["rooms"];
  final int roomIndex;
  final List<AnchorListModelEntity> rooms;
  final GlobalKey mKeyLive = GlobalKey();

  @override
  createState() => _AudienceNewPageState();
}

class _AudienceNewPageState extends AppStateBase<AudienceNewPage>
    with PlayComplete, AutomaticKeepAliveClientMixin {
  /// 数据
  final LiveRoomNewLogic _controller = LiveRoomNewLogic();

  ///
  final AgoraRtcLogic _agoraController = AgoraRtcLogic();

  final IMModel imModel = IMModel();

  late PageController _pageController;
  final PageController _pageController1 = PageController(initialPage: 1);

  String? get _anchorId =>
      _controller.state.rooms[_controller.state.roomIndex.value].id;

  Drag? _drag;

  late SVGAPlayer player;

  @override
  void initState() {
    StorageService.to.isOpenRoom = true;
    GameNetWork.shared.getGameEnterUrl();
    super.initState();
    Get.put(_controller);
    Get.put(_agoraController);
    Get.put(imModel.chats);
    _controller.setImModel(imModel);
    _controller.state.autoShowGame = true;
    heighSheetCallBack = (v) {
      if (!_controller.state.firstheightVLComes) {
        _controller.state.firstheightVLComes = true;
        return;
      }
      if (_controller.state.heightSurface.value == 0) {
        _controller.state.heightSurface.value = v;
      }
    };

    bottomSheetCallBack = (v) {
      if (v) {
        _controller.state.romPageIndex = _pageController.page?.toInt() ?? 0;
      } else {
        _pageController = PageController(
          initialPage: _controller.state.romPageIndex,
        );
      }
      _controller.state.firstheightVLComes = false;
      _controller.state.heightSurface = 0.0.obs;
      _controller.state.roomSplit.value = v;
    };

    /// 切换直播间
    print('NEO changeRoom1 widget.roomIndex = ${widget.roomIndex}');
    _controller.changeRoom(
        index: widget.roomIndex, anchorListData: widget.rooms);
    _pageController = PageController(
        initialPage:
        widget.rooms.length == 1 ? widget.roomIndex : widget.roomIndex + 1,
        keepPage: true);
    AgoraRtc.rtc.rtcAddListener(_agoraController);

    /// 礼物
    _controller.getGiftData();
    _controller.runtimeGame();

    player = SVGAPlayer(this, imModel);

    _controller.gamebackBackView = (payload) {
      print('NEO ---GAME END: $payload');

      Future.delayed(Duration(milliseconds: 100), () {
        GameNetWork.shared.eventBus.on<GameMqttData>().listen((event) {
          print('START-mqtt MqttTool GameNetWork Anh gameId ${event.data?.gameId}');
          print('START-mqtt MqttTool GameNetWork Anh roomType ${_controller.state.roomInfo.value.roomType}');
          print('START-mqtt MqttTool GameNetWork Anh roomInfo.value.gameId ${_controller.state.roomInfo.value.gameId}');
          StorageService.to.setString(
              "issueId${event.data?.gameId}", event.data?.issueId ?? "");
          if (/*_controller.state.roomInfo.value.roomType == 4 &&*/
          event.data?.gameId == _controller.state.roomInfo.value.gameId) {
            //游戏直播间,并且是同一个游戏
            if (event.data == null) {
              return;
            }
            //游戏直播间MQTT的游戏数据
            _controller.state.setUpdateGameResult(event.data!);
            Future.delayed(Duration(milliseconds: 500), () {
              _controller.state.setUpdateIsHideGameResult(false); //要显示
              Future.delayed(Duration(milliseconds: 3000), () {
                //延迟3秒隐藏开奖结果
                _controller.state.setUpdateIsHideGameResult(true);
              });
            });
          }
        });
      });
    };
  }

  @override
  String? getNextUrl() {
    if (imModel.chats.svgUrl.isNotEmpty) {
      String url = imModel.chats.svgUrl.removeAt(0);
      Alog.e("url:$url", tag: "getNextUrl");
      return url;
    }
    return null;
  }

  @override
  // TODO: implement bodyColor
  Color? get bodyColor => Colors.black.withOpacity(0.5);

  @override
  bool get extendBodyBehindAppBar => true;

  @override
  bool? get resizeToAvoidBottomInset => false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: scaffold,
        key: widget.mKeyLive,
        onWillPop: () async {
          if (_controller.state.roomInfo == null) return true;
          if (_controller.state.isFollowing.value) {
            HttpChannel.channel
                .audienceExitRoom(roomId: _anchorId!, follow: false);
            _controller.state.setShowPayPopup(false);
            return true;
          }
          return _showExitDialog().then((value) {
            if (value == null) {
              return false;
            } else if (value is bool && !value) {
              HttpChannel.channel
                  .audienceExitRoom(roomId: _anchorId!, follow: value);
              _controller.state.setShowPayPopup(false);
            }
            return true;
          });
        });
  }

  Future _showExitDialog() {
    return alertViewController(
        LiveExitAlert(
            url: _controller.state.roomInfo.value.header ?? "",
            anchorId: _anchorId!,
            roomId: _anchorId!,
            onPop: () {
              _controller.state.setShowPayPopup(false);
              Get.back();
            }),
        barrierDismissible: true,
        context: context);
  }

  bool _isForward = false;

  @override
  Widget get body => GestureDetector(
    onHorizontalDragStart: (details) {
      unFocus();
      _drag = _pageController.position.drag(details, _dragDispose);
    },
    onHorizontalDragCancel: () {
      _dragDispose();
    },
    onHorizontalDragUpdate: (details) {
      _drag?.update(details);
    },
    onHorizontalDragEnd: (details) {
      _drag?.end(details);
    },
    onVerticalDragStart: (details) {
      unFocus();
      _drag = _pageController.position.drag(details, _dragDispose);
    },
    onVerticalDragCancel: () {
      _dragDispose();
    },
    onVerticalDragUpdate: (details) {
      _isForward = details.delta.dy < 0;
      _drag?.update(details);
    },
    onVerticalDragEnd: (details) {
      _drag?.end(details);
    },
    child: Obx(
          () {
        var length = _controller.state.rooms.length;
        bool isOnlyOne = length == 1;
        var count = isOnlyOne ? 1 : length + 2;
        return Stack(
          children: [
            if(_controller
                .state
                .rooms.length>_controller.state.roomIndex.value)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(_controller
                            .state
                            .rooms[_controller.state.roomIndex.value]
                            .roomCover ??
                            ""),
                        fit: BoxFit.cover,
                        opacity: _controller.state.roomSplit.value ? 0.6 : 1),
                  ),
                ),
              ),
            Visibility(
              child: Container(
                child: _splitLiveView(),
              ),
              visible: _controller.state.roomSplit.value,
            ),
            Visibility(
              child: Container(
                child: Stack(
                  children: [
                    PageView.builder(
                        controller: _pageController,
                        pageSnapping: true,
                        itemCount: count,
                        itemBuilder: (_, int index) {
                          if (!isOnlyOne &&
                              (index == 0 || index == length + 1)) {
                            return SizedBox.shrink();
                          }
                          return LiveRoomView(
                            isOnlyOne: isOnlyOne,
                            index: index,
                            isSmallWindow: false,
                          );
                        },
                        onPageChanged: (int index) async {
                          var result =
                          _calculate(index: index, count: count);
                          var jumpIndex = result.jumpIndex;
                          if (result.needChangePage) {
                            await Future.delayed(
                                Duration(milliseconds: 400));
                            _pageController.jumpToPage(jumpIndex);
                          }
                          var model =
                          _controller.changeRoom(index: result.index);
                          imModel.initRoom(model);
                        },
                        scrollDirection: Axis.vertical),
                    Positioned.fill(
                      child: FutureBuilder(
                        builder: (_, __) {
                          Get.lazyPut(() => LiveRoomChatViewModel());
                          return LivingRoomTopView(() => _anchorId!);
                        },
                        future: Future.delayed(
                          Duration(milliseconds: 100),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              visible: !_controller.state.roomSplit.value,
            ),
            Obx(() => _itemRoomInfo()),
          ],
        );
      },
    ),
  );

  _splitLiveView() {
    return Container(
      child: Stack(
        children: [
          Positioned(
              child: Obx(() {
                bool isOnlyOne = _controller.state.rooms.length == 1;
                return Container(
                  padding: EdgeInsets.only(bottom: 4.dp),
                  width: 157.dp,
                  height: _controller.state.heightSurface.value,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.dp))),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8.dp)),
                      child: LiveRoomView(
                        isOnlyOne: isOnlyOne,
                        index: _controller.state.romPageIndex,
                        isSmallWindow: true,
                      )),
                );
              }),
              right: 12.dp,
              top: 96.dp),

        ],
      ),
    );
  }

  // void _detailEvent(
  //     {required int jumpIndex, required int count, required int index}) async {
  //   popUntil(AppRoutes.audiencePage);
  //   if (_isForward) {
  //     if (jumpIndex == count - 2) {
  //       // 下一个页面为第一个页面
  //       jumpIndex = 1;
  //       index = 0;
  //     } else {
  //       // 下一个页面
  //       jumpIndex += 1;
  //       index = jumpIndex - 1;
  //     }
  //   } else {
  //     if (jumpIndex == 1) {
  //       // 上一个页面为最后一个页面
  //       jumpIndex = count - 2;
  //       index = jumpIndex - 1;
  //     } else {
  //       // 上一个页面
  //       jumpIndex -= 1;
  //       index = jumpIndex - 1;
  //     }
  //   }
  //   _pageController.jumpToPage(jumpIndex);
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    StorageService.to.isOpenRoom = false;
    _controller.state.romPageIndex = 0;
    _controller.callBackView = null;
    _controller.danmuBackView = null;
    Get.delete<LiveRoomNewLogic>();
    Get.delete<AgoraRtcLogic>();
    Get.delete<LiveRoomChatViewModel>();
    _controller.lotteryTimer?.cancel();
    _controller.closePush(StorageService.to.getString("roomId"));
    StorageService.to.setString("roomId", "");
    AgoraRtc.rtc.removeRtcListener();
    _dragDispose();
    _pageController.dispose();
    GameNetWork.shared.dispose();
  }

  void _dragDispose() {
    _drag = null;
  }

  @override
  // TODO: implement endDraw
  Widget? get endDraw => LivingRoomEndDrawNew(
      _controller.state.rooms[_controller.state.roomIndex.value].id!,
      onTap: (rooms, index) {
        _controller.changeRoomData(index: index, anchorListData: rooms);
        Future.delayed(Duration(milliseconds: 400), () {
          _pageController.jumpToPage(rooms.length == 1 ? index : index + 1);
        });
      });

  @override
  // TODO: implement drawerScrimColor
  Color? get drawerScrimColor => Colors.transparent;

  _JumpModel _calculate({required int index, required int count}) {
    int jumpIndex;
    bool needChangePage;
    if (index == 0) {
      //当前选中的是第一个位置，自动选中倒数第二个位置
      jumpIndex = count - 2;
      needChangePage = true;
      index = jumpIndex - 1;
    } else if (index == count - 1) {
      //当前选中的是倒数第一个位置，自动选中第一个索引
      jumpIndex = 1;
      needChangePage = true;
      index = 0;
    } else {
      jumpIndex = index;
      index = index - 1;
      if (index < 0) index = 0;
      needChangePage = false;
    }
    return _JumpModel(
        index: index, jumpIndex: jumpIndex, needChangePage: needChangePage);
  }

  void _setRoomChange(int index, int count) async {
    var result = _calculate(index: index, count: count);

    var jumpIndex = result.jumpIndex;
    if (result.needChangePage) {
      await Future.delayed(Duration(milliseconds: 400));
      _pageController.jumpToPage(jumpIndex);
    }
    var model = _controller.changeRoom(index: result.index);
    imModel.initRoom(model);
  }

  @override
  bool get wantKeepAlive => true;

  Widget _itemRoomInfo() {
    if (_controller.state.livingState.value != LivingRoomState.linking) {
      return Positioned.fill(
          child: AnchorEndsPage(
            _controller.state.livingState.value,
            _controller.state.rooms[_controller.state.roomIndex.value].header
                .toString(),
            _controller.state.rooms[_controller.state.roomIndex.value].roomTitle
                .toString(),
            _controller.state.rooms[_controller.state.roomIndex.value].id
                .toString(),
            onTap: (List<AnchorListModelEntity> rooms, int index) {
              _controller.changeRoomData(index: index, anchorListData: rooms);
              Future.delayed(Duration(milliseconds: 400), () {
                _pageController.jumpToPage(rooms.length == 1 ? index : index + 1);
              });

            },
          ));
    } else {
      bool isShow = _controller.state.showPayPopup.value ;
      if (isShow) {
        _controller.state.leaveChannel();
      }
      return isShow?Positioned.fill(child: LivingPayPoppupPage()):RoomInfoPage(imModel,
          player: player,
          roomId: () => _anchorId ?? "",
          onTap: (roomid) async {
            _gotoRoom(roomid);
          });
    }
  }

  void _gotoRoom(String roomid) async {
    int indexPage = _pageController.page?.toInt() ?? 0;
    AnchorListModelEntity model = AnchorListModelEntity();
    model.id = roomid;
    int tmpIndex = _controller.state.addRoomInfo(indexPage, model);
    if (tmpIndex == -1) return;
    await Future.delayed(Duration(milliseconds: 400));
    _pageController.jumpToPage(tmpIndex);
  }
}

class _JumpModel {
  _JumpModel(
      {required this.index,
        required this.jumpIndex,
        required this.needChangePage});

  int index;
  int jumpIndex;
  bool needChangePage;
}

