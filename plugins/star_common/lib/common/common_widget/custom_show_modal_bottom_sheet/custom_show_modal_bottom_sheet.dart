/*
 *  Copyright (C), 2015-2021
 *  FileName: custom_show_modal_bottom_sheet
 *  Author: Tonight丶相拥
 *  Date: 2021/6/2
 *  Description: 
 **/
part of appcommon;

const Duration _bottomSheetEnterDuration = Duration(milliseconds: 250);
const Duration _bottomSheetExitDuration = Duration(milliseconds: 200);
const Curve _modalBottomSheetCurve = decelerateEasing;

Future<T?> customShowModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,

  ///底部背景颜色
  Color? backgroundColor,
  double? elevation,
  ShapeBorder? shape,
  Clip? clipBehavior,

  ///上面的颜色
  Color? barrierColor,
  bool isScrollControlled = false,
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = true,
  RouteSettings? routeSettings,
  double? fixedOffsetHeight,
  bool moveWithKeyboard: false,
  AnimationController? transitionAnimationController,
}) {
  assert(debugCheckHasMediaQuery(context));
  assert(debugCheckHasMaterialLocalizations(context));

  final NavigatorState navigator =
      Navigator.of(context, rootNavigator: useRootNavigator);
  return navigator.push(_ModalBottomSheetRoute<T>(
    builder: builder,
    capturedThemes:
        InheritedTheme.capture(from: context, to: navigator.context),
    isScrollControlled: isScrollControlled,
    fixedOffset: fixedOffsetHeight,
    moveWithKeyboard: moveWithKeyboard,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    backgroundColor: backgroundColor,
    elevation: elevation,
    shape: shape,
    clipBehavior: clipBehavior,
    isDismissible: isDismissible,
    modalBarrierColor: barrierColor,
    enableDrag: enableDrag,
    settings: routeSettings,
    transitionAnimationController: transitionAnimationController,
  ));
}

class _ModalBottomSheetRoute<T> extends PopupRoute<T> {
  _ModalBottomSheetRoute({
    this.builder,
    required this.capturedThemes,
    this.barrierLabel,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.clipBehavior,
    this.modalBarrierColor,
    this.isDismissible = true,
    this.enableDrag = true,
    required this.isScrollControlled,
    RouteSettings? settings,
    this.fixedOffset,
    this.moveWithKeyboard: false,
    this.transitionAnimationController,
  }) : super(settings: settings);

  final WidgetBuilder? builder;
  final double? fixedOffset;
  final CapturedThemes capturedThemes;
  final bool isScrollControlled;
  final Color? backgroundColor;
  final double? elevation;
  final ShapeBorder? shape;
  final Clip? clipBehavior;
  final Color? modalBarrierColor;
  final bool isDismissible;
  final bool enableDrag;
  final AnimationController? transitionAnimationController;
  final bool moveWithKeyboard;

  @override
  Duration get transitionDuration => _bottomSheetEnterDuration;

  @override
  Duration get reverseTransitionDuration => _bottomSheetExitDuration;

  @override
  bool get barrierDismissible => isDismissible;

  @override
  final String? barrierLabel;

  @override
  Color get barrierColor => modalBarrierColor ?? Colors.black54;

  AnimationController? _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController = transitionAnimationController ??
        BottomSheet.createAnimationController(navigator!.overlay!);
    return _animationController!;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    // By definition, the bottom sheet is aligned to the bottom of the page
    // and isn't exposed to the top padding of the MediaQuery.
    final Widget bottomSheet = MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Builder(
        builder: (BuildContext context) {
          final BottomSheetThemeData sheetTheme =
              Theme.of(context).bottomSheetTheme;
          return _ModalBottomSheet<T>(
            route: this,
            moveWithKeyboard: moveWithKeyboard,
            fixedOffset: fixedOffset,
            backgroundColor: backgroundColor ??
                sheetTheme.modalBackgroundColor ??
                sheetTheme.backgroundColor,
            elevation:
                elevation ?? sheetTheme.modalElevation ?? sheetTheme.elevation,
            shape: shape,
            clipBehavior: clipBehavior,
            isScrollControlled: isScrollControlled,
            enableDrag: enableDrag,
          );
        },
      ),
    );
    return capturedThemes.wrap(bottomSheet);
  }
}

class _ModalBottomSheet<T> extends StatefulWidget {
  const _ModalBottomSheet({
    Key? key,
    this.route,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.clipBehavior,
    this.moveWithKeyboard: false,
    this.isScrollControlled = false,
    this.fixedOffset,
    this.enableDrag = true,
  }) : super(key: key);

