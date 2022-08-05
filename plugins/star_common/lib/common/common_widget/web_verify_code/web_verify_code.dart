/*
 *  Copyright (C), 2015-2021
 *  FileName: web_verify_code
 *  Author: Tonight丶相拥
 *  Date: 2021/12/7
 *  Description: 
 **/

part of appcommon;

class WebVerifyCodeImage extends StatefulWidget {
  WebVerifyCodeImage({
    required this.refresh,
    required this.url,
    this.queryName: "uuid",
    this.onUuidChange
  });
  final String refresh;
  final String url;
  final String queryName;
  final void Function(String)? onUuidChange;
  @override
  createState() => _WebVerifyCodeImageState();
}

class _WebVerifyCodeImageState extends State<WebVerifyCodeImage> {

  late String _uuid;

  @override
  void initState(){
    super.initState();
    _setUuid(_getUid());
  }

  void _refreshUuid(){
    _setUuid(_getUid());
    setState((){});
  }

  String _getUid(){
    return Uuid().v1();
  }

  void _setUuid(String uid){
    _uuid = uid;
    widget.onUuidChange?.call(_uuid);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          ExtendedImage.network(
            "${widget.url}?${widget.queryName}=$_uuid",
            width: 114.dp,
            height: 41.dp,
            fit: BoxFit.fill,
            enableLoadState: false
          ),
          CupertinoButton(
            minSize: 24,
            onPressed: (){
              _refreshUuid();
            },
            child: CustomText("${widget.refresh}",
              fontSize: 14.sp,
              fontWeight: w_400
            ), padding: EdgeInsets.zero
          )
        ]
    );
  }
}