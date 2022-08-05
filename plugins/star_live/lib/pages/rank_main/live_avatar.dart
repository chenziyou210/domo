import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:lottie/lottie.dart';

class OnLiveAvatar extends StatelessWidget {
  final double radius; // 宽高是radius的两倍
  final bool onLive;
  final int? isInvisible;
  final bool isAnchor;
  final String? imgUrl;
  final EdgeInsets? padding;
  final String? championIcon; //适配排行榜
  //配置默认图 ，不同需要求宽高不同，单独传
  final Widget? locImageChild;
  final GestureTapCallback? onPressed;

  final double? childBotton;

  const OnLiveAvatar(
      {Key? key,
      this.locImageChild,
      this.childBotton,
      this.imgUrl,
      this.padding = const EdgeInsets.all(2),
      required this.isAnchor,
      this.championIcon = "",
      this.onLive = false,
      this.isInvisible = 1,
      this.radius = 25,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        /// 可以超过边界不报错
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.topCenter,
        children: [
          // 原形图片
          Container(
            width: (radius * 2).dp,
            height: (radius * 2).dp,
            padding: EdgeInsets.all(onLive ? 2 : 0),
            decoration: BoxDecoration(
              // image:  DecorationImage(
              //   image: NetworkImage("https://img.syt5.com/2021/0720/20210720093841897.jpg.420.420.jpg"),
              //   // image: ExactAssetImage(AppImages.rankHeadMoren,scale: 0.5),
              // ),
              borderRadius: BorderRadius.circular(radius.dp),

              /// 边框展示情况
              /// show展示的情况
              /// 1.直播中- 未直播 的都 黑色边框， 1.2 但是有本地图片展示的 为 白20
              /// false展示情况
              /// 2.1 变为透明
              color: onLive
                  ? AppMainColors.whiteColor6
                  : AppMainColors.transparent,
              border: onLive
                  ? Border.all(
                      color: onLive
                          ? AppMainColors.mainColor
                          : AppMainColors.whiteColor40,
                      width: 1,
                      style: BorderStyle.solid,
                    )
                  : const Border(),
            ),
            child: ClipOval(
              child: _buildImage(radius - 2),
            ),
          ),
          // 直播动图
          Lottie.asset('assets/data/onlive.json',
                  width: 16, height: onLive ? 16 : 0, fit: BoxFit.fill)
              .position(
                  bottom: childBotton != null ? childBotton!.dp : 2, right: 3),
          //顶部皇冠图片 适配排行版用
          championIcon!.isNotEmpty
              ? Image.asset(
                  championIcon!,
                  width: 20,
                  height: 20,
                  fit: BoxFit.cover,
                ).position(top: -16)
              : const SizedBox(),
        ]).inkWell(onTap: onPressed);
  }

  Widget _buildImage(double radius) {
    //榜单隐身
    if (!isAnchor && isInvisible == 1) {
      return Image.asset(
        R.icHideOn,
        width: 50.dp,
        height: 50.dp,
      );
    } else {
      return imgUrl != null
          ? CachedNetworkImageAnchor(imgUrl!,defalutChild: locImageChild,)
          : Center(child: locImageChild);
    }
  }
}

//网络图片请求首页统配Widget
class CachedNetworkImageAnchor extends StatelessWidget {
  final String url;
  final Widget? defalutChild;
  const CachedNetworkImageAnchor(this.url, {Key? key, this.defalutChild}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppMainColors.homeItemDefaultGradient,
          ),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            // colorFilter:
            // ColorFilter.mode(Colors.red, BlendMode.colorBurn)
          ),
        ),
      ),
      placeholder: (context, string) {
        return  Center(child: defalutChild);
      },
      errorWidget: (context, url, error) {
        return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
          colors: AppMainColors.homeItemDefaultGradient,
        )));
      },
    );
  }
}
