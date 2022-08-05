part of appcommon;

// class EnsureVisibleWhenFocused extends StatefulWidget {
//   const EnsureVisibleWhenFocused({
//     Key? key,
//     required this.child,
//     required this.focusNode,
//     this.curve: Curves.ease,
//     this.duration: const Duration(milliseconds: 100),
//   }) : super(key: key);
//
//   /// The node we will monitor to determine if the child is focused
//   final FocusNode focusNode;
//
//   /// The child widget that we are wrapping
//   final Widget child;
//
//   /// The curve we will use to scroll ourselves into view.
//   ///
//   /// Defaults to Curves.ease.
//   final Curve curve;
//
//   /// The duration we will use to scroll ourselves into view
//   ///
//   /// Defaults to 100 milliseconds.
//   final Duration duration;
//
//   @override
//   _EnsureVisibleWhenFocusedState createState() => new _EnsureVisibleWhenFocusedState();
// }
//
// ///
// /// We implement the WidgetsBindingObserver to be notified of any change to the window metrics
// ///
// class _EnsureVisibleWhenFocusedState extends State<EnsureVisibleWhenFocused> with WidgetsBindingObserver  {
//
//   @override
//   void initState(){
//     super.initState();
//     widget.focusNode.addListener(_ensureVisible);
//     WidgetsBinding.instance?.addObserver(this);
//   }
//
//   @override
//   void dispose(){
//     WidgetsBinding.instance?.removeObserver(this);
//     widget.focusNode.removeListener(_ensureVisible);
//     super.dispose();
//   }
//
//   ///
//   /// This routine is invoked when the window metrics have changed.
//   /// This happens when the keyboard is open or dismissed, among others.
//   /// It is the opportunity to check if the field has the focus
//   /// and to ensure it is fully visible in the viewport when
//   /// the keyboard is displayed
//   ///
//   @override
//   void didChangeMetrics(){
//     if (widget.focusNode.hasFocus){
//       _ensureVisible();
//     }
//   }
//
//   ///
//   /// This routine waits for the keyboard to come into view.
//   /// In order to prevent some issues if the Widget is dismissed in the
//   /// middle of the loop, we need to check the "mounted" property
//   ///
//   /// This method was suggested by Peter Yuen (see discussion).
//   ///
//   Future<Null> _keyboardToggled() async {
//     if (mounted){
//       EdgeInsets edgeInsets = MediaQuery.of(context).viewInsets;
//       while (mounted && MediaQuery.of(context).viewInsets == edgeInsets) {
//         await new Future.delayed(const Duration(milliseconds: 10));
//       }
//     }
//
//     return;
//   }
//
//   Future<Null> _ensureVisible() async {
//     // Wait for the keyboard to come into view
//     await Future.any([new Future.delayed(const Duration(milliseconds: 300)), _keyboardToggled()]);
//
//     // No need to go any further if the node has not the focus
//     if (!widget.focusNode.hasFocus){
//       return;
//     }
//
//     // Find the object which has the focus
//     final RenderObject? object = context.findRenderObject();
//     final RenderAbstractViewport viewport = RenderAbstractViewport.of(object)!;
//     assert(viewport != null);
//
//     // Get the Scrollable state (in order to retrieve its offset)
//     ScrollableState scrollableState = Scrollable.of(context)!;
//     assert(scrollableState != null);
//
//     // Get its offset
//     ScrollPosition position = scrollableState.position;
//
//     double alignment;
//
//
//     if (position.pixels > viewport.getOffsetToReveal(object!, 0.0).offset) {
//       // Move down to the top of the viewport
//       alignment = 0.0;
//     } else if (position.pixels <= viewport.getOffsetToReveal(object, 1.0).offset){
//       // Move up to the bottom of the viewport
//       alignment = 1.0;
//     } else {
//       // No scrolling is necessary to reveal the child
//       return;
//     }
//
//     position.ensureVisible(
//       object,
//       alignment: alignment,
//       duration: widget.duration,
//       curve: widget.curve,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }
// }

