/*
 *  Copyright (C), 2015-2021
 *  FileName: conversation_refresh_widget
 *  Author: Tonight丶相拥
 *  Date: 2021/9/28
 *  Description: 
 **/


part of appcommon;


class ConversationRefreshWidget extends StatefulWidget {
  ConversationRefreshWidget({
    this.children,
    this.childrenBuilder,
    this.header,
    this.footer: const ClassicFooter(
        loadStyle: LoadStyle.ShowWhenLoading
    ),
    this.enablePullDown: true,
    this.enablePullUp: false,
    this.enableTwoLevel: false,
    this.onRefresh,
    this.onLoading,
    this.onTwoLevel,
    // this.onOffsetChange,
    this.dragStartBehavior,
    this.primary,
    this.cacheExtent,
    this.semanticChildCount,
    this.reverse,
    this.physics,
    this.scrollDirection,
    this.scrollController});

  /// header indicator displace before content
  ///
  /// If reverse is false,header displace at the top of content.
  /// If reverse is true,header displace at the bottom of content.
  /// if scrollDirection = Axis.horizontal,it will display at left or right
  ///
  /// from 1.5.2,it has been change RefreshIndicator to Widget,but remember only pass sliver widget,
  /// if you pass not a sliver,it will throw error
  final Widget? header;

  /// footer indicator display after content
  ///
  /// If reverse is true,header displace at the top of content.
  /// If reverse is false,header displace at the bottom of content.
  /// if scrollDirection = Axis.horizontal,it will display at left or right
  ///
  /// from 1.5.2,it has been change LoadIndicator to Widget,but remember only pass sliver widget,
  //  if you pass not a sliver,it will throw error
  final Widget footer;
  // This bool will affect whether or not to have the function of drop-up load.
  final bool enablePullUp;

  /// controll whether open the second floor function
  final bool enableTwoLevel;

  /// This bool will affect whether or not to have the function of drop-down refresh.
  final bool enablePullDown;

  /// callback when header refresh
  ///
  /// when the callback is happening,you should use [RefreshController]
  /// to end refreshing state,else it will keep refreshing state
  final void Function(RefreshController)? onRefresh;

  /// callback when footer loading more data
  ///
  /// when the callback is happening,you should use [RefreshController]
  /// to end loading state,else it will keep loading state
  final void Function(RefreshController)? onLoading;

  /// callback when header ready to twoLevel
  ///
  /// If you want to close twoLevel,you should use [RefreshController.closeTwoLevel]
  final OnTwoLevel? onTwoLevel;
  //
  // /// callback when the indicator scroll out of edge
  // final OnOffsetChange? onOffsetChange;

  /// copy from ScrollView,for setting in SingleChildView,not ScrollView
  final Axis? scrollDirection;

  /// copy from ScrollView,for setting in SingleChildView,not ScrollView
  final bool? reverse;

  /// copy from ScrollView,for setting in SingleChildView,not ScrollView
  final ScrollController? scrollController;

  /// copy from ScrollView,for setting in SingleChildView,not ScrollView
  final bool? primary;

  /// copy from ScrollView,for setting in SingleChildView,not ScrollView
  final ScrollPhysics? physics;

  /// copy from ScrollView,for setting in SingleChildView,not ScrollView
  final double? cacheExtent;

  /// copy from ScrollView,for setting in SingleChildView,not ScrollView
  final int? semanticChildCount;

  /// copy from ScrollView,for setting in SingleChildView,not ScrollView
  final DragStartBehavior? dragStartBehavior;

  final List<Widget>? children;

  final List<Widget> Function(BuildContext, RefreshController)? childrenBuilder;

  @override
  createState() => _ConversationRefreshWidgetState();
}

class _ConversationRefreshWidgetState extends State<ConversationRefreshWidget> {
  /// 刷新控制器
  final RefreshController _controller = RefreshController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SmartRefresher(
        controller: _controller,
        cacheExtent: widget.cacheExtent,
        // onOffsetChange: widget.onOffsetChange,
        onLoading: () {
          widget.onLoading?.call(_controller);
        },
        onRefresh: (){
          widget.onRefresh?.call(_controller);
        },
        onTwoLevel: widget.onTwoLevel,
        primary: widget.primary,
        scrollController: widget.scrollController,
        scrollDirection: widget.scrollDirection,
        semanticChildCount: widget.semanticChildCount,
        reverse: widget.reverse,
        dragStartBehavior: widget.dragStartBehavior,
        enablePullDown: widget.enablePullDown,
        enablePullUp: widget.enablePullUp,
        enableTwoLevel: widget.enableTwoLevel,
        footer: LottieFooter(),
        header: LottieHeader(),
        physics: widget.physics,
        child: _ConversationScrollView(
            slivers: widget.children ?? widget.childrenBuilder?.call(context, _controller) ?? []
        )
    );
  }
}