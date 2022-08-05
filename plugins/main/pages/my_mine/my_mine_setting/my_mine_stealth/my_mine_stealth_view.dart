import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/cache.dart';
import 'package:star_common/manager/app_manager.dart';

import 'my_mine_stealth_logic.dart';
import 'my_mine_stealth_state.dart';

/// @description:
/// @author
/// @date: 2022-06-26 11:30:26
class MyMineStealthPage extends StatelessWidget with Toast {
  final MyMineStealthLogic logic = Get.put(MyMineStealthLogic());
  final MyMineStealthState state = Get.find<MyMineStealthLogic>().state;

  MyMineStealthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DefaultAppBar(
          title: CustomText("设置贵族隐身", fontSize: 18.sp, color: Colors.white),
          centerTitle: true,
        ),
        body: SafeArea(
          child: GetBuilder<MyMineStealthLogic>(
            builder: (c) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16.dp),
                child: ListView.builder(
                    itemCount: state.firstList.length,
                    itemBuilder: (c, i) {
                      return item(state.firstList[i], i).inkWell(onTap: () {
                        switch (i) {
                          case 0:
                            // logic.gotoChangePassword(context);

                            break;
                          default:
                        }
                      });
                    }),
              );
            },
          ),
        ));
  }

  Widget item(String namme, int index) {
    return Column(
      children: [
        SizedBox(
          height: 8.dp,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              namme,
              style:
                  TextStyle(color: AppMainColors.whiteColor70, fontSize: 14.dp),
            ),
            rightView(index),
          ],
        ),
        SizedBox(
          height: 8.dp,
        ),
        Container(
          height: 0.5.dp,
          color: AppMainColors.whiteColor10,
        ),
      ],
    );
  }

  Widget rightView(int index) {
    String iamges = R.icSettingC;
    switch (index) {
      case 0:
        iamges = state.enterHide == 1
            ? R.icSettingO
            : R.icSettingC;
        break;
      case 1:
        iamges = state.rankListHide == 1
            ? R.icSettingO
            : R.icSettingC;
        break;
    }
    return Padding(
      padding: EdgeInsets.only(left: 8.dp),
      child: Image.asset(
        iamges,
        width: 40.dp,
        height: 40.dp,
      ),
    ).inkWell(onTap: () {
      var level = AppManager.getInstance<AppUser>().nobleLevel;
      switch (index) {
        case 0:
          if (level == 1005 || level == 1006 || level == 1007) {
            if (state.enterHide == 0) {
              state.enterHide = 1;
            } else {
              state.enterHide = 0;
            }

            logic.setNobelHideStatus(state.rankListHide, state.enterHide).then(
                (value) => AppCacheManager.cache
                    .setisAdmissionStealthOpen(state.enterHide == 1));
          } else {
            showToast("需开通对应贵族才可设置");
          }
          // state.enterHide = !state.enterHide;
          break;
        case 1:
          //国王，榜单隐身
          if (level == 1007) {
            if (state.rankListHide == 0) {
              state.rankListHide = 1;
            } else {
              state.rankListHide = 0;
            }
            // state.isListStealthOpen = !state.isListStealthOpen;
            logic.setNobelHideStatus(state.rankListHide, state.enterHide).then(
                (value) => AppCacheManager.cache
                    .setisListStealthOpen(state.rankListHide == 1));
          } else {
            showToast("需开通对应贵族才可设置");
          }

          break;
      }
    });
  }
}
