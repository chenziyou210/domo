/*
 *  Copyright (C), 2015-2021
 *  FileName: live_room_preview
 *  Author: Tonight丶相拥
 *  Date: 2021/9/18
 *  Description: 
 **/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_live/agora_rtc/agora_rtc.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';
import 'package:star_common/common/toast.dart';
import 'package:provider/provider.dart';
import '../surface/surface_view.dart';
import 'live_room_preview_model.dart';
import 'live_room_type.dart';

class LiveRoomPreviewPage extends StatefulWidget {
  @override
  createState() => _LiveRoomPreviewPageState();
}

class _LiveRoomPreviewPageState extends AppStateBase<LiveRoomPreviewPage> with Toast {

  /// 需要释放
  bool _needRelease = true;

  /// 摄像头
  bool _isFrontCamera = true;

  /// 上传
  final UploadModel controller = UploadModel();

  /// 封面
  String? url;

  /// 输入控制器
  final TextEditingController edit = TextEditingController();

  /// 密码
  final TextEditingController password = TextEditingController();

  /// 门票
  final TextEditingController ticket = TextEditingController();

  /// 时间
  final TextEditingController timer = TextEditingController();

  /// 游戏
  final TextEditingController game = TextEditingController();

  @override
  // TODO: implement model
  LiveRoomPreviewModel get model => super.model as LiveRoomPreviewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     // _destroyRoom();
    _initTRTCRoom();
  }

  // Future<void> _destroyRoom() async{
  //   await HttpChannel.channel.destroyRoom(
  //       anchorId: "${AppManager.getInstance<AppUser>().userId}");
  //   return;
  // }

  /// 初始化Room
  Future<void> _initTRTCRoom() async{
    AgoraRtc.rtc.preview();
  }

  @override
  // TODO: implement extendBodyBehindAppBar
  bool get extendBodyBehindAppBar => true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider.value(value: model,
        child: LoadingWidget(builder: (_, __) => scaffold,
          future: model.future));
  }

  @override
  // TODO: implement appBar
  PreferredSizeWidget? get appBar => DefaultAppBar(
    backgroundColor: Colors.transparent,
    leading: CustomBackButton(
      icon: Image.asset(R.closeAlert,
          color: AppColors.c255_255_255)
    ),
    actions: [
      GestureDetector(
        onTap: () async{
          _isFrontCamera = !_isFrontCamera;
          AgoraRtc.rtc.switchCamera();
          // (await TRTCLiveRoom.sharedInstance()).switchCamera(_isFrontCamera);
        },
        child: Padding(
          padding: EdgeInsets.only(right: 8),
          child: Center(
            child: Image.asset(R.switchCamera)
          )
        )
      )
    ]
  );

  @override
  // TODO: implement body
  Widget get body => Stack(
    children: [
      Container(),
      Positioned.fill(child: SurfacePage()),
      // Positioned.fill(child: TRTCCloudVideoView(
      //   key: ValueKey("LiveRoomPage_bigVideoViewId"),
      //   viewType: TRTCCloudDef.TRTC_VideoView_SurfaceView,
      //   onViewCreated: (viewId) async {
      //     // var trtc = await TRTCLiveRoom.sharedInstance();
      //     // trtc.stopCameraPreview();
      //     // //为啥需要延迟，不延迟视频渲染会有问题。
      //     // Future.delayed(Duration(milliseconds: 500), () async {
      //     //   await trtc.startCameraPreview(_isFrontCamera, viewId);
      //     // });
      //   })
      // ),
      Container(
        color: Colors.transparent,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(width: this.width, height: 40),
              Row(
                children: [
                  SizedBox(width: 20),
                  UploadWidget(width: 80, height: 80, uploadSuccess: (url) {
                    this.url = url;
                  }, controller: controller),
                  Expanded(child: CustomTextField(
                    controller: edit,
                    hintText: intl.pleaseEnterTitleGetMoreFans,
                    hintTextStyle: AppStyles.f15w500c255_255_255.copyWith(
                      color: AppColors.c216_216_216,
                      fontSize: 18
                    ), style: AppStyles.f15w500c255_255_255.copyWith(
                      color: AppColors.c216_216_216,
                      fontSize: 18
                  ))),
                  SizedBox(width: 20)
                ]
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 8),
                  Expanded(child: Wrap(
                    spacing: 4,
                    runSpacing: 8,
                    children: [
                      SelectorCustom<LiveRoomPreviewModel, int>(
                          builder: (value) {
                            LiveRoomType type = LiveRoomType.common;
                            return _TypeButton(type.description, onPressed: (){
                              model.changeIndex(type.index);
                              }, isSelected: value == type.index);
                      }, selector: (l) => l.index),
                      SelectorCustom<LiveRoomPreviewModel, int>(
                        builder: (value) {
                          LiveRoomType type = LiveRoomType.password;
                          return _TypeButton(type.description, onPressed: (){
                            model.changeIndex(type.index);
                            }, isSelected: value == type.index);
                      }, selector: (l) => l.index),
                      SelectorCustom<LiveRoomPreviewModel, int>(
                        builder: (value) {
                          LiveRoomType type = LiveRoomType.ticket;
                          return _TypeButton(type.description, onPressed: (){
                            model.changeIndex(type.index);
                            }, isSelected: value == type.index);
                      }, selector: (l) => l.index),
                      SelectorCustom<LiveRoomPreviewModel, int>(
                        builder: (value) {
                          LiveRoomType type = LiveRoomType.timer;
                          return _TypeButton(type.description, onPressed: (){
                            model.changeIndex(type.index);
                            }, isSelected: value == type.index);
                      }, selector: (l) => l.index),
                      SelectorCustom<LiveRoomPreviewModel, int>(
                        builder: (value) {
                          LiveRoomType type = LiveRoomType.game;
                          return _TypeButton(type.description, onPressed: (){
                            model.changeIndex(type.index);
                            }, isSelected: value == type.index);
                          }, selector: (l) => l.index)
                    ]
                  )),
                  SizedBox(width: 8)
                ]
              ),
              SizedBox(
                height: 20
              ),
              Row(
                children: [
                  SelectorCustom<LiveRoomPreviewModel, int?>(builder: (index1){
                    return Wrap(
                      spacing: 4,
                      runSpacing: 8,
                      children: model.label.map((e) {
                        int index = model.label.indexOf(e);
                        return _TypeButton(e.name ?? "", onPressed: (){
                          model.changeLabel(index);
                        }, isSelected: index == index1);
                      }).toList()
                    );
                  }, selector: (l) => l.labelIndex)
                ]
              ).padding(padding: EdgeInsets.symmetric(horizontal: 8)),
              SizedBox(
                height: 20
              ),
                  SelectorCustom<LiveRoomPreviewModel, int>(
                      builder: (value) {
                        Widget widget = SizedBox();
                        LiveRoomType type = LiveRoomType.values[value];
                        if (type == LiveRoomType.password) {
                          widget = _InputWidget(password,
                              hintText: intl.pleaseEnterPassword,
                              obscureText: true);
                        }else if (type == LiveRoomType.timer) {
                          widget = _InputWidget(timer,
                              hintText: intl.pleaseEnterTimer,
                              inputType: TextInputType.numberWithOptions(decimal: true),
                              // formatters: [
                              //   FilteringTextInputFormatter.digitsOnly
                              // ]
                          );
                        }else if (type == LiveRoomType.ticket) {
                          widget = _InputWidget(ticket,
                              hintText: intl.pleaseEnterTicket,
                              inputType: TextInputType.numberWithOptions(decimal: true),
                              // formatters: [
                              //   FilteringTextInputFormatter.digitsOnly
                              // ]
                          );
                        }else if (type == LiveRoomType.game) {
                          widget = _InputWidget(game,
                              hintText: intl.pleaseEnterGame);
                        }
                        return widget;
                      },
                      selector: (l) => l.index),
                  Spacer(),
                  Row(
                    children: [
                      Expanded(child: GestureDetector(
                          onTap: (){
                            // showModalBottomSheet1(FuRenderBar(atIndex: 0),
                            //     barrierColor: Colors.transparent,
                            //     backGroundColor: Colors.transparent
                            // );
                          },
                          child: Align(
                              alignment: Alignment.center,
                              child: Column(
                                  children: [
                                    Image.asset(R.beauty1),
                                    SizedBox(height: 4),
                                    Text(intl.beauty, style: AppStyles.f14w400c255_255_255)
                                  ]
                              )
                          )
                      )),
                      GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: this.width / 2,
                            decoration: BoxDecoration(
                                color: AppColors.c255_225_0,
                                borderRadius: BorderRadius.circular(25)
                            ),
                            child: Text(intl.startLive,
                                style: AppStyles.f17w400c255_255_255),
                          ),
                          onTap: () async{
                            String text = edit.text;
                            if (text.replaceAll(" ", "").isEmpty) {
                              showToast(intl.roomNameEmpty);
                              return;
                            }

                            if (controller.isUploading) {
                              showToast("cover image is uploading");
                              return;
                            }
                            // todo: 开始直播
                            // await _destroyRoom();
                            Future future;
                            LiveRoomType type = LiveRoomType.values[model.index];
                            String? labelId = model.label.length == 0 || model.labelIndex == null ? null :
                               model.label[model.labelIndex!].id;
                            // if (type == LiveRoomType.common) {
                            //   future = HttpChannel.channel.createCommonRoom(
                            //       cover: url ?? "",
                            //       labelId: labelId,
                            //       labelName: edit.text);
                            // }else if (type == LiveRoomType.password) {
                            //   String text = password.text;
                            //   if (text.isEmpty) {
                            //     showToast(intl.pleaseEnterPassword);
                            //     return;
                            //   }
                            //   future = HttpChannel.channel.createPasswordRoom(
                            //       cover: url ?? "",
                            //       labelId: labelId,
                            //       password: password.text,
                            //       labelName: edit.text);
                            // }else if (type == LiveRoomType.ticket) {
                            //   double? v = double.tryParse(ticket.text);
                            //   if (v == null) {
                            //     showToast(intl.pleaseEnterTicket);
                            //     return;
                            //   }
                            //   future = HttpChannel.channel.createTickerAmountRoom(
                            //       cover: url ?? "",
                            //       labelId: labelId,
                            //       ticketAmount: v,
                            //       labelName: edit.text);
                            // }else if (type == LiveRoomType.timer){
                            //   double? v = double.tryParse(timer.text);
                            //   if (v == null) {
                            //     showToast(intl.pleaseEnterTimer);
                            //     return;
                            //   }
                            //   future = HttpChannel.channel.createTimeDeductionRoom(
                            //       cover: url ?? "",
                            //       timeDeduction: v,
                            //       labelId: labelId,
                            //       labelName: edit.text);
                            // }else { // type == LiveRoomType.game
                            //   String text = game.text;
                            //   if (text.isEmpty) {
                            //     showToast(intl.pleaseEnterGame);
                            //     return;
                            //   }
                            //   future = HttpChannel.channel.createGameRoom(
                            //       cover: url ?? "",
                            //       labelId: labelId,
                            //       gameId: text,
                            //       labelName: edit.text);
                            // }
                            // future.then(
                            //   (value) => value.finalize(
                            //     wrapper: WrapperModel(),
                            //     failure: (e) {
                            //       showToast(e.toString());
                            //     },
                            //     success: (value) {
                            //       print("hx has already log in: ${EMClient.getInstance.isLoginBefore} --- ");
                            //       _needRelease = false;
                            //       var user = AppManager.getInstance<AppUser>();
                            //       Navigator.of(context).popAndPushNamed(AppRoutes.liveRoom, arguments: {
                            //         "anchor": true,
                            //         "channelId": value["channelId"],
                            //         "token": value["token"],
                            //         "uid": value["uid"],
                            //         "roomName": edit.text,//"${AppUser.user.name} live room",
                            //         "ownerId": user.userId,
                            //         "chatId": value["imRoomId"],
                            //         "userId": user.userId
                            //       });
                            //     }));
                          }
                      ),
                      Spacer()
                    ]
                  ),
                  SizedBox(height: 40)
                ]
            )
        )
      )
    ]
  );

  @override
  void dispose() async{
    // TODO: implement dispose
    super.dispose();
    if (_needRelease) {
      AgoraRtc.rtc.leaveChannel();
    }
  }

  @override
  AppModel? initializeModel() {
    // TODO: implement initializeModel
    return LiveRoomPreviewModel()..anchorLabel();
  }

  @override
  // TODO: implement resizeToAvoidBottomInset
  bool? get resizeToAvoidBottomInset => false;
}

