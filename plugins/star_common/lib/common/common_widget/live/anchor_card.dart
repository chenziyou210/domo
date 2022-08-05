import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/generated/LiveRoomInfoEntity.dart';

import '../../../app_images/r.dart';
import '../../gradient_border.dart';

class AnchorCard extends AlertDialog with Toast {
  AnchorCard(this.roomInfoEntity, this.info);

  // String roomId;
  final LiveRoomInfoEntity roomInfoEntity;
  final AnchorCardInfo info;
  late BuildContext context;

  @override
  // TODO: implement backgroundColor
  Color? get backgroundColor => Colors.yellow;

  @override
  // TODO: implement elevation
  double? get elevation => 0;

  @override
  // TODO: implement contentPadding
  EdgeInsetsGeometry get contentPadding => EdgeInsets.zero;

  @override
  // TODO: implement insetPadding
  EdgeInsets get insetPadding => EdgeInsets.zero;

  @override
  Widget build(BuildContext context) {
    // requestAnchorNameCard();
    this.context = context;
    return super.build(context);
  }

  // Future requestAnchorNameCard() {
  //   return HttpChannel.channel.getNameCard(
  //       "$roomId")
  //     ..then((value) => value.finalize(
  //         wrapper: WrapperModel(),
  //         success: (data) {
  //           info = AnchorCardInfo.fromJson(data);
  //           // Alog.e(,tag:"requestAnchorNameCard");
  //         }));
  // }

  @override
  // TODO: implement content
  Widget? get content => body1;

  Widget get body1 => Stack(alignment: Alignment.center, children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 28.dp),
          margin: EdgeInsets.only(top: 42.dp),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(R.icAnchorCardBg),
                  fit: BoxFit.fill)),
          child: Column(
            children: [
              SizedBox(
                height: 58.dp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(roomInfoEntity.username ?? "",
                      fontWeight: w_500, color: Colors.white, fontSize: 16.sp),
                  SizedBox(width: 4.dp),
                  Container(
                    width: 32.dp,
                    height: 18.dp,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppMainColors.whiteColor100,
                      borderRadius: BorderRadius.all(Radius.circular(9.dp)),
                    ),
                    child: CustomText(
                      "名片",
                      fontWeight: w_400,
                      fontSize: 12.sp,
                      color: AppMainColors.mainColor,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 8.dp,
              ),
              CustomText("你若迈出第一步，剩下九十九步我陪你！",
                  fontWeight: w_400, color: Colors.white70, fontSize: 12.sp),
              SizedBox(
                height: 24.dp,
              ),
              Container(
                  width: 270.dp,
                  height: 60.dp,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12.dp)),
                      border: GradientBoxBorder(
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(255, 250, 232, 0.26),
                          Color.fromRGBO(255, 241, 191, 0.85),
                          Color.fromRGBO(255, 252, 240, 0.2)
                        ]),
                        width: 1.dp,
                      ),
                      color: Color.fromRGBO(
                        0,
                        0,
                        0,
                        0.4,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 14.dp,
                      ),
                      Image.asset(
                        R.icWechat,
                        width: 40.dp,
                        height: 40.dp,
                      ),
                      SizedBox(
                        width: 10.dp,
                      ),
                      CustomText(info.wxInfo ?? "****",
                              fontWeight: w_500,
                              color: Colors.white,
                              fontSize: 14.sp)
                          .expanded(),
                      Container(
                          width: 56.dp,
                          height: 32.dp,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: AppMainColors.commonBtnGradient),
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.dp)),
                          ),
                          alignment: Alignment.center,
                          child: CustomText(
                            info.roomUserSendGiftAmount! >= info.showCardAmount!
                                ? "复制"
                                : "获取",
                            fontSize: 14.sp,
                            fontWeight: w_500,
                            color: Colors.white,
                          )).gestureDetector(onTap: () {
                        getOrCopyWechatNumber(context);
                      }),
                      SizedBox(
                        width: 8.dp,
                      ),
                    ],
                  )),
              SizedBox(
                height: 24.dp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(TextSpan(
                      text: info.roomUserSendGiftAmount.toString(),
                      style: AppStyles.number12w400white,
                      children: [
                        TextSpan(
                            text: "/${info.showCardAmount}",
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.4)))
                      ])),
                  CustomText(
                    "赠送礼物达到要求即可获取",
                    style: AppStyles.f12w400c255_255_255,
                  )
                ],
              ),
              SizedBox(
                height: 8.dp,
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(2.dp)),
                child: LinearProgressIndicator(
                  backgroundColor: AppMainColors.whiteColor40,
                  valueColor: AlwaysStoppedAnimation(AppMainColors.mainColor),
                  value: _getProcessValue(),
                ),
              ),
              SizedBox(
                height: 16.dp,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text.rich(TextSpan(
                    text: "1.添加时请:",
                    style: TextStyle(
                      color: AppMainColors.whiteColor40,
                      fontWeight: w_400,
                      fontSize: 10.sp,
                    ),
                    children: [
                      TextSpan(
                        text: "备注昵称",
                        style: TextStyle(
                            color: AppMainColors.mainColor,
                            fontSize: 10.sp,
                            fontWeight: w_500),
                      ),
                      TextSpan(
                        text: "避免主播无法区分 \n2.联系方式如有虚假可通过客服投诉",
                      ),
                    ])),
              ),
            ],
          ),
        ),
        Align(
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: AppMainColors.whiteColor100,
              borderRadius:
                  BorderRadius.all(Radius.circular(44.dp.ceilToDouble())),
            ),
            child: CircleAvatar(
              radius: 42.dp.ceilToDouble(),
              backgroundImage: NetworkImage(roomInfoEntity.header!),
            ),
          ),
          alignment: Alignment.topCenter,
        )
      ]).container(height: 352.dp, width: 327.dp);

  void getOrCopyWechatNumber(BuildContext context) {
    //1,跳转到送礼物页面;2,复制微信号
    if (info.showCardAmount! <= info.roomUserSendGiftAmount!) {
      Clipboard.setData(ClipboardData(text: info.wxInfo));
      showToast("微信号已经复制");
    } else {
      // Navigator.of(context).pop();
      // navigator?.pop();
      Get.back();
    }
  }

  double? _getProcessValue() {
    if (info.showCardAmount == 0) {
      return 0;
    } else if (info.roomUserSendGiftAmount != null &&
        info.showCardAmount != null &&
        info.roomUserSendGiftAmount! >= info.showCardAmount!) {
      return 1;
    } else {
      return double.tryParse(
          ((info.roomUserSendGiftAmount! / info.showCardAmount!)
              .toStringAsFixed(2)));
    }
  }
}

class AnchorCardInfo {
  int? roomUserSendGiftAmount;
  int? showCardAmount;
  String? wxInfo;

  AnchorCardInfo(
      {this.roomUserSendGiftAmount, this.showCardAmount, this.wxInfo});

  AnchorCardInfo.fromJson(Map<String, dynamic> json) {
    roomUserSendGiftAmount = json['roomUserSendGiftAmount'];
    showCardAmount = json['showCardAmount'];
    wxInfo = json['wxInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomUserSendGiftAmount'] = this.roomUserSendGiftAmount;
    data['showCardAmount'] = this.showCardAmount;
    data['wxInfo'] = this.wxInfo;
    return data;
  }
}
