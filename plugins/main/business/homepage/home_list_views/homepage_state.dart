import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/generated/anchor_list_model_entity.dart';
import '../../homepage/models/homepage_model.dart';

enum ADRequestType {
  BannerHomeTabRecommend,
  BannerHomeTabGame,
  BannerHomeTabNearby,
  BannerGameTab,
  BannerMineTab,
  GameHomeTabRecommend,
  GameMineTab,
}

const String HomeGender = "HomeGender";
const String HomeCity = "HomeCity";
const String AllFocusTitle = "全部关注";
const String AllGameTitle = "全部";

double AnchorItemRectangleHeight = 224.dp;
double AnchorItemSquareHeight = 167.dp;
double AnchorItemNearbyHeight = 146.dp;
double BannerItemHeight = 108.dp;
double TipItemHeight = 42;
double RankingItemHeight = 68.dp;

class HomepageState {
  HomepageState({
    ///Initialize variables
    required this.homeListMap,
  });

  late Future future;
  ///配合退出登录操作使用
  bool showHomePage = false;

  ///当前菜单类型
  int barType = 0;
  //关注
  List<HomeInfoModel> focusList = List.empty(growable: true);
  //游戏列表
  List<HomeBannerInfo> gameItems = List.empty(growable: true);
  //跑马灯
  HomeMarqueeInfo maqreeItem = HomeMarqueeInfo();
  //游戏类型头部数据
  RxList<HomeGameModel> gameList = List.generate(7, (index) {
    var name, tabId;
    HomeGameModel temp = HomeGameModel();
    switch (index) {
      case 0:
        name = "全部";
        tabId = 0;
        break;
      case 1:
        name = "一分快三";
        tabId = 1;
        break;
      case 2:
        name = "百人牛牛";
        tabId = 2;
        break;
      case 3:
        name = "一分六合彩";
        tabId = 3;
        break;
      case 4:
        name = "鱼吓蟹";
        tabId = 4;
        break;
      case 5:
        name = "一分快车";
        tabId = 5;
        break;
      case 6:
        name = "一分时时彩";
        tabId = 6;
        break;
    }
    temp.name = name;
    temp.gameId = tabId;
    return temp;
  }).obs;

  ///1.总列表数据
  Map<int, HomeInfoControlModel> homeListMap = {};
  //1.1排行火力值模块
  HomeInfoModel rankItem = HomeInfoModel();
  //1.2轮播图模块
  HomeInfoModel bannerItem = HomeInfoModel();
  //1.3提示类型模块
  HomeTipInfo tipInfo = HomeTipInfo();

  ///游戏类型切换点选
  Color gameTextColorNormal = AppMainColors.whiteColor40;
  Color gameTextColorSelect = AppMainColors.mainColor;
  Color gameBgColorNormal = AppMainColors.whiteColor6;
  Color gameBgColorSelect = AppMainColors.mainColor20;

  /// 附近类型切换 城市性别点选
  RxString  city = "不限".obs;
  // String locationCity =  AppManager.getInstance<AppUser>().region.obs
  // Rx<String?>  city = AppManager.getInstance<AppUser>().region.obs;
  RxString gender = "女生".obs;
  RxBool showGenderView = false.obs;
  RxBool showCityView = false.obs;

  /// 游戏点选
  RxInt currentIndex = 0.obs;

  /// 获取当前ControlModel
  HomeInfoControlModel get currentMap => this.homeListMap[this.barType]!;

  /*  ----------  当前页码，类型数据 -----------------  **/

  List<HomeInfoModel> currentHomeList(int barType) {
    List<HomeInfoModel> homeList = [];
    HomeInfoControlModel controlModel = HomeInfoControlModel();
    if (homeListMap.containsKey(barType)) {
      controlModel = homeListMap[barType]!;
      homeList = controlModel.homeList;
    } else {
      homeListMap[barType] = controlModel;
      controlModel.homeList = homeList;
    }
    return homeList;
  }

  int currentListPage(int barType) {
    int page = 1;
    if (homeListMap.containsKey(barType)) {
      page = homeListMap[barType]!.page;
    } else {
      homeListMap[barType]!.page = page;
    }
    return page;
  }

  HomeInfoControlModel currentControlModel(int type) {
    HomeInfoControlModel controlModel = HomeInfoControlModel();
    if (homeListMap.containsKey(type)) {
      controlModel = homeListMap[type]!;
    } else {
      homeListMap[type] = controlModel;
    }
    return controlModel;
  }

