import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:httpplugin/http_result_container/http_result_container.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/manager/app_manager.dart';

import '../../homepage/home_nearby_alert/nearby_alert_view.dart';
import '../models/homepage_model.dart';
import '../widget/homepage_widget.dart';
import '../widget/onliveAvatarAnimation.dart';
import 'homepage_logic.dart';
import 'homepage_state.dart';

class HomeListWidgets extends StatefulWidget {
  final logic = Get.find<HomepageLogic>();
  final int barType;

  HomeListWidgets(this.barType, {Key? key}) : super(key: key);

  changeCurrentType() {
    logic.state.barType = barType;
    // if(barType == 0){
      logic.changeTabDataWithType(barType);
    // }
    // print("滚动的类型 ： $type");
    // logic.changeCurrentTypeInfo(type);
  }

  @override
  State<HomeListWidgets> createState() => _HomeListWidgetsState();
}

class _HomeListWidgetsState extends AppStateBase<HomeListWidgets>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  final logic = Get.put(HomepageLogic());
  final state = Get.find<HomepageLogic>().state;
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    state.showHomePage = true;
    state.barType = widget.barType;
    if(widget.barType == 0){
      logic.changeTabDataWithType(widget.barType);
    }
    // logic.state.showCurrentPageView(true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return

      LoadingWidget(
        circularColor: AppMainColors.mainColor,
        builder: (loadingContext, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print(": $snapshot");
            HttpResultContainer? reslutCtainer = snapshot.data;
            print("成功 ：：：： ${reslutCtainer?.data} ");
            return Container(
             // padding: EdgeInsets.only(left: 16, right: 16),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child:
              GetBuilder<HomepageLogic>(
                  id: widget.barType,
                  builder: (logic) {
                    return _showListView(logic, widget, context);
                    return Container();
                  }),
            );
          } else {
            return EmptyView(
              emptyType: EmptyType.networkError,
              onPressed: () {
                logic.changeTabDataWithType(widget.barType);
              },
            );
          }
        },
        // placeHolderBuilder: (holderContext){
        //   return EmptyView(emptyType: EmptyType.networkError);
        // },
        future: state.future);
  }
}

/// ==========     列表主Widget    ============

Widget _showListView(
    HomepageLogic logic, HomeListWidgets widget, BuildContext context) {
  int barType = widget.barType == 1111 ? 0 : widget.barType;
  List tempList = logic.state.currentHomeList(barType);

  return Column(
    children: [
      _headerViewByType(logic, context),
      RefreshWidget(
          physics: AlwaysScrollableScrollPhysics(),
          // controller: logic.state.currentRefreshController(logic.state.barType),
          controller: RefreshController(),
          children: [
            //添加除列表组件并统一滚动部件
            SliverToBoxAdapter(child: _rollingHeaderViewByType(logic, context)),
            //判断是否展示列表空数据
            tempList.length <= 0
                ? SliverToBoxAdapter(
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: 600.dp
                      ),
                      child: EmptyView(emptyType: EmptyType.noData),
                      // height: logic.state.getEmptyPageHeight(),
                  ))

                : SliverToBoxAdapter(
                    child: StaggeredGridView.countBuilder(
                        physics: NeverScrollableScrollPhysics(), //禁用滑动事件
                        // physics: BouncingScrollPhysics(),
                        crossAxisCount: 12,
                        mainAxisSpacing: 9,
                        crossAxisSpacing: 9,
                        shrinkWrap: true,
                        itemCount:
                            logic.state.currentHomeList(widget.barType).length,
                        itemBuilder: (BuildContext context, int index) {
                          //取出数组对于的model
                          HomeInfoModel itemModel = logic.state
                              .currentHomeList(widget.barType)[index];
                          //itemView
                          return HomePageViews(
                                  itemModel,
                                  (bannerIndex) {
                                    if (itemModel.viewType == ListViewType.Banner) {
                                      logic.tapBannerMeth(
                                          context, itemModel.banner[bannerIndex]);
                                    }
                          }).inkWell(onTap: () {
                            //列表点击
                            logic.tapHomeItemMeth(context, itemModel);
                          });
                        },

                        staggeredTileBuilder: (int index) {
                          /// 构建 排列样式
                          return logic.staggerdTile(widget.barType, index);
                        }),
                  ),
          ],
          enablePullUp: true,
          onRefresh: (c) async {
            await logic.changeTabDataWithType(widget.barType);
            c.refreshCompleted();
            c.resetNoData();
          },
          onLoading: (c) async {
            /// 关注不需要上拉请求
            if (widget.barType == 1111) {
              c.loadNoData();
            } else {
              if (logic.loadMoreData) await logic.loadMore();
              if (logic.loadMoreData) {
                c.loadComplete();
              } else {
                c.loadNoData();
              }
            }
          }).expanded(),
    ],
  );
}