class SampleVisibleEnsure extends StatefulWidget {
  SampleVisibleEnsure(this.node, {required this.child});
  /// 子控件
  final Widget child;
  /// 聚焦
  final FocusNode node;
  @override
  createState()=> _SampleVisibleEnsureState();
}

class _SampleVisibleEnsureState extends State<SampleVisibleEnsure> {

  _VisibleSingleScrollModel get _controller =>
    Provider.of<_VisibleSingleScrollModel>(context, listen: false);

  @override
  initState(){
    super.initState();
    widget.node.addListener(_nodeListener);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return widget.child;
  }

  void _nodeListener(){
    if (widget.node.hasFocus) {
      Future.delayed(Duration(milliseconds: 300), (){
        var mediaQuery = MediaQuery.of(context);
        EdgeInsets insets = mediaQuery.viewInsets;
        var rect = _widgetRect(context);
        Size size = mediaQuery.size;
        var bottom = size.height - rect!.bottom;
        if (bottom < insets.bottom) {

          ScrollableState scrollableState = Scrollable.of(context)!;
          ScrollPosition position = scrollableState.position;

          var offset = position.pixels + insets.bottom - bottom;
          // print("bottom: $bottom, size.height: $size, rect.bottom: $rect, offset: $offset, insetBottom: ${insets.bottom}");
          // _padding = EdgeInsets.only(bottom: bottom + offset);
          _controller.changePadding(bottom + offset);
          Future.delayed(Duration(milliseconds: 0), (){
            position.animateTo(offset,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInOut);
          });
        }
      });
    }else {
      _controller.changePadding(0);
    }
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    widget.node.removeListener(_nodeListener);
    widget.node.addListener(_nodeListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.node.removeListener(_nodeListener);
  }
}

class VisibleSingleScrollView extends StatefulWidget {
  VisibleSingleScrollView({this.children: const [],
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.textBaseline,
    this.needBounds: true,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.scrollPhysics
  });
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final ScrollPhysics? scrollPhysics;
  final bool needBounds;
  @override
  createState()=> _VisibleSingleScrollViewState();
}

class _VisibleSingleScrollViewState extends State<VisibleSingleScrollView> {

  final _controller = _VisibleSingleScrollModel();

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // var m = MediaQuery.of(context);
    // var rect = _widgetRect(context);
    // double height = rect?.height ?? context.height;
    // if (height > context.height - kToolbarHeight - kRadialReactionRadius)
    //   height = context.height;
    return ChangeNotifierProvider.value(
      value: _controller,
      child: LayoutBuilder(builder: (_, constrains) {
        return SingleChildScrollView(
          physics: widget.scrollPhysics,
          child: [
            SizedBox(
              height: widget.needBounds ? constrains.maxHeight : null,
              child: Column(
                mainAxisSize: widget.mainAxisSize,
                mainAxisAlignment: widget.mainAxisAlignment,
                crossAxisAlignment: widget.crossAxisAlignment,
                textDirection: widget.textDirection,
                textBaseline: widget.textBaseline,
                verticalDirection: widget.verticalDirection,
                children: widget.children
              )
            ),
            SelectorCustom<_VisibleSingleScrollModel, double>(
              builder: (height) {
                return SizedBox(height: height);
            }, selector: (v) => v.padding)
          ].column()
        );
      }),
    );
  }
}

class _VisibleSingleScrollModel extends ChangeNotifier{
  double padding = 0.0;

  void changePadding(double value){
    padding = value;
    if (hasListeners) {
      notifyListeners();
    }
  }
}

Rect? _widgetRect(BuildContext context){
  RenderBox? renderBox = context.findRenderObject() as RenderBox?;
  if (renderBox == null){
    return null;
  }
  var offset = renderBox.localToGlobal(Offset.zero);
  return Rect.fromLTWH(offset.dx, offset.dy, renderBox.size.width, renderBox.size.height);
}