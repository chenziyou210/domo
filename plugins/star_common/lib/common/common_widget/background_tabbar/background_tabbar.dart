/*
 *  Copyright (C), 2015-2021
 *  FileName: background_tabbar
 *  Author: Tonight丶相拥
 *  Date: 2021/10/21
 *  Description: 
 **/

part of appcommon;

class BackgroundTabBar extends StatelessWidget {
  BackgroundTabBar({
    required this.tabs,
    required this.controller,
    required this.child,
    this.height,
    this.width,
    this.unselectedLabelStyle,
    this.labelStyle,
    this.labelColor,
    this.unselectedLabelColor,
    this.indicatorWidth,
    this.borderSide,
    this.isScrollable,
    this.indicatorSize,
    this.indicatorColor,
    this.indicatorWeight = 2,
    this.labelPadding,
    this.decoration,
    this.indicatorPadding = EdgeInsets.zero,
    this.dragStartBehavior = DragStartBehavior.start,
    this.mouseCursor,
    this.onTap,
    this.physics});

  final double? height;
  final double? width;
  final Widget child;

  /// 子控件集合
  final List<Widget> Function(BuildContext) tabs;
  final TabController controller;
  /// 未选中标题样式
  final TextStyle? unselectedLabelStyle;
  /// 选中标题样式
  final TextStyle? labelStyle;
  /// 选中标题颜色
  final Color? labelColor;
  /// 未选中标题颜色
  final Color? unselectedLabelColor;
  /// 指示器宽度
  final double? indicatorWidth;
  /// 指示器border(color、width)
  final BorderSide? borderSide;
  final bool? isScrollable;
  final TabBarIndicatorSize? indicatorSize;
  final Color? indicatorColor;
  final double indicatorWeight;
  final EdgeInsetsGeometry? labelPadding;
  final EdgeInsetsGeometry indicatorPadding;
  final DragStartBehavior dragStartBehavior;
  final MouseCursor? mouseCursor;
  final ValueChanged<int>? onTap;
  final ScrollPhysics? physics;
  final Decoration? decoration;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // double w = 0;//= (this.width ?? _widgetRect(context)) ?? context.width;
    // if (this.width != null) {
    //   w = this.width!;
    // }else if (_widgetRect(context) != null) {
    //   w = _widgetRect(context)!.width;
    // }else {
    //   w = context.width;
    // }
    return LayoutBuilder(builder: (_, constrains) {
      return Stack(
          alignment: Alignment.center,
          children: [
            _BackgroundColorWidget(
                child: child,
                childWidth: width,
                width: constrains.maxWidth,
                controller: controller
            ),
            CustomTabBar(tabs: tabs,
                controller: controller,
                unselectedLabelStyle: unselectedLabelStyle,
                labelStyle: labelStyle,
                labelColor: labelColor,
                unselectedLabelColor: unselectedLabelColor,
                indicatorWidth: indicatorWidth,
                borderSide: borderSide,
                isScrollable: isScrollable,
                indicatorSize: indicatorSize,
                indicatorColor: indicatorColor,
                indicatorWeight: indicatorWeight,
                labelPadding: labelPadding,
                decoration: decoration,
                indicatorPadding: indicatorPadding,
                dragStartBehavior: dragStartBehavior,
                mouseCursor: mouseCursor,
                onTap: onTap,
                physics: physics
            )
          ]
      ).sizedBox(height: height);
    });
  }
}

class _BackgroundColorWidget extends StatefulWidget {
  _BackgroundColorWidget({required this.controller,
    required this.child, required this.width, this.childWidth});
  final Widget child;
  final TabController controller;
  final double width;
  final double? childWidth;
  @override
  createState()=> _BackgroundColorWidgetState();
}

class _BackgroundColorWidgetState extends State<_BackgroundColorWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller.animation!.addListener(_listener);
  }

  void _listener(){
    setState((){});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.controller.animation!.removeListener(_listener);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double offset = 0;
    if (widget.childWidth != null) {
      offset = widget.width / widget.controller.length - widget.childWidth!;
      offset = offset / 2;
    }
    return Positioned(
        child: widget.child,
        left: widget.controller.animation!.value * widget.width
            / widget.controller.length + offset);
    // return LayoutBuilder(builder: (_, constrains) {
    //   return  Positioned(
    //     child: child,
    //     left: controller.animation!.value
    //         * constrains.maxWidth / controller.length
    //   );
    // });
  }
}