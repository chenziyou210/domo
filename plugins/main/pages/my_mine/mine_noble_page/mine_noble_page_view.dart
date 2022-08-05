import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';
import 'package:hjnzb/pages/my_mine/mine_noble_page/mine_noble_sub_page.dart';

import 'mine_noble_help/mine_noble_help_view.dart';
import 'mine_noble_page_logic.dart';
import 'mine_noble_page_state.dart';

/// @description: 贵族
/// @author
/// @date: 2022-06-12 17:44:45
class MineNoblePage extends StatelessWidget {
  final MineNoblePageLogic logic = Get.put(MineNoblePageLogic());
  final MineNoblePageState state = Get.find<MineNoblePageLogic>().state;

  MineNoblePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DefaultAppBar(
          title: CustomText("贵族",
              fontSize: 18.sp, fontWeight: w_500, color: Colors.white),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () {
                  Get.to(() =>MineNobleHelpPage());
                },
                child: Text(
                  "帮助",
                  style: TextStyle(
                      color: Colors.white, fontSize: 14.sp, fontWeight: w_400),
                ))
          ],
        ),
        body: GetBuilder<MineNoblePageLogic>(
            init: logic,
            global: false,
            builder: (c) {
              return Container(
                child: Column(
                  children: [
                    CustomTabBar1(
                      tabs: (_) {
                        return c.tabs.map((e) {
                          return Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                CustomText(e.name!).marginOnly(bottom: 4.dp),
                                !e.isSeledet
                                    ? SizedBox(
                                        height: 2.dp,
                                      )
                                    : Image.asset(
                                        R.tabsSeletedIcon,
                                        width: 12.dp,
                                        height: 2.dp,
                                        fit: BoxFit.fill,
                                      ),
                              ],
                            ),
                          );
                        }).toList();
                      },
                      onTap: (index) {
                        c.seledetd(index);
                      },
                      labelStyle: TextStyle(fontSize: 14.sp, fontWeight: w_400),
                      unselectedLabelStyle:
                          TextStyle(fontSize: 14.sp, fontWeight: w_400),
                      unselectedLabelColor: AppColors.main_white_opacity_7,
                      labelColor: Colors.white,
                      controller: c.state.tabController,
                      borderSide:
                          BorderSide(width: 0, color: Colors.transparent),
                      isScrollable: true,
                    ),
                    CustomTabBarView(
                      children: c.nobleDatas.map((d) {
                        return MineNobleSubPage(
                            data: d,
                            expiryTime: state.expireTime ?? "",
                            openType: c.openType,
                            callBack: (int type) {
                              c.openNobles(type);
                            });
                      }).toList(),
                      controller: c.state.tabController,
                      onPageChange: (index) {
                        c.seledetd(index);
                      },
                    ).expanded()
                  ],
                ),
              );
            }));
  }
}
