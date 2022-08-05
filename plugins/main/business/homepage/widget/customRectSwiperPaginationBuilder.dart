
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:star_common/common/app_common_widget.dart';

class CustomRectSwiperPaginationBuilder extends RectSwiperPaginationBuilder{

  final Color? activeColor;
  final Color? color;
  final Key? key;
  final Size size;
  final Size activeSize;
  final double space;
  //
  CustomRectSwiperPaginationBuilder({
    this.activeColor,
    this.color,
    this.key,
    this.size = const Size(8.0, 2.0),
    this.activeSize = const Size(8.0, 2.0),
    this.space = 2.0,
  });

  @override
  Widget build(BuildContext context, SwiperPluginConfig? config) {
    final themeData = Theme.of(context);
    final activeColor = this.activeColor ?? themeData.primaryColor;
    final color = this.color ?? themeData.scaffoldBackgroundColor;

    var list = <Widget>[];

    if (config!.itemCount! > 20) {
      print(
        'The itemCount is too big, we suggest use FractionPaginationBuilder '
            'instead of DotSwiperPaginationBuilder in this situation',
      );
    }

    var itemCount = config.itemCount!;
    var activeIndex = config.activeIndex;

    for (var i = 0; i < itemCount; ++i) {
      var active = i == activeIndex;
      var size = active ? activeSize : this.size;
      list.add(Container(
        width: size.width,
        height: size.height,
        key: Key("pagination_$i"),
        margin: EdgeInsets.all(space),
        decoration: BoxDecoration(
          color: active ? activeColor : color,
          borderRadius: BorderRadius.circular(2),
        ),
      ));
    }

    if (config.scrollDirection == Axis.vertical) {
      return Column(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: list,
      );
    } else {
      return Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: AppMainColors.blackColor40,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          key: key,
          mainAxisSize: MainAxisSize.min,
          children: list,
        ),
      );
    }
  }

}