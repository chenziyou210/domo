import 'package:flutter/material.dart';


class GradientButton extends StatelessWidget {
  const GradientButton({
    Key? key,
    this.colors,
    this.bgColor,
    this.size = 14,
    this.minWidth = 50,
    this.minHeight = 26,
    this.allowTap = true,
    required this.onPressed,
    required this.child,
    this.padding,
    this.borderRadius = const BorderRadius.all(Radius.circular(30)),
    this.textColor,
    this.splashColor,
    this.disabledColor,
    this.disabledTextColor,
    this.onHighlightChanged,
  }) : super(key: key);

  // 渐变色数组
  final List<Color>? colors;
  // 设置了背景颜色，就取消了渐变 ，默认渐变
  final Color? bgColor,textColor,splashColor,disabledTextColor,disabledColor;
  final double? size,minWidth,minHeight;
  final bool allowTap;
  final EdgeInsetsGeometry? padding;

  final Widget child;
  final BorderRadius? borderRadius;

  final GestureTapCallback? onPressed;
  final ValueChanged<bool>? onHighlightChanged;

  //设置默认值 渐变不为空
  static const Color mainColor = Color(0xffFF1EAF);
  static const Color mainGradientStartColor = Color(0xffFF65C8);
  List<Color>getColors() => colors ?? [mainGradientStartColor, mainColor];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final radius = borderRadius;
    bool disabled = allowTap == false;
    bool needGradient = bgColor == null;

    return Opacity(
      opacity: allowTap ? 1.0 : 0.6,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: needGradient ? LinearGradient(
            begin:Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: getColors(),
          ): null,
          color: bgColor,
          borderRadius: radius,
        ),
        child: Material(
          type: MaterialType.transparency,
          borderRadius: radius,
          clipBehavior: Clip.hardEdge,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: this.minWidth!, minHeight: this.minHeight!),
            child: InkResponse(
              splashColor: splashColor ?? getColors().last,
              // 设置了高亮 splash颜色失效
              highlightColor: Color(0x1A000000),
              highlightShape: BoxShape.rectangle,
              onHighlightChanged: onHighlightChanged,
              radius: 0.0,
              containedInkWell: true,
              onTap: disabled ? null : onPressed,
              child: Padding(
                // padding: EdgeInsets.only(top: 0,left: 3,bottom: 0,right: 3),
                padding: padding ?? theme.buttonTheme.padding,
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    // fontSize: size,
                  ),
                  child: Center(
                    child: DefaultTextStyle(
                      style: theme.textTheme.button!.copyWith(
                        // color: disabled
                        //     ? disabledTextColor ?? Colors.black38
                        //     : textColor ?? Colors.white,
                          color: textColor ?? Color(0xB3FFFFFF),
                          fontSize: size
                      ),
                      child: child,
                    ),
                    widthFactor: 1,
                    heightFactor: 1,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ElevatedGradientButton extends StatefulWidget {
  const ElevatedGradientButton({
    Key? key,
    this.colors,
    this.size,
    this.allowTap = true,
    this.bgColor,
    this.onPressed,
    this.padding,
    this.borderRadius = const BorderRadius.all(Radius.circular(30)),
    this.textColor,
    this.splashColor,
    this.disabledColor,
    this.disabledTextColor,
    this.onHighlightChanged,
    this.shadowColor,
    required this.child,
  }) : super(key: key);

  // 渐变色数组
  final List<Color>? colors;
  final Color? bgColor;
  final Color? textColor;
  final Color? splashColor;
  final Color? disabledTextColor;
  final Color? disabledColor;
  final Color? shadowColor;
  final double? size;
  final bool allowTap;
  final EdgeInsetsGeometry? padding;

  final Widget child;
  final BorderRadius? borderRadius;

  final GestureTapCallback? onPressed;
  final ValueChanged<bool>? onHighlightChanged;

  @override
  _ElevatedGradientButtonState createState() => _ElevatedGradientButtonState();
}

class _ElevatedGradientButtonState extends State<ElevatedGradientButton> {
  bool _tapDown = false;

  @override
  Widget build(BuildContext context) {
    bool disabled = widget.onPressed == null;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        boxShadow: disabled
            ? null
            : [
          _tapDown
              ? BoxShadow(
            offset: const Offset(2, 6),
            spreadRadius: -2,
            blurRadius: 9,
            color: widget.shadowColor ?? Colors.black54,
          )
              : BoxShadow(
            offset: const Offset(0, 2),
            spreadRadius: -2,
            blurRadius: 3,
            color: widget.shadowColor ?? Colors.black87,
          )
        ],
      ),
      child: GradientButton(
        colors: widget.colors,
        onPressed: widget.onPressed,
        padding: widget.padding,
        borderRadius: widget.borderRadius,
        textColor: widget.textColor,
        splashColor: widget.splashColor,
        disabledColor: widget.disabledColor,
        disabledTextColor: widget.disabledTextColor,
        size: widget.size,
        allowTap: widget.allowTap,
        bgColor: widget.bgColor,
        child: widget.child,
        onHighlightChanged: (v) {
          setState(() {
            _tapDown = v;
          });
          if (widget.onHighlightChanged != null) {
            widget.onHighlightChanged!(v);
          }
        },
      ),
    );
  }
}
