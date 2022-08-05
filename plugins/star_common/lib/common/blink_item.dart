import 'package:flutter/cupertino.dart';

//Neo - 05/04/2022
class BlinkItem extends StatefulWidget {
  final Widget child;
  final double? w, h;
  final bool? noBlink;
  final void Function(Widget) callback;

  BlinkItem(
      {Key? key,
      required this.child,
      required this.callback,
      this.w,
      this.h,
      this.noBlink});

  @override
  _BlinkItemState createState() => _BlinkItemState();
}

class _BlinkItemState extends State<BlinkItem> {
  double opacity = 1.0;

  _BlinkItemState();

  blinkItem() {
    setState(() {
      opacity = opacity == 0.5 ? 1.0 : 0.5;
      Future.delayed(Duration(milliseconds: 100), () {
        if (!mounted) {
          return;
        }
        setState(() {
          opacity = opacity == 0.5 ? 1.0 : 0.5;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.noBlink == null) blinkItem();
        widget.callback(widget.child);
      },
      child: AnimatedOpacity(
          opacity: opacity,
          duration: Duration(milliseconds: 100),
          child: generateChild()),
    );
  }

  generateChild() {
    if (widget.w != null && widget.h != null)
      return SizedBox(
        width: widget.w,
        height: widget.h,
        child: widget.child,
      );
    if (widget.w != null)
      return SizedBox(
        width: widget.w,
        child: widget.child,
      );
    if (widget.h != null)
      return SizedBox(
        height: widget.h,
        child: widget.child,
      );
    return widget.child;
  }
}
