import 'package:flutter/material.dart';
import 'package:star_common/common/app_common_widget.dart';

class CounterText extends StatefulWidget {
  final TextStyle style;
  final ValueChanged<double> callback;
  final CounterTextController controller = CounterTextController();
  final Duration animationDuration;
  final double oldValue, newValue;
  final bool enable;

  CounterText(
      {required key,
      required this.callback,
      required this.style,
      required this.enable,
      required this.oldValue,
      required this.newValue,
      this.animationDuration = const Duration(milliseconds: 500)})
      : super(key: key);

  @override
  _CounterTextState createState() => _CounterTextState();
}

class _CounterTextState extends State<CounterText> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  double value = -1;
  @override
  void initState() {
    animationController =
        AnimationController(duration: widget.animationDuration, vsync: this);
    widget.controller.setState(this);
    if(widget.enable) {
       widget.controller.count();
    }else{
      value = widget.newValue;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _CounterTextIcon();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Widget _CounterTextIcon() {
    final Animation<double> offsetAnimation =
        Tween(begin: widget.oldValue, end: widget.newValue).animate(CurvedAnimation(
          curve: Curves.linear,
          parent: animationController,
        ))..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              value = widget.newValue;
              animationController.reverse();
              widget.callback.call(widget.newValue);
              return;
            }
          });
    final Animation<double> scaleAnim =
        Tween(begin: 1.0, end: 1.2).animate(CurvedAnimation(
      curve: Curves.linear,
      parent: animationController,
    ));

    return AnimatedBuilder(
      animation: offsetAnimation,
      builder: (context, child) {
        return AnimatedBuilder(
          animation: scaleAnim,
          builder: (context, child) {
            return Container(
              alignment: Alignment.topLeft,
              child: Text(
                '${value == -1 ? offsetAnimation.value.toStringAsFixed(1) : value}',
                style: widget.style,
              ).transformScale(scaleAnim.value),
            );
          },
        );
      },
    );
  }
}

class CounterTextController {
  late _CounterTextState _state;

  void setState(_CounterTextState state) {
    _state = state;
  }

  Future<void> count() {
    return _state.animationController.forward(from: 0.0);
  }
}
