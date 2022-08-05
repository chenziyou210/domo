/*
 *  Copyright (C), 2015-2021
 *  FileName: user_info_operation
 *  Author: Tonight丶相拥
 *  Date: 2021/12/22
 *  Description: 
 **/

import 'dart:async';

import 'package:star_common/http/http_channel.dart';
import 'package:star_common/generated/gift_entity.dart';
import 'package:star_common/manager/video_manager.dart';

class UserInfoOperation {
  static List<GiftEntity> _giftList = [];
  static List<GiftEntity> _specialList = [];

  static Future getGiftList(
      {required void Function(List<GiftEntity>) success,
      required void Function(List<GiftEntity>) specialSuccess,
      int pageNum = 1,
      int pageSize = 99}) async {
    if (_giftList.isNotEmpty && _specialList.isNotEmpty) {
      success(_giftList);
      specialSuccess(_specialList);
      return;
    }

    /// 缓存礼物
    HttpChannel.channel.roomGiftList(pageNum: pageNum, pageSize: pageSize)
      ..then((value) => value.finalize(
          wrapper: WrapperModel(),
          success: (data) async {
            List list = data["list"] ?? [];
            List specialList = data["specialList"] ?? [];
            _giftList = list.map((e) => GiftEntity.fromJson(e)).toList();
            _specialList =
                specialList.map((e) => GiftEntity.fromJson(e)).toList();
            success(_giftList);
            specialSuccess(_specialList);
            List<String> svgaList= [];
            _giftList.forEach((element) {
              if(element.type!=4 && element.gifUrl!.isNotEmpty){
                svgaList.add(element.gifUrl.toString());
              }
            });

            VideoManager.instance.cacheFiles(svgaList);
            VideoManager.instance.cacheFiles(
                specialList.map((e) => e['gifUrl'].toString()).toList());
          }));

  }
}
