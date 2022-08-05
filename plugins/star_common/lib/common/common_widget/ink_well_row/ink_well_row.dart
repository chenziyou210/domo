/*
 *  Copyright (C), 2015-2021
 *  FileName: inkwell_row
 *  Author: Tonight丶相拥
 *  Date: 2021/7/16
 *  Description: 
 **/

part of appcommon;

class InkWellRow extends StatelessWidget {
  InkWellRow({required this.children, this.onTap,
    this.mainAxisAlignment: MainAxisAlignment.start});
  final VoidCallback? onTap;
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: this.mainAxisAlignment,
        children: children
      )
    );
  }
}

class ExpandInkWellRow extends InkWellRow {
  ExpandInkWellRow({required List<Widget> children,
    VoidCallback? onTap, this.constraints})
      : super(children: children, onTap: onTap);

  final BoxConstraints? constraints;

  @override
  // TODO: implement mainAxisAlignment
  MainAxisAlignment get mainAxisAlignment => MainAxisAlignment.end;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget w = super.build(context);
    w = ConstrainedBox(constraints: constraints ?? BoxConstraints.expand(), child: w);
    return Expanded(child: w);
  }
}