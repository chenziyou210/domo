/*
 *  Copyright (C), 2015-2021
 *  FileName: bar_pulse_loading
 *  Author: Tonight丶相拥
 *  Date: 2021/12/10
 *  Description: 
 **/

part of appcommon;

class BarPulseLoading extends StatefulWidget {
  final double width;
  final double height;
  final Color color;
  final BorderRadiusGeometry borderRadius;
  final Duration duration;
  final Curve curve;

  const BarPulseLoading(
      {Key? key,
        this.width = 2.0,
        this.height = 15.0,
        this.color = Colors.white,
        this.borderRadius = const BorderRadius.only(
            topLeft: Radius.circular(3), topRight: Radius.circular(3)),
        this.duration = const Duration(milliseconds: 800),
        this.curve = Curves.linear})
      : super(key: key);
  @override
  createState() => _BarPulseLoadingState();
}

class _BarPulseLoadingState extends State<BarPulseLoading> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(5, (index) {
          return ScaleTransition(
            scale: _DelayTween(begin: 1.0, end: 2.3, delay: index * .2).animate(
                CurvedAnimation(parent: _controller, curve: widget.curve)),
            child: _Bar(
              color: widget.color,
              width: widget.width,
              borderRadius: widget.borderRadius,
              height: widget.height,
            ),
          );
        }),
      ).sizedBox(width: 40, height: 40)
    );
  }
}


class _Bar extends StatelessWidget {
  final double? width;
  final double? height;
  final Color color;
  final BorderRadiusGeometry? borderRadius;

  const _Bar({
    Key? key,
    this.width,
    this.height,
    this.color = Colors.white,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: color,
            borderRadius: borderRadius,
          ),
        ));
  }
}

class _DelayTween extends Tween<double> {
  final double delay;

  _DelayTween({double? begin, double? end, required this.delay})
      :super(begin: begin, end: end);

  @override
  double lerp(double t) {
    return super.lerp((math.sin((t - delay) * 2 * math.pi) + 1) / 2);
  }

  @override
  double evaluate(Animation<double> animation) => lerp(animation.value);
}