  final _ModalBottomSheetRoute<T>? route;
  final bool isScrollControlled;
  final double? fixedOffset;
  final Color? backgroundColor;
  final double? elevation;
  final ShapeBorder? shape;
  final Clip? clipBehavior;
  final bool enableDrag;
  final bool moveWithKeyboard;

  @override
  _ModalBottomSheetState<T> createState() => _ModalBottomSheetState<T>();
}

class _ModalBottomSheetState<T> extends State<_ModalBottomSheet<T>> {
  ParametricCurve<double> animationCurve = _modalBottomSheetCurve;

  String _getRouteLabel(MaterialLocalizations localizations) {
    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return '';
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return localizations.dialogLabel;
    }
  }

  void handleDragStart(DragStartDetails details) {
    // Allow the bottom sheet to track the user's finger accurately.
    animationCurve = Curves.linear;
  }

  void handleDragEnd(DragEndDetails details, {bool? isClosing}) {
    // Allow the bottom sheet to animate smoothly from its current position.
    animationCurve = _BottomSheetSuspendedCurve(
      widget.route!.animation!.value,
      curve: _modalBottomSheetCurve,
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    assert(debugCheckHasMaterialLocalizations(context));
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final String routeLabel = _getRouteLabel(localizations);

    return AnimatedBuilder(
      animation: widget.route!.animation!,
      child: Padding(
        padding: EdgeInsets.zero,
        // padding: MediaQuery.of(context).viewInsets,
        child: BottomSheet(
          animationController: widget.route!._animationController,
          onClosing: () {
            if (widget.route!.isCurrent) {
              Get.back();
            }
          },
          builder: widget.route!.builder!,
          backgroundColor: widget.backgroundColor,
          elevation: widget.elevation,
          shape: widget.shape,
          clipBehavior: widget.clipBehavior,
          enableDrag: widget.enableDrag,
          onDragStart: handleDragStart,
          onDragEnd: handleDragEnd,
        ),
      ),
      builder: (BuildContext context, Widget? child) {
        // Disable the initial animation when accessible navigation is on so
        // that the semantics are added to the tree at the correct time.
        final double animationValue = animationCurve.transform(
            mediaQuery.accessibleNavigation
                ? 1.0
                : widget.route!.animation!.value);
        return Semantics(
          scopesRoute: true,
          namesRoute: true,
          label: routeLabel,
          explicitChildNodes: true,
          child: ClipRect(
            child: CustomSingleChildLayout(
              delegate: _ModalBottomSheetLayout(
                  animationValue,
                  widget.isScrollControlled,
                  widget.fixedOffset,
                  widget.moveWithKeyboard,
                  mediaQuery.viewInsets.bottom),
              child: child,
            ),
          ),
        );
      },
    );
  }
}

class _BottomSheetSuspendedCurve extends ParametricCurve<double> {
  /// Creates a suspended curve.
  const _BottomSheetSuspendedCurve(
    this.startingPoint, {
    this.curve = Curves.easeOutCubic,
  });

  /// The progress value at which [curve] should begin.
  ///
  /// This defaults to [Curves.easeOutCubic].
  final double startingPoint;

  /// The curve to use when [startingPoint] is reached.
  final Curve curve;

  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    assert(startingPoint >= 0.0 && startingPoint <= 1.0);

    if (t < startingPoint) {
      return t;
    }

    if (t == 1.0) {
      return t;
    }

    final double curveProgress = (t - startingPoint) / (1 - startingPoint);
    final double transformed = curve.transform(curveProgress);
    return lerpDouble(startingPoint, 1, transformed)!;
  }

  @override
  String toString() {
    return '${describeIdentity(this)}($startingPoint, $curve)';
  }
}

class _ModalBottomSheetLayout extends SingleChildLayoutDelegate {
  _ModalBottomSheetLayout(this.progress, this.isScrollControlled,
      this.fixedOffset, this.moveWithKeyboard, this.viewInset);

  final double progress;
  final double? fixedOffset;
  final bool isScrollControlled;
  final bool moveWithKeyboard;
  final double viewInset;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
        minWidth: constraints.maxWidth,
        maxWidth: constraints.maxWidth,
        minHeight: 0.0,
        maxHeight: constraints.maxHeight
        // maxHeight: isScrollControlled
        //     ? constraints.maxHeight
        //     : constraints.maxHeight * 9.0 / 16.0,
        );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double offset = (fixedOffset ?? childSize.height) * progress;
    if (moveWithKeyboard) {
      offset += viewInset;
    }
    if (size.height < offset) {
      offset = 40;
    } else {
      offset = size.height - offset;
    }
    return Offset(0.0, offset);
  }

  @override
  bool shouldRelayout(_ModalBottomSheetLayout oldDelegate) {
    return progress != oldDelegate.progress || moveWithKeyboard;
  }
}
