import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_common/generated/rank_new_entity.dart';

class RankMainState {
  RankMainState() {
    ///Initialize variables
  }

  late TabController mainController;

  List mainMenuTitles = [intl.starList,intl.richList];
  List subMenuTitles  = [intl.dailyList, intl.weeklyList, intl.monthlyList];

  //默认点选第一个
  RxInt menuIndex = 0.obs;
  //默认点选第一个
  int subAnchorIndex = 0;
  int subUserIndex   = 0;

  Map <String, Widget> listWidgetMap = {};
  Map <String,   List> listDataMap   = {};

  /* ==========  属性值  ==========  */
  ///保存了 6 个数组
  ///分别以 日榜主播榜 周榜主播榜 月榜主播榜
  ///      日榜富豪榜 周榜富豪榜 月榜富豪榜
  ///为key 对应 6 个刷新key
  ///
  List currentListData({String? tempKey}){
    late var currentList ;
    var key = tempKey ?? getRefreshKey();
    if (listDataMap.containsKey(key)){
      currentList = listDataMap[key]!;
    }else{

       currentList = List.generate(30, (index) {
        //初始化列表判断的必要值
        RankNewEntity temp = RankNewEntity();
        temp.isLive = false;
        temp.username = "虚位以待";
        temp.isAnchor = false;
        temp.attention = false;
        return temp;
      });
      listDataMap[key] = currentList;
    }
    return currentList;
  }

  String getRefreshKey() {
    var key = "";
    switch(menuIndex.value){
      case 0: key = "${subMenuTitles[subAnchorIndex]}${mainMenuTitles[menuIndex.value]}"; break;
      case 1: key = "${subMenuTitles[subUserIndex]}${mainMenuTitles[menuIndex.value]}";break;
    }
    return key;
  }

  void setSubIndex(int index){
    switch(menuIndex.value){
      case 0: subAnchorIndex = index; break;
      case 1: subUserIndex = index; break;
    }
  }

  Text titleText(int index){
    bool isSelected = menuIndex == index;
    String title = mainMenuTitles[index];
    return Text(
      title,
      style: TextStyle(
        fontWeight: w_400,
        fontSize: isSelected ? 18.dp : 16.dp,
        color: isSelected ? AppMainColors.whiteColor100 : AppMainColors.whiteColor70
      ),
    );
  }


  ///序号
  String indexString(int index){
    ///列表从第4个开始 排序
    var numberStr = index.toString();
    var tempStr;
    if(index < 10){
      tempStr = numberStr.padLeft(2,"0");
    }else{
      tempStr = numberStr;
    }
    return tempStr;
  }

  resetDefalutValue(){
    menuIndex.value = 0;
    subUserIndex = 0;
    subAnchorIndex = 0;
    mainController.animateTo(0);

  }

}
