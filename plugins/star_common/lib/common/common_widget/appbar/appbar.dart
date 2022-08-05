/*
 *  Copyright (C), 2015-2020 , schw
 *  FileName: appbar
 *  Author: Tonight丶相拥
 *  Date: 2020/12/19
 *  Description: 
 **/

part of appcommon;

class SpecialAppBar extends StatelessWidget implements PreferredSizeWidget {
  SpecialAppBar(this.children, {this.backGroundColor: Colors.transparent,
    this.crossAxisAlignment: CrossAxisAlignment.center,
    this.height, this.marginTop
  });

  final double? height;
  final double? marginTop;

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(this.height ?? kToolbarHeight);
  final CrossAxisAlignment crossAxisAlignment;

  /// 子控件
  final List<Widget> children;
  final Color backGroundColor;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Semantics(
      container: true,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Material(
          color: backGroundColor,
          elevation: 0,
          shadowColor: Color(0xFF000000),
          shape: null,
          child: Semantics(
            explicitChildNodes: true,
            child: Container(
              margin: EdgeInsets.only(top: marginTop ?? kRadialReactionRadius),
              color: backGroundColor,
              child: Row(
                crossAxisAlignment: crossAxisAlignment,
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
