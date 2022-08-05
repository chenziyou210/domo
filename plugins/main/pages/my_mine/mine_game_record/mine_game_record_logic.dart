import 'package:get/get.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/router/router_config.dart';
import 'mine_game_record_state.dart';
import 'models/game_record_model.dart';
import 'models/gane_bet_record_model.dart';

class MineGameRecordLogic extends GetxController with Toast {
  final MineGameRecordState state = MineGameRecordState();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    loadTodayGameRecord(true);
    loadYesterdayGameRecord(false);
  }

  void loadTodayGameRecord(bool needActivity) {
    if (needActivity) show();
    HttpChannel.channel.gameRecordList(type: 1).then((value) {
      state.todayRefreshController.refreshCompleted();
      dismiss();
      state.onLoading = false;
      value.finalize(
          wrapper: WrapperModel(),
          failure: (e) => showToast(e),
          success: (data) {
            final gameRecord = gameRecordFromJson(data);
            state.todayGameRecord = gameRecord;
            state.todayRecordList = gameRecord.record ?? [];
            update([GameRecordType.today]);
          });
    });
  }

  void loadYesterdayGameRecord(bool needActivity) {
    if (needActivity) show();
    HttpChannel.channel.gameRecordList(type: 2).then((value) {
      state.yesterdayRefreshController.refreshCompleted();
      dismiss();
      value.finalize(
          wrapper: WrapperModel(),
          failure: (e) => showToast(e),
          success: (data) {
            final gameRecord = gameRecordFromJson(data);
            state.yesterdayGameRecord = gameRecord;
            state.yesterdayRecordList = gameRecord.record ?? [];
            update([GameRecordType.yesterday]);
          });
    });
  }

  void loadGameBetRecord() {
    switch (state.loadType) {
      case LoadType.refreshData:
        state.page = 1;
        state.betRecordList = [];
        break;
      case LoadType.loadingData:
        show();
        state.page = 1;
        state.betRecordList = [];
        break;
      case LoadType.loadMoreData:
        state.page++;
        break;
      default:
        break;
    }
    HttpChannel.channel
        .gameBetRecordList(
            pageNum: state.page,
            companyId: state.record.companyId ?? '',
            type: state.type)
        .then((value) {
      state.betRefreshController.refreshCompleted();
      state.betRefreshController.loadComplete();
      dismiss();
      value.finalize(
          wrapper: WrapperModel(),
          failure: (e) => showToast(e),
          success: (data) {
            List lst = data['data'] ?? [];
            List<GameBetRecord> d =
                lst.map((e) => gameBetRecordFromJson(e)).toList();
            if (d.isEmpty) {
              if(state.page == 1) {
                state.loadType = LoadType.noData;
              }else{
                state.loadType = LoadType.noMoreData;
                state.betRefreshController.loadNoData();
              }
            } else {
              state.betRecordList.addAll(d);
            }
            update();
          });
    });
  }

  void pushBetPage(Record record, int type) {
    state.type = type;
    state.record = record;
    Get.toNamed(AppRoutes.mineGameBetPage);
    state.loadType = LoadType.loadingData;
    loadGameBetRecord();
  }
}
