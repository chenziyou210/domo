import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hjnzb/pages/my_mine/mine_income_expenditure_details/views/mine_date_select.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/http_channel.dart';
import 'mine_income_expenditure_details_state.dart';
import 'models/income_expenditure_detail_model.dart';
import 'package:intl/intl.dart';

class MineIncomeExpenditureDetailsLogic extends GetxController with Toast {
  final MineIncomeExpenditureDetailsState state =
      MineIncomeExpenditureDetailsState();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    loadExpenditureDetails();
    loadIncomeDetails();
  }

  /// 消费明细
  void expendituredDateSelectItemEvent(DateSelectItemTypes type) {
    if (type == DateSelectItemTypes.customize) {
      state.expenditureDateType = type;
      expenditureTogglePanel();
    } else {
      if (state.expenditureDateType != type) {
        state.expenditureDateType = type;
        if (state.expenditureCrossFadeState.value ==
            CrossFadeState.showSecond) {
          state.expenditureCrossFadeState.value = CrossFadeState.showFirst;
        }
        state.expenditureLoadType = LoadType.loadingData;
        loadExpenditureDetails();
      }
    }
  }

  void expenditureCustomizeDateSureEvent(DateTime startDate, DateTime endDate) {
    if (startDate.compareTo(endDate) <= 0) {
      expenditureTogglePanel();
      state.expenditureStartDate = startDate;
      state.expenditureEndDate = endDate;
      state.expenditureLoadType = LoadType.loadingData;
      loadExpenditureDetails();
    } else {
      showToast('开始时间要小于结束时间');
    }
  }

  void expenditureTogglePanel() {
    state.expenditureCrossFadeState.value =
        state.expenditureCrossFadeState.value == CrossFadeState.showFirst
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst;
  }

  void loadExpenditureDetails() {
    switch (state.expenditureLoadType) {
      case LoadType.refreshData:
        state.expenditurePage = 1;
        state.expenditureList = [];
        break;
      case LoadType.loadingData:
        show();
        state.expenditurePage = 1;
        state.expenditureList = [];
        break;
      case LoadType.loadMoreData:
        state.expenditurePage++;
        break;
      default:
        break;
    }

    final startTime = getStartTimeWithType(
        state.expenditureDateType, state.expenditureStartDate);
    final endTime =
        getEndTimeWithType(state.expenditureDateType, state.expenditureEndDate);

    HttpChannel.channel
        .accountDetail(
      page: state.expenditurePage,
      type: 2,
      startTime: startTime,
      endTime: endTime,
    )
        .then((value) {
      state.expenditureRefreshController.refreshCompleted();
      state.expenditureRefreshController.loadComplete();
      dismiss();
      value.finalize(
          wrapper: WrapperModel(),
          failure: (e) => showToast(e),
          success: (data) {
            final incomeExpenditureDetails =
                incomeExpenditureDetailsFromJson(data);
            final expenditureTotal =
                (incomeExpenditureDetails.totalAmount ?? 0).toString();
            final expenditureList = incomeExpenditureDetails.data ?? [];
            if (expenditureList.isEmpty &&
                state.expenditureLoadType == LoadType.loadMoreData) {
              state.expenditureLoadType = LoadType.noMoreData;
              state.expenditureRefreshController.loadNoData();
            } else if (expenditureList.isEmpty &&
                (state.expenditureLoadType == LoadType.refreshData ||
                    state.expenditureLoadType == LoadType.loadingData)) {
              state.expenditureLoadType = LoadType.noData;
            } else {
              state.expenditureList.addAll(expenditureList);
            }
            state.expenditureTotal = expenditureTotal;
            update([DetailsType.expenditure]);
          });
    });
  }

  /// 收入明细
  void incomeDateSelectItemEvent(DateSelectItemTypes type) {
    if (type == DateSelectItemTypes.customize) {
      state.incomeDateType = type;
      incomeTogglePanel();
    } else {
      if (state.incomeDateType != type) {
        state.incomeDateType = type;
        if (state.incomeCrossFadeState.value == CrossFadeState.showSecond) {
          state.incomeCrossFadeState.value = CrossFadeState.showFirst;
        }
        state.incomeLoadType = LoadType.loadingData;
        loadIncomeDetails();
      }
    }
  }

  void incomeCustomizeDateSureEvent(DateTime startDate, DateTime endDate) {
    if (startDate.compareTo(endDate) <= 0) {
      incomeTogglePanel();
      state.incomeStartDate = startDate;
      state.incomeEndDate = endDate;
      state.incomeLoadType = LoadType.loadingData;
      loadIncomeDetails();
    } else {
      showToast('开始时间要小于结束时间');
    }
  }

  void incomeTogglePanel() {
    state.incomeCrossFadeState.value =
        state.incomeCrossFadeState.value == CrossFadeState.showFirst
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst;
  }

  void loadIncomeDetails() {
    switch (state.incomeLoadType) {
      case LoadType.refreshData:
        state.incomePage = 1;
        state.incomeList = [];
        break;
      case LoadType.loadingData:
        show();
        state.incomePage = 1;
        state.incomeList = [];
        break;
      case LoadType.loadMoreData:
        state.incomePage++;
        break;
      default:
        break;
    }

    final startTime =
        getStartTimeWithType(state.incomeDateType, state.incomeStartDate);
    final endTime =
        getEndTimeWithType(state.incomeDateType, state.incomeEndDate);

    HttpChannel.channel
        .accountDetail(
      page: state.incomePage,
      type: 1,
      startTime: startTime,
      endTime: endTime,
    )
        .then((value) {
      state.incomeRefreshController.refreshCompleted();
      state.incomeRefreshController.loadComplete();
      dismiss();
      value.finalize(
          wrapper: WrapperModel(),
          failure: (e) => showToast(e),
          success: (data) {
            final incomeExpenditureDetails =
                incomeExpenditureDetailsFromJson(data);
            final incomeTotal =
                (incomeExpenditureDetails.totalAmount ?? 0).toString();
            final incomeList = incomeExpenditureDetails.data ?? [];
            if (incomeList.isEmpty &&
                state.incomeLoadType == LoadType.loadMoreData) {
              state.incomeLoadType = LoadType.noMoreData;
              state.incomeRefreshController.loadNoData();
            } else if (incomeList.isEmpty &&
                (state.incomeLoadType == LoadType.refreshData ||
                    state.incomeLoadType == LoadType.loadingData)) {
              state.incomeLoadType = LoadType.noData;
            } else {
              state.incomeList.addAll(incomeList);
            }
            state.incomeTotal = incomeTotal;
            update([DetailsType.income]);
          });
    });
  }

  String getStartTimeWithType(DateSelectItemTypes type, DateTime date) {
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(Duration(days: 1));
    DateTime sevenday = now.subtract(Duration(days: 7));
    DateTime thirtyday = now.subtract(Duration(days: 30));
    String startTime = '';
    String spliceTime = '00:00:00';
    switch (type) {
      case DateSelectItemTypes.today:
        startTime = '${DateFormat('yyyy-MM-dd').format(now)} $spliceTime';
        break;
      case DateSelectItemTypes.yesterday:
        startTime = '${DateFormat('yyyy-MM-dd').format(yesterday)} $spliceTime';
        break;
      case DateSelectItemTypes.sevenday:
        startTime = '${DateFormat('yyyy-MM-dd').format(sevenday)} $spliceTime';
        break;
      case DateSelectItemTypes.thirtyday:
        startTime = '${DateFormat('yyyy-MM-dd').format(thirtyday)} $spliceTime';
        break;
      case DateSelectItemTypes.customize:
        startTime = '${DateFormat('yyyy-MM-dd').format(date)} $spliceTime';
        break;
    }
    return startTime;
  }

  String getEndTimeWithType(DateSelectItemTypes type, DateTime date) {
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(Duration(days: 1));
    String spliceTime = '23:59:59';
    String endTime = '${DateFormat('yyyy-MM-dd').format(now)} $spliceTime';
    if (type == DateSelectItemTypes.yesterday) {
      endTime = '${DateFormat('yyyy-MM-dd').format(yesterday)} $spliceTime';
    }
    if (type == DateSelectItemTypes.customize) {
      endTime = '${DateFormat('yyyy-MM-dd').format(date)} $spliceTime';
    }
    return endTime;
  }
}