/// =========== 判断展示不同类型的数据Widget ===========
//不在滚动组件里的头部视图
Widget _headerViewByType(HomepageLogic logic, BuildContext context) {
  var showContent;
  switch (logic.state.barType) {
    //游戏
    case 1:
      showContent = _gameCommonView(logic);
      break;
    //附近
    case 2:
      showContent = _nearbyCommonView(logic);
      break;
    default:
      showContent = SizedBox();
      break;
  }
  return showContent;
}

//在滚动组件里的头部视图
Widget _rollingHeaderViewByType(HomepageLogic logic, BuildContext context) {
  var showContent;
  switch (logic.state.barType) {
    //关注
    case 1111:
      showContent = _focusHeaderView(logic, context);
      break;
    //推荐
    case 0:
      showContent = _recommendCommonView(logic);
      break;
    default:
      showContent = SizedBox();
      break;
  }
  return showContent;
}

/// ==========    各类型头部Widget       ============
// 推荐头部模块
Widget _recommendCommonView(HomepageLogic logic) {

  int count = logic.state.gameItems.length > 8 ? 8 : logic.state.gameItems.length;
  int row = (count / 4).ceil();
  double rowHeight = 0;
  if (row == 1){
    rowHeight = 100;
  }else if(row == 2){
    rowHeight = 154;
  }

  return Container(
    height: rowHeight.dp,
    width: double.infinity,
    // color: Colors.purple,
    margin: EdgeInsets.only(bottom: 16,top: 10),
    child: Column(
      children: [
        /// 游戏内容
        GridView.builder(
          itemCount: count,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1.7,
          ),
          itemBuilder: (context, index) {
            //对应游戏内容
            HomeBannerInfo itemModel = logic.state.gameItems[index];
            return HomeGameItem(itemModel).inkWell(onTap: () {
              //点击游戏
              logic.tapGameInfoMeth(context, itemModel);
            });
          },
        ).expanded(),
        // SizedBox(height: 10),
        ///跑马灯
        HomeMarqueeWidget(logic.state.maqreeItem),
      ],
    ),
  );
}

// 附近类型头部模块
Widget _nearbyCommonView(HomepageLogic logic) {
  return Container(
    height: 40.dp,
    // color: AppMainColors.mainColor,
    alignment: Alignment.topLeft,
    margin: EdgeInsets.only(top: 4),
    child: Row(
      children: [
        // 获取城市上下文
        Builder(builder: (cityContext) {
          String? cityValue = AppManager.getInstance<AppUser>().region;
          if (logic.state.city.value.length > 0) {
            cityValue = logic.state.city.value;
          }

          return Obx(() => Container(
                  height: 24.dp,width: 60.dp,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.dp),
                    color: logic.state.gameBgColorNormal),
                child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(cityValue!,
                        style: TextStyle(
                            fontSize: 12.dp,
                            color: logic.state.gameTextColorNormal)),
                    Image.asset(logic.state.arrowCityImage(),
                        height: 16.dp, width: 16.dp),
                  ],
                ),
              ).inkWell(onTap: () {
                //点击弹窗
                // if(logic.state.showCityView.value == false){
                  logic.state.showCityView.value = true;
                  _showAttach(cityContext, HomeCity);
                // }

              }));
        }),
        SizedBox(width: 8.dp),
        // 获取性别上下文
        Builder(builder: (genderContext) {
          return Obx(() => Container(
             height: 24.dp,width: 60.dp,
            // margin: EdgeInsets.all(5),
                // padding:
                //     EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.dp),
                  color: logic.state.gameBgColorNormal,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${logic.state.gender}",
                        style: TextStyle(
                          fontSize: 12.dp,
                          color: logic.state.gameTextColorNormal,
                        )),
                    Image.asset(logic.state.arrowGenderImage(),
                        height: 16.dp, width: 16.dp),
                  ],
                ),
              ).inkWell(onTap: () {

                // if(logic.state.showGenderView.value == false){
                  logic.state.showGenderView.value = true;
                  _showAttach(genderContext, HomeGender);
                // }

              }));
        }),
      ],
    ),
  );
}

// 游戏类型头部模块
Widget _gameCommonView(HomepageLogic logic) {
  return Container(
      margin: EdgeInsets.only(top: 2,bottom: 6),
      alignment: Alignment.topLeft,
      height: 34.dp,
      // color: Colors.brown,
      child: Obx(() {
        return ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(logic.state.gameList.length, (index) {
            HomeGameModel item = logic.state.gameList[index];
            int tempGameId = item.gameId!.toInt();
            return Obx(() => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.dp),
                    color: logic.state.gameBgColor(tempGameId),
                  ),
                  alignment: Alignment.center,
                  // margin: EdgeInsets.only(top: 5,bottom: 5,left: 6,right: 6),
                  margin: EdgeInsets.symmetric(vertical: 5,horizontal: 6),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Text("${item.name}",
                      style: TextStyle(
                        fontSize: 12.dp,
                        fontWeight: logic.state.gameTextWeight(tempGameId),
                        color: logic.state.gameTextColor(tempGameId),
                      )).inkWell(onTap: () {
                    if (logic.state.currentIndex.value != tempGameId) {
                      logic.state.currentIndex.value = tempGameId;
                      logic.dataRefreshWithBool(true);
                    }
                    //切换点选
                  }),
                ));
          }),
        );
      })
  );
}

