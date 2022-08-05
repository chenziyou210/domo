/*
 *  Copyright (C), 2015-2021
 *  FileName: gradient_border
 *  Author: Tonight丶相拥
 *  Date: 2021/11/25
 *  Description: 
 **/

part of appcommon;

class CustomGradientBorderContainer extends StatelessWidget {
  final _GradientPainter _painter;
  final Widget _child;

  CustomGradientBorderContainer({
    double strokeWidth: 2,
    double radius: 3,
    required Gradient gradient,
    required Widget child,
  }): this._painter = _GradientPainter(strokeWidth: strokeWidth,
      radius: radius, gradient: gradient),
        this._child = child;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomPaint(
      painter: _painter,
      child: _child
    );
  }
}

class _GradientPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  _GradientPainter({required this.strokeWidth,
    required this.radius,
    required this.gradient});

  @override
  void paint(Canvas canvas, Size size) {
    // create outer rectangle equals size
    // size = Size(size.width + strokeWidth, size.height + strokeWidth);
    Rect outerRect = Offset.zero & size;
    var outerRRect = RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    // create inner rectangle smaller by strokeWidth
    Rect innerRect = Rect.fromLTWH(strokeWidth, strokeWidth,
      size.width - strokeWidth * 2, size.height - strokeWidth * 2);
    var innerRRect = RRect.fromRectAndRadius(innerRect,
      Radius.circular(radius - strokeWidth));

    // apply gradient shader
    _paint.shader = gradient.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    Path path1 = Path()..addRRect(outerRRect);
    Path path2 = Path()..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}