import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hjnzb/pages/my_mine/mine_income_expenditure_details/views/mine_date_select.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'models/income_expenditure_detail_model.dart';

enum DetailsType { expenditure, income }

enum LoadType {
  refreshData,
  loadingData,
  loadMoreData,
  noMoreData,
  noData,
}

class MineIncomeExpenditureDetailsState {
  final List<String> titles = ["消费明细", "收入明细"];
  late RefreshController expenditureRefreshController;
  late RefreshController incomeRefreshController;
  // 时间选择类型
  late DateSelectItemTypes expenditureDateType;
  late DateSelectItemTypes incomeDateType;
  // 数据请求页数
  late int expenditurePage;
  late int incomePage;
  // 自定义时间选择器起始时间
  late DateTime expenditureStartDate;
  late DateTime expenditureEndDate;
  late DateTime incomeStartDate;
  late DateTime incomeEndDate;
  // 数据请求状态
  late LoadType expenditureLoadType;
  late LoadType incomeLoadType;
  // 自定义时间选择展开折叠状态
  final expenditureCrossFadeState = CrossFadeState.showFirst.obs;
  final incomeCrossFadeState = CrossFadeState.showFirst.obs;
  // 共支出收入砖石数
  late String expenditureTotal = '';
  late String incomeTotal = '';
  // 数据列表
  late List<Detail> expenditureList;
  late List<Detail> incomeList;

  MineIncomeExpenditureDetailsState() {
    expenditurePage = 1;
    incomePage = 1;
    expenditureStartDate = DateTime.now();
    expenditureEndDate = DateTime.now();
    incomeStartDate = DateTime.now();
    incomeEndDate = DateTime.now();
    expenditureRefreshController = RefreshController();
    incomeRefreshController = RefreshController();
    expenditureDateType = DateSelectItemTypes.today;
    incomeDateType = DateSelectItemTypes.today;
    expenditureLoadType = LoadType.loadingData;
    incomeLoadType = LoadType.loadingData;
    expenditureCrossFadeState.value = CrossFadeState.showFirst;
    incomeCrossFadeState.value = CrossFadeState.showFirst;
    expenditureList = [];
    incomeList = [];
  }
}
