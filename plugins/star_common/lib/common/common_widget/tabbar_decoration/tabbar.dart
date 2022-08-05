
part of appcommon;
class CustomTabBar extends StatelessWidget {
  CustomTabBar({
    required this.tabs,
    required this.controller,
    TextStyle? unselectedLabelStyle,
    TextStyle? labelStyle,
    Color? labelColor,
    Color? unselectedLabelColor,
    double? indicatorWidth,
    BorderSide? borderSide,
    bool? isScrollable,
    TabBarIndicatorSize? indicatorSize,
    Color? indicatorColor,
    this.indicatorWeight = 2,
    this.labelPadding,
    this.decoration,
    this.indicatorPadding = EdgeInsets.zero,
    this.dragStartBehavior = DragStartBehavior.start,
    this.mouseCursor,
    this.onTap,
    this.physics
  }): this.unselectedLabelStyle = unselectedLabelStyle ?? TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
  this.labelStyle = labelStyle ?? TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
  this.labelColor = labelColor ?? Colors.black,
  this.unselectedLabelColor = unselectedLabelColor,
  this.indicatorWidth = indicatorWidth ?? 0,
  this.borderSide = borderSide ?? BorderSide(width: 2.0, color: Colors.black),
  this.isScrollable = isScrollable ?? false,
  this.indicatorSize = indicatorSize ?? TabBarIndicatorSize.label,
  this.indicatorColor = indicatorColor ?? Colors.black;

  /// 子控件集合
  final List<Widget> Function(BuildContext) tabs;
  final TabController controller;
  /// 未选中标题样式
  final TextStyle unselectedLabelStyle;
  /// 选中标题样式
  final TextStyle labelStyle;
  /// 选中标题颜色
  final Color labelColor;
  /// 未选中标题颜色
  final Color? unselectedLabelColor;
  /// 指示器宽度
  final double indicatorWidth;
  /// 指示器border(color、width)
  final BorderSide borderSide;
  final bool isScrollable;
  final TabBarIndicatorSize indicatorSize;
  final Color indicatorColor;
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
    return
      Container(
        alignment: Alignment.topLeft,
        child: TabBar(tabs: tabs(context), controller: controller,
            unselectedLabelStyle: unselectedLabelStyle,
            labelStyle: labelStyle,
            indicatorWeight: indicatorWeight,
            labelPadding: labelPadding,
            indicatorPadding: indicatorPadding,
            dragStartBehavior: dragStartBehavior,
            mouseCursor: mouseCursor,
            onTap: onTap,
            physics: physics,
            labelColor: labelColor,
            unselectedLabelColor: unselectedLabelColor,
            indicator: decoration ?? UnderlineTabIndicatorCustom(width: indicatorWidth, borderSide: borderSide),
            isScrollable: isScrollable,
            indicatorSize: indicatorSize,
            indicatorColor: indicatorColor),
      );


  }
}



class CustomTabBar1 extends StatelessWidget {
  CustomTabBar1({
    required this.tabs,
    required this.controller,
    TextStyle? unselectedLabelStyle,
    TextStyle? labelStyle,
    Color? labelColor,
    Color? unselectedLabelColor,
    double? indicatorWidth,
    BorderSide? borderSide,
    bool? isScrollable,
    TabBarIndicatorSize? indicatorSize,
    Color? indicatorColor,
    this.indicatorWeight = 2,
    this.labelPadding,
    this.decoration,
    this.indicatorPadding = EdgeInsets.zero,
    this.dragStartBehavior = DragStartBehavior.start,
    this.mouseCursor,
    this.onTap,
    this.physics
  }): this.unselectedLabelStyle = unselectedLabelStyle ?? TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
        this.labelStyle = labelStyle ?? TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
        this.labelColor = labelColor ?? Colors.black,
        this.unselectedLabelColor = unselectedLabelColor,
        this.indicatorWidth = indicatorWidth ?? 0,
        this.borderSide = borderSide ?? BorderSide(width: 2.0, color: Colors.black),
        this.isScrollable = isScrollable ?? false,
        this.indicatorSize = indicatorSize ?? TabBarIndicatorSize.label,
        this.indicatorColor = indicatorColor ?? Colors.black;

  /// 子控件集合
  final List<Widget> Function(BuildContext) tabs;
  final TabController controller;
  /// 未选中标题样式
  final TextStyle unselectedLabelStyle;
  /// 选中标题样式
  final TextStyle labelStyle;
  /// 选中标题颜色
  final Color labelColor;
  /// 未选中标题颜色
  final Color? unselectedLabelColor;
  /// 指示器宽度
  final double indicatorWidth;
  /// 指示器border(color、width)
  final BorderSide borderSide;
  final bool isScrollable;
  final TabBarIndicatorSize indicatorSize;
  final Color indicatorColor;
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
    return EliminateFontAnimationTabBar(tabs: tabs(context), controller: controller,
        unselectedLabelStyle: unselectedLabelStyle,
        labelStyle: labelStyle,
        indicatorWeight: indicatorWeight,
        labelPadding: labelPadding,
        indicatorPadding: indicatorPadding,
        dragStartBehavior: dragStartBehavior,
        mouseCursor: mouseCursor,
        onTap: onTap,
        physics: physics,
        labelColor: labelColor,
        unselectedLabelColor: unselectedLabelColor,
        indicator: decoration ?? UnderlineTabIndicatorCustom(width: indicatorWidth, borderSide: borderSide),
        isScrollable: isScrollable, indicatorSize: indicatorSize,
        indicatorColor: indicatorColor);
  }
}