class _TypeButton extends StatelessWidget {
  _TypeButton(this.text, {this.onPressed, this.isSelected = false});
  final String text;
  final VoidCallback? onPressed;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black12),
              color: isSelected ? AppColors.c0_153_153.withOpacity(0.3) : null
          ),
          child: MaterialButton(
              padding: EdgeInsets.symmetric(horizontal: 8),
              minWidth: 60,
              child: Text(text, style: isSelected ? AppStyles.f14w400c255_255_255
                  : AppStyles.f14w400c42_208_199.copyWith(
                  color: Colors.black54
              )),
              onPressed: onPressed
          )
      )
    );
  }
}

class _InputWidget extends StatelessWidget {
  _InputWidget(this.controller, {this.hintText: "",
    this.formatters: const [], this.inputType,
    this.obscureText: false});
  final TextEditingController controller;
  final String hintText;
  final List<TextInputFormatter> formatters; /// [FilteringTextInputFormatter.digitsOnly]
  final TextInputType? inputType; /// TextInputType.numberWithOptions(decimal: true)
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white
          )
        )
      ),
      child: CustomTextField(
        controller: controller,
        hintText: hintText,
        hintTextStyle: AppStyles.f15w500c255_255_255.copyWith(
            color: AppColors.c216_216_216,
            fontSize: 18
        ),
        style: AppStyles.f15w500c255_255_255.copyWith(
            color: AppColors.c216_216_216,
            fontSize: 18
        ),
        inputFormatter: formatters,
        keyboardType: inputType,
        obscureText: obscureText,
        textInputAction: TextInputAction.done
      )
    );
  }
}