/*
 *  Copyright (C), 2015-2021
 *  FileName: online_cell
 *  Author: Tonight丶相拥
 *  Date: 2021/12/11
 *  Description: 
 **/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/common_widget/live/admin_icon_Widget.dart';
import 'package:star_common/common/common_widget/live/guard_icon_widget.dart';
import 'package:star_common/common/common_widget/live/peerage_widget.dart';
import 'package:star_common/common/common_widget/live/sex_icon_widget.dart';

import 'package:star_common/generated/living_audience_entity.dart';

class OnlineCell extends StatelessWidget {
  OnlineCell(this.model);

  final LivingAudienceEntity model;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.dp, vertical: 8.dp),
        child: Row(children: [
          // ExtendedImage.network(model.header!,
          //         enableLoadState: false, width: 40.dp, height: 40.dp)
          //     .clipRRect(radius: BorderRadius.circular(20.dp)),
          Stack(
            children: [
              CircleAvatar(
                radius: 20.dp,
                backgroundImage: NetworkImage(model.header!),
              ).marginOnly(left: 8.dp, top: 8.dp),
              _buildNobelCover(model.nobleType)
            ],
          ),
          SizedBox(
            width: 12.dp,
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CustomText("${model.username}",
                fontWeight: w_500, fontSize: 14.sp, color: Colors.white),
            SizedBox(
              height: 4.dp,
            ),
            Row(children: [
              UserLevelView(model.rank!),
              PeerageWidget(model.nobleType, 4),
              GuardIconWidget(model.watchType, 4),
              AdminIconWidget(model.adminFlag),
              SexIconWidget(model.sex).marginOnly(
                  left: (model.rank! > 0 ||
                          model.nobleType! > 0 ||
                          model.watchType! > 0)
                      ? 4.dp
                      : 0),
            ]),
          ]).expanded()
        ]));
  }

  String getTitleNoble(int? type) {
    switch (type) {
      case 1001:
        return R.nobleAvatarYouxia;
      case 1002:
        return R.nobleAvatarQishi;
      case 1003:
        return R.nobleAvatarZijue;
      case 1004:
        return R.nobleAvatarBojue;
      case 1005:
        return R.nobleAvatarHoujue;
      case 1006:
        return R.nobleAvatarGongjue;
      case 1007:
        return R.nobleAvatarGuowang;
      default:
        return R.nobleAvatarYouxia;
    }
  }

  Widget _buildNobelCover(int? type) {
    if (type != null && type > 1000 && type < 1008) {
      return Image.asset(
        getTitleNoble(type),
        width: 56.dp,
        height: 56.dp,
      );
    } else {
      return Container();
    }
  }
}
