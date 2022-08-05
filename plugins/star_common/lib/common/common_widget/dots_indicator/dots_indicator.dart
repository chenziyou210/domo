/*
 *  Copyright (C), 2015-2021
 *  FileName: dots_indicator
 *  Author: Tonight丶相拥
 *  Date: 2021/9/15
 *  Description: 
 **/

part of appcommon;

class DotsIndicatorNormal extends AnimatedWidget {
  DotsIndicatorNormal(
      {required this.controller,
      required this.onPageSelected,
      required this.itemCount,
      this.color: AppMainColors.mainColor,
      this.unSelectColor: Colors.white,
      this.kDotSize = 8,
      this.kDotSpacing = 16})
      : super(listenable: controller);

  /// 页面控制器
  final PageController controller;

  /// 页面数量
  final int itemCount;

  /// 下边改变通知
  final ValueChanged<int> onPageSelected;

  /// 颜色
  final Color color;
  final Color unSelectColor;

  /// 下标大小
  final double kDotSize;

  /// 间距
  final double kDotSpacing;

  @override
  Widget build(BuildContext context) {
    /// 计算界面占位宽度
    double _width = MediaQuery.of(context).size.width ;
    // TODO: implement build
    return Stack(children: [
      Container(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(itemCount, (index) {
                return Container(
                    width: kDotSpacing,
                    child: Center(
                        child: Material(
                            color: unSelectColor,
                            type: MaterialType.card,
                            child: Container(
                                width: kDotSize,
                                height: 2,
                                child: InkWell(
                                    onTap: () => onPageSelected(index))))));
              }))),
      Positioned(
          child: Container(
              width: kDotSpacing,
              child: Center(
                  child: Material(
                      color: color,
                      type: MaterialType.card,
                      child: Container(width: kDotSize, height: 2)))),
          left: (_width - kDotSpacing * itemCount) / 2 +
              kDotSpacing * (controller.page ?? controller.initialPage))
    ]);
  }
}

class DotsIndicator extends AnimatedWidget {
  DotsIndicator(
      {required this.controller,
      this.color: Colors.white,
      required this.itemCount,
      this.kDotSize = 8.0,
      this.kDotSpacing = 25.0,
      this.kMaxZoom = 2.0,
      required this.onPageSelected})
      : super(listenable: controller);

  /// 页面控制器
  final PageController controller;

  /// 页面数量
  final int itemCount;

  /// 下边改变通知
  final ValueChanged<int> onPageSelected;

  /// 颜色
  final Color color;

  /// 下标大小
  final double kDotSize;

  /// 最大缩放
  final double kMaxZoom;

  /// 间距
  final double kDotSpacing;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(itemCount, (index) {
          double selectedness = Curves.easeOut.transform(math.max(
              0.0,
              1.0 -
                  ((controller.page ?? controller.initialPage) - index).abs()));
          double zoom = 1.0 + (kMaxZoom - 1.0) * selectedness;
          return Container(
              width: kDotSpacing,
              child: Center(
                  child: Material(
                      color: color,
                      type: MaterialType.circle,
                      child: Container(
                          width: kDotSize * zoom,
                          height: kDotSize * zoom,
                          child:
                              InkWell(onTap: () => onPageSelected(index))))));
        }));
  }
}
