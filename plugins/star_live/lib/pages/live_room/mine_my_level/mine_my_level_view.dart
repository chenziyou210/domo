import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_common/lottie/lottie_view.dart';
import 'package:star_common/manager/app_manager.dart';
import 'mine_my_level_logic.dart';
import 'models/mine_level_model.dart';
import 'views/mine_level_upgrade_tips.dart';

class MineMyLevelPage extends StatefulWidget {
  @override
  State<MineMyLevelPage> createState() => _MineMyLevelPageState();
}

class _MineMyLevelPageState extends State<MineMyLevelPage> {
  final logic = Get.put(MineMyLevelLogic());
  final state = Get.find<MineMyLevelLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic.getGrade();
  }

  @override
  Widget build(BuildContext context) {
    state.context = context;
    return Scaffold(
      appBar: DefaultAppBar(
        centerTitle: true,
        title: AppLayout.appBarTitle('我的等级'),
        actions: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 18.dp),
            child: AppLayout.textWhite14('规则'),
          ).gestureDetector(onTap: () {
            logic.pushLevelRegulationPage();
          }),
        ],
      ),
      body: SafeArea(
        child: GetBuilder<MineMyLevelLogic>(builder: (logic) {
          return SmartRefresher(
            controller: state.refreshController,
            enablePullDown: true,
            header: LottieHeader(),
            footer: LottieFooter(),
            onRefresh: () => logic.getGrade(),
            child: state.loadDateDone
                ? ListView(
                    children: _getList(),
                  )
                : Container(),
          );
        }),
      ),
    );
  }

  List<Widget> _getList() {
    List<Widget> children = [];
    final lockedList = _getLockedList();
    final unLockList = _getUnLockList();
    children.add(_buildLevelProgress());
    children.add(_buildListHeader(R.mineLevelLocked,
        '已解锁${lockedList.length >= 5 ? '全部' : '${lockedList.length}个'}特权'));
    if (lockedList.length > 0) {
      children.add(_buildLockedListCard(lockedList));
    }
    if (lockedList.length < 5) {
      children.add(_buildListHeader(R.mineLevelUnlock, '未解锁特权'));
      children.addAll(unLockList);
    }
    return children;
  }

  Widget _buildLevelProgress() {
    return Container(
      height: 158.dp,
      child: Stack(
        children: [
          Image.asset(R.mineLevelBg, fit: BoxFit.cover, width: double.infinity, height: 134.dp,),
          Column(
            children: [
              SizedBox(
                height: 24.dp,
              ),
              UserLevelView(state.userGrade.userLevel ?? 0),
              SizedBox(
                height: 8.dp,
              ),
              AppLayout.textWhite12('当前成长值：${state.userGrade.nowExperience ?? 0}'),
              SizedBox(
                height: 16.dp,
              ),
              _buildLevelProgressSpeed(),
              SizedBox(height: 8.dp,),
              AppLayout.text70White12(
                  '距离${(state.userGrade.userLevel ?? 0) + 1}级还差${state.userGrade.upgradeExperience ?? 0}成长值'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLevelProgressSpeed() {
    final double totalWidth = 247;
    final double speedWidth = totalWidth * (state.userGrade.expPer ?? 0);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppLayout.textWhite12('Lv${state.userGrade.userLevel ?? 0}'),
          SizedBox(
            width: 8.dp,
          ),
          Container(
            height: 4.dp,
            width: totalWidth.dp,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.dp),
                    color: AppMainColors.whiteColor100,
                  ),
                ),
                Container(
                  width: speedWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.dp),
                    color: AppMainColors.mainColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 8.dp,
          ),
          AppLayout.textWhite12('Lv${(state.userGrade.userLevel ?? 0) + 1}'),
        ],
      ),
    );
  }

  Widget _buildListHeader(String icon, String title) {
    return Container(
      padding: EdgeInsets.only(left: AppLayout.pageSpace, bottom: 12.dp),
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 24.dp,
            height: 24.dp,
          ),
          SizedBox(
            width: 4.dp,
          ),
          SizedBox(
            height: 24.dp,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: AppLayout.boldFont,
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLockedListCard(List<Widget> list) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppLayout.pageSpace),
      height: list.length > 4 ? 224.dp : 114.dp,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisExtent: 94.dp,
          mainAxisSpacing: 9.dp,
        ),
        children: list,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }

  /// 已解锁特权
  List<Widget> _getLockedList() {
    List<Widget> children = [];
    children = state.lockedList.map((e) => _buildLockedItem(e)).toList();
    return children;
  }

  Widget _buildLockedItem(MineLevelModel model) {
    return InkWell(
      child: Column(
        children: [
          Image.asset(
            model.lockedIcon,
            width: 64.dp,
            height: 64.dp,
          ),
          SizedBox(height: 8.dp),
          AppLayout.textWhite14(model.lockedContent),
        ],
      ),
      onTap: () => logic.pushLevelPrivilegePage(model),
    );
  }

  /// 未解锁特权
  List<Widget> _getUnLockList() {
    List<Widget> children = [];
    if ((state.userGrade.userLevel ?? 0) < 1) {
      final itemLv1 =
          _buildUnlockItemLv1(logic.getLevelModel(LevelType.level1, false));
      children.add(itemLv1);
    }
    if ((state.userGrade.userLevel ?? 0) < 10) {
      final itemLv10 =
          _buildUnlockItemLv10(logic.getLevelModel(LevelType.level10, false));
      children.add(itemLv10);
    }
    if ((state.userGrade.userLevel ?? 0) < 12) {
      final itemLv12 =
          _buildUnlockItemLv12(logic.getLevelModel(LevelType.level12, false));
      children.add(itemLv12);
    }
    if ((state.userGrade.userLevel ?? 0) < 21) {
      final itemLv21 =
          _buildUnlockItemLv21(logic.getLevelModel(LevelType.level21, false));
      children.add(itemLv21);
    }
    if ((state.userGrade.userLevel ?? 0) < 30) {
      final itemLv30 =
          _buildUnlockItemLv30(logic.getLevelModel(LevelType.level30, false));
      children.add(itemLv30);
    }
    return children;
  }

  Widget _buildUnlockItemLv1(MineLevelModel model) {
    return _buildUnlockItem(
      model,
      Column(
        children: [
          _buildUnlockItemLevel(model),
          _buildUnlockItemMedal(model, model.unlockTitle1),
          _buildUnlockItemUnlock(model, model.unlockTitle2),
        ],
      ),
    );
  }

  Widget _buildUnlockItemLv10(MineLevelModel model) {
    return _buildUnlockItem(
      model,
      Column(
        children: [
          _buildUnlockItemLevel(model),
          _buildUnlockItemUnlock(model, model.unlockTitle1),
        ],
      ),
    );
  }

  Widget _buildUnlockItemLv12(MineLevelModel model) {
    return _buildUnlockItem(
      model,
      Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildUnlockItemLevel(model),
                      AppLayout.textWhite12(model.unlockTitle1),
                    ],
                  ),
                ),
                Container(
                  width: 56.dp,
                  height: 56.dp,
                  child: Image.asset(R.giftLevel12),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.dp),
          _buildUnlockItemMedal(model, model.unlockTitle2),
          _buildUnlockItemUnlock(model, model.unlockTitle3),
        ],
      ),
    );
  }

  Widget _buildUnlockItemLv21(MineLevelModel model) {
    return _buildUnlockItem(
      model,
      Column(
        children: [
          _buildUnlockItemLevel(model),
          _buildUnlockItemUnlock(model, model.unlockTitle1),
        ],
      ),
    );
  }

  Widget _buildUnlockItemLv30(MineLevelModel model) {
    return _buildUnlockItem(
      model,
      Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildUnlockItemLevel(model),
                      AppLayout.textWhite12(model.unlockTitle1),
                    ],
                  ),
                ),
                Container(
                  width: 56.dp,
                  height: 56.dp,
                  child: Image.asset(R.carLevel30),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnlockItem(MineLevelModel model, Widget child) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 8.dp, left: AppLayout.pageSpace, right: AppLayout.pageSpace),
        padding: EdgeInsets.all(12.dp),
        decoration: BoxDecoration(
            color: AppMainColors.whiteColor6,
            borderRadius: BorderRadius.circular(8.dp)),
        child: child,
      ),
      onTap: () => logic.pushLevelPrivilegePage(model),
    );
  }

  Widget _buildUnlockItemLevel(MineLevelModel model) {
    return Container(
      padding: EdgeInsets.only(bottom: 16.dp),
      child: Row(
        children: [
          Container(
            width: 12.dp,
            height: 12.dp,
            child: Image.asset(model.levelIcon),
          ),
          SizedBox(width: 5.dp),
          AppLayout.textWhite14('Lv${model.level}'),
        ],
      ),
    );
  }

  Widget _buildUnlockItemMedal(MineLevelModel model, String title) {
    return Container(
      padding: EdgeInsets.only(bottom: 16.dp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppLayout.textWhite12(title),
          UserLevelView(model.level),
        ],
      ),
    );
  }

  Widget _buildUnlockItemUnlock(MineLevelModel model, String title) {
    final AppUser user = AppManager.getInstance<AppUser>();
    return Container(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppLayout.textWhite12(title),
          SizedBox(
            height: 8.dp,
          ),
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              model.levelType == LevelType.level21
                  ? LevelUpgradeTips(model.level, tip: '${user.username} 来了')
                  : LevelUpgradeTips(model.level, allRadius: model.levelType == LevelType.level10 ? true : false),
            ],
          )),
        ],
      ),
    );
  }

}
