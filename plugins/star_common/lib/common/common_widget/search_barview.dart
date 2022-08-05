import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:star_common/common/app_common_widget.dart';

import 'package:star_common/config/app_layout.dart';

import '../../app_images/r.dart';

class SearchAppBarPage extends StatelessWidget implements PreferredSizeWidget {
  final String? leftIcon, rightIcon, rightText, leftText;
  final Widget? leftWidget, rightWidget;
  final double? iconWidth;
  final bool? tfEnable;
  final Color? rightTextColor;
  final List<Widget>? rightWidgets;
  final GestureTapCallback? onPressedLeft, onPressedMiddle, onPressedRight;
  final void Function(String)? submitTap;
  final void Function(String)? onValueChange;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextStyle? rightTextStyle;
  final BuildContext? baseContext;

  const SearchAppBarPage({
    Key? key,
    this.leftIcon,
    this.rightIcon,
    this.leftText,
    this.rightText,
    this.iconWidth,
    this.tfEnable = true,
    this.onPressedLeft,
    this.onPressedMiddle,
    this.onPressedRight,
    this.onValueChange,
    this.submitTap,
    this.leftWidget,
    this.rightWidget,
    this.rightTextStyle,
    this.rightTextColor,
    this.controller,
    this.focusNode,
    this.rightWidgets = const [],
    this.baseContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      AppBar(
      backgroundColor: Colors.transparent,
      titleSpacing: 0,
      title: Container(
        height: 32.dp,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppMainColors.separaLineColor6,
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          border: Border.all(color: AppMainColors.separaLineColor10),
        ),
        child: TextField(
          controller: controller ?? TextEditingController(),
          maxLines: 1,
          inputFormatters: [
            FilteringTextInputFormatter.allow(
                RegExp("[a-zA-Z]|[\u4e00-\u9fa5]|[0-9_]")),
          ],
          decoration: InputDecoration(
            // border: InputBorder.none,
            isCollapsed: true,
            hintStyle: TextStyle(
                fontWeight: w_400,
                fontSize: 14.sp,
                color: AppMainColors.whiteColor20),
            hintText: intl.homeSearchHint,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(left: -10),
            isDense: true,
            enabled: tfEnable!,
            icon: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Image.asset(
                  R.homeSearchIcon,
                  width: 16.dp,
                  height: 16.dp,
                  fit: BoxFit.cover,
                )),
          ),
          style: TextStyle(
              fontWeight: w_400,
              fontSize: 14.sp,
              color: AppMainColors.whiteColor100),
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          textInputAction: TextInputAction.send,
          focusNode: focusNode,
          //内容改变回调
          onChanged: (text) => onValueChange!(text),
          //内容提交（回车）回调
          onSubmitted: (text) => submitTap!(text),
          //按回车调用
          onEditingComplete: () {
            submitTap!(controller?.text ?? "");
          },
        ).inkWell(onTap: onPressedMiddle),
      ),
      // centerTitle: true,
      ///左边图标
      leading: leftWidget ??
          IconButton(
            // icon:Image.asset(AppImages.backIconWhite,width: 16,height: 16,),
            icon: Image.asset(
              leftIcon!,
              width: 24.dp,
              height: 24.dp,
            ),
            iconSize: 10,
            onPressed: onPressedLeft,
          ),

      ///右边图标集
      actions: rightWidgets!.isNotEmpty
          ?
          //1.如果是右边数组 ，优先读取数组
          rightWidgets
          : [
              //2.如果自定义右边Widget 展示widget
              rightWidget ??
                  (rightIcon != null
                      ?
                      //3.如果有图片 ，展示图片按钮
                      IconButton(
                          // icon:Image.asset(AppImages.backIconWhite,width: 16,height: 16,),
                          icon: Image.asset(rightIcon!),
                          iconSize: 10,
                          onPressed: onPressedRight)
                      :
                      //4.暂时文字按钮
                      TextButton(
                          // 去掉水波纹
                          style: ButtonStyle(overlayColor:
                              MaterialStateProperty.resolveWith((states) {
                            return Colors.transparent;
                          })),
                          onPressed: onPressedRight,
                          child: Text(
                            rightText!,
                            style: rightTextStyle ??
                                TextStyle(
                                  fontSize: 14.sp,
                                  color: rightTextColor ??
                                      AppMainColors.whiteColor40,
                                ),
                          )))
            ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize {
    // double insetTop = MediaQuery.of(baseContext!).padding.top;
    //  double height  = insetTop > 20 ? 56 : 56;
    return const Size.fromHeight(56);
  }
}
