import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:hjnzb/pages/my_mine/mine_game_record/mine_game_record_state.dart';
import 'package:hjnzb/pages/my_mine/mine_game_record/views/mine_game_record_header.dart';
import 'package:hjnzb/pages/my_mine/mine_game_record/views/mine_game_record_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_common/lottie/lottie_view.dart';
import 'mine_game_record_logic.dart';

class MineGameRecordPage extends StatefulWidget {
  @override
  State<MineGameRecordPage> createState() => _MineGameRecordPageState();
}

class _MineGameRecordPageState extends State<MineGameRecordPage>
    with SingleTickerProviderStateMixin {
  final logic = Get.put(MineGameRecordLogic());
  final state = Get.find<MineGameRecordLogic>().state;
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    state.context = context;
    return Scaffold(
        appBar: DefaultAppBar(
          title: _buildAppBarTitle(),
          centerTitle: true,
        ),
        body: TabBarView(
            controller: _tabController,
            children: [TodayGameRecordList(), YesterdayGameRecordList()]));
  }

  Widget _buildAppBarTitle() {
    return TabBar(
      isScrollable: true,
      indicatorColor: Colors.transparent,
      labelColor: AppMainColors.whiteColor100,
      unselectedLabelColor: AppMainColors.whiteColor70,
      labelStyle: TextStyle(fontSize: 18.sp, fontWeight: AppLayout.boldFont),
      unselectedLabelStyle: TextStyle(fontSize: 16.sp),
      controller: _tabController,
      onTap: (index) {
        // Alog.i(index);
      },
      tabs: state.titles.map((title) {
        return CustomText(title);
      }).toList(),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }
}

class TodayGameRecordList extends StatelessWidget {
  TodayGameRecordList({Key? key}) : super(key: key);
  final logic = Get.find<MineGameRecordLogic>();
  final state = Get.find<MineGameRecordLogic>().state;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<MineGameRecordLogic>(
        id: GameRecordType.today,
        builder: (logic) {
          return SmartRefresher(
            enablePullDown: true,
            header: LottieHeader(),
            footer: LottieFooter(),
            onRefresh: () {
              logic.loadTodayGameRecord(false);
            },
            controller: state.todayRefreshController,
            child: (state.todayRecordList.isEmpty && !state.onLoading) ? EmptyView(emptyType: EmptyType.noRecord) : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: MineGameRecordHeader(
                    betAmount: '${state.todayGameRecord.sumBetMoney ?? 0}',
                    bonusAmount: '${state.todayGameRecord.sumWinMoney ?? 0}',
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final record = state.todayRecordList[index];
                      return MineGameRecordItem(
                          record: record,
                          itemEvent: () => logic.pushBetPage(record, 1));
                    },
                    childCount: state.todayRecordList.length,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class YesterdayGameRecordList extends StatelessWidget {
  YesterdayGameRecordList({Key? key}) : super(key: key);
  final logic = Get.find<MineGameRecordLogic>();
  final state = Get.find<MineGameRecordLogic>().state;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<MineGameRecordLogic>(
        id: GameRecordType.yesterday,
        builder: (logic) {
          return SmartRefresher(
            enablePullDown: true,
            header: LottieHeader(),
            footer: LottieFooter(),
            onRefresh: () {
              logic.loadYesterdayGameRecord(false);
            },
            controller: state.yesterdayRefreshController,
            child: (state.yesterdayRecordList.isEmpty && !state.onLoading) ? EmptyView(emptyType: EmptyType.noRecord) : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: MineGameRecordHeader(
                    betAmount: '${state.yesterdayGameRecord.sumBetMoney ?? 0}',
                    bonusAmount: '${state.yesterdayGameRecord.sumWinMoney ?? 0}',
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final record = state.yesterdayRecordList[index];
                      return MineGameRecordItem(
                          record: record,
                          itemEvent: () => logic.pushBetPage(record, 2));
                    },
                    childCount: state.yesterdayRecordList.length,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
