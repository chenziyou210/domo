
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState;

import '../common/app_common_widget.dart';

class LottieHeader extends RefreshIndicator {
  LottieHeader() : super(height: 140.0, refreshStyle: RefreshStyle.Follow);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GifHeaderState();
  }
}

class GifHeaderState extends RefreshIndicatorState<LottieHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _anicontroller;

  @override
  void initState() {
    // TODO: implement initState
    // init frame is 2
    _anicontroller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    super.initState();
  }

  @override
  Widget buildContent(BuildContext context, RefreshStatus mode) {
    // TODO: implement buildContent
    return Container(
      child: Column(
        //控件里面内容主轴负轴剧中显示
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        //主轴高度最小
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Lottie.asset(
            "assets/data/lottie_animation.json",
            // controller: _anicontroller,
            width: 72,
            height: 72,
            fit: BoxFit.fill,
            onLoaded: (composition) {
              // Configure the AnimationController with the duration of the
              // Lottie file and start the animation.
              _anicontroller
                ..duration = composition.duration
                ..forward();
            },
          ),
          CustomText('正在加载',
              fontSize: 12.dp, color: AppMainColors.whiteColor40),
          SizedBox(height: 20,)
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _anicontroller.dispose();
    super.dispose();
  }
}
