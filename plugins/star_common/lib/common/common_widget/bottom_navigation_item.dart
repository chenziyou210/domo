/*
 *  Copyright (C), 2015-2021
 *  FileName: bottom_navigation_item
 *  Author: Tonight丶相拥
 *  Date: 2021/7/13
 *  Description: 
 **/

part of appcommon;

class BottomNavigationItem extends StatelessWidget {
  BottomNavigationItem(
      {this.title,
      this.icon,
      this.padding,
      this.onTap,
      this.margin: 0,
      this.txtStyle,
      this.mark,
      this.alignment})
      : assert(icon != null, "icon data can not be null or empty"),
        assert(title != null, "title can not be null or empty");
  final EdgeInsetsGeometry? padding;

  /// 选中样式
  final TextStyle? txtStyle;
  final double margin;

  /// 图片
  final Widget? icon;
  final void Function()? onTap;
  final String? title;
  final Widget? mark;
  final MainAxisAlignment? alignment;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Expanded(
        flex: 1,
        child: new GestureDetector(
            onTap: onTap,
            child: Container(
                child: Padding(
                    padding: padding ?? EdgeInsets.zero,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              // mainAxisAlignment: alignment ?? MainAxisAlignment.center,
                              children: <Widget>[
                                icon ?? SizedBox(),
                                SizedBox(height: margin),
                                Text(
                                  title ?? "",
                                  style: txtStyle,
                                ),
                                SizedBox(height: 8),
                              ],
                            )),
                        mark ?? SizedBox()
                      ],
                    )))));
  }
}
