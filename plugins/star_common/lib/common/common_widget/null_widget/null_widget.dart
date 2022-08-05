/*
 *  Copyright (C), 2015-2021
 *  FileName: null_widget
 *  Author: Tonight丶相拥
 *  Date: 2021/4/26
 *  Description: 
 **/
part of appcommon;

class NullWidget<T> extends StatelessWidget {
  NullWidget(this.value, {required this.builder,
    this.placeHolder: const SizedBox(),
    this.predict});
  final T? value;
  final Widget Function(BuildContext, T) builder;
  final Widget placeHolder;
  final bool Function(T)? predict;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (value == null || (predict?.call(this.value!) ?? false)) {
      return placeHolder;
    }else {
      return builder(context, value!);
    }
  }
}