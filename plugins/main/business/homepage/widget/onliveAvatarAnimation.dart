import 'package:flutter/material.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:lottie/lottie.dart';

import 'draw_ring.dart';
import 'homepage_widget.dart';

class OnLiveAvatarAnimation extends StatefulWidget {

  final double size; // 宽高等同 确定动画范围
  final bool onLive,needBorder;
  final Color? ringColor;
  final String? imgUrl;
  final EdgeInsets? padding;
  final Widget? locationImage;
  final Widget? netWorkImage;
  //配置默认图 ，不同需要求宽高不同，单独传
  final GestureTapCallback? onPressed;

  const OnLiveAvatarAnimation(
      this.size,
      {Key? key,
        this.imgUrl ,
        this.locationImage,
        this.padding,
        this.onLive = false,
        this.needBorder = false,
        this.ringColor = AppMainColors.mainColor,
        this.onPressed,
        this.netWorkImage,})
      : super(key: key);

  @override
  State<OnLiveAvatarAnimation> createState() => _OnLiveAvatarAnimationState();
}

class _OnLiveAvatarAnimationState extends State<OnLiveAvatarAnimation> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1500,
      ),
    )..repeat();

    _animationController.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        print("status is completed");
      }else if(status == AnimationStatus.forward){
        print("status is forward");
      }else if(status == AnimationStatus.reverse){
        print("status is reverse");
      }else if(status == AnimationStatus.dismissed){}
    });

  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.size;
    final Color color = widget.ringColor!;
    double imageRadiu = ((size - 4 ) / 2).ceilToDouble();
    bool location = widget.imgUrl == null;
    return Stack(
        alignment: AlignmentDirectional.center,
        children: [
          // 是否展示动画
          widget.onLive
              ? AnimatedBuilder(
            animation: _animationController,
            builder: (_, __) => Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Visibility(
                  visible: true,
                  child: Ring.draw(
                    color: color,
                    size: size,
                    strokeWidth: 0.5,
                  ),
                ),
                //动画大圆  在到达0.7-0.8 期间做了一组动画，在固定圆的基础上，往外延展了
                Opacity(
                  opacity: 1.0 - _animationController.value,
                  // visible: _animationController.value <= 0.8 &&
                  //     _animationController.value >= 0.7,
                  child: Transform.scale(
                    scale: Tween<double>(begin: 1.0, end: 1.3)
                        .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.0,
                          1.0,
                        ),
                      ),
                    ).value,
                    child: Ring.draw(
                      color: color,
                      size: size,
                      strokeWidth: 0.5,
                    ),
                  ),
                ),
                Opacity(
                  opacity: 1.0 - _animationController.value,
                  child: Transform.scale(
                    scale: Tween<double>(begin: 0.9, end: 1.15)
                        .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.5,
                          1.0,
                        ),
                      ),
                    ).value,
                    child: Ring.draw(
                      color: color,
                      size: size,
                      strokeWidth: 1,
                    ),
                  ),
                ),
                Opacity(
                  opacity: 1.0 - _animationController.value ,
                  child: Transform.scale(
                    scale: Tween<double>(begin: 1.0, end: 1.15)
                        .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.6,
                          0.8,
                        ),
                      ),
                    )
                        .value,
                    child: Ring.draw(
                      color: color,
                      size: size,
                      strokeWidth: 0.5,
                    ),
                  ),
                ),
                Opacity(
                  opacity: 1.0 - _animationController.value ,
                  child: Transform.scale(
                    scale: Tween<double>(begin: 0.9, end: 1.18)
                        .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.7,
                          1.0,
                        ),
                      ),
                    ).value,
                    child: Ring.draw(
                      color: color,
                      size: size,
                      strokeWidth: 0.5,
                    ),
                  ),
                ),
                Opacity(
                  opacity: 1.0 - _animationController.value ,
                  child: Transform.scale(
                    scale: Tween<double>(begin: 0.9, end: 1.25)
                        .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.1,
                          1.0,
                        ),
                      ),
                    ).value,
                    child: Ring.draw(
                      color: color,
                      size: size,
                      strokeWidth: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          )
              : SizedBox(),
          location
          //本地图片
              ? Container(
                    width: size,
                    height: size,
                    // color: AppMainColors.whiteColor20,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular((size / 2).ceilToDouble()),
                      color:AppMainColors.whiteColor20,
                      border: Border.all(
                        color: AppMainColors.whiteColor40,
                        width: 1,
                        style: BorderStyle.solid,
                      )
                    ),
                    child: widget.locationImage,
                  ).inkWell(onTap: widget.onPressed)
          //网络图片
              : Container(
                  width: size - 6,
                  height: size - 6,
                  // color: AppMainColors.transparent,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(imageRadiu),
                      gradient: LinearGradient(
                        colors: AppMainColors.homeItemDefaultGradient,
                      )
                  ),
                  // child: CachedNetworkImageAnchor(widget.imgUrl!),
                  child: CircleAvatar(
                         child:widget.netWorkImage,
                         maxRadius: imageRadiu,
                         backgroundImage: NetworkImage(widget.imgUrl!),
                         backgroundColor:  AppMainColors.transparent,
                  ),
                ).inkWell(onTap: widget.onPressed),
          // 直播动图
          Lottie.asset('assets/data/onlive.json',
              width: 16, height: widget.onLive ? 16 : 0, fit: BoxFit.cover)
              .position(bottom: 0, right: 0),
        ]
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
