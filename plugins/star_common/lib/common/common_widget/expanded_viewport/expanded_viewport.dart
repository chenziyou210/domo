/*
 *  Copyright (C), 2015-2021
 *  FileName: expanded_viewport
 *  Author: Tonight丶相拥
 *  Date: 2021/9/28
 *  Description: 
 **/
part of appcommon;

class ExpandedViewport extends Viewport {
  ExpandedViewport({
    Key? key,
    AxisDirection axisDirection = AxisDirection.down,
    AxisDirection? crossAxisDirection,
    double anchor = 0.0,
    required ScrollPosition offset,
    Key? center,
    double? cacheExtent,
    List<Widget> slivers = const <Widget>[],
  }) : super(
      key: key,
      slivers: slivers,
      axisDirection: axisDirection,
      crossAxisDirection: crossAxisDirection,
      anchor: anchor,
      offset: offset,
      center: center,
      cacheExtent: cacheExtent);

  @override
  RenderViewport createRenderObject(BuildContext context) {
    // TODO: implement createRenderObject
    return _RenderExpandedViewport(
      axisDirection: axisDirection,
      crossAxisDirection: crossAxisDirection ??
          Viewport.getDefaultCrossAxisDirection(context, axisDirection),
      anchor: anchor,
      offset: offset,
      cacheExtent: cacheExtent,
    );
  }
}

class _RenderExpandedViewport extends RenderViewport {
  _RenderExpandedViewport({
    AxisDirection axisDirection = AxisDirection.down,
    required AxisDirection crossAxisDirection,
    required ViewportOffset offset,
    double anchor = 0.0,
    List<RenderSliver>? children,
    RenderSliver? center,
    double? cacheExtent,
  }) : super(
      axisDirection: axisDirection,
      crossAxisDirection: crossAxisDirection,
      offset: offset,
      anchor: anchor,
      children: children,
      center: center,
      cacheExtent: cacheExtent);

  @override
  void performLayout() {
    // TODO: implement performLayout
    super.performLayout();
    RenderSliver? expand;
    RenderSliver p = firstChild!;
    double totalLayoutExtent = 0;
    double BehindExtent = 0.0, FrontExtent = 0.0;
    while (p != null) {
      totalLayoutExtent += p.geometry!.scrollExtent;
      if (p is _RenderExpanded) {
        expand = p;
        FrontExtent = totalLayoutExtent;
      }

      p = childAfter(p)!;
    }
    double count = 0;
    BehindExtent = totalLayoutExtent - FrontExtent;
    if (expand != null && size.height > totalLayoutExtent) {
      _attemptLayout(expand, size.height, size.width,
          offset.pixels - FrontExtent - (size.height - totalLayoutExtent));
    }
  }

  /// mainAxisExtent 主轴 也就是高
  /// crossAxisExtent 纵轴 也就是宽
  /// correctedOffset 纠正偏移量
  // _minScrollExtent private in super,no setter method
  double _attemptLayout(RenderSliver expandPosition, double mainAxisExtent,
      double crossAxisExtent, double correctedOffset) {
    assert(!mainAxisExtent.isNaN);
    assert(mainAxisExtent >= 0.0);
    assert(crossAxisExtent.isFinite);
    assert(crossAxisExtent >= 0.0);
    assert(correctedOffset.isFinite);

    // centerOffset is the offset from the leading edge of the RenderViewport
    // to the zero scroll offset (the line between the forward slivers and the
    // reverse slivers).
    ///第一个sliver布局开始点的偏移
    final double centerOffset = mainAxisExtent * anchor - correctedOffset;

    ///反向余留的绘制范围
    final double reverseDirectionRemainingPaintExtent =
    centerOffset.clamp(0.0, mainAxisExtent);

    ///正向余留的绘制范围
    final double forwardDirectionRemainingPaintExtent =
    (mainAxisExtent - centerOffset).clamp(0.0, mainAxisExtent);
    ///总共的缓存范围
    final double fullCacheExtent = mainAxisExtent + 2 * cacheExtent!;
    ///
    final double centerCacheOffset = centerOffset + cacheExtent!;
    ///反向余留的缓存范围
    final double reverseDirectionRemainingCacheExtent =
    centerCacheOffset.clamp(0.0, fullCacheExtent);
    /// 正向余留的缓存范围
    final double forwardDirectionRemainingCacheExtent =
    (fullCacheExtent - centerCacheOffset).clamp(0.0, fullCacheExtent);

    final RenderSliver? leadingNegativeChild = childBefore(center!);//给定center之前的控件
    // positive scroll offsets
    return layoutChildSequence(
      child: expandPosition,///布局的起始child，类型必须是RenderSliver
      scrollOffset: math.max(0.0, -centerOffset),///centerSliver的偏移量
      overlap:
      leadingNegativeChild == null ? math.min(0.0, -centerOffset) : 0.0,
      layoutOffset: centerOffset >= mainAxisExtent///布局的偏移量
          ? centerOffset
          : reverseDirectionRemainingPaintExtent,
      remainingPaintExtent: forwardDirectionRemainingPaintExtent,///剩余需要绘制的范围
      mainAxisExtent: mainAxisExtent,///viewport的主轴范围
      crossAxisExtent: crossAxisExtent,///viewport的纵轴范围
      growthDirection: GrowthDirection.forward,///增长方向
      advance: childAfter,
      remainingCacheExtent: forwardDirectionRemainingCacheExtent,///剩余需要缓存的范围
      cacheOrigin: centerOffset.clamp(-cacheExtent!, 0.0),///缓存的起点
    );
  }
}

//tag
class SliverExpanded extends SingleChildRenderObjectWidget {
  SliverExpanded() : super(child: Container());

  @override
  RenderSliver createRenderObject(BuildContext context) {
    // TODO: implement createRenderObject
    return _RenderExpanded();
  }
}

class _RenderExpanded extends RenderSliver
    with RenderObjectWithChildMixin<RenderBox> {
  @override
  void performLayout() {
    // TODO: implement performLayout
    geometry = SliverGeometry.zero;
  }
}