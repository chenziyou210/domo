import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import '../../business/homepage/models/homepage_model.dart';

enum GroupTypes{
  diamondDetails,
  gameRecord,
  myFocus,
  phoneApprove,
  myBackpack,
  myLevel,
}

class MyMineState {
  final List<GroupTypes> group1 = [GroupTypes.diamondDetails, GroupTypes.gameRecord];
  final title1 = ['钻石明细', '游戏记录'];
  final img1 = [R.icBalance, R.icGameRecord];
  final List<GroupTypes> group2 = [GroupTypes.myFocus, GroupTypes.phoneApprove, GroupTypes.myBackpack, GroupTypes.myLevel];
  final title2 = ['我的关注', '手机认证', '我的背包', '我的等级'];
  final img2 = [
    R.icMineAttention,
    R.icPhoneVerify,
    R.icBag,
    R.icDiamond,
  ];

  MyMineState();

  RxList<HomeBannerInfo> _banner = <HomeBannerInfo>[].obs;
  RxList<HomeBannerInfo> get banner => _banner;

  RxList<HomeBannerInfo> games = <HomeBannerInfo>[].obs;

  void addBanner(List<HomeBannerInfo> gameList) {
    _banner.value = gameList;
  }
}
