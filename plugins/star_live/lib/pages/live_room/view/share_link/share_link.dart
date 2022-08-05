/*
 *  Copyright (C), 2015-2022
 *  FileName: share_link
 *  Author: Tonight丶相拥
 *  Date: 2022/4/7
 *  Description: 
 **/

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/i18n/i18n.dart';

class ShareModel {
  ShareModel({required this.avatar,
    required this.nickName,
    required this.roomLink,
    required this.roomNumber});
  final String avatar;
  final String nickName;
  final String roomNumber;
  final String roomLink;
}

class ShareLinkView extends StatelessWidget with Toast {
  ShareLinkView({required this.model});
  final ShareModel model;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var intl = AppInternational.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 21, 23, 35),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12)
        )
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 8),
          CustomText(intl.shareLink,
            fontSize: 16,
            fontWeight: w_600,
            color: Colors.white
          ),
          SizedBox(height: 16),
          Row(
            children: [
              ExtendedImage.network(model.avatar,
                width: 83,
                height: 83
              ).clipRRect(radius: BorderRadius.circular(5)),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  [
                    CustomText(intl.anchorNickname,
                      fontSize: 10, fontWeight: w_500,
                      color: Color.fromARGB(255, 100, 102, 114)
                    ).expanded(),
                    CustomText(intl.hostRoomNumber,
                      fontSize: 10, fontWeight: w_500,
                      color: Color.fromARGB(255, 100, 102, 114)
                    ).expanded(flex: 2)
                  ].row(),
                  SizedBox(height: 16),
                  [
                    CustomText("${model.nickName}",
                      fontSize: 14, fontWeight: w_500,
                      color: Colors.white
                    ).expanded(),
                    CustomText("${model.roomNumber}",
                      fontSize: 14, fontWeight: w_500,
                      color: Colors.white
                    ).expanded(flex: 2)
                  ].row(),
                  SizedBox(height: 16),
                  CustomText(intl.roomLink,
                    fontSize: 10, fontWeight: w_500,
                    color: Color.fromARGB(255, 100, 102, 114)
                  ),
                  SizedBox(height: 8),
                  CustomText("${model.roomLink}",
                    fontSize: 14, fontWeight: w_400,
                    color: Colors.white
                  )
                ]
              ).expanded()
            ]
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            // constraints: BoxConstraints(minWidth: 104, minHeight: 28),
            // alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: AppColors.buttonGradientColors
              )
            ),
            child: CustomText(intl.copyRoomLink,
              fontSize: 12, fontWeight: w_400,
              color: Colors.white,
            )
          ).cupertinoButton(onTap: (){
            Clipboard.setData(ClipboardData(text: model.roomLink));
            showToast(intl.copySuccess);
          }),
          SizedBox(height: 16)
        ]
      )
    );
  }
}