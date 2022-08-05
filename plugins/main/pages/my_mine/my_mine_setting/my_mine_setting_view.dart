// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/common_widget/custom_gradientbutton/custom_gradientbutton.dart';
import 'package:star_common/http/cache.dart';

import 'my_mine_setting_logic.dart';
import 'my_mine_setting_state.dart';

/// @description:
/// @author
/// @date: 2022-05-25 11:30:29
class MyMineSettingPage extends StatelessWidget {
  final MyMineSettingLogic logic = Get.find<MyMineSettingLogic>();
  final MyMineSettingState state = Get.find<MyMineSettingLogic>().state;

  MyMineSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DefaultAppBar(
          title: CustomText("设置", fontSize: 18.dp, color: Colors.white),
          centerTitle: true,
        ),
        body: SafeArea(
          child: GetBuilder<MyMineSettingLogic>(
            builder: (c) {
              return Container(
                padding: EdgeInsets.only(left: 8.dp, right: 8.dp),
                child: ListView.builder(
                    // itemCount: state.firstList.length, //不过滤应用锁
                    itemCount: state.firstList.length - 1, //过滤应用锁
                    itemBuilder: (c, i) {
                      // return i == state.firstList.length - 1 //不过滤应用锁
                      var index = i; //过滤应用锁
                      if (i > 1) {
                        //过滤应用锁
                        index = index + 1; //过滤应用锁
                      } //过滤应用锁
                      return index == state.firstList.length - 1 //过滤应用锁
                          ? but(context)
                          // : item(state.firstList[i], i).inkWell(onTap: () {  //过滤应用锁
                          : item(state.firstList[index], index).inkWell(
                              onTap: () {
                              switch (index) {
                                case 0:
                                  logic.gotoChangePassword(context);
                                  break;
                                case 1:
                                  logic.gotoStealth(context);
                                  break;
                                case 5:
                                  logic.gotoAbouts(context);
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.dp),
      child: Column(
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
                    TextStyle(color: AppMainColors.whiteColor100, fontSize: 16),
              ),
              rightView(state.endList[index], index),
            ],
          ),
          SizedBox(
            height: 8.dp,
          ),
          Container(
            height: 1,
            color: AppMainColors.whiteColor6,
          ),
        ],
      ),
    );
  }

  Widget rightView(int type, int index) {
    String iamges = R.icSettingC;
    switch (index) {
      case 2:
        iamges =
            state.isLockOpen ? R.icSettingO : R.icSettingC;
        break;
      case 3:
        iamges =
        AppCacheManager.cache.getiGiftOpen()==false ? R.icSettingO : R.icSettingC;
        break;
      case 4:
        iamges =
        AppCacheManager.cache.getiDriveOpen()==false ? R.icSettingO : R.icSettingC;
        break;
    }

    Widget view = Container();
    switch (type) {
      case 1:
        view = Row(
          children: [
            Text(
              index == 0 ? logic.title() : '',
              style:
                  TextStyle(color: AppMainColors.whiteColor70, fontSize: 14.dp),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 8.dp, top: 10.dp, bottom: 10.dp),
              child: Image.asset(
                R.icRightArrow,
                width: 20.dp,
                height: 20.dp,
                color: AppMainColors.whiteColor70,
              ),
            ),
          ],
        );
        break;
      case 2:
        view = Padding(
          padding: EdgeInsets.only(left: 8.dp),
          child: Image.asset(
            iamges,
            width: 40.dp,
            height: 40.dp,
          ),
        ).inkWell(onTap: () {
          switch (index) {
            case 2:
              state.isLockOpen = !state.isLockOpen;
              logic.update();
              AppCacheManager.cache.setisLockOpen(state.isLockOpen);
              break;
            case 3:
              state.isGiftOpen = !state.isGiftOpen;
              logic.update();
              AppCacheManager.cache.setisGiftOpen(!state.isGiftOpen);
              break;
            case 4:
              state.isDriveOpen = !state.isDriveOpen;
              logic.update();
              AppCacheManager.cache.setisDriveOpen(!state.isDriveOpen);
              break;
          }
        });
        break;
      case 3: //版本
        logic.getPackageInfo();
        view = Row(
          children: [
            Text(
              "v${state.version}",
              style:
                  TextStyle(color: AppMainColors.whiteColor70, fontSize: 14.dp),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.dp, bottom: 10.dp),
              child: Image.asset(
                R.icRightArrow,
                width: 20.dp,
                height: 20.dp,
                color: AppMainColors.whiteColor70,
              ),
            ),
          ],
        );
        break;
      default:
    }
    return view;
  }

  Widget but(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 48),
      child: Container(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: GradientButton(
          child: Text(
            '切换账号',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          onPressed: () {
            logic.loginOut(context,isChangeLogin: true);
          },
        ),
      ),
    );
  }
}
