part of appcommon;

/// 警告弹窗
class ConsultingWarning extends AlertDialog {
  ConsultingWarning({this.titleWidget,
    this.titleStr,
    this.bottomWidget,
    this.contentMargin,
    this.contentStr,
    this.spaceHeight,
    this.rightColor = Colors.black,
    this.leftColor = Colors.black,
    this.rightFontSize,
    this.leftFontSize,
    this.leftFontWeight,
    this.rightFontWeight,
    this.rightTit,
    this.alignment,
    this.leftTit,
    this.rightCall,
    this.leftCall,
    this.onPop,
    this.contentFontSize,
    this.contentFontWeight,
    this.titFontSize, this.titleStrTopMargin,
    this.titFontWeight, this.height = 40, this.contentHeight, this.contentWidth,
    this.contentColor, this.radius, this.top, this.contentWidget,
    EdgeInsetsGeometry? contentPadding
  }): this.margin = contentPadding ?? EdgeInsets.symmetric(horizontal: 8);

  /// 按钮
  final Widget? bottomWidget;

  /// 标题
  final Widget? titleWidget;

  /// 警示标题
  final String? titleStr;

  /// 内容
  final String? contentStr;

  final Color? contentColor;

  /// 空隙
  final double? spaceHeight;

  /// 左标提
  final String? leftTit;

  /// 右标提
  final String? rightTit;

  /// 左回调
  final void Function()? leftCall;

  /// 右回调
  final void Function()? rightCall;

  /// 左标题字体大小
  final double? leftFontSize;

  /// 右标题字体大小
  final double? rightFontSize;

  /// 右标题字体
  final FontWeight? rightFontWeight;

  /// 左标题字体
  final FontWeight? leftFontWeight;

  /// 左标题颜色
  final Color leftColor;

  /// 右标题颜色
  final Color rightColor;

  /// 返回
  final void Function()? onPop;

  /// 标题字体
  final double? titFontSize;

  /// 内容字体
  final double? contentFontSize;

  /// 标题大小
  final FontWeight? titFontWeight;

  /// 内容大小
  final FontWeight? contentFontWeight;
  final double? contentHeight;
  final double? contentWidth;

  final double? radius;
  final double? top;
  final Alignment? alignment;
  final double? contentMargin;
  final double? titleStrTopMargin;
  /// 中间内容widget
  final Widget? contentWidget;
  final EdgeInsetsGeometry margin;

