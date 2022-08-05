import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_common/manager/app_manager.dart';
import '../mine_my_level_logic.dart';
import '../models/mine_level_model.dart';
import '../models/mine_level_privilege_model.dart';
import 'mine_level_upgrade_tips.dart';

class MineLevelPrivilegePage extends StatefulWidget {
  const MineLevelPrivilegePage({Key? key}) : super(key: key);

  @override
  State<MineLevelPrivilegePage> createState() => _MineLevelPrivilegePageState();
}

class _MineLevelPrivilegePageState extends State<MineLevelPrivilegePage>
    with SingleTickerProviderStateMixin {
  final logic = Get.put(MineMyLevelLogic());
  final state = Get.find<MineMyLevelLogic>().state;
  late PageController _pageController;
  late ScrollController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final width = MediaQuery.of(state.context).size.width;
    _pageController = PageController(initialPage: state.selectIndex);
    _controller = ScrollController(initialScrollOffset: (state.selectIndex) * width / 4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        centerTitle: true,
        title: AppLayout.appBarTitle('特权详情'),
        bottom: PreferredSize(
          child: _buildSelectHeader(),
          preferredSize: Size.fromHeight(148.dp),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildSelectHeader() {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        GetBuilder<MineMyLevelLogic>(builder: (logic) {
          return Container(
            height: 140.dp,
            color: AppMainColors.whiteColor6,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 9,
              controller: _controller,
              //physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                int levelIndex = 0;
                if (2 <= index && index < 7) {
                  levelIndex = index - 2;
                }
                final model = state.levelModels[levelIndex];

                return (2 <= index && index < 7)
                    ? GestureDetector(
                  child: Container(
                    width: width / 4,
                    alignment: Alignment.center,
                    child: Container(
                      width: levelIndex == state.selectIndex ? 64.dp : 44.8.dp,
                      height: levelIndex == state.selectIndex ? 100.dp : 70.dp,
                      child: Stack(
                        children: [
                          Container(
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: Image.asset(
                                    model.lockedStatus ? model.lockedIcon : model.unlockIcon, fit: BoxFit.cover,),
                                ),
                                Positioned(
                                  bottom: levelIndex == state.selectIndex ? 28.dp : 19.6.dp,
                                  left: 0,
                                  right: 0,
                                  child: model.lockedStatus ? Container() : Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(horizontal: 9.dp, vertical: 1.dp),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.dp),
                                      color: AppMainColors.string2Color('#787878'),
                                    ),
                                    child: FittedBox(
                                      child: CustomText('Lv${model.level}解锁', color: AppMainColors.whiteColor70,),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: FittedBox(
                                      child: CustomText(model.lockedContent, color: levelIndex == state.selectIndex ? Colors.white : AppMainColors.whiteColor70,)
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () => updateIndex(levelIndex),
                )
                    : (index == 0 || index == 8)
                    ? Container(width: width / 8)
                    : Container(width: width / 4);
              },
            ),
          );
        }),
        Image.asset(R.iconLevelTriangle, width: 24.dp, height: 8.dp,),
      ],
    );
  }

  void updateIndex(int index) {
    final width = MediaQuery.of(context).size.width;
    _controller.jumpTo(index * width / 4);
    _pageController.jumpToPage(index);
    state.selectIndex = index;
    logic.update();
  }

  Widget _buildBody() {
    return PageView.builder(
      controller: _pageController,
      itemCount: state.pages.length,
      itemBuilder: (context, index) {
        final model = state.pages[index];
        return _buildPage(model);
      },
      onPageChanged: (index) {
        updateIndex(index);
      },
    );
  }

  Widget _buildPage(LevelPrivilegeModel model) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildPageHeader(model),
          Container(
            margin: EdgeInsets.only(left: 16.dp, right: 16.dp, bottom: 16.dp),
            padding: EdgeInsets.all(16.dp),
            decoration: BoxDecoration(
              color: AppMainColors.blue10,
              borderRadius: BorderRadius.circular(8.dp),
            ),
            child: Column(
              children: [
                _buildPageSynopsisSliver(model),
                _buildPageSynopsisDetailSliverList(model.synopsisList),
                (model.carDiamondList ?? []).length <= 0 ? Container() : _buildPageCarSliverList(model),
                _buildPageSliverList(model),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageHeader(LevelPrivilegeModel model) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.dp, 16.dp, 16.dp, 12.dp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Image.asset(
                R.mineLevelLock,
                width: 24.dp,
                height: 24.dp,
              ),
              SizedBox(width: 4.dp,),
              AppLayout.textWhite16('解锁条件'),
            ],
          ),
          SizedBox(
            height: 10.dp,
          ),
          Row(
            children: [
              AppLayout.text70White12('用户等级'),
              Text(
                'Lv${model.level}及以上',
                style: TextStyle(color: AppMainColors.mainColor, fontSize: 12.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPageSynopsisSliver(LevelPrivilegeModel model) {
    return Container(
      padding: EdgeInsets.only(bottom: 16.dp),
      child: Row(
        children: [
          AppLayout.textWhite14('特权说明').expanded(),
          _buildPageSynopsisTag(model.tag1),
          SizedBox(
            width: 8.dp,
          ),
          _buildPageSynopsisTag(model.tag2),
        ],
      ),
    );
  }

  Widget _buildPageSynopsisTag(String tag) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.dp, vertical: 2.dp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.dp),
        color: AppMainColors.blackColor70,
        border: Border.all(
          color: AppMainColors.whiteColor60,
          width: 0.5.dp,
        ),
      ),
      child: Text(
        tag,
        style: TextStyle(color: AppMainColors.whiteColor100, fontSize: 10.sp),
      ),
    );
  }

  /// 特权说明描述列表
  Widget _buildPageSynopsisDetailSliverList(List<String> synopsisList) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: synopsisList.length,
      itemBuilder: (_, index) {
        return Container(
          padding: EdgeInsets.only(bottom: 12.dp),
          child: Text(
            synopsisList[index],
            style: TextStyle(color: AppMainColors.whiteColor70, fontSize: 12.sp),
            maxLines: 2,
          ),
        );
      },
    );
  }

  /// 坐骑消费钻石列表
  Widget _buildPageCarSliverList(LevelPrivilegeModel model) {
    final carlist = model.carList ?? [];
    final carDiamondList = model.carDiamondList ?? [];
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: carlist.length,
      itemBuilder: (_, index) {
        return Container(
            padding: EdgeInsets.only(bottom: 4.dp),
            child: Row(
              children: [
                Container(
                  width: 6.dp,
                  height: 6.dp,
                  decoration: BoxDecoration(
                    color: AppMainColors.adornColor,
                    borderRadius: BorderRadius.circular(3.dp),
                  ),
                ),
                SizedBox(
                  width: 8.dp,
                ),
                Text(
                  '${carlist[index]}${carDiamondList[index]}',
                  style: TextStyle(color: AppMainColors.whiteColor100, fontSize: 12.sp),
                ),
              ],
            ));
      },
    );
  }

  Widget _buildPageSliverList(LevelPrivilegeModel model) {
    if (model.levelType == LevelType.level1) return level1SliverList(model);
    if (model.levelType == LevelType.level10) return level10SliverList(model);
    if (model.levelType == LevelType.level12) return level12SliverList(model);
    if (model.levelType == LevelType.level21) return level21SliverList(model);
    if (model.levelType == LevelType.level30) return level30SliverList(model);
    return Container();
  }

  /// 身份标识列表
  Widget level1SliverList(LevelPrivilegeModel model) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 6,
      itemBuilder: (_, index) {
        return _buildListItem(
          '用户等级Lv${index * 10 + 1}-${(index + 1) * 10}',
          UserLevelView(index * 10 + 1),
        );
      },
    );
  }

  /// 升级提示列表
  Widget level10SliverList(LevelPrivilegeModel model) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 7,
      itemBuilder: (_, index) {
        return _buildListItem(
          index == 0
              ? '用户等级Lv10及以上 ——直播间可见'
              : '用户等级Lv${(index - 1) * 10 + 1}——仅自己可见',
          Row(children: [
            index == 0
                ? LevelUpgradeTips(10)
                : LevelUpgradeTips((index - 1) * 10 + 1, allRadius: false),
          ]),
        );
      },
    );
  }

  /// 专属礼物列表
  Widget level12SliverList(LevelPrivilegeModel model) {
    final giftList = model.giftList ?? [];
    final giftLevelList = model.giftLevelList ?? [];
    final giftRemarkList = model.giftRemarkList ?? [];
    return ListView.builder(
      itemCount: giftList.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (_, index) {
        return Container(
          padding: EdgeInsets.only(top: 12.dp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppLayout.text70White12('特权礼物-Lv${giftLevelList[index]}'),
              SizedBox(
                height: 8.dp,
              ),
              Container(
                padding: EdgeInsets.only(left: 12.dp),
                height: 72.dp,
                decoration: BoxDecoration(
                  color: AppMainColors.whiteColor6,
                  borderRadius: BorderRadius.circular(8.dp),
                  border: Border.all(
                    color: AppMainColors.whiteColor10,
                    width: 1.dp,
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      '${R.iconLevelTriangle}gift_level_${giftLevelList[index]}.png',
                      width: 56.dp,
                      height: 56.dp,
                    ),
                    SizedBox(
                      width: 12.dp,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppLayout.textWhite14(giftList[index]),
                          SizedBox(
                            height: 8.dp,
                          ),
                          AppLayout.text40White12(giftRemarkList[index]),
                        ],
                      ),
                    ),
                  ],
                ),
                alignment: Alignment.centerLeft,
              ),
            ],
          ),
        );
      },
    );
  }

  /// 进房提示列表
  Widget level21SliverList(LevelPrivilegeModel model) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (_, index) {
        return _buildListItem(
          '用户等级Lv${(index + 2) * 10 + 1}-Lv${(index + 3) * 10}',
          Row(children: [LevelUpgradeTips((index + 2) * 10 + 1, tip: '${AppManager.getInstance<AppUser>().username} 来了',)],),
        );
      },
    );
  }

  /// 身份坐骑列表
  Widget level30SliverList(LevelPrivilegeModel model) {
    final carlist = model.carList ?? [];
    final carLevelList = model.carLevelList ?? [];
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: carlist.length,
      itemBuilder: (_, index) {
        return _buildListItem(
          '${carlist[index]} -Lv${carLevelList[index]}',
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LevelUpgradeTips(carLevelList[index],
                  tip: '${AppManager.getInstance<AppUser>().username} 来了'),
              Image.asset(
                'R.car_level_${carLevelList[index]}.png',
                width: 72.dp,
                height: 72.dp,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListItem(String title, Widget child) {
    return Container(
      padding: EdgeInsets.only(top: 12.dp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppLayout.text70White12(title),
          SizedBox(
            height: 8.dp,
          ),
          Container(
            height: 80.dp,
            padding: EdgeInsets.symmetric(horizontal: 16.dp),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(R.levelPrivilegeBg),
                  fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(8.dp),
            ),
            child: child,
            alignment: Alignment.centerLeft,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
    _controller.dispose();
  }
}
