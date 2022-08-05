part of appcommon;

class FunctionList extends StatefulWidget {
  FunctionList(
      {required this.child,
      required this.length,
      required this.cellTapped,
      this.actionDecoration,
      this.actionSize: const Size(80, 80),
      this.separatorBuilder,
      this.actionMargin: 0,
      this.colors = const [],
      this.functions = const [],
      this.titles = const []})
      : assert(
            colors.length == functions.length && colors.length == titles.length,
            """colors.length cannot pairing functions.length and titles.length, 
            in other word colors.length must equals functions.length and titles.length""");

  /// child
  final Widget Function(int) child;

  /// DataSource
  final int length;

  final List<Color> colors;
  final List<void Function(int)> functions;
  final List<String> titles;

  final void Function(int) cellTapped;

  final Size actionSize;
  final BoxDecoration? actionDecoration;
  final IndexedWidgetBuilder? separatorBuilder;
  final double actionMargin;

  @override
  createState() => _FunctionListState();
}

class _FunctionListState extends State<FunctionList> {
  Map<String, GlobalKey<SlideButtonState>> mapKey = {};
  ScrollController controller = ScrollController();

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
    return ListView.separated(
      controller: controller,
      itemBuilder: (context, index) {
        GlobalKey<SlideButtonState> key;
        if (!mapKey.containsKey(index.toString())) {
          key = GlobalKey<SlideButtonState>();
          mapKey[index.toString()] = key;
        } else {
          key = mapKey[index.toString()]!;
        }
        List<Widget> buttons = [];
        for (int i = 0; i < widget.functions.length; i++) {
          buttons.add(buildAction(key, widget.titles[i], widget.colors[i], () {
            if (widget.functions[i] != null) widget.functions[i](index);
            key.currentState?.close();
          }));
        }
        return InkWell(
            onTap: () => widget.cellTapped(index),
            child: SlideButton(
              slideKey: key,
              index: index,
              child: widget.child(index),
              singleButtonWidth: widget.actionSize.width + widget.actionMargin,
              buttons: buttons,
              // Colors.grey[400]置顶  Colors.amber 未读 Colors.red 删除
              onSlideStarted: (index) {
                closeOpen(index);
              },
            ));
      },
      itemCount: widget.length,
      separatorBuilder: widget.separatorBuilder!
    );
  }

  /// 功能button
  InkWell buildAction(GlobalKey<SlideButtonState> key, String text, Color color,
      GestureTapCallback tap) {
    BoxDecoration decoration;
    decoration = widget.actionDecoration?.copyWith(
        color: color
    ) ?? BoxDecoration(
        color: color
    );
    return InkWell(
      onTap: tap,
      child: Container(
        alignment: Alignment.center,
        width: widget.actionSize.width,
        height: widget.actionSize.height,
        decoration: decoration,
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
    if (((mapKey[index.toString()] as GlobalKey<SlideButtonState>).currentState
                ?.sliderState ??
            SliderState.completed) ==
        SliderState.normal) {
      return;
    }
    mapKey.forEach((index1, k) {
      GlobalKey<SlideButtonState>? k1 = k;
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