  /// 默认按钮高度
  final double height;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
        type: MaterialType.transparency,
        child: GestureDetector(
          onTap: onPop,
          child: Container(
            color: Colors.transparent,
            child: Center(
              child: Container(
                height: this.contentHeight,
                width: this.contentWidth,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                        top: titleWidget == null ? 0 : (top ?? spaceHeight),
                        child: ClipRRect(
                          borderRadius:
                          BorderRadius.all(Radius.circular(radius ?? (8 / 2))),
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                titleWidget == null
                                    ? SizedBox()
                                    : SizedBox(height: spaceHeight),
                                SizedBox(height: titleStrTopMargin ?? 8),
                                titleStr == null || titleStr!.isEmpty
                                    ? SizedBox(height: 8)
                                    : Text(titleStr!, style: TextStyle(
                                    fontWeight:
                                    titFontWeight ?? FontWeight.w500,
                                    fontSize: titFontSize ?? 15
                                )),
                                titleStr != null && titleStr!.isNotEmpty
                                    ? SizedBox(height: contentMargin ?? 8)
                                    : SizedBox(),
                                Expanded(
                                    child: Container(
                                      child: Align(
                                        alignment: alignment ?? Alignment.center,
                                        child: Container(
                                          margin: margin,
                                          child: SingleChildScrollView(
                                            child: contentWidget ?? Text(contentStr ?? "",
                                                style: TextStyle(
                                                    fontSize:
                                                    contentFontSize ?? 13,
                                                    fontWeight: contentFontWeight ??
                                                        FontWeight.w500, color: contentColor
                                                )),
                                          ),
                                        ),
                                      ),
                                    )),
                                SizedBox(height: 8 / 2),
                                bottomWidget ??
                                    DefaultBottomWidget(
                                        height: height,
                                        leftCall: leftCall,
                                        rightCall: rightCall,
                                        leftTit: leftTit,
                                        rightTit: rightTit,
                                        leftColor: leftColor,
                                        leftFontSize: leftFontSize,
                                        leftFontWeight: leftFontWeight,
                                        rightColor: rightColor,
                                        rightFontSize: rightFontSize,
                                        rightFontWeight: rightFontWeight)
                              ],
                            ),
                          ),
                        )),
                    titleWidget ?? SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class ConsultingWarningContentFillWidget extends AlertDialog {
  ConsultingWarningContentFillWidget({this.titleWidget,
    this.bottomWidget,
    this.alignment: AlignmentDirectional.topStart,
    this.onPop, this.contentHeight, this.contentWidth,
    this.radius, this.top, this.contentWidget});

  /// 按钮
  final Widget? bottomWidget;
  final Widget? titleWidget;
  final double? contentHeight;
  final double? contentWidth;
  /// 返回
  final void Function()? onPop;
  final double? radius;
  final double? top;
  final AlignmentGeometry alignment;
  /// 中间内容widget
  final Widget? contentWidget;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
        type: MaterialType.transparency,
        child: GestureDetector(
          onTap: onPop,
          child: Container(
            color: Colors.transparent,
            child: Center(
              child: Container(
                height: this.contentHeight,
                width: this.contentWidth,
                child: Stack(
                  alignment: alignment,
                  children: <Widget>[
                    Positioned.fill(
                        top: titleWidget == null ? 0 : (top ?? 0),
                        child: ClipRRect(
                          borderRadius:
                          BorderRadius.all(Radius.circular(radius ?? (8 / 2))),
                          child: Container(
                            color: Colors.white,
                            child: contentWidget
                          ),
                        )),
                    titleWidget ?? SizedBox(),
                    bottomWidget ?? SizedBox()
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

/// 默认按钮
class DefaultBottomWidget extends StatelessWidget {
  DefaultBottomWidget({this.leftCall,
    this.rightCall,
    this.leftTit,
    this.rightTit,
    this.leftColor,
    this.leftFontSize,
    this.leftFontWeight,
    this.rightColor,
    this.rightFontSize,
    this.rightFontWeight, this.height = 100});

  /// 左标提
  final String? leftTit;

  /// 右标提
  final String? rightTit;

  /// 左回调
  final void Function()? leftCall;

  /// 右回调
  final void Function()? rightCall;

  /// 左标题字体大小
  final double? leftFontSize;

  /// 右标题字体大小
  final double? rightFontSize;

  /// 右标题字体
  final FontWeight? rightFontWeight;

  /// 左标题字体
  final FontWeight? leftFontWeight;

  /// 左标题颜色
  final Color? leftColor;

  /// 右标题颜色
  final Color? rightColor;

  /// 按钮高度
  final double height;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Color.fromARGB(255, 242, 242, 242),
      padding: EdgeInsets.only(top: 1),
      height: height,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
                color: Colors.white,
                height: height,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Text(leftTit ?? "",
                      style: TextStyle(
                          fontWeight: leftFontWeight ?? FontWeight.w500,
                          fontSize: leftFontSize ?? 14,
                          color: leftColor
                      )),
                  onPressed: leftCall
                )),
          ),
          SizedBox(width: 1),
          Expanded(
              child: Container(
                  color: Colors.white,
                  height: height,
                  child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Text(rightTit ?? "",
                          style: TextStyle(fontWeight: rightFontWeight ?? FontWeight.w500,
                              fontSize: rightFontSize ?? 14,
                              color: rightColor)),
                      onPressed: rightCall
                  )))
        ],
      ),
    );
  }
}

/// 单一底部按钮
class SignalBottomWidget extends StatelessWidget {
  SignalBottomWidget({this.fontSize,
    this.callBack,
    this.fontWeight,
    this.radius,
    this.tit,
    this.titColor = Colors.black,
    this.backColor,
    this.height = 50,
    this.insets = const EdgeInsets.symmetric(horizontal: 8 * 2)});

  /// 右标提
  final String? tit;

  /// 右回调
  final void Function()? callBack;

  /// 右标题字体大小
  final double? fontSize;

  /// 右标题字体
  final FontWeight? fontWeight;

  /// 右标题颜色
  final Color titColor;

  /// 元切角
  final double? radius;

  /// 背景色
  final Color? backColor;

  /// btn 高度
  final double height;

