/*
 *  Copyright (C), 2015-2021
 *  FileName: top_triangle_border
 *  Author: Tonight丶相拥
 *  Date: 2021/10/26
 *  Description: 
 **/

part of appcommon;

class TopTriangleBorder extends ShapeBorder {
  TopTriangleBorder({this.borderRadius: BorderRadius.zero,
    this.borderWidth: 1.0, this.triangleHeight: 10,
    this.triangleWidth: 6, this.fillColor: Colors.white
  });
  final double borderWidth;
  final BorderRadius borderRadius;
  final double triangleHeight;
  final double triangleWidth;
  final Color fillColor;

  @override
  // TODO: implement dimensions
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(borderWidth);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    // TODO: implement getInnerPath
    return Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    // TODO: implement getOuterPath
    return Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect));
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // TODO: implement paint
    Path path = Path();
    path.addRRect(borderRadius.resolve(textDirection).toRRect(rect));
    path.moveTo(rect.topCenter.dx - triangleWidth / 2, rect.topCenter.dy);
    path.lineTo(rect.topCenter.dx, rect.topCenter.dy - triangleHeight);
    path.lineTo(rect.topCenter.dx + triangleWidth / 2, rect.topCenter.dy);
    path.close();
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = fillColor;
    canvas.drawPath(path, paint);
  }

  @override
  ShapeBorder scale(double t) {
    // TODO: implement scale
    return TopTriangleBorder(borderWidth: borderWidth * t, borderRadius: borderRadius * t);
  }
}


class BottomTriangleBorder extends ShapeBorder {
  BottomTriangleBorder({this.borderRadius: BorderRadius.zero,
    this.borderWidth: 1.0, this.triangleHeight: 10,
    this.triangleWidth: 6, this.fillColor: Colors.white,
    this.offsetX: 0, this.borderColor: Colors.transparent,
    this.radius: 10
  });
  final double borderWidth;
  final BorderRadius borderRadius;
  final double triangleHeight;
  final double triangleWidth;
  final Color fillColor;
  final double offsetX;
  final double radius;
  final Color borderColor;

  @override
  // TODO: implement dimensions
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(borderWidth);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    // TODO: implement getInnerPath
    return Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    // TODO: implement getOuterPath
    return Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect));
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // TODO: implement paint
    Path path = Path();
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = fillColor;
    path.moveTo(rect.left + radius, rect.top);
    path.lineTo(rect.right - radius, rect.top);
    path.arcToPoint(Offset(rect.right, rect.top + radius), radius: Radius.circular(radius));
    path.lineTo(rect.right, rect.bottom - radius);
    path.arcToPoint(Offset(rect.right - radius, rect.bottom), radius: Radius.circular(radius));
    path.lineTo(rect.left + radius + triangleWidth + 2, rect.bottom);
    path.lineTo(rect.left + radius + triangleWidth / 2 + 2, rect.bottom + triangleHeight);
    path.lineTo(rect.left + radius + 2, rect.bottom);
    path.lineTo(rect.left + radius, rect.bottom);
    path.arcToPoint(Offset(rect.left, rect.bottom - radius), radius: Radius.circular(radius));
    path.lineTo(rect.left, rect.top + radius);
    path.arcToPoint(Offset(rect.left + radius, rect.top), radius: Radius.circular(radius));
    canvas.drawPath(path, paint);
  }

  @override
  ShapeBorder scale(double t) {
    // TODO: implement scale
    return BottomTriangleBorder(borderWidth: borderWidth * t, borderRadius: borderRadius * t);
  }
}


class BottomLeftTriangleBorder extends ShapeBorder {
  BottomLeftTriangleBorder({this.borderRadius: BorderRadius.zero,
    this.borderWidth: 1.0, this.triangleHeight: 10,
    this.triangleWidth: 6, this.fillColor: Colors.white,
    this.offsetX: 0, this.borderColor: Colors.transparent
  });
  final double borderWidth;
  final BorderRadius borderRadius;
  final double triangleHeight;
  final double triangleWidth;
  final Color fillColor;
  final double offsetX;
  final Color borderColor;

  @override
  // TODO: implement dimensions
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(borderWidth);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    // TODO: implement getInnerPath
    return Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    // TODO: implement getOuterPath
    return Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect));
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // TODO: implement paint
    Path path = Path();
    path.addRRect(borderRadius.resolve(textDirection).toRRect(rect));
    path.moveTo(rect.bottomLeft.dx + borderRadius.bottomLeft.x + offsetX, rect.bottomCenter.dy);
    path.lineTo(rect.bottomLeft.dx + borderRadius.bottomLeft.x + offsetX + triangleWidth / 2, rect.bottomCenter.dy + triangleHeight);
    path.lineTo(rect.bottomLeft.dx + borderRadius.bottomLeft.x + offsetX + triangleWidth, rect.bottomCenter.dy);
    path.close();
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = fillColor;
    canvas.drawPath(path, paint);

    Paint paint1 = Paint()
      ..style = PaintingStyle.stroke
      ..color = borderColor;
    canvas.drawPath(path, paint1);
  }

  @override
  ShapeBorder scale(double t) {
    // TODO: implement scale
    return BottomLeftTriangleBorder(borderWidth: borderWidth * t, borderRadius: borderRadius * t);
  }
}