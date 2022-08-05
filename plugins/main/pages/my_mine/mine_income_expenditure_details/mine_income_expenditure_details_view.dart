import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:hjnzb/pages/my_mine/mine_income_expenditure_details/views/mine_expenditure_details_page.dart';
import 'package:hjnzb/pages/my_mine/mine_income_expenditure_details/views/mine_income_details_page.dart';
import 'package:star_common/config/app_layout.dart';
import 'mine_income_expenditure_details_logic.dart';

class MineIncomeExpenditureDetailsPage extends StatefulWidget {
  @override
  State<MineIncomeExpenditureDetailsPage> createState() =>
      _MineIncomeExpenditureDetailsPageState();
}

class _MineIncomeExpenditureDetailsPageState
    extends State<MineIncomeExpenditureDetailsPage>
    with SingleTickerProviderStateMixin {
  final logic = Get.put(MineIncomeExpenditureDetailsLogic());
  final state = Get.find<MineIncomeExpenditureDetailsLogic>().state;
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        centerTitle: true,
        title: TabBar(
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
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MineIncomeDetailsPage(),
          MineExpenditureDetailsPage(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }
}
