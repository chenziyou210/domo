part of appcommon;

/// 排序list
class SortList extends StatefulWidget {
  SortList(
      {this.children, required this.onReorder, this.cellAtIndex, this.length});

  /// 排序子控件
  final List<Widget>? children;

  /// 重新排序
  final void Function(int oldIndex, int newIndex) onReorder;

  /// cell 自定义
  final Widget Function(int index)? cellAtIndex;

  /// 数据长度
  final int? length;

  @override
  createState() => _SortListState();
}

class _SortListState extends State<SortList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return body;
  }

  Widget get body => Container(
        child: ReorderableListView(
          children: widget.children ??
              List.generate(widget.length ?? 0, (index) {
                return widget.cellAtIndex!(index);
              }),
          onReorder: widget.onReorder,
          padding: EdgeInsets.zero,
        ),
      );
}

/// 可滑动
class SlideSortList extends StatefulWidget {
  SlideSortList(
      {required this.child,
      required this.length,
      required this.cellTapped,
      this.onReOrder,
      this.colors = const [],
      this.functions = const [],
      this.titles = const []});

  /// 功能按钮背景色
  final List<Color> colors;

  /// 功能
  final List<void Function(int)> functions;

  /// 按钮标题
  final List<String> titles;

  /// child
  final Widget Function(int) child;

  /// DataSource
  final int length;

  final void Function(int) cellTapped;

  /// 位置发生了改变
  final void Function(int oldIndex, int newIndex)? onReOrder;

  @override
  createState() => _SlideSortListState();
}

class _SlideSortListState extends State<SlideSortList> {
  Map<String, GlobalKey<SlideButtonState>> mapKey = {};

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return body;
  }

  Widget get body => SortList(
        onReorder: (oldIndex, newIndex) {
          scrollChange();
          widget.onReOrder!(oldIndex, newIndex);
        },
        length: widget.length,
        cellAtIndex: (index) {
          GlobalKey<SlideButtonState> key;
          if (!mapKey.containsKey(index.toString())) {
            key = GlobalKey<SlideButtonState>();
            mapKey[index.toString()] = key;
          } else {
            key = mapKey[index.toString()]!;
          }
          List<Widget> buttons = [];
          for (int i = 0; i < widget.functions.length; i++) {
            buttons
                .add(buildAction(key, widget.titles[i], widget.colors[i], () {
              if (widget.functions[i] != null) widget.functions[i](index);
              key.currentState?.close();
            }));
          }
          return InkWell(
              key: ValueKey(index),
              onTap: () => widget.cellTapped(index),
              child: SlideButton(
                slideKey: key,
                index: index,
                child: widget.child(index),
                singleButtonWidth: 80,
                buttons: buttons,
                // Colors.grey[400]置顶  Colors.amber 未读 Colors.red 删除
                onSlideStarted: (index) {
                  closeOpen(index);
                },
              ));
        },
      );

  /// 功能button
  InkWell buildAction(GlobalKey<SlideButtonState> key, String text, Color color,
      GestureTapCallback tap) {
    return InkWell(
      onTap: tap,
      child: Container(
        alignment: Alignment.center,
        width: 80,
        color: color,
        child: Text(text,
            style: TextStyle(
              color: Colors.white,
            )),
      ),
    );
  }

  void scrollChange() {
    closeOpen(-1);
  }

  void closeOpen(int index) {
    if (((mapKey[index.toString()] as GlobalKey<SlideButtonState>)
                .currentState
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
