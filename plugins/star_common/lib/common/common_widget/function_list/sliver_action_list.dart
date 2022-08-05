/*
 *  Copyright (C), 2015-2021 , schw
 *  FileName: sliver_action_list
 *  Author: Tonight丶相拥
 *  Date: 2021/1/21
 *  Description: 
 **/

part of appcommon;

class SliverActionList extends StatefulWidget {
  SliverActionList(
      {required this.builder,
        required this.length,
        required this.cellTapped,
        required this.controller,
        this.colors = const [],
        this.actionDecoration,
        this.actionSize: const Size(80, 80),
        this.actionMargin: 0,
        this.functions = const [],
        this.popIntercept: false,
        this.rightMargin,
        this.stackAlignment,
        this.titles = const [] //this.insets = const EdgeInsets.symmetric(horizontal: margin * 2),
})
      : assert(
  colors.length == functions.length && colors.length == titles.length,
  """colors.length cannot pairing functions.length and titles.length, 
            in other word colors.length must equals functions.length and titles.length""");

  /// 子控件生成器
  final Widget Function(BuildContext context, int index) builder;
  /// 数据长度
  final int length;
  ///按钮餐宿
  final List<Color> colors;
  final List<void Function(int)> functions;
  final List<String> titles;
  /// 点击事件
  final void Function(int) cellTapped;
  /// 滚动控制器
  final ScrollController controller;
  final Size actionSize;
  final BoxDecoration? actionDecoration;
  final double actionMargin;
  final bool popIntercept;
  final double? rightMargin;
  final AlignmentGeometry? stackAlignment;

  @override
  createState() => _SliverActionListState(controller);
}

class _SliverActionListState extends State<SliverActionList> {
  _SliverActionListState(this.controller);
  Map<String, GlobalKey<SlideButtonState>> mapKey = {};
  ScrollController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ignore: invalid_use_of_protected_member
    if (!controller.hasListeners) controller.addListener(scrollChange);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, int index) {
        GlobalKey<SlideButtonState> key;
        if (!mapKey.containsKey(index.toString())) {
          key = GlobalKey<SlideButtonState>();
          mapKey[index.toString()] = key;
        } else {
          key = mapKey[index.toString()]!;
        }
        List<Widget> buttons = [];
        BoxDecoration decoration;
        for (int i = 0; i < widget.functions.length; i++) {
          decoration = widget.actionDecoration?.copyWith(
              color: widget.colors[i]
          ) ?? BoxDecoration(
              color: widget.colors[i]
          );

          buttons.add(InkWell(
            onTap: () {
              if (widget.functions[i] != null) widget.functions[i](index);
              key.currentState?.close();
            },
            child: Container(
              alignment: Alignment.center,
              width: widget.actionSize.width,
              height: widget.actionSize.height,
              decoration: decoration,
              child: Text(widget.titles[i],
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
          ));
        }
        return InkWell(
            onTap: () => widget.cellTapped(index),
            child: SlideButton(
              slideKey: key,
              rightMargin: widget.rightMargin,
              popIntercept: widget.popIntercept,
              stackAlignment: widget.stackAlignment,
              index: index,
              child: widget.builder(context, index),
              singleButtonWidth: widget.actionSize.width + widget.actionMargin,
              buttons: buttons,
              // Colors.grey[400]置顶  Colors.amber 未读 Colors.red 删除
              onSlideStarted: (index) {
                closeOpen(index);
              },
            ));
      }, childCount: widget.length)
    );
  }

  void scrollChange() {
    closeOpen(-1);
  }

  void closeOpen(int index) {
    GlobalKey<SlideButtonState>? key = mapKey[index.toString()];
    if ((key?.currentState
        ?.sliderState ??
        SliderState.completed) ==
        SliderState.normal) {
      return;
    }
    mapKey.forEach((index1, k) {
      GlobalKey<SlideButtonState> k1 = k;
      if (index1 != index.toString()) {
        if ((k1.currentState?.sliderState ?? SliderState.completed) !=
            SliderState.normal) k1.currentState?.close();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}