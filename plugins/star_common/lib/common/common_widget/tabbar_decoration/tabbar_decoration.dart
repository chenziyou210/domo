part of appcommon;

class UnderlineTabIndicatorCustom extends Decoration {
  /// Create an underline style selected tab indicator.
  ///
  /// The [borderSide] and [insets] arguments must not be null.
  const UnderlineTabIndicatorCustom({
    this.borderSide = const BorderSide(width: 2.0, color: Colors.white),
    this.insets = EdgeInsets.zero, this.width: 0
  });

  /// The color and weight of the horizontal line drawn below the selected tab.
  final BorderSide borderSide;
  final double width;

  /// Locates the selected tab's underline relative to the tab's boundary.
  ///
  /// The [TabBar.indicatorSize] property can be used to define the tab
  /// indicator's bounds in terms of its (centered) tab widget with
  /// [TabBarIndicatorSize.label], or the entire tab with
  /// [TabBarIndicatorSize.tab].
  final EdgeInsetsGeometry insets;

  @override
  Decoration? lerpFrom(Decoration? a, double t) {
    if (a is UnderlineTabIndicator) {
      return UnderlineTabIndicator(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration? lerpTo(Decoration? b, double t) {
    if (b is UnderlineTabIndicator) {
      return UnderlineTabIndicator(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  // @override
  // Decoration lerpFrom(Decoration a, double t) {
  //   if (a is UnderlineTabIndicatorCustom) {
  //     return UnderlineTabIndicatorCustom(
  //       borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
  //       insets: EdgeInsetsGeometry.lerp(a.insets, insets, t),
  //     );
  //   }
  //   return super.lerpFrom(a, t);
  // }

  // @override
  // Decoration lerpTo(Decoration b, double t) {
  //   if (b is UnderlineTabIndicatorCustom) {
  //     return UnderlineTabIndicatorCustom(
  //       borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
  //       insets: EdgeInsetsGeometry.lerp(insets, b.insets, t),
  //     );
  //   }
  //   return super.lerpTo(b, t);
  // }

  @override
  _UnderlinePainter createBoxPainter([ VoidCallback? onChanged ]) {
    return _UnderlinePainter(this, onChanged);
  }

  Rect _indicatorRectFor(Rect? rect, TextDirection? textDirection) {
    assert(rect != null);
    assert(textDirection != null);
    final Rect indicator = insets.resolve(textDirection).deflateRect(rect!);
    final double _width = this.width > 0 ? (indicator.right - indicator.left - this.width) / 2 : 0;
    return Rect.fromLTWH(
      indicator.left + _width,
      indicator.bottom - borderSide.width,
      this.width > 0 ? this.width : (indicator.right - indicator.left),
      borderSide.width,
    );
  }

  @override
  Path getClipPath(Rect rect, TextDirection textDirection) {
    return Path()..addRect(_indicatorRectFor(rect, textDirection));
  }
}

class _UnderlinePainter extends BoxPainter {
  _UnderlinePainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  final UnderlineTabIndicatorCustom decoration;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size!;
    final TextDirection textDirection = configuration.textDirection!;
    final Rect indicator = decoration._indicatorRectFor(rect, textDirection).deflate(decoration.borderSide.width / 2.0);
    final Paint paint = decoration.borderSide.toPaint()
      ..strokeCap = StrokeCap.square;
    canvas.drawLine(indicator.bottomLeft, indicator.bottomRight, paint);
  }
}