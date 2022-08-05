/*
 *  Copyright (C), 2015-2021
 *  FileName: half_circle_process
 *  Author: Tonight丶相拥
 *  Date: 2021/11/16
 *  Description: 
 **/

part of appcommon;

class HalfCircleProcessPainter extends CustomPainter {
  HalfCircleProcessPainter({this.strokeWidth: 3, this.strokeColor: Colors.black12,
    this.emptyAngle: math.pi / 2, this.percent: 0, this.color: Colors.black12});
  final double strokeWidth;
  final Color strokeColor;
  final double emptyAngle;
  final double percent;
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    if(emptyAngle >= math.pi * 2)
      return;
    Paint paint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.fill;
    Path path = Path();

    _paintSemiCircle(canvas, paint, path, size, emptyAngle, math.pi * 2 - emptyAngle);

    Paint paint1 = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..color = strokeColor;
    Path path1 = Path();
    _paint(canvas, paint1, path1, size, emptyAngle, math.pi * 2 - emptyAngle);


    Paint paint2 = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    Path path2 = Path();

    _paintSemiCircle(canvas, paint2, path2, size, emptyAngle, (math.pi * 2 - emptyAngle) * percent);

    Paint paint3 = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..color = color;
    Path path3 = Path();
    _paint(canvas, paint3, path3, size, emptyAngle, (math.pi * 2 - emptyAngle) * percent);
  }

  void _paint(Canvas canvas, Paint paint, Path path, Size size, double angle, double endAngle){
    path.addArc(Rect.fromLTWH(strokeWidth / 2, strokeWidth / 2, size.width - strokeWidth,
        size.height - strokeWidth),
        math.pi / 2 + angle / 2,
        endAngle);
    canvas.drawPath(path, paint);
  }

  /// 半圆
  void _paintSemiCircle(Canvas canvas, Paint paint, Path path, Size size, double emptyAngle, double angle){

    if (angle == 0)
      return;
    double h = strokeWidth / 2;
    double w = strokeWidth / 2;

    double px = size.width / 2;
    double py = size.height / 2;


    if (emptyAngle < math.pi) {
      py = py + size.height / 2 * math.cos(emptyAngle / 2);
      px = px - size.width / 2 * math.sin(emptyAngle / 2);
      h += strokeWidth / 2 * math.cos(emptyAngle / 2);
      w -= strokeWidth / 2 * math.sin(emptyAngle / 2);
    }else if (emptyAngle > math.pi){
      double angle = emptyAngle / 2 - math.pi / 2;
      py -= size.height / 2 * math.sin(angle);
      px = px - size.width / 2 * math.sin(angle);
      h -= strokeWidth / 2 * math.sin(angle);
      w -= strokeWidth / 2 * math.sin(angle);
    }else {
      w = strokeWidth;
      px = size.width;
      py = size.height / 2;
    }


    double js = math.pi / 2 + emptyAngle / 2 + math.pi;
    path.addArc(Rect.fromLTWH(px - w,
        py - h,
        strokeWidth, strokeWidth),
        js, math.pi);
    path.close();

    double px1 = size.width / 2;
    double py1 = size.height / 2;
    double h1 = strokeWidth / 2;
    double w1 = strokeWidth / 2;

    double js1 = math.pi / 2 + emptyAngle / 2 + angle;
    if (math.pi * 2 < js1 && js1 < math.pi +math.pi * 2) {
      double angle = js1 - math.pi * 2;
      py1 = py1 + size.height / 2 * math.sin(angle);
      px1 = px1 + size.width / 2 * math.cos(angle);
      h1 += strokeWidth / 2 * math.sin(angle);
      w1 += strokeWidth / 2 * math.cos(angle);
    }else if (js1 == math.pi * 2) {
      w1 = 0;
      px1 = 0;
      py1 = size.height / 2;
    }else if (js1 < math.pi * 2 && js1 > math.pi * 3 / 2){
      double angle = math.pi * 2 - js1;
      py1 -= size.height / 2 * math.sin(angle);
      px1 = px1 + size.width / 2 * math.cos(angle);
      h1 -= strokeWidth / 2 * math.sin(angle);
      w1 += strokeWidth / 2 * math.cos(angle);
    }else if (js1 < math.pi * 3 / 2 && js1 > math.pi){
      double angle = math.pi * 3 / 2 - js1;
      py1 -= size.height / 2 * math.cos(angle);
      px1 = px1 - size.width / 2 * math.sin(angle);
      h1 -= strokeWidth / 2 * math.cos(angle);
      w1 -= strokeWidth / 2 * math.sin(angle);
    }else {
      double angle = math.pi - js1;
      py1 += size.height / 2 * math.sin(angle);
      px1 = px1 - size.width / 2 * math.cos(angle);
      h1 += strokeWidth / 2 * math.sin(angle);
      w1 -= strokeWidth / 2 * math.cos(angle);
    }

    path.addArc(Rect.fromLTWH(px1 - w1,
        py1 - h1,
        strokeWidth, strokeWidth),
        js1, math.pi);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is HalfCircleProcessPainter) {
      return oldDelegate.color != color
          || oldDelegate.percent != percent
          || oldDelegate.emptyAngle != emptyAngle
          || oldDelegate.strokeColor != strokeColor
          || oldDelegate.strokeWidth != strokeWidth;
    }
    return false;
  }
}

/*
  CustomPaint(
    painter: HalfCircleProcessPainter(
      emptyAngle: math.pi / 2,
      strokeWidth: 5,
      percent: 1 - 0.23,
      color: Color.fromARGB(255, 106, 170, 156)
    ),
    child: CustomText("已售${controller.state.percent}%",
      fontWeight: w_300, fontSize: 8.sp,
      color: Colors.black).center,
  ).sizedBox(width: 54.5, height: 54.5)
  */