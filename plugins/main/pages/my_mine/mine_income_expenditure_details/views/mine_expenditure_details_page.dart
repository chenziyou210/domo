import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hjnzb/pages/my_mine/mine_income_expenditure_details/mine_income_expenditure_details_state.dart';
import 'package:hjnzb/pages/my_mine/mine_income_expenditure_details/views/mine_details_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_common/lottie/lottie_view.dart';
import '../mine_income_expenditure_details_logic.dart';
import 'mine_customize_date.dart';
import 'mine_date_select.dart';

class MineIncomeDetailsPage extends StatelessWidget {
  MineIncomeDetailsPage({Key? key}) : super(key: key);

  final logic = Get.put(MineIncomeExpenditureDetailsLogic());
  final state = Get.find<MineIncomeExpenditureDetailsLogic>().state;

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          child: MineDateSelect(
            itemEvent: (type) => logic.expendituredDateSelectItemEvent(type),
            type: state.expenditureDateType,
          ),
        ),
        Positioned(
          left: 0,
          top: 40.dp,
          right: 0,
          child: GetBuilder<MineIncomeExpenditureDetailsLogic>(
            init: logic,
            id: DetailsType.expenditure,
            builder: (logic) {
              return state.expenditureList.isEmpty
                  ? Container()
                  : Container(
                padding: EdgeInsets.only(left: AppLayout.pageSpace),
                alignment: Alignment.centerLeft,
                height: 48.dp,
                child: Text(
                  '共支出${state.expenditureTotal}钻',
                  style: AppStyles.number14w4004white,
                ),
              );
            },
          ),
        ),
        Positioned(
          top: 88.dp,
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            child: _buildListView(),
          ),
        ),
        Positioned(
          left: 0,
          top: 40.dp,
          right: 0,
          child: _buildPanel(context),
        ),
      ],
    );
  }

  Widget _buildPanel(BuildContext context) {
    return Obx(() {
      return AnimatedCrossFade(
        firstCurve: Curves.easeInCirc,
        secondCurve: Curves.easeInToLinear,
        firstChild: Container(),
        secondChild: MineCustomizeDate(
          startDate: state.expenditureStartDate,
          endDate: state.expenditureEndDate,
          quitEvent: (startDate, endDate) {
            state.expenditureStartDate = startDate;
            state.expenditureEndDate = endDate;
            logic.expenditureTogglePanel();
          },
          sureEvent: (startDate, endDate) =>
              logic.expenditureCustomizeDateSureEvent(startDate, endDate),
        ),
        duration: Duration(milliseconds: 300),
        crossFadeState: state.expenditureCrossFadeState.value,
      );
    });
  }

  Widget _buildListView() {
    return SafeArea(
      child: GetBuilder<MineIncomeExpenditureDetailsLogic>(
        init: logic,
        id: DetailsType.expenditure,
        builder: (logic) {
          return SmartRefresher(
            controller: state.expenditureRefreshController,
            enablePullDown: true,
            header: LottieHeader(),
            footer: LottieFooter(),
            enablePullUp: true,
            onRefresh: () {
              state.expenditureLoadType = LoadType.refreshData;
              logic.loadExpenditureDetails();
            },
            onLoading: () {
              state.expenditureLoadType = LoadType.loadMoreData;
              logic.loadExpenditureDetails();
            },
            child: state.expenditureLoadType == LoadType.noData
                ? EmptyView(
                    emptyType: EmptyType.noData,
                  )
                : ListView.builder(
                    itemCount: state.expenditureList.length,
                    itemBuilder: (_, index) {
                      final detail = state.expenditureList[index];
                      return DetailsItem(
                          detail: detail, type: DetailsType.expenditure);
                    },
                  ),
          );
        },
      ),
    );
  }
}
