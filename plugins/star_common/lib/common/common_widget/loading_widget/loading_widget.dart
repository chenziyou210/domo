/*
 *  Copyright (C), 2015-2021 , schw
 *  FileName: loading_widget
 *  Author: Tonight丶相拥
 *  Date: 2021/2/24
 *  Description: 
 **/


part of appcommon;

class LoadingWidget extends StatelessWidget {
  LoadingWidget({required this.builder,
    required this.future, this.placeHolderBuilder, this.circularColor});
  final Widget Function(BuildContext context, AsyncSnapshot snapshot) builder;
  final Future future;
  final Widget Function(BuildContext)? placeHolderBuilder;
  final Color? circularColor;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (_, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        return builder(context, snapshot);
      }
      if (placeHolderBuilder != null) return placeHolderBuilder!(context);
      return Center(child: CircularProgressIndicator(color: circularColor));
    }, future: future);
  }
}

