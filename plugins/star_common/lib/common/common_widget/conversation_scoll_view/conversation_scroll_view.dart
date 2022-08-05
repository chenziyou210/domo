/*
 *  Copyright (C), 2015-2021
 *  FileName: conversation_scroll_view
 *  Author: Tonight丶相拥
 *  Date: 2021/9/28
 *  Description: 
 **/


part of appcommon;

class _ConversationScrollView extends CustomScrollView {
  const _ConversationScrollView({
    Key? key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    ScrollBehavior? scrollBehavior,
    bool shrinkWrap = false,
    Key? center,
    double anchor = 0.0,
    double? cacheExtent,
    this.slivers = const <Widget>[],
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
    this.axisDirection: AxisDirection.up
  }) : super(
    key: key,
    scrollDirection: scrollDirection,
    reverse: reverse,
    controller: controller,
    primary: primary,
    physics: physics,
    scrollBehavior: scrollBehavior,
    shrinkWrap: shrinkWrap,
    center: center,
    anchor: anchor,
    cacheExtent: cacheExtent,
    semanticChildCount: semanticChildCount,
    dragStartBehavior: dragStartBehavior,
    keyboardDismissBehavior: keyboardDismissBehavior,
    restorationId: restorationId,
    clipBehavior: clipBehavior
  );

  /// The slivers to place inside the viewport.
  final List<Widget> slivers;

  final AxisDirection axisDirection;

  @override
  Widget buildViewport(BuildContext context, ViewportOffset offset,
      AxisDirection axisDirection, List<Widget> slivers) {
    return ExpandedViewport(offset: offset as ScrollPosition,
      axisDirection: this.axisDirection, slivers: slivers);
  }
}