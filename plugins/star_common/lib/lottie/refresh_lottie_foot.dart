import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState;

import '../common/app_common_widget.dart';

class LottieFooter extends StatefulWidget {
  LottieFooter() : super();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LottieFooterState();
  }
}

class _LottieFooterState extends State<LottieFooter>
    with SingleTickerProviderStateMixin {
  late AnimationController _anicontroller;

  @override
  void initState() {
    // TODO: implement initState
    // init frame is 2
    _anicontroller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomFooter(
      height: 80,
      builder: (context, mode) {
        Widget child;
        switch (mode) {
          case LoadStatus.failed:
            child = CustomText("失败，点击重试",
                fontSize: 12.dp, color: AppMainColors.whiteColor40);
            break;
          case LoadStatus.noMore:
            child = CustomText("没有更多数据",
                fontSize: 12.dp, color: AppMainColors.whiteColor40);
            break;
          default:
            child = Container(
              child: Row(
                //控件里面内容主轴负轴剧中显示
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                //主轴高度最小
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Lottie.asset(
                    "assets/data/lottie_animation.json",
                    // controller: _anicontroller,
                    width: 60,
                    height: 60,
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
                ],
              ),
            );
            break;
        }
        return Container(
          height: 60,
          child: Center(
            child: child,
          ),
        );
      },
      loadStyle: LoadStyle.ShowWhenLoading,
      onModeChange: (mode) {
        if (mode == LoadStatus.loading) {
          _anicontroller.repeat(
              min: 0, max: 29, period: Duration(milliseconds: 500));
        }
      },
      endLoading: () async {
        _anicontroller.value = 30;
        return _anicontroller.animateTo(59,
            duration: Duration(milliseconds: 500));
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _anicontroller.dispose();
    super.dispose();
  }
}
