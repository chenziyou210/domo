/*
 *  Copyright (C), 2015-2021
 *  FileName: live_cell
 *  Author: Tonight丶相拥
 *  Date: 2021/7/15
 *  Description: 
 **/

import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';
import 'package:star_common/i18n/i18n.dart';
import 'live_enum.dart';

class LiveCellViewModel {
  LiveCellViewModel(
      {required this.avatar,
      required this.local,
      required this.name,
      required this.count,
      required this.eventName,
      required this.liveType,
      required this.unit});

  final String avatar;
  final String name;
  final String local;
  final String eventName;
  final int count;
  final int liveType;
  final dynamic unit;

  LiveEnum get type => LiveEnum.common.getLiveType(liveType);
}

class LiveCell extends StatelessWidget {
  LiveCell(this.viewModel);

  final LiveCellViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    // String str;
    // if (viewModel.type == LiveEnum.common || viewModel.type == LiveEnum.secret){
    //   str = viewModel.type.description;
    // }else {
    //   str = "${viewModel.type.description}: ${viewModel.unit}";
    // }

    return ClipRRect(
        borderRadius: BorderRadius.circular(10.5.dp),
        child: Stack(children: [
          Positioned.fill(
              child: ExtendedImage.network(viewModel.avatar,
                  enableLoadState: false,
                  fit: BoxFit.cover, loadStateChanged: (state) {
            if (state.extendedImageLoadState == LoadState.loading ||
                state.extendedImageLoadState == LoadState.failed) {
              return Image.asset(R.imgPlaceHolder, fit: BoxFit.cover);
            }
          })),
          Positioned(
              child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                AppColors.c0_0_0.withOpacity(0),
                AppColors.c0_0_0.withOpacity(0.4),
                AppColors.c0_0_0.withOpacity(0.85)
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter))),
              left: 0,
              right: 0,
              bottom: 0,
              height: 88),
          //房间类型
          Container(
            height: 16.dp,
            child: Text(
              "一分快三",
              style: AppStyles.f10w500c255_255_255,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: AppMainColors.gameLabelGradient),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
          ).position(top: 8.dp, left: 8.dp),
          Container(
            height: 16.dp,
            child: Row(
              children: [
                Image.asset(
                  R.icLive,
                  width: 8.dp,
                  height: 8.dp,
                ),
                SizedBox(width: 4.dp),
                Text(
                  "直播中",
                  style: AppStyles.f10w400c255_255_255,
                )
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 4.0.dp),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                border: Border.all(color: Color.fromARGB(153, 255, 255, 255)),
                color: (Colors.black.withAlpha(153))),
          ).position(top: 8.dp, right: 8.dp),
          Row(
            children: [
              Container(
                height: 16.dp,
                padding: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: AppMainColors.rankBgGradient),
                  borderRadius: BorderRadius.all(Radius.circular(2.0.dp)),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      R.icHomeRank,
                      height: 12.dp,
                      width: 12.dp,
                    ),
                    Text(
                      "TOP1",
                      textAlign: TextAlign.center,
                      style: AppStyles.f10w500c255_255_255,
                    )
                  ],
                ),
              ),
              SizedBox(width: 4.dp),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.dp),
                height: 16.dp,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border:
                        Border.all(color: Color.fromARGB(153, 255, 255, 255)),
                    borderRadius: BorderRadius.all(Radius.circular(2.0.dp)),
                    color: (Colors.black.withAlpha(153))),
                child: Text("dddd", style: AppStyles.f10w400c70white),
              ),
            ],
          ).position(bottom: 46.dp, left: 8.dp),
          Text("${viewModel.name}", style: AppStyles.f12w500c255_255_255)
              .position(left: 8.dp, bottom: 21.dp),
          Row(children: [
            Text("${viewModel.local}", style: AppStyles.f10w400c70white)
                .expanded(),
            Text("${viewModel.count}", style: AppStyles.f12w400white70)
          ]).position(left: 8.dp, right: 8.dp, bottom: 5.dp)
        ]));
  }

  Widget _getWidget(LiveEnum type, AppInternational intl) {
    Widget child;
    TextStyle _style =
        TextStyle(fontSize: 12.dp, fontWeight: w_400, color: Colors.white);
    if (type == LiveEnum.game) {
      child = Container(
          constraints: BoxConstraints(minHeight: 21.dp),
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 228, 31, 38),
              borderRadius:
                  BorderRadius.horizontal(left: Radius.circular(10.5.dp)) +
                      BorderRadius.only(topRight: Radius.circular(10.5.dp))),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CustomText("${intl.gameRoom}", style: _style)]));
    } else if (type == LiveEnum.timer) {
      child = Container(
          constraints: BoxConstraints(minHeight: 21.dp),
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: AppColors.buttonGradientColors),
              borderRadius:
                  BorderRadius.horizontal(left: Radius.circular(10.5.dp)) +
                      BorderRadius.only(topRight: Radius.circular(10.5.dp))),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CustomText("${intl.timerRoom}", style: _style)]));
    } else if (type == LiveEnum.ticker) {
      child = Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          constraints: BoxConstraints(minHeight: 21.dp),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 17, 195, 131),
              borderRadius:
                  BorderRadius.horizontal(left: Radius.circular(10.5.dp)) +
                      BorderRadius.only(topRight: Radius.circular(10.5.dp))),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CustomText("${intl.ticketRoom}", style: _style)]));
    } else {
      /// common room
      child = Container(
          constraints: BoxConstraints(minHeight: 21.dp),
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 84, 120, 248),
              borderRadius:
                  BorderRadius.horizontal(left: Radius.circular(10.5.dp)) +
                      BorderRadius.only(topRight: Radius.circular(10.5.dp))),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CustomText("${intl.commonRoom}", style: _style)]));
    }
    return child;
  }
}

/**
 * Container(
    width: 73,
    height: 21,
    alignment: Alignment.center,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(4),
    gradient: LinearGradient(colors: [
    AppColors.c252_0_255,
    AppColors.c0_219_222
    ], begin: Alignment.centerLeft,
    end: Alignment.centerRight
    )
    ),//eventName
    child: Text(str, style: AppStyles.f12w400c255_255_255)
    )*/
