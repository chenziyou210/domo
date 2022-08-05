import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hjnzb/pages/upgrade/view.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/common_widget/custom_gradientbutton/custom_gradientbutton.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/config/app_layout.dart';
import '../my_mine_setting_logic.dart';
import '../my_mine_setting_state.dart';
import 'my_mine_aboutus_logic.dart';
import 'my_mine_aboutus_state.dart';

/// @description:
/// @author
/// @date: 2022-07-14 17:01:50
class MyMineAboutusPage extends StatelessWidget with Toast {
  final MyMineAboutusLogic logic = Get.put(MyMineAboutusLogic());
  final MyMineAboutusState state = Get.find<MyMineAboutusLogic>().state;
  final MyMineSettingState vesionState = Get.find<MyMineSettingLogic>().state;
  MyMineAboutusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logic.checkUpdate();
    return Scaffold(
        appBar: DefaultAppBar(
          title: AppLayout.appBarTitle('版本信息'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: GetBuilder<MyMineAboutusLogic>(
            builder: (c) {
              return Container(
                padding: EdgeInsets.only(bottom: 44, top: 0),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      R.aboutLogo,
                      width: 96.dp,
                      height: 96.dp,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "当前版本 v${vesionState.version}",
                      style: TextStyle(
                          color: AppMainColors.whiteColor100, fontSize: 16),
                    ),
                    SizedBox(height: 24),
                    Obx(() {
                      if (state.needUpdate.value) {
                        return GradientButton(
                          onPressed: () => checkVersionUpdate(context),
                          child: CustomText(
                            '发现新版本，立即更新',
                            fontSize: 12.sp,
                            color: Colors.white,
                          ),
                        );
                      }else{
                        return Container();
                      }
                    }),
                  ],
                ),
              );
            },
          ),
        ));
  }

  void checkVersionUpdate(context) {
    checkUpgrade(
      context: context,
      onError: (error) {
        showToast(error);
      },
    );
  }

}
