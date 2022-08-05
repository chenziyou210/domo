import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/config/app_layout.dart';
import 'mine_backpack_logic.dart';
import 'views/mine_bag_page.dart';
import 'views/mine_car_page.dart';

class MineBackpackPage extends StatefulWidget {
  @override
  State<MineBackpackPage> createState() => _MineBackpackPageState();
}

class _MineBackpackPageState extends State<MineBackpackPage>
    with SingleTickerProviderStateMixin {
  final logic = Get.find<MineBackpackLogic>();
  final state = Get.find<MineBackpackLogic>().state;
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    logic.loadCarList(true);
    logic.loadPackageList();
  }

  @override
  Widget build(BuildContext context) {
    state.context = context;
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
          MineCarPage(),
          MineBagPage(),
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
