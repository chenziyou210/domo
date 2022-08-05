import 'package:flutter/material.dart';
import 'package:star_common/app_images/r.dart';

/// @description:
/// @author
/// @date: 2022-06-12 17:44:45
class MineNoblePageState {
  MineNoblePageState() {
    ///Initialize variables
  }

  ///到期时间
  String? expireTime;
  late final TabController tabController;
  final datas = ["游侠", "骑士", "子爵", "伯爵", "侯爵", "公爵", "国王"];
  List<MineNobleTabsData> tabs() {
    List<MineNobleTabsData> list = [];
    for (var i = 0; i < datas.length; i++) {
      list.add(MineNobleTabsData(datas[i], i == 0 ? true : false));
    }
    return list;
  }

  ///贵族页面数据
  List<MineNobleData> nobleDatas() {
    List<MineNobleData> list = [];
    //首次开通
    List<int> firstTimeNums = [1888, 3333, 8888, 18888, 66666, 166666, 288888];
    //首次赠送
    List<int> giftFirstTimeNums = [
      1500,
      2666,
      7000,
      16666,
      60000,
      150000,
      260000
    ];
    //续费
    List<int> renewalNUms = [1800, 3000, 7777, 16666, 55555, 133333, 222222];
    //续费赠送
    List<int> giftRenewalNUms = [
      1620,
      2700,
      6999,
      14999,
      50000,
      120000,
      200000
    ];
    List<int> privilegesNums = [5, 7, 7, 8, 10, 11, 12];

    List<String> titles = [
      "贵族勋章",
      "专属铭牌",
      "进房金光",
      "专属客服",
      "头像边框",
      "升级加速",
      "专属资料卡",
      "平台喇叭",
      "公聊皮肤",
      "进场隐身",
      "防禁言",
      "榜单隐身"
    ];
    List<String> subTitles = [
      "专属标记",
      "贵族专属标签",
      "专属进房特效",
      "24小时服务",
      "展示贵族头像框",
      "送礼物经验+",
      "专属资料卡边框",
      "赠送10个喇叭",
      "聊天专属皮肤",
      "低调看直播",
      "无法被禁言",
      "神秘低调的守护"
    ];
    //经验
    List<String> exs = ["0%", "8%", "12%", "14%", "14%", "14%", "14%"];
    List<String> nobleImageNames = [
      R.nobleLevelIconYouxia,
      R.nobleLevelIconQishi,
      R.nobleLevelIconZijue,
      R.nobleLevelIconBojue,
      R.nobleLevelIconHoujue,
      R.nobleLevelIconGongjue,
      R.nobleLevelIconGuowang,
    ];
    List<String> itemImageNames = [
      R.nobleXunzhang,
      R.nobleTexiao,
      R.nobleJinguang,
      R.nobleKefu,
      "",
      R.nobleShengji,
      R.nobleGuangbo,
      R.nobleLaba,
      R.noblePifu,
      R.nobleYinshen,
      R.nobleJinyan,
      R.nobleBangdanYinshen,
    ];
    List<String> avatars = [
      R.nobleAvatarYouxia,
      R.nobleAvatarQishi,
      R.nobleAvatarZijue,
      R.nobleAvatarBojue,
      R.nobleAvatarHoujue,
      R.nobleAvatarGongjue,
      R.nobleAvatarGuowang
    ];
    List<int> types = [1001, 1002, 1003, 1004, 1005, 1006, 1007];
    for (var i = 0; i < datas.length; i++) {
      List<PrivilegeItem> items = [];
      for (var j = 0; j < titles.length; j++) {
        PrivilegeItem item = PrivilegeItem(
            title: titles[j],
            subTitle: j == 5 ? subTitles[j] + exs[i] : subTitles[j],
            itemImageName: j == 4 ? avatars[i] : itemImageNames[j],
            isLightUp: privilegesNums[i] > j);
        items.add(item);
      }
      MineNobleData data = MineNobleData(
          nobleName: datas[i],
          nobleImageName: nobleImageNames[i],
          firstTimeNum: firstTimeNums[i],
          giftFirstTimeNum: giftFirstTimeNums[i],
          renewalNUm: renewalNUms[i],
          giftRenewalNUm: giftRenewalNUms[i],
          privilegesNum: privilegesNums[i],
          type: types[i],
          items: items);
      list.add(data);
    }

    return list;
  }
}

class MineNobleData {
  ///贵族点击名称
  String? nobleName;

  ///图片名称
  String? nobleImageName;

  ///首次开通的钻石
  int firstTimeNum = 0;

  ///首次开通赠送的钻石
  int giftFirstTimeNum = 0;

  ///续费的钻石
  int renewalNUm = 0;

  ///续费赠送的钻石
  int giftRenewalNUm = 0;

  ///特权的个数
  int privilegesNum = 0;
  //开通的type
  int type = 0;
  //特权item
  List<PrivilegeItem>? items;
  MineNobleData(
      {this.nobleName,
      this.nobleImageName,
      required this.firstTimeNum,
      required this.giftFirstTimeNum,
      required this.giftRenewalNUm,
      required this.privilegesNum,
      required this.renewalNUm,
      required this.type,
      this.items});
}

//特权
class PrivilegeItem {
  //图片
  String? itemImageName;
  String? title;
  String? subTitle;
  //是否点亮
  bool isLightUp = false;
  PrivilegeItem(
      {this.itemImageName, this.title, this.subTitle, required this.isLightUp});
}

class MineNobleTabsData {
  String? name;
  bool isSeledet = false;
  MineNobleTabsData(this.name, this.isSeledet);
}
