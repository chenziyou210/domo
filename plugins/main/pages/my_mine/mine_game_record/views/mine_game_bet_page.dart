import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hjnzb/pages/my_mine/mine_game_record/mine_game_record_state.dart';
import 'package:hjnzb/pages/my_mine/mine_game_record/models/gane_bet_record_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_common/lottie/lottie_view.dart';
import '../mine_game_record_logic.dart';
import 'mine_game_record_content_item.dart';
import 'mine_game_record_header.dart';

class MineGameBetPage extends StatelessWidget {
  MineGameBetPage({Key? key}) : super(key: key);

  final logic = Get.find<MineGameRecordLogic>();
  final state = Get.find<MineGameRecordLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DefaultAppBar(
          title: AppLayout.appBarTitle('游戏注单'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.dp),
            child: GetBuilder<MineGameRecordLogic>(builder: (logic) {
              return (state.loadType == LoadType.noData || state.loadType == LoadType.loadingData) ? Container() : MineGameRecordHeader(
                  betAmount: state.record.bet ?? '',
                  bonusAmount: state.record.win ?? '');
            }),
          ),
          centerTitle: true,
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    return SafeArea(
      child: GetBuilder<MineGameRecordLogic>(
        builder: (logic) {
          return SmartRefresher(
            controller: state.betRefreshController,
            enablePullDown: true,
            header: LottieHeader(),
            footer: LottieFooter(),
            enablePullUp: true,
            onRefresh: () {
              state.loadType = LoadType.refreshData;
              logic.loadGameBetRecord();
            },
            onLoading: () {
              state.loadType = LoadType.loadMoreData;
              logic.loadGameBetRecord();
            },
            child: state.loadType == LoadType.noData ? EmptyView(emptyType: EmptyType.noRecord) : ListView.builder(
              itemCount: state.betRecordList.length,
              itemBuilder: (context, index) {
                final betRecord = state.betRecordList[index];
                return _buildCell(betRecord);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildCell(GameBetRecord betRecord) {
    return Container(
      padding:
          EdgeInsets.fromLTRB(AppLayout.pageSpace, 12.dp, AppLayout.pageSpace, 0),
      color: AppMainColors.whiteColor6,
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppLayout.textWhite14(betRecord.gameName ?? ''),
                AppLayout.text40White14(betRecord.createTime ?? ''),
              ],
            ),
          ),
          SizedBox(height: 8.dp),
          Container(
            child: Row(
              children: [
                MineGameRecordContentItem(
                    title: '下注金额',
                    value: betRecord.bet ?? '',
                    valueColor: AppMainColors.string2Color('#78FFA6')),
                SizedBox(width: 100.dp),
                MineGameRecordContentItem(
                    title: '中奖金额',
                    value: betRecord.win ?? '',
                    valueColor: AppMainColors.string2Color('#32C5FF')),
              ],
            ),
          ),
          SizedBox(height: 12.dp),
          Container(
            height: 1.dp,
            color: AppMainColors.whiteColor6,
          ),
        ],
      ),
    );
  }
}
