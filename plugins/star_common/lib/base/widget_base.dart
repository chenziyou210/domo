/*
 *  Copyright (C), 2015-2021
 *  FileName: widget_base
 *  Author: Tonight丶相拥
 *  Date: 2021/7/13
 *  Description: 
 **/

part of app_base;

abstract class AppStateBase<T extends StatefulWidget> extends State<T>
    with WidgetContext, BaseWidgetImplements, WidgetFunctionImplement {
  AppModel? model;

  AppInternational get intl => AppInternational.current;

  AppModel? initializeModel() {
    return null;
  }

  /// 界面宽
  double get width => MediaQuery.of(context).size.width;

  /// 界面高
  double get height => MediaQuery.of(context).size.height;

  @override
  // TODO: implement widgetContext
  BuildContext? get widgetContext => this.context;

  /*更新状态*/
  void updateState() {
    if (mounted) this.setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = initializeModel();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return scaffold;
  }

  /// scaffold
  Widget get scaffold => Scaffold(
      backgroundColor: bodyColor,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      bottomNavigationBar: bottomNavigationBar,
      appBar: appBar,
      endDrawer: endDraw,
      drawerScrimColor: drawerScrimColor,
      body: body);

  /// app bar
  PreferredSizeWidget? get appBar => null;

  Color? get drawerScrimColor => null;

  /// body
  @required
  Widget get body => Container();

  /// bodyColor
  Color? get bodyColor => Colors.transparent;

  /// floating Action button
  Widget? get floatingActionButton => null;

  /// extend body behind appbar
  bool get extendBodyBehindAppBar => false;

  /// floating action button location
  FloatingActionButtonLocation? get floatingActionButtonLocation => null;

  /// bottom navigation bar
  Widget? get bottomNavigationBar => null;

  bool? get resizeToAvoidBottomInset => null;

  Widget? get endDraw => null;
}

mixin WidgetContext {
  /// 上下文
  BuildContext? widgetContext;
}

mixin WidgetFunctionImplement on WidgetContext, BaseWidgetImplements {
  /// tab bar padding width
  double get tabBarPaddingWidth =>
      kTabLabelPadding.left + kTabLabelPadding.right;

  /* 提示框
  * widgetObj 初始化好的widget*/
  Future<T?> alertViewController<T>(Widget widgetObj,
      {bool barrierDismissible = true, BuildContext? context}) {
    return context == null && widgetContext == null
        ? Future.value()
        : super.alertViewControllerWith(
            widgetContext == null ? context! : widgetContext!,
            widgetObj,
            barrierDismissible);
  }
  //
  // /* 返回上一个界面
  // * result 返回的参数
  // * 供 then 和 _await 使用 */
  // void popViewController<T extends Object>([T? result]) {
  //   super.popViewControllerWith(widgetContext!, result);
  // }
  //
  // /*界面替换 RootViewController
  // * widgetOjc 初始化好的root
  // * predicate 并不知道是什么*/
  // void pushAndRemoveUntil<T extends Widget>(T widgetOjc,
  //     [RoutePredicate? predicate]) {
  //   super.pushAndRemoveUntilWith(widgetContext!, widgetOjc, predicate);
  // }
  //
  // /* pushViewController
  // * widgetObj 初始化好的widget*/
  // Future<T?> pushViewController<T extends Object>(Widget widgetObj) {
  //   return super.pushViewControllerWith(widgetContext!, widgetObj);
  // }
  //
  // /* 透明层
  // * Widget 对象*/
  // void showTransparentWidget(Widget obj) {
  //   super.showTransparentWidgetWith(widgetContext!, obj);
  // }

  /// 取消焦点
  void unFocus() {
    super.unFocusWith(widgetContext!);
  }

  // /*
  //  * modal bottom sheet
  //  * widgetObj: child (which will be show)*/
  // Future<T?> showModalBottomSheet1<T>(Widget widgetObj,
  //     {BuildContext? ownContext,
  //     Color? backGroundColor,
  //     Color? barrierColor,
  //     bool isScrollControlled: false,
  //     bool isDismissible: true}) {
  //   return showModalBottomSheet(
  //       context: ownContext ?? widgetContext!,
  //       isScrollControlled: isScrollControlled,
  //       backgroundColor: backGroundColor,
  //       barrierColor: barrierColor,
  //       isDismissible: isDismissible,
  //       builder: (_) {
  //         return widgetObj;
  //       });
  // }

  // /// 推送到指定界面
  // void popUntil(String name, {BuildContext? context}) {
  //   super.popUntilWith(context ?? widgetContext!, name);
  // }
  //
  // /// 推入界面
  // Future<T?> pushViewControllerWithName<T>(String name,
  //     {BuildContext? context, Object? arguments}) {
  //   return super.pushViewControllerWithNameAndContext(
  //       context ?? widgetContext!, name,
  //       arguments: arguments);
  // }
}

