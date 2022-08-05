/*
 *  Copyright (C), 2015-2021
 *  FileName: default_appbar
 *  Author: Tonight丶相拥
 *  Date: 2021/3/11
 *  Description: 
 **/

part of appcommon;

class DefaultAppBar extends AppBar {
  DefaultAppBar({
    Key? key,
    Widget leading: const CustomBackButton(),
    bool automaticallyImplyLeading = true,
    Widget? title,
    List<Widget>? actions,
    Widget? flexibleSpace,
    PreferredSizeWidget? bottom,
    double? elevation,
    Color? shadowColor,
    ShapeBorder? shape,
    Color? backgroundColor,
    Color? foregroundColor,
    Brightness? brightness,
    IconThemeData? iconTheme,
    IconThemeData? actionsIconTheme,
    TextTheme? textTheme,
    bool primary = true,
    bool? centerTitle,
    bool excludeHeaderSemantics = false,
    double? titleSpacing,
    double toolbarOpacity = 1.0,
    double bottomOpacity = 1.0,
    double? toolbarHeight,
    double? leadingWidth,
    bool? backwardsCompatibility,
    TextStyle? toolbarTextStyle,
    TextStyle? titleTextStyle,
    SystemUiOverlayStyle? systemOverlayStyle
  }): super(key: key,
    leading: leading,
    automaticallyImplyLeading: automaticallyImplyLeading,
    title: title,
    actions: actions,
    flexibleSpace: flexibleSpace ,
    bottom: bottom,
    elevation: elevation,
    shadowColor: shadowColor,
    shape: shape,
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
    // brightness: Brightness.light,
    iconTheme: iconTheme,
    actionsIconTheme: actionsIconTheme,
    textTheme: textTheme,
    primary: primary,
    centerTitle: centerTitle,
    excludeHeaderSemantics: excludeHeaderSemantics,
    titleSpacing: titleSpacing,
    toolbarOpacity: toolbarOpacity,
    bottomOpacity: bottomOpacity,
    toolbarHeight: toolbarHeight,
    leadingWidth: leadingWidth,
    backwardsCompatibility: backwardsCompatibility,
    toolbarTextStyle: toolbarTextStyle,
    titleTextStyle: titleTextStyle,
    // systemOverlayStyle: systemOverlayStyle
   );
}