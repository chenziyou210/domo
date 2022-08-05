/*
 *  Copyright (C), 2015-2021
 *  FileName: top_view
 *  Author: Tonight丶相拥
 *  Date: 2021/12/10
 *  Description: 
 **/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/common_widget/live/guard_icon_widget.dart';
import 'package:star_common/common/gradient_border.dart';
import 'package:star_common/i18n/i18n.dart';
import 'package:star_common/manager/app_manager.dart';
import 'package:star_common/common/common_widget/live/peerage_widget.dart';
import 'package:star_common/util_tool/util_tool.dart';
import 'animation_view.dart';
import '../live_room_chat_model.dart';

class LivingRoomTopView extends StatefulWidget {
  LivingRoomTopView(this.id);

  final String Function() id;

  @override
  createState() => _LivingRoomTopViewState();
}

class _LivingRoomTopViewState extends State<LivingRoomTopView>
    with TickerProviderStateMixin {
  late final List<LotteryController> _controllers;

  List<GameModel> get _games => AppManager.getInstance<Game>()
      .games
      .where((element) => element.showFlag)
      .toList();

  // AppInternational get intl => AppInternational.of(context);
  AppInternational get intl => AppInternational.current;

  double _baseBottom = 150;

  LiveRoomChatViewModel get _chats => Get.isRegistered<LiveRoomChatViewModel>()
      ? Get.find<LiveRoomChatViewModel>()
      : Get.put(LiveRoomChatViewModel());

  late final CommonController _winPrizeController;
  late final CommonController _givingGiftController;
  late final CommonController _enterRoomController;
  late final Animation<double> _colorAnimation;

  ChatModel? get _enterModel =>
      _chats.enterRoomList.isEmpty ? null : _chats.enterRoomList.first;

  ChatModel? get _winPrizeModel =>
      _chats.winP.length == 0 ? null : _chats.winP.first;

  ChatModel? get _sendGiftModel =>
      _chats.sendGift.length == 0 ? null : _chats.sendGift.first;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controllers = _games.where((element) => element.showFlag).map((e) {
      AnimationController c =
          AnimationController(vsync: this, duration: Duration(seconds: 10));
      var a = LotteryController(
          c,
          [
            AnimatedGroupModel(Tween(begin: 0, end: 1000), Interval(0, 0.4)),
            AnimatedGroupModel(Tween(begin: 0, end: 1000), Interval(0.6, 1))
          ],
          e.gameName);
      return a;
    }).toList();
    var enterRoomC =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _enterRoomController = CommonController(controller: enterRoomC, models: [
      AnimatedGroupModel(Tween(begin: 0, end: 1000), Interval(0, 0.6)),
    ]);
    _colorAnimation = Tween(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(curve: Interval(0.8, 1), parent: enterRoomC));

    var giftC =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    _givingGiftController = CommonController(controller: giftC, models: [
      AnimatedGroupModel(Tween(begin: 0, end: 1000), Interval(0, 0.26)),
      AnimatedGroupModel(Tween(begin: 0, end: 1000), Interval(0.6, 1))
    ]);

    var winC =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    _winPrizeController = CommonController(controller: winC, models: [
      AnimatedGroupModel(Tween(begin: 0, end: 1000), Interval(0, 0.26)),
      AnimatedGroupModel(Tween(begin: 0, end: 1000), Interval(0.6, 1))
    ]);

    EventBus.instance.addListener(_enterListener, name: enterRoom);
    EventBus.instance.addListener(_winPrizeListener, name: winPrize);
    EventBus.instance.addListener(_sendGiftListener, name: givingGift);
    EventBus.instance.addListener(_onVerifyRoom, name: verifyRoomSuccess);
    // _enterRoomScription = _chats.enterRoom.listen((p0) {
    //   _enterListener();
    // });
    // _givingGiftScription = _chats.sendGift.stream.listen((event) {
    //   _sendGiftListener();
    // });
    // _winPrizeScription = _chats.winP.stream.listen((event) {
    //   _winPrizeListener();
    // });
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   if (_winPrizeModel != null && !_winPrizeController.controller.isAnimating) {
    //     _winPrizeController.controller.forward();
    //   }
    //   if (_enterModel != null && !_enterRoomController.controller.isAnimating) {
    //     _enterRoomController.controller.forward();
    //   }
    //   if (_sendGiftModel != null && !_givingGiftController.controller.isAnimating) {
    //     _givingGiftController.controller.forward();
    //   }
    // });
  }

  void _onVerifyRoom(_) {
    _enterRoomController.controller.reset();
    _enterIsAnimation = false;

    _winPrizeController.controller.reset();
    _winPrizeIsAnimation = false;

    _givingGiftController.controller.reset();
    _sendGiftIsAnimation = false;
  }

  bool _enterIsAnimation = false;

  void _enterListener(_) {
    if (_enterRoomController.controller.isAnimating || _enterIsAnimation) {
      return;
    } else if (_enterRoomController.controller.isDismissed ||
        _enterRoomController.controller.isCompleted) {
      if (_chats.enterRoomList.isNotEmpty) {
        _enterIsAnimation = true;
        _enterRoomController.controller.forward().then((value) {
          if (_chats.enterRoomList.length > 0) _chats.enterRoomList.removeAt(0);
          _enterRoomController.controller.reset();
          _enterIsAnimation = false;
          _enterListener(null);
        });
      }
    }
  }

  bool _winPrizeIsAnimation = false;

  void _winPrizeListener(_) {
    if (_winPrizeController.controller.isAnimating || _winPrizeIsAnimation) {
      return;
    } else if (_winPrizeController.controller.isDismissed ||
        _winPrizeController.controller.isCompleted) {
      if (_chats.winP.isNotEmpty) {
        _winPrizeIsAnimation = true;
        _winPrizeController.controller.forward().then((value) {
          _chats.winP.removeAt(0);
          _winPrizeController.controller.reset();
          _winPrizeIsAnimation = false;
          _winPrizeListener(null);
        });
      }
    }
  }

  bool _sendGiftIsAnimation = false;

  void _sendGiftListener(_) {
    if (_givingGiftController.controller.isAnimating || _sendGiftIsAnimation) {
      return;
    } else if (_givingGiftController.controller.isDismissed ||
        _givingGiftController.controller.isCompleted) {
      if (_chats.sendGift.isNotEmpty) {
        _sendGiftIsAnimation = true;
        _givingGiftController.controller.forward().then((value) {
          _chats.sendGift.removeAt(0);
          _givingGiftController.controller.reset();
          _sendGiftIsAnimation = false;
          _sendGiftListener(null);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    int index =
        _controllers.indexWhere((element) => element.name == "BaccaratGame");
    return Stack(children: [
      for (int i = 0; i < _controllers.length; i++)
        LivingRoomAnimationView(_controllers[i],
            (140.0 + 70 * i + (index != -1 && i > index ? 30 : 0)).dp),

      CommonAnimationWidget(_enterRoomController, 360, isBottom: true,
          childBuilder: (_) {
        return Offstage(
            offstage: _enterModel?.name == null ||
                _enterModel?.level == null ||
                _enterModel?.content == null,
            // _enterModel.nobleLevel="游侠" 为空 时 不显示贵族图标
            child: _enterModel?.levelUp == 1
                ? levelUp(_enterModel).opacity(_colorAnimation.value)
                : _enterModel?.nobleLevel == 0
                    ? _enterModel?.guardLevel == 0
                        ? getNomalEnter(_enterModel)
                            .opacity(_colorAnimation.value)
                        : getGuardWidget(_enterModel)
                    : getPeerageWidget(_enterModel)
                        .opacity(_colorAnimation.value));
      }),
      _CarDisplay().center
    ]);
  }

//贵族
  Widget getPeerageWidget(ChatModel? enterModel) {
    return Container(
      margin: EdgeInsets.only(left: 12.dp),
      height: 24.dp,
      decoration: BoxDecoration(
        border: GradientBoxBorder(
          gradient: LinearGradient(colors: [
            Color.fromRGBO(46, 142, 255, 1),
            Color.fromRGBO(234, 250, 255, 1),
            Color.fromRGBO(73, 211, 255, 1)
          ]),
          width: 1.dp,
        ),
        gradient: LinearGradient(colors: [
          Color.fromRGBO(90, 107, 255, 1),
          Color.fromRGBO(50, 197, 255, 1)
        ]),
        borderRadius: BorderRadius.circular(12.dp),
      ),
      child: Row(
        children: [
          PeerageWidget(_enterModel?.nobleLevel, 4),
          SizedBox(width: 4.dp),
          CustomText(_enterModel?.name ?? "",
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: w_500,
                  color: Color(0xFFEEFF87))),
          SizedBox(width: 4.dp),
          CustomText("贵族·${getName(_enterModel?.nobleLevel ?? 1)}闪亮登场",
              style: TextStyle(
                  fontSize: 14.sp, fontWeight: w_500, color: Colors.white)),
          SizedBox(width: 8.dp),
        ],
      ),
    );
  }

  Widget getGuardWidget(ChatModel? enterModel) {
    return Container(
      height: 24.dp,
      padding: EdgeInsets.only(
        right: 8.dp,
      ),
      decoration: BoxDecoration(
        border: GradientBoxBorder(
          gradient: LinearGradient(colors: [
            Color(0xFFFF76C8),
            Color(0xFFFFCDE5),
            Color(0xFFFF32AD),
          ]),
          width: 1.dp,
        ),
        gradient: LinearGradient(colors: [
          Color(0xFFEA3167),
          Color(0xFFFDCC9E),
        ]),
        borderRadius: BorderRadius.circular(12.dp),
      ),
      child: Row(
        children: [
          GuardIconWidget(_enterModel?.guardLevel, 8),
          SizedBox(width: 4.dp),
          CustomText(_enterModel?.name ?? "",
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: w_500,
                  color: Color(0xFFEEFF87))),
          SizedBox(width: 4.dp),
          CustomText("${getGuardTypeName(_enterModel?.guardLevel)}·守护华丽登场",
              style: TextStyle(
                  fontSize: 14.sp, fontWeight: w_500, color: Colors.white)),
        ],
      ),
    );
  }

  String getGuardTypeName(int? watchType) {
    switch (watchType) {
      case 2001:
        return '周';
      case 2002:
        return '月';
      case 2003:
        return '年';
    }
    return '周';
  }

  //非贵族超过20级进入
  Widget getNomalEnter(ChatModel? enterModel) {
    if (enterModel?.level == null) {
      return Container();
    }
    if (enterModel != null && enterModel.level! < 21) {
      return Container();
    }
    return Container(
      margin: EdgeInsets.only(left: 12.dp),
      height: 24.dp,
      padding: EdgeInsets.only(left: 4.dp, right: 8.dp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.dp),
          gradient: getBgByLevel(_enterModel?.level ?? 0)),
      child: Row(
        children: [
          UserLevelView(_enterModel?.level ?? 21),
          SizedBox(width: 4.dp),
          CustomText(_enterModel?.name ?? "",
              style: TextStyle(
                  fontSize: 12.sp, fontWeight: w_500, color: Colors.white)),
          SizedBox(width: 4.dp),
          CustomText("来了",
              style: TextStyle(
                  fontSize: 12.sp, fontWeight: w_500, color: Colors.white)),
        ],
      ),
    );
  }

  //用户等级提升
  Widget levelUp(ChatModel? enterModel) {
    return Container(
      margin: EdgeInsets.only(left: 12.dp),
      height: 24.dp,
      padding: EdgeInsets.only(left: 16.dp, right: 16.dp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.dp),
          gradient: LinearGradient(colors: [
            AppMainColors.string2Color("#DE8EAB"),
            AppMainColors.string2Color("#E25E86")
          ])),
      child: Row(
        children: [
          CustomText("恭喜 ${_enterModel?.name}等级提升至Lv${_enterModel?.level}",
              style: TextStyle(
                  fontSize: 12.sp, fontWeight: w_500, color: Colors.white)),
        ],
      ),
    );
  }

  LinearGradient getBgByLevel(int level) {
    if (level > 20 && level <= 30) {
      return LinearGradient(colors: [
        AppMainColors.string2Color("#84E8CA"),
        AppMainColors.string2Color("#2CC194")
      ]);
    } else if (level > 30 && level <= 40) {
      return LinearGradient(colors: [
        AppMainColors.string2Color("#B98EEF"),
        AppMainColors.string2Color("#A362F6")
      ]);
    } else if (level > 40 && level <= 50) {
      return LinearGradient(colors: [
        AppMainColors.string2Color("#ED92F0"),
        AppMainColors.string2Color("#E642EB")
      ]);
    } else if (level > 50 && level <= 60) {
      return LinearGradient(colors: [
        AppMainColors.string2Color("#F19292"),
        AppMainColors.string2Color("#F66161"),
        AppMainColors.string2Color("#EF4040")
      ]);
    }
    return LinearGradient(colors: [
      AppMainColors.string2Color("#84E8CA"),
      AppMainColors.string2Color("#2CC194")
    ]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controllers.forEach((element) {
      element.removeListener();
    });
    _enterRoomController.dispose();
    _winPrizeController.dispose();
    _givingGiftController.dispose();
    super.dispose();
    EventBus.instance.removeListener(_enterListener, name: enterRoom);
    EventBus.instance.removeListener(_winPrizeListener, name: winPrize);
    EventBus.instance.removeListener(_sendGiftListener, name: givingGift);
    EventBus.instance.removeListener(_onVerifyRoom, name: verifyRoomSuccess);
    // _winPrizeScription.cancel();
    // _givingGiftScription.cancel();
    // _enterRoomScription.cancel();
  }

  String getName(int type) {
    switch (type) {
      case 1001:
        return "游侠";
      case 1002:
        return "骑士";
      case 1003:
        return "子爵";
      case 1004:
        return "伯爵";
      case 1005:
        return "候爵";
      case 1006:
        return "公爵";
      case 1007:
        return "国王";
      default:
        return "游侠";
    }
  }
}

class _CarDisplay extends StatefulWidget {
  @override
  createState() => _CarDisplayState();
}

class _CarDisplayState extends State<_CarDisplay> {
  LiveRoomChatViewModel get _chats => Get.find<LiveRoomChatViewModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EventBus.instance.addListener(_onListen, name: enterRoom);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    EventBus.instance.removeListener(_onListen, name: enterRoom);
  }

  void _onListen(_) {
    if (_chats.cars.length == 0 || isAnimation) {
      if (_chats.cars.isEmpty) setState(() {});
      return;
    }
    isAnimation = true;
    setState(() {});
  }

  bool isAnimation = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    bool offstage = _chats.cars.length == 0;
    return Offstage(
        offstage: offstage,
        child: offstage
            ? SizedBox.shrink()
            : CustomGiftView.network(_chats.cars[0], onFinish: () {
                isAnimation = false;
                if (_chats.cars.length > 0) {
                  _chats.cars.removeAt(0);
                } else {
                  setState(() {});
                }
                _onListen(null);
              }, loop: false));
  }
}
