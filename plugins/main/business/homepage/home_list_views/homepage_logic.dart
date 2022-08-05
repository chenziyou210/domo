import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:httpplugin/http_result_container/http_result_container.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/http_channel.dart';

import 'package:star_common/generated/anchor_list_model_entity.dart';
import 'package:star_common/manager/app_manager.dart';
import 'package:star_common/util_tool/stringutils.dart';
import 'package:star_common/router/router_config.dart';
import 'package:star_live/pages/personal_information/my_fans/my_fans_view.dart';
import '../../../../pages/game/jump_game_logic.dart';
import '../models/homepage_model.dart';
import 'homepage_state.dart';

class HomepageLogic extends GetxController
    with PagingMixin<AnchorListModelEntity>, Toast {
  HomepageLogic() {
    EventBus.instance.addListener(_refreshAttention, name: refreshAttention);
  }
  final HomepageState state = HomepageState(homeListMap: {});

  @override
  void onInit() {
    super.onInit();
  }

  @override
  InternalFinalCallback<void> get onDelete {
    EventBus.instance.removeListener(_refreshAttention, name: refreshAttention);
    return super.onDelete;
  }

  @override
  void onClose() {
    super.onClose();
  }

  void _refreshAttention(arguments) {
    print("通知刷新了吗");
    changeTabDataWithType(1111);
  }

  /*   -------------  点击跳转    --------------    */
  /// 观众直播间列表
  tapHomeItemMeth(BuildContext context, HomeInfoModel itemModel) {
    if (itemModel.viewType == ListViewType.Anchor) {
      List anchorList = state.containsOnlyAnchorsArr(state.barType);
      //找到在主播列表的下标
      int tempIndex = anchorList.indexOf(itemModel.anchorItem);
      //如果没找到 默认第一个
      tempIndex <= 0 ? 0 : tempIndex;
      Map<String, dynamic> args = {
        "index": tempIndex,
        "rooms": anchorList,
      };
      Get.toNamed(AppRoutes.audiencePage,arguments: args);
    }

    /// 火力值点击
    else if (itemModel.viewType == ListViewType.Ranking) {
      Get.toNamed(AppRoutes.rankIntegration);
    }
  }

  //关注头像点击
  tapFoucsHeaderMeth(BuildContext context, HomeInfoModel itemModel) {
    int tempIndex = 0;
    List tempList = state.containsOnlyAnchorsArr(state.barType);
    int index = tempList.indexOf(itemModel.anchorItem);
    tempIndex = index > 0 ? index : 0;
    bool onlive = itemModel.anchorItem.state == 1;
    if (onlive) {
      Map<String, dynamic> args = {"index": tempIndex, "rooms": tempList};
      //在线跳转直播间
      Get.toNamed(AppRoutes.audiencePage,arguments: args);
    } else {
      //跳转个人信息
      Get.toNamed(AppRoutes.userById,
          arguments: {"userId": itemModel.anchorItem.userId ?? " 0"});
    }
  }

  //banner点击
  tapBannerMeth(BuildContext context, HomeBannerInfo bannerItem) {
    print("地址是多少： ${bannerItem.url}");
    if (bannerItem.url!.contains("http")) {
      Map<String, dynamic> args = {"url": bannerItem.url};
      homeWebPage(context, args);
    } else {
      if (int.parse(bannerItem.url!) is int) {
        Get.put(JumpGameLogic()).gotoGameDetail(bannerItem.url!);
      }
    }
  }

  //游戏点击
  tapGameInfoMeth(BuildContext context, HomeBannerInfo gameInfo) {
    if (gameInfo.urlType == 3) {
      Get.put(JumpGameLogic()).gotoGameDetail(gameInfo.url!);
    } else if (gameInfo.urlType == 2) {
      Map<String, dynamic> args = {"url": gameInfo.url};

      ///网络跳转
      homeWebPage(context, args);
    }
  }

  /// 观众直播间列表
  pushAudiencePageHero(BuildContext context, Map arguments) {
    Get.toNamed(AppRoutes.audiencePage,arguments: arguments);
  }

  /// 全部关注
  pushFavoriteList(BuildContext context) {
    Get.to(() => MyFansPage(arguments: {
      "type": 0,
      "userId": AppManager.getInstance<AppUser>().userId}
    ));
  }

  /*   -------------  是否需要重新请求    --------------    */
  void changeCurrentTypeInfo(int type) {
    state.barType = type;
    HomeInfoControlModel controlModel = state.currentControlModel(type);
    if (controlModel.showPageView == false) {
      if (controlModel.homeList.length <= 0) {
        changeTabDataWithType(type);
      } else {
        update([type]);
      }
    }
  }

  void updateHomeRank(HomeRankingInfo model) {
    HomeInfoControlModel controlModel = state.currentControlModel(0);
    controlModel.homeList.forEach((element) {
      if (element.viewType == ListViewType.Ranking) {
        element.ranking = model;
        return;
      }
    });

    if (state.barType == 0) {
      update([0]);
    }
  }

  /*   -------------  请求部分    --------------    */
  changeTabDataWithType(int type) {
    /// 获取类型参数
    HomeInfoControlModel controlModel = state.currentControlModel(type);
    controlModel.homeList.clear();
    controlModel.page = 1;
    print("刷新的类型是   type: $type");

    switch (type) {
      case 1111:
        state.future = getRequestFoucusData(type);
        break;
      case 0:
        {
          requestBannerInfoData(ADRequestType.GameHomeTabRecommend);
          reqeustMarqueeInfoData();
          state.future = _getRequestRecommendDataCommon(type);
        }
        break;
      case 1:
        {
          reqeustGameInfoData();
          state.future = _getRequestGameDataCommon(type);
        }
        break;
      case 2:
        {
          state.future = _getNearByDataCommon(type);
        }
        break;
      default:
        state.future = dataRefreshWithBool(false);
        break;
    }
  }

  /*------- 组合请求方法 ---------------*/

  /// 关注
  Future getRequestFoucusData(int type) async {
    // if (state.barType != 1111) {
    //   ///如果不是当前 待切换到此页面进行更新请求
    //   HomeInfoControlModel controlModel = state.currentControlModel(1111);
    //   controlModel.homeList.clear();
    //   controlModel.showPageView = false;
    // }
    // else {

    if (state.barType != 1111) return;

    return await Future.wait<dynamic>([requestAnchorListData()]).then((value) {
      /* 解析一步错 后面不在执行...flutter*/
      List<HomeInfoModel> liveAnchors = [];
      List<HomeInfoModel> unLiveAnchors = [];
      state.focusList.clear();

      ///3.主播列表
      value[0].forEach((element) {
        HomeInfoModel homeModel = HomeInfoModel();
        homeModel.viewType = ListViewType.Anchor;
        homeModel.anchorItem = element;
        homeModel.anchorItem.barType = type;
        if (element.state == 1) {
          homeModel.isSquare = true;
          liveAnchors.add(homeModel);
        } else {
          unLiveAnchors.add(homeModel);
        }
      });

      /// 只有有关注数据就追加全部关注
      if (liveAnchors.length > 0 || unLiveAnchors.length > 0) {
        state.focusList.add(state.allFocusModel());
        state.focusList.addAll(liveAnchors);
        state.focusList.addAll(unLiveAnchors);
      }

      /// 主播主列表数据
      List tempAllHomeList = state.currentHomeList(type);
      tempAllHomeList.clear();
      //正在直播
      if (liveAnchors.length > 0) {
        tempAllHomeList.add(state.liveTipInfo("正在直播"));
        tempAllHomeList.addAll(liveAnchors);
      }
      //推荐列表随机匹配
      List<AnchorListModelEntity> recomondList =
          state.containsOnlyAnchorsArr(0);
      Set<HomeInfoModel> randomSet = Set();

      if (recomondList.length > 0) {
        recomondList.forEach((element) {
          /// 最多取10个
          if (randomSet.length <= 10) {
            HomeInfoModel homeModel = HomeInfoModel();
            homeModel.viewType = ListViewType.Anchor;
            homeModel.anchorItem = element;
            homeModel.anchorItem.barType = 0;
            randomSet.add(homeModel);
          }
        });
        // var rng = Random();
        // Set <HomeInfoModel>randomSet = Set();
        // for (var i = 0; i < 15; i ++) {
        //   int index = rng.nextInt(recomondList.length);
        //   HomeInfoModel anchorInfoModel = recomondList[index];
        //   //如果是主播的数据的就加入数组
        //   if (anchorInfoModel.viewType == ListViewType.Anchor) {
        //     randomSet.add(recomondList[index]);
        //   }
        // }

        /// 移除正在直播的数据
        liveAnchors.forEach((liveElement) {
          randomSet.removeWhere((allElement) =>
              liveElement.anchorItem.userId == allElement.anchorItem.userId);
        });

        if (randomSet.length > 0) {
          //添加TipTitle
          tempAllHomeList.add(state.liveTipInfo("为你推荐"));
          List<HomeInfoModel> foulist = randomSet.toList();
          tempAllHomeList.addAll(foulist);
        }
      }

      if (state.barType == 1111) {
        update([1111]);
      }

      // }
    }).catchError((error) {});
    // }
  }

  /// 推荐推荐内容组合
  Future _getRequestRecommendDataCommon(int type) async {
    // requestBannerInfoData(4),reqeustMarqueeInfoData()
    // 去掉游戏入口请求 ，去掉跑马灯组合请求，此为固定参数
    if (state.barType != 0) return;
    return await Future.wait<dynamic>([
      requestAnchorListData(),
      requestBannerInfoData(ADRequestType.BannerHomeTabRecommend),
      requestHomeRankFirstData()
    ]).then((value) {
      /* 解析一步错 后面不在执行...flutter*/

      ///预防串类型数量错乱
      List tempHomeList = state.currentHomeList(0);

      List anchors = value[0];
      if (anchors.length > 0) {
        ///3.主播列表
        value[0].forEach((element) {
          HomeInfoModel homeModel = HomeInfoModel();
          homeModel.viewType = ListViewType.Anchor;
          homeModel.anchorItem = element;
          homeModel.anchorItem.barType = type;
          tempHomeList.add(homeModel);
        });
      }

      ///4.banner的值
      List banners = value[1];
      if (banners.length > 0) {
        HomeInfoModel bannerHomeModel = HomeInfoModel();
        bannerHomeModel.viewType = ListViewType.Banner;
        bannerHomeModel.banner.clear();
        bannerHomeModel.banner.addAll(value[1]);
        state.bannerItem = bannerHomeModel;
        //大于4个插入
        if (anchors.length > 4) {
          tempHomeList.insert(4, bannerHomeModel);
        } else {
          tempHomeList.add(bannerHomeModel);
        }
      }

      if (value[2] != null) {
        ///5.火力排行版
        HomeInfoModel rankInfoModel = HomeInfoModel();
        HomeRankingInfo rankItem = value[2];
        rankItem.fireRank = StringUtils.showNmberOver10k(rankItem.heat);
        rankInfoModel.viewType = ListViewType.Ranking;
        rankInfoModel.ranking = rankItem;
        state.rankItem = rankInfoModel;

        //大于7个插入
        if (anchors.length > 7) {
          tempHomeList.insert(7, rankInfoModel);
        } else {
          tempHomeList.add(rankInfoModel);
        }
      }

      if (state.barType == 0) {
        update([0]);
      }
    }).catchError((error) {});
  }

  /// 游戏内容
  Future _getRequestGameDataCommon(int type) async {
    return await Future.wait<dynamic>([
      requestBannerInfoData(ADRequestType.BannerHomeTabGame),
      requestAnchorListData()
    ]).then((value) {
      if (state.barType != 1) return;

      List tempHomeList = state.currentHomeList(1);
      tempHomeList.clear();
      print("请求游戏：类型：${state.barType}  数组：${tempHomeList.length} ");

      ///2.主播列表
      value[1].forEach((element) {
        HomeInfoModel homeModel = HomeInfoModel();
        homeModel.viewType = ListViewType.Anchor;
        homeModel.anchorItem = element;
        homeModel.anchorItem.barType = type;
        tempHomeList.add(homeModel);
      });

      if (tempHomeList.length > 0) {
        ///1.banner的值
        ///如果有数据那么追加一条banner数据
        List lst = value[0];
        if (lst.length <= 0) {
          if (state.bannerItem.banner.length > 0) {
            tempHomeList.add(state.bannerItem);
          }
        } else {
          HomeInfoModel bannerHomeModel = HomeInfoModel();
          bannerHomeModel.viewType = ListViewType.Banner;
          bannerHomeModel.banner.clear();
          bannerHomeModel.banner.addAll(value[0]);
          state.bannerItem = bannerHomeModel;
          tempHomeList.insert(0, bannerHomeModel);
        }
      }

      if (state.barType == 1) {
        update([1]);
      }
    }).catchError((error) {});
  }

  /// 附近内容
  Future _getNearByDataCommon(int type) async {
    return await Future.wait<dynamic>([
      requestBannerInfoData(ADRequestType.BannerHomeTabNearby),
      requestAnchorListData()
    ]).then((value) {
      if (state.barType != 2) return;
      List tempHomeList = state.currentHomeList(2);

      ///1.banner的值
      List banners = value[0];
      HomeInfoModel bannerHomeModel = HomeInfoModel();
      if (banners.isNotEmpty) {
        print("banner 有吗");
        bannerHomeModel.viewType = ListViewType.Banner;
        bannerHomeModel.banner.clear();
        bannerHomeModel.banner.addAll(value[0]);
        state.bannerItem = bannerHomeModel;
      }

      List anchors = value[1];

      ///1.主播列表
      value[1].forEach((element) {
        HomeInfoModel homeModel = HomeInfoModel();
        homeModel.viewType = ListViewType.Anchor;
        homeModel.anchorItem = element;
        homeModel.anchorItem.barType = type;
        tempHomeList.add(homeModel);
      });

      int count = tempHomeList.length;
      // banner插入原则
      if (count > 0) {
        if (count > 0 && count < 3) {
          tempHomeList.insert(0, state.bannerItem);
        } else if (count >= 3 && count < 6) {
          tempHomeList.insert(3, state.bannerItem);
        } else {
          tempHomeList.insert(6, state.bannerItem);
        }
      }

      if (state.barType == 2) {
        update([2]);
      }
    }).catchError((error) {});
  }

/*   单个请求方法  **/
  /// 首页banner图
  /// 类型（
  // 1：开机屏幕图，
  // 2：首页弹框，
  // 3：首页-推荐banner图,
  // 31.首页-游戏banner
  // 32.首页-附近banner）
  //  5.充值页banner
  // 6.游戏页banner
  // 7.我的页面-banner
  // 4: 首页游戏快捷入口
  // 41:我的页面-快捷入口
  requestBannerInfoData(ADRequestType type) async {
    var reslut;
    int tempType = state.adRequestTypeToInt(type);
    await Future(
        () => HttpChannel.channel.advertiseBanner(advertiseType: tempType)
          ..then((value) => value.finalize(
              wrapper: WrapperModel(),
              success: (data) {
                List lst = data ?? [];
                List<HomeBannerInfo> banners =
                    lst.map((e) => HomeBannerInfo.fromJson(e)).toList();

                if (type == ADRequestType.GameHomeTabRecommend) {
                  state.gameItems.clear();
                  state.gameItems = banners;
                }

                reslut = banners;
              })));
    return reslut;
    // }
  }

  /// 直播风云榜
  requestHomeRankFirstData() async {
    var reslut;
    await Future(() => HttpChannel.channel.homeRankFirst()
      ..then((value) => value.finalize(
          wrapper: WrapperModel(),
          success: (data) {
            if (data != null) {
              var map = data ?? {};
              HomeRankingInfo rankingInfo = HomeRankingInfo.fromJson(map);
              reslut = rankingInfo;
            }
          })));
    return reslut;
    // }
  }

  /// 跑马灯
  reqeustMarqueeInfoData() async {
    var reslut;
    await Future(() => HttpChannel.channel.announcementList(1)
      ..then((value) => value.finalize(
          wrapper: WrapperModel(),
          success: (data) {
            List lst = data ?? [];
            List<HomeMarqueeInfo> announcement =
                lst.map((e) => HomeMarqueeInfo.fromJson(e)).toList();

            HomeMarqueeInfo tempMarquee = HomeMarqueeInfo();
            if (announcement.length > 0) {
              String tempContent = "";
              announcement.forEach((element) {
                tempContent = "$tempContent ${element.content}";
              });
              tempMarquee.content = tempContent;
            } else {
              tempMarquee.content = "欢迎来到广岛直播";
            }
            state.maqreeItem = tempMarquee;
            reslut = announcement;
          })));
    return reslut;
  }

  requestAnchorListData() async {
    var reslut;
    int currentPage = state.currentListPage(state.barType);
    await Future(() {
      return _dataRequest(currentPage, failure: (e) {
        showToast(e);
      }, success: (data) {
        this.data = data;
        reslut = data;
      });
    });
    return reslut;
  }

  /// 直播列表
  Future _dataRequest(int page,
      {Failure? failure, void Function(dynamic)? success}) {
    print("类型h：${state.barType}  页码 $page");
    Future<HttpResultContainer> future;
    switch (state.barType) {
      case 1111:
        {
          future = HttpChannel.channel.watchlistListByType(page);
          print("我是关注");
        }
        break;
      case 1:
        {
          future = HttpChannel.channel.anchorListByType(page, state.barType, 15,
              gameId: state.currentIndex.value);
          print("我是游戏");
        }
        break;
      case 2:
        {
          late var sex;
          if (state.gender.value == "不限") {
            sex = 0;
          } else if (state.gender.value == "男生") {
            sex = 1;
          } else if (state.gender.value == "女生") {
            sex = 2;
          }
          String? cityValue = AppManager.getInstance<AppUser>().region;
          if (state.city.value.length > 0) {
            cityValue = state.city.value;
          }
          future = HttpChannel.channel.anchorListByType(page, state.barType, 15,
              city: cityValue, sex: sex);
          print("我是附近");
        }
        break;
      default:
        future = HttpChannel.channel.anchorListByType(page, state.barType, 15);
        break;
    }

    return future
      ..then((value) => value.finalize(
          wrapper: WrapperModel(),
          failure: failure,
          success: (data) {
            if (data is Map) {
              List lst = data["data"] ?? [];
              if (lst.length > 0) {
                page++;
                state.homeListMap[state.barType]!.page = page;
              }
              // _count = data["total"];
              List<AnchorListModelEntity> anchorList =
                  lst.map((e) => AnchorListModelEntity.fromJson(e)).toList();
              success?.call(anchorList);
            }
          }));
  }

  reqeustGameInfoData() async {
    // var reslut;
    await Future(() => HttpChannel.channel.homeGameList()
      ..then((value) => value.finalize(
          wrapper: WrapperModel(),
          success: (data) {
            List lst = data ?? [];
            List<HomeGameModel> gameInfo =
                lst.map((e) => HomeGameModel.fromJson(e)).toList();
            state.gameList.clear();
            gameInfo.insert(0, state.allGameModel());
            // Future.delayed(Duration(seconds: 10),(){
            state.gameList.value = gameInfo;
            // });
            // reslut = gameInfo;
          })));
    // return reslut;
  }

  /* ============== 上拉 - 下拉 - 刷新 ================ */

  @override
  Future dataRefreshWithBool(needReload) {
    HomeInfoControlModel controlModel =
        state.currentControlModel(state.barType);
    if (needReload) {
      controlModel.page = 1;
      controlModel.homeList.clear();
    }
    List<HomeInfoModel> tempList = List.empty(growable: true);

    return _dataRequest(controlModel.page, failure: (e) {
      showToast(e);
    }, success: (data) {
      this.data = data;
      dismiss();
      data.forEach((element) {
        HomeInfoModel homeModel = HomeInfoModel();
        homeModel.viewType = ListViewType.Anchor;
        homeModel.anchorItem = element;
        homeModel.anchorItem.barType = state.barType;
        tempList.add(homeModel);
      });

      int count = tempList.length;
      if (count > 0) {
        // 如果是游戏 与附近，清空数组之后，需加上轮播图
        if (state.barType == 1) {
          tempList.insert(0, state.bannerItem);
        } else if (state.barType == 2) {
          if (count > 0 && count < 3) {
            tempList.insert(0, state.bannerItem);
          } else if (count >= 3 && count < 6) {
            tempList.insert(3, state.bannerItem);
          } else {
            tempList.insert(6, state.bannerItem);
          }
        }
      }
      controlModel.homeList = tempList;
      update([state.barType]);
    });
  }

  @override
  Future loadMore() {
    // TODO: implement loadMore
    HomeInfoControlModel controlModel =
        state.currentControlModel(state.barType);
    return _dataRequest(controlModel.page, failure: (e) {
      // showToast(e);
    }, success: (value) {
      this.data = value;
      value.forEach((element) {
        HomeInfoModel homeModel = HomeInfoModel();
        homeModel.viewType = ListViewType.Anchor;
        homeModel.anchorItem = element;
        homeModel.anchorItem.barType = state.barType;
        controlModel.homeList.add(homeModel);
      });
      update([state.barType]);
    });
  }

  /* 返回列表item的具体项 */
  StaggeredTile staggerdTile(int barType, int index) {
    final list = state.currentHomeList(barType);
    HomeInfoModel model = list[index];
    final type = index < list.length ? model.viewType : null;
    var tempTileExtent = StaggeredTile.extent(6, 0);
    if (type != null) {
      switch (type) {
        case ListViewType.Nearby:
        case ListViewType.Anchor:
          final int crossAxisCellCount = barType == 2 ? 4 : 6;
          double mainAxisCellCount = 0;
          //推荐 游戏 为长方形
          if (barType == 0 || barType == 1) {
            mainAxisCellCount = AnchorItemRectangleHeight;
          }
          //附近为短长
          else if (barType == 2) {
            mainAxisCellCount = AnchorItemNearbyHeight;
          }
          //关注的
          else if (barType == 1111) {
            //直播的为短
            if (model.isSquare == true) {
              mainAxisCellCount = AnchorItemSquareHeight;
            } else {
              //非直播的长
              mainAxisCellCount = AnchorItemRectangleHeight;
            }
          } else {
            //其他都是短
            mainAxisCellCount = AnchorItemSquareHeight;
          }

          tempTileExtent =
              StaggeredTile.extent(crossAxisCellCount, mainAxisCellCount);
          break;
        case ListViewType.Tip:
          tempTileExtent = StaggeredTile.extent(12, TipItemHeight);
          break;
        case ListViewType.Banner:
          tempTileExtent = StaggeredTile.extent(12, BannerItemHeight);
          break;
        case ListViewType.Ranking:
          tempTileExtent = StaggeredTile.extent(12, RankingItemHeight);
          break;
        default:
          break;
      }
    }
    return tempTileExtent;
  }
}
