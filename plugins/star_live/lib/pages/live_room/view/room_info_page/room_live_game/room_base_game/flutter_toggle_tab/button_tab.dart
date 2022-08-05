import 'package:flutter/material.dart';
import 'package:star_common/app_images/r.dart';

import 'helper.dart';

class ButtonsTab extends StatefulWidget {
  /// Define attribute Widget and State
  ///
  const ButtonsTab({
    Key? key,
    this.title,
    required this.size,
    this.onPressed,
    required this.width,
    this.height,
    this.isSelected,
    this.radius,
    this.selectedTextStyle,
    this.unSelectedTextStyle,
    required this.selectedColors,
    this.icons,
    required this.unSelectedColors,
    this.begin,
    this.end,
    this.marginSelected = EdgeInsets.zero,
  }) : super(key: key);

  final String? title;
  final Function? onPressed;
  final int size;
  final double? width;
  final double? height;
  final List<Color>? selectedColors;
  final List<Color>? unSelectedColors;
  final TextStyle? selectedTextStyle;
  final TextStyle? unSelectedTextStyle;

//  final BoxDecoration selectedDecoration;
//  final BoxDecoration unSelectedDecoration;
  final bool? isSelected;
  final double? radius;
  final IconData? icons;

  final Alignment? begin;
  final Alignment? end;

  final EdgeInsets? marginSelected;

  @override
  _ButtonsTabState createState() => _ButtonsTabState();
}

class _ButtonsTabState extends State<ButtonsTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width ?? widthInPercent(100, context),
        height: widget.height ?? 50,
        //wrap with container to fix margin issue
        child: Container(
          margin: widget.isSelected! ? widget.marginSelected : EdgeInsets.zero,
          decoration: widget.isSelected!
              ? BoxDecoration(image: DecorationImage(image: AssetImage(
                widget.size<4?R.bgButtonTab:
                (widget.size<5?R.bgButton2Tab:R.bgButton3Tab)
              ), fit: BoxFit.fill))
              : null,
          child: TextButton(
              onPressed: widget.onPressed as void Function()?,
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(widget.radius!))),
                  padding: MaterialStateProperty.all(EdgeInsets.zero)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.icons != null
                      ? Icon(
                          widget.icons,
                          color: widget.isSelected!
                              ? widget.selectedTextStyle!.color
                              : widget.unSelectedTextStyle!.color,
                        )
                      : Container(),
                  Visibility(
                    visible: widget.icons != null,
                    child: SizedBox(
                      width: 4,
                    ),
                  ),
                  Text(
                    widget.title!,
                    style: widget.isSelected!
                        ? widget.selectedTextStyle
                        : widget.unSelectedTextStyle,
                    textAlign: TextAlign.center,
                  )
                ],
              )),
        ));
  }
}