/// 1关注头部模块
Widget _focusHeaderView(HomepageLogic logic, BuildContext context) {
  // 如果没有关注数据 展示 暂未图
  // 关注数组 包括 用户关注的 与 给用户推的 (为你推荐)
  List foucsList = logic.state.focusList;
  late var content;

  //有关注数据 但是没有直播的情况
  if (foucsList.length > 0 && !logic.state.ifHaveOnLive()) {
    content = Column(
      children: [
        //头部数据
        _showFocusHeader(logic, context),
        _showFocusNoDataView("你关注的人儿还没有直播"),
      ],
    );
  }

  // 有关注有直播
  else if (foucsList.length > 0 && logic.state.ifHaveOnLive()) {
    content = _showFocusHeader(logic, context);
  } else {
    // 没有关注 没有直播情况
    content = _showFocusNoDataView("你还没有关注过任何人");
  }

  return content;
}

/// 1.1关注头部数据
Widget _showFocusHeader(HomepageLogic logic, BuildContext context) {
  List foucsList = logic.state.focusList;
  var width = ((MediaQuery.of(context).size.width - 32) / 6);
  int focusCount = foucsList.length > 6 ? 6 : foucsList.length;
  return Container(
    height: 80.dp,
    // color: Colors.blueGrey,
    padding: EdgeInsets.only(top: 8),
    child: Row(
      //交叉轴的布局方式，对于Row来说就是水平方向的布局方式
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: List.generate(focusCount, (index) {
        HomeInfoModel model = foucsList[index];
        /// 是否直播
        bool onLive = model.anchorItem.state == 1;
        /// 全部关注不需要直播状态
        bool isAllFoucs = model.anchorItem.roomTitle == AllFocusTitle;
        onLive = isAllFoucs ? false : onLive;
        var url = model.anchorItem.header;

        return Container(
          width: width,
          child: Column(
            children: [
              Container(
                height: 49.dp,
                child: OnLiveAvatarAnimation(
                    44.dp.ceilToDouble(),
                    imgUrl: url,
                    onLive: onLive,
                    locationImage: Image.asset(R.homeQuanbu, width: 24.dp, height: 24.dp,fit: BoxFit.cover,),
                    onPressed: () {
                        if (isAllFoucs) {
                          logic.pushFavoriteList(context);
                        } else {
                          logic.tapFoucsHeaderMeth(context, model);
                        }
                      }
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 50.dp,
                height: 22.dp,
                // color: Colors.blueGrey,
                child: Text(model.anchorItem.username ?? "全部关注",
                    style: TextStyle(
                      fontSize: 10,
                      color: AppMainColors.whiteColor70,
                      overflow: TextOverflow.ellipsis,
                    )),
              )
            ],
          ),
        );
      }),
    ),
  );
}

// 1.2关注默认图
Widget _showFocusNoDataView(String name) {
  return Container(
    height: 160,
    width: double.infinity,
    child: EmptyView(
      emptyType: EmptyType.noData,
      emptyStr: name,
      imageWidget: Image.asset(
        R.emptyFoucse, width: 120, height: 120,
      ),
      // imageStr: AppImages.empty_foucse,
      imagePaddingBottom: 0,
      textPaddingTop: 100,
    ),
  );
}

/// ==========      弹窗       ============
// 地址 性别弹窗
void _showAttach(BuildContext ctx, String showStr) {
  final logic = Get.put(HomepageLogic());
  // var attachDialog = (BuildContext context) {
  SmartDialog.showAttach(
    targetContext: ctx,
    debounce: true,
    keepSingle: true,
    maskColor: Colors.brown,
    maskWidget: Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 200),
    ),
    animationTime: Duration(
      microseconds: 1,
    ),
    onDismiss: () {
      if (showStr == HomeCity) {
        logic.state.showCityView.value = false;
      } else {
        logic.state.showGenderView.value = false;
      }
    },
    alignment: Alignment.bottomCenter,
    // useSystem: true,
    builder: (context) {
      if (showStr == HomeCity) {
        return NearbyAlertView(onTap: (value, ids) {
          logic.state.city.value = value!;
          logic.state.showCityView.value = false;
          SmartDialog.dismiss();
          logic.dataRefreshWithBool(true);
        });
      } else {
        return GenderAlertView(onTap: (value, ids) {
          logic.state.gender.value = value;
          logic.state.showGenderView.value = false;
          SmartDialog.dismiss();
          logic.dataRefreshWithBool(true);
        });
      }
    },
  );
}
