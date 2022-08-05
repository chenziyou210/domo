import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/router/router_config.dart';

import '../../../app_images/r.dart';

class BannerItem {
  // 命名函数
  BannerItem(
      {this.id,
      this.pic,
      this.url,
      this.urlType,
      this.picType,
      this.position,
      this.duration,
      this.startTime,
      this.endTime});
  int? id;
  String? pic;
  String? url;

  int? picType;
  int? position;
  int? duration;
  String? startTime;
  String? endTime;

  //链接类型 0：内链，1：外链，2：APP页面内跳转, 3:三方游戏跳转
  int? urlType;

  BannerItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pic = json['pic'];
    url = json['url'];
    urlType = json['urlType'];
    picType = json['picType'];
    position = json['position'];
    duration = json['duration'];
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['pic'] = this.pic;
    data['url'] = this.url;
    data['urlType'] = this.urlType;
    data['picType'] = this.picType;
    data['position'] = this.position;
    data['duration'] = this.duration;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;

    return data;
  }
}

class UniversalBanner extends StatelessWidget with Toast {
  UniversalBanner(this.banner);
  List<BannerItem> banner;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    gradient: LinearGradient(
                      colors: AppMainColors.homeItemDefaultGradient,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        banner[index].pic!,
                      ),
                      fit: BoxFit.fill,
                    )),
              );
            },
            autoplay: true,
            itemCount: banner.length,
            scrollDirection: Axis.horizontal,
            pagination: new SwiperPagination(
                builder: new DotSwiperPaginationBuilder(
                    color: Colors.white30,
                    activeColor: AppMainColors.mainColor,
                    size: 8.0,
                    activeSize: 8.0)),
            control: null,
            layout: SwiperLayout.DEFAULT,
            onTap: (index) {
              //banner点击
              BannerItem info = banner[index];
              if (info.url!.contains("http")) {
                show();
                Map<String, dynamic> args = {"url": info.url};
                homeWebPage(context, args);
              }
            },
          ).expanded(),
        ],
      ),
    );
    // });
  }
}

class UniversalAnnouncement extends StatelessWidget {
  UniversalAnnouncement(this.contentString);
  RxString contentString;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(() {
      if (contentString.isEmpty) {
        return Container();
      }
      return Container(
        height: 40,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppMainColors.separaLineColor6,
          //设置四周圆角 角度
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          //设置四周边框
          border:
              new Border.all(width: 1, color: AppMainColors.separaLineColor10),
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Image.asset(R.homeToutiao,
              width: 50.dp, height: 40.dp, fit: BoxFit.fill),
          Marquee(
                  text: contentString.value
                      .replaceAll("\r", "")
                      .replaceAll("\n", ""),
                  style: TextStyle(
                      fontSize: 14, fontWeight: w_500, color: Colors.white),
                  scrollAxis: Axis.horizontal,
                  velocity: 50.0,
                  blankSpace: 259.dp,
                  accelerationCurve: Curves.linear,
                  decelerationCurve: Curves.easeOut)
              .expanded(),
        ]),
      );
    });
  }
}
