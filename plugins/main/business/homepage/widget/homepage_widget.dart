import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:hjnzb/business/homepage/models/homepage_listDataConfig.dart';
import 'package:lottie/lottie.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:marquee/marquee.dart';
import 'package:star_common/generated/anchor_list_model_entity.dart';
import '../home_nearby_alert/nerby_alert_model.dart';
import '../models/homepage_model.dart';
import 'customRectSwiperPaginationBuilder.dart';

class HomePageViews extends StatelessWidget {
  final HomeInfoModel itemModel;
  final void Function(int)? tapBanner;
  const HomePageViews(this.itemModel, this.tapBanner, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Widget tempItemView;
    switch (itemModel.viewType) {
      case ListViewType.Anchor:
      case ListViewType.Nearby:
        tempItemView = HomeAnchorItem(itemModel.anchorItem);
        break;
      case ListViewType.Banner:
        tempItemView = HomeBannerWidget(itemModel.banner, this.tapBanner);
        break;
      case ListViewType.Ranking:
        tempItemView = HomeRankingWidget(itemModel.ranking);
        break;
      case ListViewType.Tip:
        tempItemView = HomeTipItem(itemModel.tipMessage);
        break;
      // case ListViewType.Game:tempItemView = HomeGameItem(itemModel.bannerGame);break;
      // case ListViewType.Marquee:tempItemView = HomeMarqueeWidget(itemModel.marquee);break;
      // 默认返回主播cell样式
      default:
        tempItemView = Container();
        break;
    }
    return tempItemView;
  }
}

/// 跑马灯
class HomeMarqueeWidget extends StatelessWidget {
  final HomeMarqueeInfo marquee;
  const HomeMarqueeWidget(this.marquee, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.dp,
      decoration: BoxDecoration(
        border: Border.all(color: AppMainColors.whiteColor15),
        gradient: LinearGradient(colors: AppMainColors.homeItemDefaultGradient),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
          child: Image.asset(R.homeToutiao,
              width: 56.dp, height: 40.dp, fit: BoxFit.cover),
        ),
        Marquee(
                text: marquee.content ?? " ",
                style: TextStyle(
                    fontSize: 12.dp, fontWeight: w_400, color: Colors.white),
                scrollAxis: Axis.horizontal,
                velocity: 50.0,
                blankSpace: 259,
                accelerationCurve: Curves.linear,
                decelerationCurve: Curves.easeOut)
            .expanded(),
      ]),
    );
  }
}

/// 火力排行版
class HomeRankingWidget extends StatelessWidget {
  final HomeRankingInfo ranking;
  const HomeRankingWidget(this.ranking, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppMainColors.whiteColor15),
        gradient: LinearGradient(colors: AppMainColors.homeItemDefaultGradient),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: [
          //风云icon
          Image.asset(R.homeFyb,
              width: 90.dp, height: double.infinity, fit: BoxFit.cover),
          //名字
          Container(
            height: 40.dp,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  "${ranking.username} 荣登榜首第1名",
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.f14w500white100,
                ).expanded(),
                CustomText(
                  "${ranking.fireRank} 火力值",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 12.dp,
                      fontWeight: FontWeight.w400,
                      color: AppMainColors.mainColor),
                ),
              ],
            ),
          ).expanded(),
          //查阅icon
          Image.asset(
            R.homeFybBangdan,
            height: 44,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}

/// banner图
class HomeBannerWidget extends StatelessWidget {
  final List<HomeBannerInfo> banners;
  final void Function(int)? tapBanner;
  const HomeBannerWidget(this.banners, this.tapBanner, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (ScreenUtil().screenWidth - 32.dp) / 3.23,
      // padding: EdgeInsets.only(top: 7, bottom: 7),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.dp),
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return CachedNetworkImageAnchor(banners[index].pic ?? "");
          },
          autoplay: true,
          itemCount: banners.length,
          scrollDirection: Axis.horizontal,
          pagination: SwiperPagination(
              builder: CustomRectSwiperPaginationBuilder(
            color: AppMainColors.whiteColor100,
            activeColor: AppMainColors.mainColor,
          )),
          control: null,
          layout: SwiperLayout.DEFAULT,
          onTap: (index) => tapBanner?.call(index),
        ),
      ),
    ).inkWell();
  }
}

/// 推荐游戏item
class HomeGameItem extends StatelessWidget {
  final HomeBannerInfo game;
  const HomeGameItem(this.game, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(4),
      ///套层圆角rect 图片降被约束圆角
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.0),
            bottomLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
            bottomRight: Radius.circular(4.0)),
        child: CachedNetworkImageAnchor(game.pic ?? ""),
      ),
    );
  }
}

/// 提示item
class HomeTipItem extends StatelessWidget {
  final HomeTipInfo tip;
  final Color? textColor;
  final double? fontSize;
  const HomeTipItem(
      this.tip,
        {Key? key,
        this.textColor = AppMainColors.whiteColor100,
        this.fontSize = 14}
      ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomLeft,
        margin: EdgeInsets.all(5),
        child: Text(
          tip.tipName ?? "",
          style: TextStyle(
            fontSize: fontSize?.sp,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ));
  }
}

