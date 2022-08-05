part of appcommon;



enum EmptyType {
  noData,
  noRecord,
  noSearch,
  noMessage,
  networkError,
}

class EmptyView extends StatelessWidget {
  EmptyView({required this.emptyType,
    this.emptyStr,
    this.imageStr,
    this.topOffset,
    this.onPressed,
    this.imagePaddingBottom = 130,
    this.textPaddingTop = 60,
    this.buttonPaddingTop = 150,
    this.btnStr,
    this.buttonWidget,
    this.imageWidget,
    this.textWidget,
    Key? key}) : super(key: key);

  final String? emptyStr,btnStr,imageStr;
  final EmptyType emptyType;
  final double? topOffset;// 向上偏移量
  final Function()? onPressed;

  /// 已body 的最大高度
  final double? imagePaddingBottom; //从中心向上移动 值越大越往上 带默认值
  final double? textPaddingTop;     //从中心向下移动 值越大越往下 带默认值
  final double? buttonPaddingTop;   //从中心向下移动 值越大越往下 带默认值
  final Widget? imageWidget,textWidget,buttonWidget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          imageWidget ?? Image.asset(
            imageStr ?? _getEmptyImage(),
            width: 180.dp,
            height: 180.dp,

          ).padding(padding: EdgeInsets.only(bottom: imagePaddingBottom!.dp)),

          textWidget ?? Text(
            emptyStr ?? _getEmptyText(),
            style: TextStyle(fontSize: 12.sp, color: AppMainColors.whiteColor70,),
            textAlign: TextAlign.center,
          ).padding(padding: EdgeInsets.only(top: textPaddingTop!.dp)),

            emptyType == EmptyType.networkError ?
           buttonWidget ?? Container(
              padding: EdgeInsets.only(top: buttonPaddingTop!.dp),
              child: GradientButton(
                  onPressed: onPressed,
                  minHeight: 32.dp,
                  minWidth: 120.dp,
                  child: Text( btnStr ?? "刷新试试")),
          ) : Container(),
        ],
      ),
    );
  }

  String _getEmptyImage(){
    switch (emptyType) {
      case EmptyType.noData:
        return R.emptyNormal;
      case EmptyType.noRecord:
        return R.emptyRecord;
      case EmptyType.noMessage:
        return R.emptyMessage;
      case EmptyType.noSearch:
        return R.emptySearch;
      case EmptyType.networkError:
        return R.emptyNetwork;
    }
  }

  String _getEmptyText(){
    switch (emptyType) {
      case EmptyType.noData:
        return '这里空空的，什么都没有';
      case EmptyType.noRecord:
        return '一个记录都没有呢';
      case EmptyType.noMessage:
        return '还没有收到任何消息哦';
      case EmptyType.noSearch:
        return '没有搜到？换个词试试吧';
      case EmptyType.networkError:
        return '网络好像跑路了，请检查网络是否正常';
    }
  }

}

