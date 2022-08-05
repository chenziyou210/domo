/*
 *  Copyright (C), 2015-2021
 *  FileName: widget_extension
 *  Author: Tonight丶相拥
 *  Date: 2021/10/8
 *  Description: 
 **/


part of appcommon;

// /// 小部件扩展
// extension WidgetExtension on Widget {
//   Widget sizedBox({double? height, double? width}) {
//     return SizedBox(height: height, width: width, child: this);
//   }
//
//   Widget clipRRect({BorderRadius? radius}){
//     return ClipRRect(
//       borderRadius: radius,
//       child: this,
//     );
//   }
//
//   Widget container({Decoration? decoration, Color? color,
//     double? width, double? height, EdgeInsetsGeometry? padding,
//     EdgeInsetsGeometry? margin, AlignmentGeometry? alignment,
//     BoxConstraints? constraints}) {
//     assert(color == null || decoration == null, "color and decoration can not have value on same time");
//     return Container(
//       alignment: alignment,
//       padding: padding,
//       margin: margin,
//       height: height,
//       width: width,
//       color: color,
//       decoration: decoration,
//       constraints: constraints,
//       child: this
//     );
//   }
//
//   Widget nullWidget<T>(T? value, {Widget placeHolder: const SizedBox(),
//     bool Function(T)? predict}){
//     return NullWidget<T>(value,
//         builder: (_, __) {
//           return this;
//         },
//         predict: predict,
//         placeHolder: placeHolder);
//   }
//
//   // Widget selectorCustom<T extends ChangeNotifier, T1>({required T1 Function(T) selector,
//   //   ShouldRebuild<T1>? shouldRebuild}){
//   //   print(2222222222);
//   //   return SelectorCustom<T, T1>(builder: (_) {
//   //     print(33333333333333);
//   //     return (()=> this)();
//   //   }, selector: selector,
//   //       shouldRebuild: shouldRebuild);
//   // }
//
//   Widget gestureDetector({void Function()? onTap}){
//     return GestureDetector(
//       onTap: onTap,
//       child: this
//     );
//   }
//
//   Widget safeArea({bool left = true, bool top = true, bool right = true,
//     bool bottom = true, EdgeInsets minimum = EdgeInsets.zero,
//     bool maintainBottomViewPadding = false}){
//     return SafeArea(
//       left: left,
//       right: right,
//       top: top,
//       bottom: bottom,
//       minimum: minimum,
//       maintainBottomViewPadding: maintainBottomViewPadding,
//       child: this,
//     );
//   }
//
//   Widget center(){
//     return Center(child: this);
//   }
//
//   Widget padding({required EdgeInsetsGeometry padding}){
//     return Padding(
//       padding: padding,
//       child: this,
//     );
//   }
//
//   Widget expanded({int flex = 1}){
//     return Expanded(
//       flex: flex,
//       child: this,
//     );
//   }
//
//   Widget singleScrollView({ScrollController? controller}){
//     return SingleChildScrollView(
//       child: this,
//       controller: controller
//     );
//   }
// }
//
// extension ListExtension on List<Widget> {
//   Widget customScrollView({ScrollController? controller,
//     ScrollPhysics? physics}){
//     return CustomScrollView(
//       physics: physics,
//       controller: controller,
//       slivers: this
//     );
//   }
//
//   Widget refreshWidget({ScrollController? scrollController, Axis? scrollDirection,
//     ScrollPhysics? physics, void Function(RefreshController)? onLoading,
//     void Function(RefreshController)? onRefresh,
//     bool enablePullDown: true, bool enablePullUp: false}){
//     return RefreshWidget(
//       children: this,
//       scrollController: scrollController,
//       scrollDirection: scrollDirection,
//       physics: physics,
//       onLoading: onLoading,
//       onRefresh: onRefresh,
//       enablePullDown: enablePullDown,
//       enablePullUp: enablePullUp
//     );
//   }
//
//   Widget row({MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
//     MainAxisSize mainAxisSize = MainAxisSize.max,
//     CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
//     TextDirection? textDirection,
//     VerticalDirection verticalDirection = VerticalDirection.down}){
//     return Row(
//       mainAxisSize: mainAxisSize,
//       mainAxisAlignment: mainAxisAlignment,
//       crossAxisAlignment: crossAxisAlignment,
//       textDirection: textDirection,
//       verticalDirection: verticalDirection,
//       children: this,
//     );
//   }
//
//   Widget column({MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
//     MainAxisSize mainAxisSize = MainAxisSize.max,
//     CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
//     TextDirection? textDirection,
//     VerticalDirection verticalDirection = VerticalDirection.down}){
//     return Column(
//       mainAxisSize: mainAxisSize,
//       mainAxisAlignment: mainAxisAlignment/// 小部件扩展
// // extension WidgetExtension on Widget {
// //   Widget sizedBox({double? height, double? width}) {
// //     return SizedBox(height: height, width: width, child: this);
// //   }
// //
// //   Widget clipRRect({BorderRadius? radius}){
// //     return ClipRRect(
// //       borderRadius: radius,
// //       child: this,
// //     );
// //   }
// //
// //   Widget container({Decoration? decoration, Color? color,
// //     double? width, double? height, EdgeInsetsGeometry? padding,
// //     EdgeInsetsGeometry? margin, AlignmentGeometry? alignment,
// //     BoxConstraints? constraints}) {
// //     assert(color == null || decoration == null, "color and decoration can not have value on same time");
// //     return Container(
// //       alignment: alignment,
// //       padding: padding,
// //       margin: margin,
// //       height: height,
// //       width: width,
// //       color: color,
// //       decoration: decoration,
// //       constraints: constraints,
// //       child: this
// //     );
// //   }
// //
// //   Widget nullWidget<T>(T? value, {Widget placeHolder: const SizedBox(),
// //     bool Function(T)? predict}){
// //     return NullWidget<T>(value,
// //         builder: (_, __) {
// //           return this;
// //         },
// //         predict: predict,
// //         placeHolder: placeHolder);
// //   }
// //
// //   // Widget selectorCustom<T extends ChangeNotifier, T1>({required T1 Function(T) selector,
// //   //   ShouldRebuild<T1>? shouldRebuild}){
// //   //   print(2222222222);
// //   //   return SelectorCustom<T, T1>(builder: (_) {
// //   //     print(33333333333333);
// //   //     return (()=> this)();
// //   //   }, selector: selector,
// //   //       shouldRebuild: shouldRebuild);
// //   // }
// //
// //   Widget gestureDetector({void Function()? onTap}){
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: this
// //     );
// //   }
// //
// //   Widget safeArea({bool left = true, bool top = true, bool right = true,
// //     bool bottom = true, EdgeInsets minimum = EdgeInsets.zero,
// //     bool maintainBottomViewPadding = false}){
// //     return SafeArea(
// //       left: left,
// //       right: right,
// //       top: top,
// //       bottom: bottom,
// //       minimum: minimum,
// //       maintainBottomViewPadding: maintainBottomViewPadding,
// //       child: this,
// //     );
// //   }
// //
// //   Widget center(){
// //     return Center(child: this);
// //   }
// //
// //   Widget padding({required EdgeInsetsGeometry padding}){
// //     return Padding(
// //       padding: padding,
// //       child: this,
// //     );
// //   }
// //
// //   Widget expanded({int flex = 1}){
// //     return Expanded(
// //       flex: flex,
// //       child: this,
// //     );
// //   }
// //
// //   Widget singleScrollView({ScrollController? controller}){
// //     return SingleChildScrollView(
// //       child: this,
// //       controller: controller
// //     );
// //   }
// // }
// //
// // extension ListExtension on List<Widget> {
// //   Widget customScrollView({ScrollController? controller,
// //     ScrollPhysics? physics}){
// //     return CustomScrollView(
// //       physics: physics,
// //       controller: controller,
// //       slivers: this
// //     );
// //   }
// //
// //   Widget refreshWidget({ScrollController? scrollController, Axis? scrollDirection,
// //     ScrollPhysics? physics, void Function(RefreshController)? onLoading,
// //     void Function(RefreshController)? onRefresh,
// //     bool enablePullDown: true, bool enablePullUp: false}){
// //     return RefreshWidget(
// //       children: this,
// //       scrollController: scrollController,
// //       scrollDirection: scrollDirection,
// //       physics: physics,
// //       onLoading: onLoading,
// //       onRefresh: onRefresh,
// //       enablePullDown: enablePullDown,
// //       enablePullUp: enablePullUp
// //     );
// //   }
// //
// //   Widget row({MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
// //     MainAxisSize mainAxisSize = MainAxisSize.max,
// //     CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
// //     TextDirection? textDirection,
// //     VerticalDirection verticalDirection = VerticalDirection.down}){
// //     return Row(
// //       mainAxisSize: mainAxisSize,
// //       mainAxisAlignment: mainAxisAlignment,
// //       crossAxisAlignment: crossAxisAlignment,
// //       textDirection: textDirection,
// //       verticalDirection: verticalDirection,
// //       children: this,
// //     );
// //   }
// //
// //   Widget column({MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
// //     MainAxisSize mainAxisSize = MainAxisSize.max,
// //     CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
// //     TextDirection? textDirection,
// //     VerticalDirection verticalDirection = VerticalDirection.down}){
// //     return Column(
// //       mainAxisSize: mainAxisSize,
// //       mainAxisAlignment: mainAxisAlignment,
// //       crossAxisAlignment: crossAxisAlignment,
// //       textDirection: textDirection,
// //       verticalDirection: verticalDirection,
// //       children: this
// //     );
// //   }
// // },
//       crossAxisAlignment: crossAxisAlignment,
//       textDirection: textDirection,
//       verticalDirection: verticalDirection,
//       children: this
//     );
//   }
// }