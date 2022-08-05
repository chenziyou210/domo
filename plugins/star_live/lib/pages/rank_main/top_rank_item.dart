import 'package:flutter/material.dart';
import 'package:star_common/common/app_common_widget.dart';

import 'package:star_common/common/common_widget/custom_gradientbutton/custom_gradientbutton.dart';
import 'live_avatar.dart';

class TopRankItem extends StatelessWidget {
  final String? localNumIcon;
  final String? nikeName;
  final String? rankFire;
  final bool? showFocusBtn;
  final bool? showLevel;

  /// 是否展示等级
  final bool? isFocus;

  /// 是否关注了
  final int? level;
  final double topSpaceHeight;
  final EdgeInsets? margin,nikeNameEdge;
  final BoxShadow shadow;
  final GestureTapCallback? onPressed;
  final OnLiveAvatar avatarChild;

  const TopRankItem({
    Key? key,
    this.nikeName = "虚位以待",
    this.rankFire,
    this.isFocus = false,
    this.showFocusBtn = false,
    this.showLevel = false,
    this.margin = const EdgeInsets.all(0),
    this.nikeNameEdge = const EdgeInsets.only(left: 15,right: 10,top: 5),
    this.topSpaceHeight = 0.0,
    this.shadow = const BoxShadow(),
    this.level,
    this.onPressed,
    required this.localNumIcon,
    required this.avatarChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        //背景
        Positioned.fill(
          child: Container(
            margin: margin,
            // child: Image.asset(
            //     AppImages.me_gxb_third,
            //     fit: BoxFit.cover,
            // ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xffF5EFFF), Color(0xffC7DBFF)],
              ),
              color: Colors.blueGrey,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0)),
              boxShadow: [shadow],
            ),
          ),
        ),
        Image.asset(
          localNumIcon!,
          width: 42.dp,
          height:70 ,
          fit: BoxFit.cover,
        ).position(right: 0, top: 0),
        //富文本
        Container(
          // padding: EdgeInsets.only(left: 12,right: 12),
          // color: Colors.brown,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              //间距
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Container(height: topSpaceHeight),
              ),
              //换行符
              const TextSpan(text: "\n"),
              //间距
              WidgetSpan(
                child: Container(height: 25),
              ),

              ///头像组件
              WidgetSpan(
                child: avatarChild,
              ),
              //换行符
              const TextSpan(text: "\n"),
              //间距
              const WidgetSpan(child: SizedBox(height: 10)),
              /// 昵称
              WidgetSpan(
                child: Container(
                  height:30 ,
                  // width: double.infinity,
                  // color: Colors.yellow,
                  alignment: Alignment.center,
                  padding: nikeNameEdge,
                  child: Text(
                      nikeName ?? "虚位以待",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: AppMainColors.string2Color("333333"))),
                ),
              ),
              //换行符
              const TextSpan(text: '\n'),
              //间距
              const WidgetSpan(child: SizedBox(height: 5)),
              //换行符
              /// 火力值
              TextSpan(
                text: rankFire!.length > 0 ? "$rankFire 火力" : "",
                style: TextStyle(
                    fontSize: 13.sp,
                    fontFamily: "Number",
                    color: AppMainColors.string2Color("999999"),
                    height: 2
                ),
              ),
              //间距
              //换行符
              const TextSpan(text: '\n'),
              const WidgetSpan(child: SizedBox(height: 25)),

              // 等级
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: showLevel == true
                    ? UserLevelView(level ?? 0)
                    : const SizedBox(),
              ),
              //换行
              const TextSpan(text: '\n'),

              // 关注按钮
              WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: showFocusBtn == false
                      ? const SizedBox()
                      : GradientButton(
                          onPressed: onPressed,
                          // isFocus == true ? null : onPressed,
                          child: Text(isFocus == true ? "已关注" : "关注"),
                          size: 12,
                          textColor: isFocus == true
                              ? AppMainColors.mainColor60
                              : AppMainColors.mainColor,
                          bgColor: isFocus == true
                              ? AppMainColors.whiteColor60
                              : AppMainColors.whiteColor100,
                        )),
            ]),
          ),
        ),
      ],
    );
  }
}