  RefreshController currentRefreshController(int type) {
    HomeInfoControlModel controlModel = currentControlModel(type);
    return controlModel.controller;
  }

  Future currentFuture(int type) {
    HomeInfoControlModel controlModel = currentControlModel(type);
    return controlModel.future;
  }

/*  ----------  属性值获取 -----------------  **/

  bool showDefalutPage() {
    /// 默认展示默认图
    bool showDefalutPage = true;
    HomeInfoControlModel controlModel = currentControlModel(this.barType);
    //判断列表是否有数据
    showDefalutPage = controlModel.homeList.length <= 0;
    // 如果列表已经展示过了
    if (controlModel.showPageView) {
      // 就不会在展示默认图
      showDefalutPage = false;
    }
    return showDefalutPage;
  }

  //是否有存在直播的
  bool ifHaveOnLive() {
    bool showDefalutPage = false;
    for (HomeInfoModel model in focusList) {
      if (model.anchorItem.state == 1) {
        return true;
      }
    }
    return showDefalutPage;
  }

  //设置当前页面展示情况
  showCurrentPageView(bool show) {
    HomeInfoControlModel controlModel = currentControlModel(this.barType);
    controlModel.showPageView = show;
  }

  //只包含主播数组的列表
  List<AnchorListModelEntity> containsOnlyAnchorsArr(int type) {
    List<HomeInfoModel> allAnchorList = this.currentHomeList(type);
    List<AnchorListModelEntity> anchorList = List.empty(growable: true);
    allAnchorList.forEach((element) {
      if (element.viewType == ListViewType.Anchor) {
        anchorList.add(element.anchorItem);
      }
    });
    return anchorList;
  }

/*  ----------  初始配置数据 -----------------  **/

  HomeInfoModel liveTipInfo(String name) {
    HomeInfoModel homeModel = HomeInfoModel();
    HomeTipInfo liveTip = HomeTipInfo();
    liveTip.tipName = name;
    homeModel.viewType = ListViewType.Tip;
    homeModel.tipMessage = liveTip;
    return homeModel;
  }

  HomeInfoModel allFocusModel() {
    HomeInfoModel homeModel = HomeInfoModel();
    AnchorListModelEntity anchorModel = AnchorListModelEntity();
    anchorModel.roomTitle = AllFocusTitle;
    anchorModel.state = 3;
    homeModel.viewType = ListViewType.Anchor;
    homeModel.anchorItem = anchorModel;
    return homeModel;
  }

  HomeGameModel allGameModel() {
    HomeGameModel game = HomeGameModel();
    game.name = AllGameTitle;
    game.gameId = 0;
    return game;
  }

  int adRequestTypeToInt(ADRequestType type) {
    int key = 0;
    switch (type) {
      case ADRequestType.BannerHomeTabRecommend:
        key = 3;
        break;
      case ADRequestType.BannerHomeTabGame:
        key = 31;
        break;
      case ADRequestType.BannerHomeTabNearby:
        key = 32;
        break;
      case ADRequestType.BannerGameTab:
        key = 6;
        break;
      case ADRequestType.BannerMineTab:
        key = 7;
        break;
      case ADRequestType.GameHomeTabRecommend:
        key = 4;
        break;
      case ADRequestType.GameMineTab:
        key = 41;
        break;
      default:
        break;
    }
    return key;
  }

  /* ============  游戏城市切换点选值获取  ============== */

  Color gameBgColor(int index) {
    var key =
        (index == currentIndex.value) ? gameBgColorSelect : gameBgColorNormal;
    return key;
  }

  Color gameTextColor(int index) {
    var key = (index == currentIndex.value)
        ? gameTextColorSelect
        : gameTextColorNormal;
    return key;
  }

  FontWeight gameTextWeight(int index) {
    var key = (index == currentIndex.value)
        ? FontWeight.w600
        : FontWeight.w500;
    return key;
  }

  String arrowGenderImage() {
    var key = showGenderView.value
        ? R.comShaixuanShang
        : R.comShaixuanXia;
    return key;
  }

  String arrowCityImage() {
    var key = showCityView.value
        ? R.comShaixuanShang
        : R.comShaixuanXia;
    return key;
  }
}
