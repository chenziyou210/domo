import 'package:flutter/cupertino.dart';

class Shake extends StatefulWidget {
  final Widget child;
  final double padding;
  final Axis orient;
  final bool enable;
  final double animationRange;
  final ShakeController controller = ShakeController();
  final Duration animationDuration;

  Shake(
      {required Key key,
      required this.child,
      this.padding = 5,
      this.enable = true,
      this.orient = Axis.vertical,
      this.animationRange = 2,
      this.animationDuration = const Duration(milliseconds: 500)})
      : super(key: key);

  @override
  _ShakeState createState() => _ShakeState();
}

class _ShakeState extends State<Shake> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  double index = 0.0;

  @override
  void initState() {
    animationController =
        AnimationController(duration: widget.animationDuration, vsync: this);
    widget.controller.setState(this);
    if(widget.enable) {
      widget.controller.shake(index);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> offsetAnimation =
        Tween(begin: -widget.animationRange, end: widget.animationRange)
            .animate(animationController)
          ..addStatusListener((status) {
            print('NEO: shake $status');
            if (status == AnimationStatus.completed) {
              index = index == 0.0 ? 1.0 : 0.0;
              widget.controller.shake(index);
            } else if (status == AnimationStatus.dismissed) {
              index = index == 0.0 ? 1.0 : 0.0;
              widget.controller.shake(index);
            }
          });

    return AnimatedBuilder(
      animation: offsetAnimation,
      builder: (context, child) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: widget.animationRange),
          padding: widget.orient == Axis.vertical
              ? EdgeInsets.only(
                  top: offsetAnimation.value + widget.padding,
                  bottom: widget.padding - offsetAnimation.value)
              : EdgeInsets.only(
                  left: offsetAnimation.value + widget.padding,
                  right: widget.padding - offsetAnimation.value),
          child: widget.child,
        );
      },
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class ShakeController {
  late _ShakeState _state;

  void setState(_ShakeState state) {
    _state = state;
  }

  Future<void> shake(index) {
    if (index == 0) {
      return _state.animationController.forward(from: 0.0);
    }
    return _state.animationController.reverse();
  }
}
