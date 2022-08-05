
part of appcommon;

enum SliderState { starting, completed, normal }

class SlideButton extends StatefulWidget {
  final Widget child;
  final List<Widget> buttons;
  final GlobalKey<SlideButtonState>? slideKey;
  final double singleButtonWidth;
  final int index;

  /// 滑动开始
  final void Function(int index)? onSlideStarted;

  /// 滑动完成
  final void Function(int index)? onSlideCompleted;

  /// 取消滑动
  final void Function(int index)? onSlideCanceled;
  final double? rightMargin;
  final bool popIntercept;
  final AlignmentGeometry? stackAlignment;

  SlideButton(
      {this.slideKey,
      required this.child,
      required this.singleButtonWidth,
      required this.buttons,
      required this.index,
      this.onSlideCanceled,
      this.onSlideCompleted,
        this.stackAlignment,
      this.onSlideStarted, this.rightMargin, this.popIntercept: false})
      : super(key: slideKey);

  @override
  createState() => SlideButtonState();
}

class SlideButtonState extends State<SlideButton>
    with TickerProviderStateMixin {
  /// x 方向上动画
  double transLateX = 0;

  /// 最大拖动距离
  late double maxDragDistance;

  /// 手势字典
  final Map<Type, GestureRecognizerFactory> gestures = {};

  /// 动画控制器
  late AnimationController animation;

  /// 滑动状态
  late SliderState sliderState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    maxDragDistance = widget.singleButtonWidth * widget.buttons.length;

    gestures[HorizontalDragGestureRecognizer] =
        GestureRecognizerFactoryWithHandlers<HorizontalDragGestureRecognizer>(
            () => HorizontalDragGestureRecognizer(debugOwner: this),
            (HorizontalDragGestureRecognizer instance) {
      instance
        ..onDown = onHorizontalDragDown
        ..onUpdate = onHorizontalDragUpdate
        ..onEnd = onHorizontalDragEnd
        ..onStart = onHorizontalStart;
    });
    animation = AnimationController(
        vsync: this,
        lowerBound: -maxDragDistance,
        upperBound: 0,
        duration: Duration(milliseconds: 300))
      ..addListener(() {
        transLateX = animation.value;
        updateState();
      });
    sliderState = SliderState.normal;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        child: Stack(
          alignment: widget.stackAlignment ?? AlignmentDirectional.topStart,
          children: <Widget>[
            Positioned.fill(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: widget.buttons,
            ), right: widget.rightMargin ?? 0),
            RawGestureDetector(
              gestures: gestures,
              child: Transform.translate(
                offset: Offset(transLateX, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[Expanded(child: widget.child)],
                ),
              ),
            )
          ],
        ),
        onWillPop: () async {
          if (transLateX != 0) {
            close();
            return widget.popIntercept;
            // return false;
          }
          return true;
        });
  }

  void updateState() {
    setState(() {});
  }

  void onHorizontalDragDown(DragDownDetails details) {
//    sliderState = SliderState.starting;
//    if (widget.onSlideStarted != null) widget.onSlideStarted(widget.index);
  }

  void onHorizontalStart(DragStartDetails details) {
//    print('the details is --  ---${details.localPosition} ---  ${details.globalPosition}--  ');
  }

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    sliderState = SliderState.starting;
    transLateX = (transLateX + details.delta.dx).clamp(-maxDragDistance, 0.0);
    updateState();
    if (widget.onSlideStarted != null && details.delta.dx < 0) widget.onSlideStarted?.call(widget.index);
  }

  void onHorizontalDragEnd(DragEndDetails details) {
    animation.value = transLateX;
    if (details.velocity.pixelsPerSecond.dx > 200) {
      close();
    } else if (details.velocity.pixelsPerSecond.dx < -200) {
      open();
    } else {
      if (transLateX.abs() > maxDragDistance / 2) {
        open();
      } else {
        close();
      }
    }
  }

  void open() {
    sliderState = SliderState.completed;
    if (transLateX != -maxDragDistance) {
      animation.animateTo(-maxDragDistance).then((_) {
        if (widget.onSlideCompleted != null) widget.onSlideCompleted?.call(widget.index);
      });
    }
  }

  void close() {
    sliderState = SliderState.normal;
    if (transLateX != 0)
      animation.animateTo(0).then((_) {
        if (widget.onSlideCanceled != null) widget.onSlideCanceled?.call(widget.index);
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animation.dispose();
    super.dispose();
  }
}
