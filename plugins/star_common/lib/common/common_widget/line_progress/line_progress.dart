/*
 *  Copyright (C), 2015-2021
 *  FileName: line_progress
 *  Author: Tonight丶相拥
 *  Date: 2021/11/16
 *  Description: 
 **/

part of appcommon;


class LineProgressPainter extends CustomPainter {
  LineProgressPainter({
    this.color: Colors.black12,
    this.radius: BorderRadius.zero,
    required this.colors,
    required double percent
  }): this.percent = percent > 1 ? 1 : percent;

  final List<Color> colors;
  final Color color;
  final BorderRadius radius;
  final double percent;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paintBackground = Paint()
      ..color = this.color;
    Rect rectBackground = Rect.fromLTWH(0, 0, size.width, size.height);
    var rRectBackground = radius.toRRect(rectBackground);
    canvas.drawRRect(rRectBackground, paintBackground);

    Paint paint = Paint();
    Rect rect = Rect.fromLTWH(0, 0, size.width * percent, size.height);
    paint.shader = LinearGradient(colors: this.colors)
      .createShader(rect);
    var rRect = radius.toRRect(rect);
    canvas.drawRRect(rRect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    if (oldDelegate is LineProgressPainter) {
      return this.colors != oldDelegate.colors
          || this.color != oldDelegate.color
          || this.radius != oldDelegate.radius;
    }
    return false;
  }
}