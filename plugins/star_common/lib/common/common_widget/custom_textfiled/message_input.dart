
part of appcommon;

class MessageInput extends StatelessWidget {
  MessageInput(
      {this.title,
      this.subTitle,
      this.ensureVisible = false,
        this.leftMargin = 8 * 2, this.rightMargin = 8 * 2, this.midMargin = 8,
        this.obscureText = false,
        this.height,
        this.align,
      this.node, this.enable: true,
      this.controller, this.backgroundColor, this.onChange,
      TextStyle? titleStyle, this.inputType,
      this.textStyle,
      TextStyle? subTitleStyle, this.inputFormatter})
      : assert((ensureVisible && node != null) || !ensureVisible,
            "ensureVisible cannot be true when node is null"),
  _titleStyle = titleStyle ?? TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
  _subTitleStyle = subTitleStyle ?? TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400);

  /// 标题
  final String? title;
  /// 标题样式
  final TextStyle? _titleStyle;
  /// 副标题
  final String? subTitle;
  /// 副标题样式
  final TextStyle _subTitleStyle;
  /// 副标题样式
  final TextStyle? textStyle;
  /// 是否可见
  final bool ensureVisible;
  /// 文本输入控制器
  final TextEditingController? controller;
  /// 节点
  final FocusNode? node;
  /// 背景色
  final Color? backgroundColor;
  /// 高度
  final double? height;
  /// *文字
  final bool obscureText;
  /// 左间隔
  final double leftMargin;
  /// 左间隔
  final double rightMargin;
  /// 中间隔
  final double midMargin;
  /// 输入框
  final TextAlign? align;
  final void Function(String)? onChange;
  final bool enable;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputType? inputType;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: height ?? 49,
      color: backgroundColor ?? Colors.white,
      child: Row(
        children: [
          SizedBox(width: leftMargin),
          Text(title ?? "", style: _titleStyle),
          SizedBox(width: midMargin),
          Expanded(
              child: TextField(controller: controller, decoration: InputDecoration(
                  hintStyle: _subTitleStyle,
                  hintText: subTitle ?? "",
                  enabled: enable,
                  border: InputBorder.none
              ), obscureText: obscureText, style: textStyle ?? _subTitleStyle,
                  textAlign: align ?? TextAlign.right, keyboardType: inputType,
                  onChanged: onChange, inputFormatters: inputFormatter)),
          SizedBox(width: rightMargin)
        ],
      ),
    );
  }
}