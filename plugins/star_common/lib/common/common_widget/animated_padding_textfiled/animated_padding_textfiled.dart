/*
 *  Copyright (C), 2015-2021
 *  FileName: animated_padding_textfiled
 *  Author: Tonight丶相拥
 *  Date: 2021/9/15
 *  Description: 
 **/

part of appcommon;

class AnimatedPaddingTextFiled extends StatelessWidget {
  AnimatedPaddingTextFiled({this.width, this.hintStyle,
    this.controller, this.hintText, this.node,
    this.onSubmit, this.style, this.formatter,
    this.action, this.onChange, this.verticalAlign
  });
  /// 宽度
  final double? width;
  /// 占位样式
  final TextStyle? hintStyle;
  /// 样式
  final TextStyle? style;
  /// 占位
  final String? hintText;
  /// 控制器
  final TextEditingController? controller;
  /// 聚焦
  final FocusNode? node;
  /// 发送
  final void Function(String)? onSubmit;
  final void Function(String)? onChange;
  /// 输入规则
  final List<TextInputFormatter>? formatter;
  /// 动作
  final TextInputAction? action;
  final TextAlignVertical? verticalAlign;


  @override
  Widget build(BuildContext context) {

    var width = this.width ?? MediaQuery.of(context).size.width;
    // TODO: implement build
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: Duration(milliseconds: 100),
      child: Container(
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
        ),
        width: width - 16,
        child: CustomTextField(
            node: node,
            textAlignVertical: verticalAlign ?? TextAlignVertical.top,
            submit: onSubmit,
            onChange: onChange,
            inputFormatter: this.formatter,
            textInputAction: action ?? TextInputAction.send,
            hintText: hintText,
            controller: controller,
            hintTextStyle: hintStyle,
            style: style
        ),
      ),
    );
  }
}

