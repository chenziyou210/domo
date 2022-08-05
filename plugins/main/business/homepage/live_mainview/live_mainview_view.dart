import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hjnzb/business/homepage/home_list_views/homepage_view.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/common_widget/search_barview.dart';
import 'package:star_common/common/toast.dart';
import '../../../pages/tab/tabbar_control/coutom_tabbar.dart' as Coustom;

import 'live_mainview_logic.dart';
import 'package:star_common/base/app_base.dart';

class LiveMainViewPage extends StatefulWidget {
  LiveMainViewPage({Key? key}) : super(key: key);

  @override
  State<LiveMainViewPage> createState() => _LiveMainViewPageState();
}

class _LiveMainViewPageState extends AppStateBase<LiveMainViewPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin, Toast {
  final logic = Get.put(LiveMainViewPageLogic());
  final state = Get.find<LiveMainViewPageLogic>().state;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        //底黑
        Container(
          color: AppMainColors.backgroudColor,
        ).positionFill(),
        //渐变图
        Image.asset(
          R.homeTopBg,
          fit: BoxFit.cover,
          height: 128,
          width: context.width,
        ),
        // Opacity(opacity: 0.1 ,
        //   child: Container(
        //     decoration: BoxDecoration(
        //         gradient: LinearGradient(
        //           colors: [Color(0xFFFB44FF),Color(0xFF67EDFF), Color(0xFFFF4466)],
        //           begin: Alignment.topLeft,
        //           end: Alignment.bottomRight,
        //         )
        //     ),
        //   ),
        // ).positionFill(),
        //内容
        scaffold.positionFill(),
      ],
    );
  }

  @override
  PreferredSizeWidget get appBar => SearchAppBarPage(
        leftWidget: Container(
          width: 42.dp,
          height: 42.dp,
          alignment: Alignment.center,
          // color: Colors.blueGrey,
          child: Image.asset(
            R.appLogo,
            width: 32.dp,
            height: 32.dp,
            fit: BoxFit.cover,
          ),
        ),
        tfEnable: false, //不允许点击 就可以tfWidget 能响应点击事件
        rightWidget: Center(
          child: Container(
            width: 60,
            height: 32.dp,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 10),
            // margin: EdgeInsets.only(left: 10, right: 10,top: 10,bottom: 10),
            decoration: BoxDecoration(
                color: AppMainColors.whiteColor15,
                borderRadius: BorderRadius.circular(20)),
            child: Image.asset(
              R.iconHomeRank,
              width: 24.dp,
              height: 24.dp,
              fit: BoxFit.cover,
            ),
          ).gestureDetector(onTap: () {
            logic.pushHomeRankingPage(context);
          }),
        ),
        onPressedMiddle: () {
          logic.pushHomeSearchPage(context);
        },
      );

  @override
  // // TODO: implement body
  Widget get body => GetBuilder<LiveMainViewPageLogic>(
        builder: (logic) {
          return Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                height: 40,
                // color: Colors.brown,
                child: Coustom.TabBar(
                  tabs: state.tabItems.map((e) {
                    return Container(
                        alignment: Alignment.bottomCenter,
                        child: CustomText(
                          "${e.name}",
                        ) //, textAlign: TextAlign.center
                        );
                  }).toList(),
                  labelStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                  unselectedLabelStyle: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w300),
                  unselectedLabelColor: AppMainColors.whiteColor70,
                  labelColor: AppMainColors.whiteColor100,
                  controller: state.controller,
                  isScrollable: true,
                  labelPadding:
                      EdgeInsets.only(bottom: 10, left: 11, right: 11),
                  indicatorWeight: 0.1,
                  indicatorPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  // indicator: UnderlineTabIndicatorCustom(width: 0, borderSide: BorderSide()),
                ),
              ),
              CustomTabBarView(
                controller: state.controller,
                children: state.tabItems.map((e) {
                  late HomeListWidgets view;

                  print("这里吗 ${state.listMap}");
                  if (state.listMap.containsKey(e.id)) {
                    view = state.listMap[e.id]! as HomeListWidgets;

                  } else {
                    view = HomeListWidgets(e.id!);
                    state.listMap[e.id!] = view;

                  }
                  return view;

                }).toList(),
                onPageChange: (index) {
                  int tabId = logic.currentTabId(index);
                  HomeListWidgets view =
                      state.listMap[tabId]! as HomeListWidgets;
                  view.changeCurrentType();
                },
              ).expanded(),

              // CustomTabBar(
              //   tabs: (_) => state.tabItems.map((e) {
              //     return Container(
              //         alignment: Alignment.bottomCenter,
              //         child: CustomText(
              //           "${e.name}",
              //         ) //, textAlign: TextAlign.center
              //     );
              //   }).toList(),
              //   labelStyle: TextStyle(fontSize: 18),
              //   unselectedLabelStyle: TextStyle(fontSize: 14),
              //   unselectedLabelColor: AppMainColors.whiteColor70,
              //   labelColor: AppMainColors.whiteColor100,
              //   controller: state.controller,
              //   borderSide: BorderSide(width: 0, color: Colors.transparent),
              //   isScrollable: true,
              // ),
              // CustomTabBarView(
              //   controller: state.controller,
              //   children: state.tabItems.map((e) {
              //     late HomeListWidgets view;
              //     if(state.listMap.containsKey(e.id)){
              //       view = state.listMap[e.id]! as HomeListWidgets;
              //
              //     }else{
              //       view = HomeListWidgets(e.id);
              //       state.listMap[e.id!] = view;
              //     }
              //     return view;
              //
              //   }).toList(),
              //   onPageChange: (index){
              //     int tabId = logic.currentTabId(index);
              //     HomeListWidgets view = state.listMap[tabId]! as HomeListWidgets;
              //     view.changeCurrentType(tabId);
              //   },
              //
              // ).expanded(),
            ],
          );
        },
      );
}
