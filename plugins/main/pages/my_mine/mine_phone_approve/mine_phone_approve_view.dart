import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/config/app_layout.dart';
import 'mine_phone_approve_logic.dart';

class MinePhoneApprovePage extends StatefulWidget {
  @override
  State<MinePhoneApprovePage> createState() => _MinePhoneApprovePageState();
}

class _MinePhoneApprovePageState extends State<MinePhoneApprovePage> {
  final logic = Get.put(MinePhoneApproveLogic());
  final state = Get.find<MinePhoneApproveLogic>().state;

  @override
  Widget build(BuildContext context) {
    state.context = context;
    return Scaffold(
      appBar: DefaultAppBar(
        centerTitle: true,
        title: AppLayout.appBarTitle('账号安全'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Obx(() {
              return Container(
                padding: EdgeInsets.only(top: 36.dp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      state.phone.value.isEmpty
                          ? R.minePhoneSafeLow
                          : R.minePhoneSafeHigh,
                      width: 120.dp,
                      height: 120.dp,
                    ),
                    SizedBox(height: 16.dp),
                    AppLayout.textWhite16(
                        '安全等级-${state.phone.value.isEmpty ? '低' : '高'}'),
                    SizedBox(height: 24.dp),
                    Container(
                      padding: EdgeInsets.only(left: 16.dp),
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      height: 44.dp,
                      color: AppMainColors.whiteColor6,
                      child: Text(
                        state.phone.value.isEmpty ? '通过以下设置提高安全等级' : '您已经绑定了手机',
                        style: TextStyle(
                            color: AppMainColors.adornColor, fontSize: 14.sp),
                      ),
                    ),
                    _buildPhoneBindCard(context),
                  ],
                ),
              );
            }),
            _buildBottom(),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneBindCard(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.dp),
        child: Column(
          children: [
            Container(
              height: 55.dp,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppLayout.textWhite16('手机绑定').expanded(),
                  AppLayout.text70White14(
                      state.phone.value.isEmpty ? '去绑定' : state.phone.value),
                  state.phone.value.isEmpty
                      ? Image.asset(R.comArrowRight,
                          width: 16.dp, height: 16.dp)
                      : Container(),
                ],
              ),
            ),
            Container(
              height: 1.dp,
              color: AppMainColors.separaLineColor4,
            ),
          ],
        ),
      ),
      onTap: () {
        if (state.phone.value.isEmpty) {
          logic.pushBindPhone(context);
        }
      },
    );
  }

  Widget _buildBottom() {
    return Positioned(
      bottom: 40.dp,
      left: 0,
      right: 0,
      child: Container(
        child: Column(
          children: [
            AppLayout.text70White14('实名认证手机号码将用于以下功能'),
            SizedBox(height: 16.dp),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildBottomItem('手机登入', R.minePhoneBottom0),
                _buildBottomItem('安全认证', R.minePhoneBottom1),
                _buildBottomItem('收益', R.minePhoneBottom2),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomItem(String text, String imageText) {
    return Container(
      child: Column(
        children: [
          Image.asset(imageText, width: 40.dp, height: 40.dp),
          SizedBox(height: 4.dp,),
          AppLayout.text40White12(text),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
