/*
 *  Copyright (C), 2015-2020 , schw
 *  FileName: custom_textfield
 *  Author: Tonight丶相拥
 *  Date: 2020/12/10
 *  Description: 
 **/

part of appcommon;

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {this.onTap,
      this.onChange,
      this.submit,
      this.keyboardType,
      this.fillColor,
      this.maxLength,
      this.prefixIcon,
      this.hintText,
      this.textInputAction: TextInputAction.done,
      this.suffixIcon,
      this.node,
      this.controller,
      this.contentPadding,
      this.errorText,
      this.onEditComplete,
      this.onAppPrivateCommand,
      this.enable,
      this.autofocus: true,
      this.obscureText: false,
      BoxConstraints? prefixIconConstraints,
      BoxConstraints? suffixIconConstraints,
      TextStyle? hintTextStyle,
      TextStyle? style,
      Widget? suffix,
      Widget? prefix,
      this.border: const OutlineInputBorder(borderSide: BorderSide.none),
      this.textAlignVertical: TextAlignVertical.bottom,
      this.textAlign: TextAlign.start,
      this.iconMaxWidth: 20,
      this.iconMaxHeight: 20,
      this.inputFormatter,
      this.enableInteractiveSelection = true})
      : this.style =
            style ?? TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400),
        this.hintTextStyle = hintTextStyle ??
            TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400),
        this.prefixIconConstraints = prefixIconConstraints ??
            (prefixIcon != null
                ? BoxConstraints(
                    maxWidth: iconMaxWidth, maxHeight: iconMaxHeight)
                : null),
        this.suffixIconConstraints = suffixIconConstraints ??
            (suffixIcon != null
                ? BoxConstraints(
                    maxWidth: iconMaxWidth, maxHeight: iconMaxHeight)
                : null),
        this.suffix =
            suffix ?? (suffixIcon != null ? SizedBox(width: 8) : null),
        this.prefix =
            prefix ?? (prefixIcon != null ? SizedBox(width: 8) : null);

  /// 文本
  final TextEditingController? controller;

  /// 焦点
  final FocusNode? node;

  /// 输入文字样式
  final TextStyle? style;

  /// 文字输入改变
  final void Function(String)? onChange;

  /// 点击
  final void Function()? onTap;

  /// 提交
  final void Function(String)? submit;

  /// 输入框 border
  final InputBorder? border;

  /// 前widget
  final Widget? prefix;

  /// 前图片
  final Widget? prefixIcon;

  /// 前图标
  final BoxConstraints? prefixIconConstraints;

  /// 尾widget
  final Widget? suffix;

  /// 尾图标
  final Widget? suffixIcon;

  /// 尾图标约束
  final BoxConstraints? suffixIconConstraints;

  /// 占位符
  final String? hintText;

  /// 占位符样式
  final TextStyle? hintTextStyle;

  /// 垂直排列
  final TextAlignVertical? textAlignVertical;

  /// 是否可用
  final bool? enable;

  /// 位置
  final TextAlign textAlign;

  /// 图片宽
  final double iconMaxWidth;

  /// 按钮方式
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatter;

  /// 图片高
  final double iconMaxHeight;
  final void Function()? onEditComplete;
  final void Function(String, Map<String, dynamic>)? onAppPrivateCommand;
  final EdgeInsetsGeometry? contentPadding;

  /// 是否模糊
  final bool obscureText;
  final bool autofocus;

  /// 错误提示
  final String? errorText;

  final Color? fillColor;
  final int? maxLength;

  ///长按是否展示【剪切/复制/粘贴菜单LengthLimitingTextInputFormatter】
  final bool enableInteractiveSelection;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextField(
        controller: controller,
        focusNode: node,
        textAlignVertical: textAlignVertical,
        style: style,
        onTap: onTap,
        textAlign: textAlign,
        onSubmitted: submit,
        obscureText: obscureText,
        onChanged: onChange,
        onEditingComplete: onEditComplete,
        onAppPrivateCommand: onAppPrivateCommand,
        enabled: enable,
        maxLines: 1,
        autofocus: autofocus,
        maxLength: maxLength,
        enableInteractiveSelection: enableInteractiveSelection,
        inputFormatters: inputFormatter,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          isCollapsed: true,
          contentPadding: contentPadding,
          border: border,
          enabledBorder: border,
          counterText: "",
          prefix: prefix,
          fillColor: fillColor,
          errorText: errorText,
          prefixIcon: prefixIcon,
          prefixIconConstraints: prefixIconConstraints,
          hintText: hintText,
          hintStyle: hintTextStyle,
          suffix: suffix,
          suffixIcon: suffixIcon,
          suffixIconConstraints: suffixIconConstraints,
        ));
  }
}
