/*
 *  Copyright (C), 2015-2021
 *  FileName: tabbar_linear_gradent_decoration
 *  Author: Tonight丶相拥
 *  Date: 2021/7/14
 *  Description: 
 **/

part of appcommon;

class UnderlineTabLinearGradientIndicatorCustom extends Decoration {
  /// Create an underline style selected tab indicator.
  ///
  /// The [borderSide] and [insets] arguments must not be null.
  const UnderlineTabLinearGradientIndicatorCustom({
    this.borderSide = const BorderSide(width: 2.0, color: Colors.white),
    this.insets = EdgeInsets.zero, this.width: 0,
    required this.gradient,
    this.isCircle = false
  });

  /// The color and weight of the horizontal line drawn below the selected tab.
  final BorderSide borderSide;
  final double width;
  final LinearGradient gradient;
  final bool isCircle;

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
  _UnderlineLinearGradientPainter createBoxPainter([ VoidCallback? onChanged ]) {
    return _UnderlineLinearGradientPainter(this, onChanged);
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

class _UnderlineLinearGradientPainter extends BoxPainter {
  _UnderlineLinearGradientPainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  final UnderlineTabLinearGradientIndicatorCustom decoration;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size!;
    final TextDirection textDirection = configuration.textDirection!;
    final Rect indicator = decoration._indicatorRectFor(rect, textDirection).deflate(decoration.borderSide.width / 2.0);
    final Paint paint = decoration.borderSide.toPaint()
      ..strokeCap = StrokeCap.square
      ..shader = decoration.gradient.createShader(indicator);

    if (!decoration.isCircle) {
      canvas.drawLine(indicator.bottomLeft, indicator.bottomRight, paint);
    }else {
      Path path = Path();
      double r = decoration.borderSide.width / 2;
      double dy = indicator.bottomLeft.dy;
      double left = indicator.bottomLeft.dx;
      double right = indicator.bottomRight.dx;
      double dy1 = dy + decoration.borderSide.width;


      path.moveTo(left + r, dy);
      path.lineTo(right - r, dy);
      path.addArc(Rect.fromLTWH(right - r, dy, r * 2,
          r * 2), -math.pi / 2, math.pi);
      path.lineTo(left + r, dy1);
      path.addArc(Rect.fromLTWH(left, dy, r * 2,
          r * 2), math.pi / 2, math.pi);
      path.close();
      canvas.drawPath(path, paint);
    }
  }
}