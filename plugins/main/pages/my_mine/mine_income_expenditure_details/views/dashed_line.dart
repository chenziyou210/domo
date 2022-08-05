import 'package:flutter/cupertino.dart';
import 'package:star_common/common/app_common_widget.dart';

class DashedLine extends StatelessWidget {
  final Axis axis;
  final double dashedWidth;
  final double dashedHeight;
  final int count;
  Color? color;

  DashedLine({
    required this.axis,
    this.dashedWidth = 1,
    this.dashedHeight = 5,
    required this.count,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // 根据宽度计算个数
        return Flex(
          direction: this.axis,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(this.count, (int index) {
            return SizedBox(
              width: dashedWidth,
              height: dashedHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: color ?? AppMainColors.string2Color('#EEFF87')),
              ),
            );
          }),
        );
      },
    );
  }
}