/// 主播item
class HomeAnchorItem extends StatelessWidget {
  final AnchorListModelEntity anchorItem;
  const HomeAnchorItem(this.anchorItem, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ListDataConfig dataConfig = ListDataConfig(anchorItem: anchorItem);

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          // 背景图
          CachedNetworkImageAnchor(dataConfig.roomCover()).positionFill(),
          // FadeInImage.assetNetwork(
          //   placeholder: "",
          //   placeholderFit: BoxFit.cover,
          //   placeholderErrorBuilder: (context, error, stackTrace) {
          //     return Container(
          //       decoration: BoxDecoration(
          //         border: Border.all(color: AppMainColors.whiteColor15),
          //         gradient: LinearGradient(
          //           colors: AppMainColors.homeItemDefaultGradient,
          //         ),
          //       ),
          //     );
          //   },
          //   image: dataConfig.roomCover(),
          //   fit: BoxFit.cover,
          //   imageErrorBuilder: (context, error, stackTrace) {
          //     return Container(
          //       decoration: BoxDecoration(
          //         border: Border.all(color: AppMainColors.whiteColor15),
          //         gradient: LinearGradient(
          //           colors: AppMainColors.homeItemDefaultGradient,
          //         ),
          //       ),
          //     );
          //   },
          // ).positionFill(),
          // 城市名字信息遮罩
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                AppMainColors.blackColor0,
                AppMainColors.blackColor70,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
          ).position(bottom: 0, left: 0, right: 0, height: 60.dp),
          // 游戏主播房间类型
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0.dp),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppMainColors.homeItemGameBgTipGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(9.0.dp)),
            ),
            child: Text(
              dataConfig.roomName(),
              style: TextStyle(
                fontSize: 10.dp,
                fontWeight: FontWeight.w500,
                color: AppMainColors.whiteColor100,
              ),
            ),
          ).position(
              top: 8.dp,
              left: 8.dp,
              height: dataConfig.showRoomWidget() ? 18.dp : 0),
          //是否展示直播
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.0.dp),
            // alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppMainColors.blackColor70,
                border: Border.all(color: AppMainColors.whiteColor70),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0.dp),
                )),
            child: Row(
              children: [
                Lottie.asset('assets/data/studio.json',
                    width: 8, height: 8, fit: BoxFit.cover),
                Text(
                  " 直播中",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: AppMainColors.whiteColor100,
                  ),
                )
              ],
            ),
          ).position(
              top: 8.dp,
              right: 8.dp,
              height: dataConfig.showLiveWidget() ? 16.dp : 0),
          // 房间信息富文本
          RichText(
              text: TextSpan(text: "", children: [
            //1.富文本
            WidgetSpan(
                child: Row(
              children: [
                //Top榜内容
                dataConfig.showTopWidget()
                ? Container(
                    height: dataConfig.showTopWidget() ? 16.dp : 0.0,
                    padding: EdgeInsets.symmetric(horizontal: 4.dp),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: AppMainColors.rankBgGradient),
                        borderRadius:
                            BorderRadius.all(Radius.circular(2.0.dp))),
                    child: Row(
                      children: [
                        Image.asset(
                          R.icHomeRank,
                          height: 12.dp,
                          width: 12.dp,
                        ),
                        Text(
                          dataConfig.showTopText(),
                          textAlign: TextAlign.center,
                          style: AppStyles.f10w500c255_255_255,
                        )
                      ],
                    ),
                  )
                :SizedBox(),

                SizedBox(width: dataConfig.showTopWidget() ? 4.dp : 0.0),
                //收费内容
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.dp),
                  height: dataConfig.showBillWidget() ? 16.dp : 0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    // gradient: LinearGradient(colors: AppMainColors.homeItembillGradient),
                    borderRadius: BorderRadius.all(Radius.circular(2.0.dp)),
                    border: Border.all(
                        color: AppMainColors.whiteColor60, width: 0.5),
                  ),
                  child: Text(dataConfig.showBillText(),
                      style: AppStyles.f10w400c70white),
                ),
              ],
            )),
            //2.房间名字
            WidgetSpan(
              child: Container(
                height: 25.dp,
                alignment: Alignment.bottomLeft,
                // width: double.infinity,
                child: Text(
                  dataConfig.roomTitle(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 12.dp,
                      // fontWeight: FontWeight.bold,
                      fontWeight: FontWeight.w500,
                      color: AppMainColors.whiteColor100,
                      height: 1.5),
                ),
              ),
            ),
            WidgetSpan(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                //城市
                Text(
                  dataConfig.showCityText(),
                  style: TextStyle(
                      fontSize: 10.dp,
                      // fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w300,
                      color: AppMainColors.whiteColor70,
                      height: 1.5),
                ).expanded(),
                SizedBox(width: 8),
                //热度
                Text(dataConfig.showHeatText(),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 12.dp,
                        overflow: TextOverflow.ellipsis,
                        fontFamily: "Number",
                        color: AppMainColors.whiteColor70,
                        height: 1.5))
              ],
            )),
          ])).position(left: 8.dp, right: 8.dp, bottom: 4.dp),
        ],
      ),
    );
  }
}

/// 附近点击弹窗
class HomeNearAlertItem extends StatelessWidget {
  final HomeNearAlertItemModel alertItem;
  const HomeNearAlertItem({
    Key? key,
    required this.alertItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.dp),
        color: alertItem.backgroudColor,
        border: Border.all(
            color: alertItem.backgroudColor,
            width: alertItem.seletecd ? 1 : 0,
            style: BorderStyle.solid),
      ),
      alignment: Alignment.center,
      child: Text(alertItem.name ?? "",
          style: TextStyle(
            fontSize: 12.sp,
            color: alertItem.textColor,
          )),
    );
  }
}

//网络图片请求首页统配Widget
class CachedNetworkImageAnchor extends StatelessWidget {
  final String url;
  const CachedNetworkImageAnchor(this.url, {Key? key}) : super(key: key);

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
        return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
          colors: AppMainColors.homeItemDefaultGradient,
        )));
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


/*--- 游戏列表*/