  /// btn insets
  final EdgeInsets insets;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Color.fromARGB(255, 242, 242, 242),
      height: this.height,
      margin: EdgeInsets.only(bottom: 8 / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: CupertinoButton(
                    child: Text(tit ?? "",
                        style: TextStyle(fontWeight: fontWeight ?? FontWeight.w500,
                            fontSize: fontSize ?? 14,
                            color: titColor)),
                    onPressed: callBack,
                    padding: insets,
                    color: backColor,
                  )))
        ],
      ),
    );
  }
}

/// 普通底部按钮
class NormalBottomWidget extends StatelessWidget {
  NormalBottomWidget({this.leftCall,
    this.rightCall,
    this.leftTit,
    this.rightTit,
    this.leftColor = Colors.black,
    this.leftFontSize,
    this.leftFontWeight,
    this.rightColor = Colors.black,
    this.rightFontSize,
    this.rightFontWeight,
    this.rightBackColor,
    this.rightInsets = const EdgeInsets.symmetric(horizontal: 8 * 2),
    this.leftInsets = const EdgeInsets.symmetric(horizontal: 8 * 2),
    this.leftBackColor,
    this.height = 50});

  /// 左标提
  final String? leftTit;

  /// 右标提
  final String? rightTit;

  /// 左回调
  final void Function()? leftCall;

  /// 右回调
  final void Function()? rightCall;

  /// 左标题字体大小
  final double? leftFontSize;

  /// 右标题字体大小
  final double? rightFontSize;

  /// 右标题字体
  final FontWeight? rightFontWeight;

  /// 左标题字体
  final FontWeight? leftFontWeight;

  /// 左标题颜色
  final Color leftColor;

  /// 右标题颜色
  final Color rightColor;

  /// 左边颜色
  final Color? leftBackColor;

  /// 右边颜色
  final Color? rightBackColor;

  /// btn insets
  final EdgeInsets leftInsets;

  /// btn insets
  final EdgeInsets rightInsets;

  /// btn 高度
  final double height;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      height: this.height,
      margin: EdgeInsets.only(bottom: 8 / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: Container(
                  alignment: Alignment.centerRight,
                  color: Colors.white,
                  child: CupertinoButton(
                    child: Text(leftTit ?? "",
                        style: TextStyle(
                            fontWeight: leftFontWeight ?? FontWeight.w500,
                            fontSize: leftFontSize ?? 14,
                            color: leftColor
                        )),
                    onPressed: leftCall,
                    padding: leftInsets,
                    color: leftBackColor
                  ))),
          Spacer(),
          Expanded(
              child: Container(
                  alignment: Alignment.centerLeft,
                  color: Colors.white,
                  child: CupertinoButton(
                      child: Text(rightTit ?? "",
                          style: TextStyle(
                              fontWeight: rightFontWeight ?? FontWeight.w500,
                              fontSize: rightFontSize ?? 14,
                              color: rightColor
                          )),
                      onPressed: rightCall,
                      padding: rightInsets,
                      color: rightBackColor
                  )))
        ],
      ),
    );
  }
}

/// 单按钮
class SignalBottomAlter extends StatelessWidget {
  SignalBottomAlter({this.onPop,
    this.spaceHeight,
    this.titleWidget,
    this.titleStr,
    this.contentStr,
    this.btnHeight1 = 50,
    this.callBack,
    this.btnBackColor,
    this.btnFontSize,
    this.btnFontWeight,
    this.btnInsets = const EdgeInsets.symmetric(horizontal: 8 * 2),
    this.btnRadius,
    this.btnTitColor = Colors.black,
    this.tit,
    this.contentFontWeight,
    this.contentFontSize,
    this.titFontSize,
    this.titFontWeight, this.contentHeight, this.contentWidth});

  /// 标题
  final Widget? titleWidget;

  /// 警示标题
  final String? titleStr;

  /// 内容
  final String? contentStr;

  /// 空隙
  final double? spaceHeight;

  /// 返回
  final void Function()? onPop;

  /// 标题字体
  final double? titFontSize;

  /// 内容字体
  final double? contentFontSize;

  /// 标题大小
  final FontWeight? titFontWeight;

  /// 内容大小
  final FontWeight? contentFontWeight;

  /// 底部button 属性
  /// 右回调
  final void Function()? callBack;

  /// 右标题字体大小
  final double? btnFontSize;

  /// 右标题字体
  final FontWeight? btnFontWeight;

  /// 右标题颜色
  final Color btnTitColor;

  /// 元切角
  final double? btnRadius;

  /// 背景色
  final Color? btnBackColor;

  /// btn 高度
  final double btnHeight1;

