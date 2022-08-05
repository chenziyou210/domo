/*
 *  Copyright (C), 2015-2021
 *  FileName: live_new_logic
 *  Author: Tonight丶相拥
 *  Date: 2021/12/7
 *  Description: 
 **/

import 'dart:convert';

import 'package:get/get.dart';
import 'package:star_common/common/common_widget/components/components_view.dart';
import 'package:star_common/i18n/i18n.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:flutter/material.dart';

import 'package:star_common/generated/json/base/json_convert_content.dart';
import 'package:star_live/im/im_manager.dart';

class LiveHomeData extends GetxController with WidgetsBindingObserver {
  LiveHomeData() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      ImManager.imLogIn();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    appBannerLoad();
    appAnnouncementLoad();
  }

  @override
  // TODO: implement onDelete
  InternalFinalCallback<void> get onDelete {
    WidgetsBinding.instance.removeObserver(this);
    return super.onDelete;
  }

  final _LiveHomeState state = _LiveHomeState();

  Future getHomeTabData(BuildContext context) {
    return HttpChannel.channel.cateGoryLabel()
      ..then((value) => value.finalize(
          wrapper: WrapperModel(),
          success: (data) {
            List lst = data ?? [];
            List<HomeTabDataEntity> tabData =
                lst.map((e) => HomeTabDataEntity.fromJson(e)).toList();
            state._setData(tabData, context);
          }));
  }

  Future appBannerLoad() {
    return HttpChannel.channel.advertiseBanner(advertiseType: 3)
      ..then((value) => value.finalize(
          wrapper: WrapperModel(),
          success: (data) {
            List lst = data ?? [];
            List<BannerItem> banner =
                lst.map((e) => BannerItem.fromJson(e)).toList();
            state._setBannerData(banner);
          }));
  }

  Future appAnnouncementLoad() {
    return HttpChannel.channel.announcementList(1)
      ..then((value) => value.finalize(
          wrapper: WrapperModel(),
          success: (data) {
            List lst = data ?? [];
            List<HomeAnnouncementEntity> announcement =
                lst.map((e) => HomeAnnouncementEntity.fromJson(e)).toList();
            state._setAnnouncementData(announcement);
          }));
  }

  Future labelLoad() {
    return HttpChannel.channel.systemDictionary()
      ..then((value) => value.finalize(
          wrapper: WrapperModel(),
          success: (data) {
            List lst = data ?? [];
            lst =
                lst.where((e) => e["dicType"] == "ANCHOR_LABEL_LIST").toList();
            state._setLabels(lst
                .map((e) => _LabelEntity(
                    id: e["dicValue"].toString(), title: e["dicCnValue"]))
                .toList());
          }));
  }

  // Future load() {
  //   return Future.wait([
  //     appActivityLoad(),
  //     HttpChannel.channel.gameConfig()
  //       ..then((value) => value.finalize(
  //           wrapper: WrapperModel(),
  //           success: (value) {
  //             AppManager.getInstance<Game>().initializeGame(value);
  //           })),
  //     labelLoad()
  //   ]);
  // }

  // Future appActivityLoad() {
  //   return HttpChannel.channel.appActivity()
  //     ..then((value) => value.finalize(
  //         wrapper: WrapperModel(),
  //         success: (data) {
  //           List lst = data ?? [];
  //           List<AppActivityEntity> banner =
  //           lst.map((e) => AppActivityEntity.fromJson(e)).toList();
  //           state._setBanner(banner);
  //         }));
  // }

  void setLabelIndex(int value) {
    state._setLabelIndex(value);
  }
}

class HomeTabDataEntity {
  int? id;
  String? name;
  HomeTabDataEntity();

  // HomeTabDataEntity(int id,String name){
  //   this.id=id;
  //   this.name=name;
  // }
  factory HomeTabDataEntity.fromJson(Map<String, dynamic> json) =>
      $HomeTabDataEntityFromJson(json);
  // Map<String, dynamic> toJson() => $ExchangeGiftListEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

class HomeAnnouncementEntity {
  String? content;
  String? jumpPath;
  String? title;

  HomeAnnouncementEntity({this.content, this.jumpPath, this.title});

  HomeAnnouncementEntity.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    jumpPath = json['jumpPath'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['content'] = this.content;
    data['jumpPath'] = this.jumpPath;
    data['title'] = this.title;
    return data;
  }
}

HomeTabDataEntity $HomeTabDataEntityFromJson(Map<String, dynamic> json) {
  final HomeTabDataEntity homeTabDataEntity = HomeTabDataEntity();

  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    homeTabDataEntity.id = id;
  }
  final String? labelName = jsonConvert.convert<String>(json['name']);
  if (labelName != null) {
    homeTabDataEntity.name = labelName;
  }
  return homeTabDataEntity;
}

class _LiveHomeState {
  RxList<HomeTabDataEntity> _homeTabdata = <HomeTabDataEntity>[].obs;
  RxList<HomeTabDataEntity> get homeTabdata => _homeTabdata;

  RxList<BannerItem> _homeBanner = <BannerItem>[].obs;
  RxList<BannerItem> get homeBanner => _homeBanner;

  RxList<HomeAnnouncementEntity> _homeAnnouncement =
      <HomeAnnouncementEntity>[].obs;
  RxList<HomeAnnouncementEntity> get homeAnnouncement => _homeAnnouncement;

  RxString _announcementString = "".obs;
  RxString get announcementString => _announcementString;

  RxList<_LabelEntity> _label = RxList();
  RxList<_LabelEntity> get labels => _label;

  RxInt _labelIndex = (-1).obs;
  RxInt get labelIndex => _labelIndex;

  void _setLabelIndex(int value) {
    _labelIndex.value = value;
  }

  void _setLabels(List<_LabelEntity> value) {
    _label.value = value;
  }

  void _setData(List<HomeTabDataEntity> value, BuildContext context) {
    _homeTabdata.value = value;
    var attention = new HomeTabDataEntity();
    attention.name = "${AppInternational.of(context).attention}";
    attention.id = 1111;
    _homeTabdata.insert(0, attention);
  }

  void _setBannerData(List<BannerItem> value) {
    _homeBanner.value = value;
  }

  void _setAnnouncementData(List<HomeAnnouncementEntity> value) {
    _homeAnnouncement.value = value;
    if (value.length > 0) {
      String tempContent = "";
      value.forEach((element) {
        tempContent = "$tempContent ${element.content}";
      });
      _announcementString.value = tempContent + "    ";
    } else {
      _announcementString.value = "欢迎来到广岛直播" + "    ";
    }
  }
}

class _LabelEntity {
  _LabelEntity({required this.title, required this.id});
  final String title;
  final String id;
}
