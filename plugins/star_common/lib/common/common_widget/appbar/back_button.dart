/*
 *  Copyright (C), 2015-2021
 *  FileName: back_button
 *  Author: Tonight丶相拥
 *  Date: 2021/3/11
 *  Description: 
 **/
part of appcommon;

class CustomBackButton extends StatelessWidget {
  const CustomBackButton(
      {Key? key,
      this.onPressed,
      this.color: Colors.black,
      this.iconSize: 25,
      this.alignment: Alignment.centerLeft,
      this.iconColor,
      this.icon,
      this.padding: const EdgeInsets.only(left: 5.5)})
      : super(key: key);

  /// 点击事件
  final VoidCallback? onPressed;

  /// 颜色
  final Color color;

  /// 按钮大小
  final double iconSize;

  /// 按钮
  final Widget? icon;

  /// 对齐方式
  final Alignment alignment;

  /// 填充
  final EdgeInsetsGeometry padding;

  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return IconButton(
      padding: this.padding,
      alignment: this.alignment,
      iconSize: iconSize, // package: "project_common",
      icon: icon ??
          Image.asset(R.comAppbarBack,
              width: 24.dp, height: 24.dp, color: iconColor),
      color: color,
      // tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        } else {
          Get.back();
        }
      },
    );
  }
}