mixin WidgetObserver on WidgetsBindingObserver {
  /// 添加frame 绘制完成回调
  void addPostFrameBack() {
    WidgetsBinding.instance.addPostFrameCallback(frameBack);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      appEnterBackGround();
    } else {
      appResumeCall();
    }
    super.didChangeAppLifecycleState(state);
  }

  /// 添加app 状态
  void addAppLifecycleStateObserver() {
    WidgetsBinding.instance.addObserver(this);
  }

  /// 绘制完成回调
  void frameBack(_) {}

  /// app 恢复活跃状态
  void appResumeCall() {}

  /// 生命周期回调
  void appEnterBackGround() {}
}

mixin BaseWidgetImplements {
  /* 提示框
  * widgetObj 初始化好的widget*/
  Future<T?> alertViewControllerWith<T>(BuildContext context, Widget widgetObj,
      [bool barrierDismissible = false]) {
    return showDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (dialogContext) {
          return widgetObj;
        });
  }
  //
  // /* 返回上一个界面
  // * result 返回的参数
  // * 供 then 和 _await 使用 */
  // void popViewControllerWith<T extends Object>(BuildContext context,
  //     [T? result]) {
  //   if (Navigator.of(context).canPop()) {
  //     Navigator.of(context).pop(result);
  //   }
  // }
  //
  // /*界面替换 RootViewController
  // * widgetOjc 初始化好的root
  // * predicate 并不知道是什么*/
  // void pushAndRemoveUntilWith<T extends Widget>(
  //     BuildContext context, T widgetOjc,
  //     [RoutePredicate? predicate]) {
  //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (
  //     BuildContext context,
  //   ) {
  //     return widgetOjc;
  //   }), predicate ?? _route1());
  // }

  // RoutePredicate _route1() {
  //   return (Route<dynamic> route) {
  //     return false;
  //   };
  // }

  // /* pushViewController
  // * widgetObj 初始化好的widget*/
  // Future<T?> pushViewControllerWith<T extends Object>(
  //     BuildContext context, Widget widgetObj) {
  //   return Navigator.push(
  //       context, new MaterialPageRoute(builder: (context) => widgetObj));
  // }
  //
  // /* 透明层
  // * Widget 对象*/
  // void showTransparentWidgetWith(BuildContext context, Widget obj) {
  //   Navigator.of(context).push(PageRouteBuilder(
  //       opaque: false,
  //       pageBuilder: (context, animation, secondaryAnimation) {
  //         return Material(type: MaterialType.transparency, child: obj);
  //       }));
  // }

  /// 取消焦点
  void unFocusWith(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
      primaryFocus?.unfocus();
    }
    // SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  // /*
  //  * modal bottom sheet
  //  * widgetObj: child (which will be show)*/
  // Future<T?> showModalBottomSheet1With<T>(
  //     BuildContext context, Widget widgetObj,
  //     {Color? backGroundColor,
  //     Color? barrierColor,
  //     bool isScrollControlled: false,
  //     bool isDismissible: true}) {
  //   return showModalBottomSheet(
  //       context: context,
  //       isScrollControlled: isScrollControlled,
  //       backgroundColor: backGroundColor,
  //       barrierColor: barrierColor,
  //       isDismissible: isDismissible,
  //       builder: (_) {
  //         return widgetObj;
  //       });
  // }
  //
  // /// 推送到指定界面
  // void popUntilWith(BuildContext context, String name) {
  //   Navigator.of(context).popUntil(ModalRoute.withName(name));
  // }
  //
  // /// 推入界面
  // Future<T?> pushViewControllerWithNameAndContext<T>(
  //     BuildContext context, String name,
  //     {Object? arguments}) {
  //   return Navigator.of(context).pushNamed(name, arguments: arguments);
  // }
}

class NavKey {
  static final navKey = new GlobalKey<NavigatorState>();
}
