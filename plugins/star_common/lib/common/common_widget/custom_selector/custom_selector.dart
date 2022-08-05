/*
 *  Copyright (C), 2015-2021
 *  FileName: custom_selector
 *  Author: Tonight丶相拥
 *  Date: 2021/7/16
 *  Description: 
 **/

part of appcommon;

class SelectorCustom<T extends ChangeNotifier, T1> extends StatelessWidget {
  SelectorCustom({required Widget Function(T1) builder,
    required this.selector, this.shouldRebuild}): this._childBuild = builder;
  /// 子控件 控件返回
  final Widget Function(T1) _childBuild;
  /// 值返回
  final T1 Function(T) selector;
  ///
  final ShouldRebuild<T1>? shouldRebuild;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Selector<T, T1>(builder: (_, T1 value, __) {
      return _childBuild(value);
    }, selector: (_, t) => selector(t),
        shouldRebuild: shouldRebuild ??
                (previous, next) => previous != next);// (previous, next) => previous != next
  }
}