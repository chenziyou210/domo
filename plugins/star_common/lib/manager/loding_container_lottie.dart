

import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:star_common/common/app_common_widget.dart';



class LoadingContainer extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  LoadingContainer({required this.isLoading,required this.child});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Stack(
       children: [
         child,
        isLoading ? _loadingView:Container(),
       ],
    );
  }

  Widget get _loadingView{
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
            width: 100,
            height: 80,
            fit: BoxFit.fill,
          ),
          CustomText('正在加载',
              fontSize: 12.dp, color: AppMainColors.whiteColor40),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}

