import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hjnzb/pages/my_mine/mine_income_expenditure_details/mine_income_expenditure_details_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_common/lottie/lottie_view.dart';
import '../mine_income_expenditure_details_logic.dart';
import 'mine_customize_date.dart';
import 'mine_date_select.dart';
import 'mine_details_item.dart';

class MineExpenditureDetailsPage extends StatelessWidget {
  MineExpenditureDetailsPage({Key? key}) : super(key: key);

  final logic = Get.put(MineIncomeExpenditureDetailsLogic());
  final state = Get.find<MineIncomeExpenditureDetailsLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          child: MineDateSelect(
            itemEvent: (type) => logic.incomeDateSelectItemEvent(type),
            type: state.incomeDateType,
          ),
        ),
        Positioned(
          left: 0,
          top: 40.dp,
          right: 0,
          child: GetBuilder<MineIncomeExpenditureDetailsLogic>(
            init: logic,
            id: DetailsType.income,
            builder: (logic) {
              return state.incomeList.isEmpty
                  ? Container()
                  : Container(
                padding: EdgeInsets.only(left: AppLayout.pageSpace),
                alignment: Alignment.centerLeft,
                height: 48.dp,
                child: Text(
                  '共收入${state.incomeTotal}钻',
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
          startDate: state.incomeStartDate,
          endDate: state.incomeEndDate,
          quitEvent: (startDate, endDate) {
            state.incomeStartDate = startDate;
            state.incomeStartDate = endDate;
            logic.incomeTogglePanel();
          },
          sureEvent: (startDate, endDate) =>
              logic.incomeCustomizeDateSureEvent(startDate, endDate),
        ),
        duration: Duration(milliseconds: 300),
        crossFadeState: state.incomeCrossFadeState.value,
      );
    });
  }

  Widget _buildListView() {
    return SafeArea(
      child: GetBuilder<MineIncomeExpenditureDetailsLogic>(
        init: logic,
        id: DetailsType.income,
        builder: (logic) {
          return SmartRefresher(
            controller: state.incomeRefreshController,
            enablePullDown: true,
            header: LottieHeader(),
            footer: LottieFooter(),
            enablePullUp: true,
            onRefresh: () {
              state.incomeLoadType = LoadType.refreshData;
              logic.loadIncomeDetails();
            },
            onLoading: () {
              state.incomeLoadType = LoadType.loadMoreData;
              logic.loadIncomeDetails();
            },
            child: state.incomeLoadType == LoadType.noData
                ? EmptyView(
                    emptyType: EmptyType.noData,
                  )
                : ListView.builder(
                    itemCount: state.incomeList.length,
                    itemBuilder: (_, index) {
                      final detail = state.incomeList[index];
                      return DetailsItem(
                          detail: detail, type: DetailsType.income);
                    },
                  ),
          );
        },
      ),
    );
  }
}