  /// btn insets
  final EdgeInsets btnInsets;

  /// 按钮标题
  final String? tit;
  /// 元素高度
  final double? contentHeight;
  /// 元素宽度
  final double? contentWidth;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ConsultingWarning(
      onPop: onPop,
      spaceHeight: spaceHeight,
      titleWidget: titleWidget,
      titleStr: titleStr,
      contentStr: contentStr,
      contentHeight: contentHeight,
      contentWidth: contentWidth,
      contentFontWeight: contentFontWeight,
      contentFontSize: contentFontSize,
      titFontSize: titFontSize,
      titFontWeight: titFontWeight,
      bottomWidget: SignalBottomWidget(
          fontSize: btnFontSize,
          callBack: callBack,
          fontWeight: btnFontWeight,
          radius: this.btnRadius,
          tit: this.tit,
          titColor: this.btnTitColor,
          backColor: this.btnBackColor,
          height: this.btnHeight1,
          insets: this.btnInsets),
    );
  }
}

/// 正常双按钮
class NormalBottomAlter extends StatelessWidget {
  NormalBottomAlter({this.contentFontWeight,
    this.titFontWeight,
    this.titFontSize,
    this.contentFontSize,
    this.titleStr,
    this.onPop,
    this.contentStr,
    this.titleWidget,
    this.spaceHeight,
    this.btnRightColor = Colors.black,
    this.btnLeftCall,
    this.btnRightCall,
    this.btnLeftFontWeight,
    this.btnLeftFontSize,
    this.btnLeftColor = Colors.black,
    this.btnRightFontWeight,
    this.btnRightFontSize,
    this.btnHeight1 = 50,
    this.btnLeftInsets = const EdgeInsets.symmetric(horizontal: 8 * 2),
    this.btnRightInsets = const EdgeInsets.symmetric(horizontal: 8 * 2),
    this.btnRightBackColor,
    this.btnLeftBackColor,
    this.btnLeftTit,
    this.btnRightTit});

  /// 标题
  final Widget? titleWidget;

  /// 警示标题
  final String? titleStr;

  /// 内容
  final String? contentStr;

  /// 空隙
  final double? spaceHeight;

  /// 返回
  final void Function()? onPop;

  /// 标题字体
  final double? titFontSize;

  /// 内容字体
  final double? contentFontSize;

  /// 标题大小
  final FontWeight? titFontWeight;

  /// 内容大小
  final FontWeight? contentFontWeight;

  /// btn 属性
  /// 左标提
  final String? btnLeftTit;

  /// 右标提
  final String? btnRightTit;

  /// 左回调
  final void Function()? btnLeftCall;

  /// 右回调
  final void Function()? btnRightCall;

  /// 左标题字体大小
  final double? btnLeftFontSize;

  /// 右标题字体大小
  final double? btnRightFontSize;

  /// 右标题字体
  final FontWeight? btnRightFontWeight;

  /// 左标题字体
  final FontWeight? btnLeftFontWeight;

  /// 左标题颜色
  final Color btnLeftColor;

  /// 右标题颜色
  final Color btnRightColor;

  /// 左边颜色
  final Color? btnLeftBackColor;

  /// 右边颜色
  final Color? btnRightBackColor;

  /// btn insets
  final EdgeInsets btnLeftInsets;

  /// btn insets
  final EdgeInsets btnRightInsets;

  /// btn 高度
  final double? btnHeight1;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ConsultingWarning(
      onPop: onPop,
      spaceHeight: spaceHeight,
      titleWidget: titleWidget,
      titleStr: titleStr,
      contentStr: contentStr,
      contentFontWeight: contentFontWeight,
      contentFontSize: contentFontSize,
      titFontSize: titFontSize,
      titFontWeight: titFontWeight,
      bottomWidget: NormalBottomWidget(
          leftCall: btnLeftCall,
          rightCall: btnRightCall,
          leftTit: btnLeftTit,
          rightTit: btnRightTit,
          leftColor: btnLeftColor,
          leftFontSize: btnLeftFontSize,
          leftFontWeight: btnLeftFontWeight,
          rightColor: btnRightColor,
          rightFontSize: btnRightFontSize,
          rightFontWeight: btnRightFontWeight,
          rightBackColor: btnRightBackColor,
          rightInsets: btnRightInsets,
          leftInsets: btnLeftInsets,
          leftBackColor: btnLeftBackColor,
          height: 50),
    );
  }
}
