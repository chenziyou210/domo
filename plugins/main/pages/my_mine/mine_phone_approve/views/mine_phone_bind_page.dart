import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/common_widget/custom_gradientbutton/custom_gradientbutton.dart';
import 'package:star_common/config/app_layout.dart';
import '../mine_phone_approve_logic.dart';

class MinePhoneBindPage extends StatefulWidget {
  @override
  State<MinePhoneBindPage> createState() => _MinePhoneBindPageState();
}

class _MinePhoneBindPageState extends State<MinePhoneBindPage> {
  final logic = Get.find<MinePhoneApproveLogic>();
  final state = Get
      .find<MinePhoneApproveLogic>()
      .state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    state.phoneTEC.text = '';
    state.codeTEC.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        centerTitle: true,
        title: AppLayout.appBarTitle('手机认证'),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(
                AppLayout.pageSpace, 12.dp, AppLayout.pageSpace, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildCountry(context),
                _buildLine(),
                _buildPhoneNumber(),
                _buildLine(),
                _buildVerificationCode(),
                _buildLine(),
                SizedBox(height: 48.dp),
                Obx(() {
                  return Container(
                    width: double.infinity,
                    height: 40.dp,
                    padding: EdgeInsets.symmetric(horizontal: 16.dp),
                    child: GradientButton(
                      allowTap: state.approveStatus.value,
                      child: Text('认证', style: TextStyle(fontSize: 16.sp,
                          color: Colors.white),),
                      onPressed: () => logic.approveEvent(context),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountry(BuildContext context) {
    return Container(
      height: 55.dp,
      child: InkWell(
        child: Row(
          children: [
            AppLayout.textWhite16('国家与地区'),
            Obx(() {
              return Text('（+${state.area.value.tel}）${state.area.value.name}',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppMainColors.whiteColor100,
                  ));
            }).expanded(),
            SizedBox(width: 8.dp),
            Image.asset(R.comArrowRight, width: 16.dp, height: 16.dp)
          ],
        ),
        onTap: () => logic.pushCityListPage(context),
      ),
    );
  }

  Widget _buildLine() {
    return Container(
      height: 1.dp,
      color: AppMainColors.separaLineColor4,
    );
  }

  Widget _buildPhoneNumber() {
    return Container(
      height: 55.dp,
      child: Row(
        children: [
          Container(
            width: 80.dp,
            child: AppLayout.textWhite16('手机号码'),
          ),
          CustomTextField(
            controller: state.phoneTEC,
            textAlign: TextAlign.start,
            hintText: '请输入手机号码',
            keyboardType: TextInputType.phone,
            hintTextStyle:
            TextStyle(fontSize: 16.sp, color: AppMainColors.whiteColor20),
            style: TextStyle(
                fontSize: 16.sp, color: AppMainColors.whiteColor100),
            onChange: (_) => logic.updateApproveStatus(),
          ).expanded(),
        ],
      ),
    );
  }

  Widget _buildVerificationCode() {
    return Container(
      height: 55.dp,
      child: Row(
        children: [
          Container(
            width: 80.dp,
            child: AppLayout.textWhite16('验证码'),
          ),
          CustomTextField(
            controller: state.codeTEC,
            textAlign: TextAlign.start,
            hintText: '请输入验证码',
            keyboardType: TextInputType.phone,
            hintTextStyle:
            TextStyle(fontSize: 16.sp, color: AppMainColors.whiteColor20),
            style: TextStyle(
                fontSize: 16.sp, color: AppMainColors.whiteColor100),
            onChange: (_) => logic.updateApproveStatus(),
          ).expanded(),
          Container(
            height: 32.dp,
            width: 72.dp,
            child: Obx(
                  () {
                return GradientButton(
                  padding: EdgeInsets.all(0),
                  allowTap: state.codeStatus.value,
                  borderRadius: BorderRadius.circular(16.dp),
                  bgColor: state.codeStatus.value
                      ? AppMainColors.mainColor20
                      : AppMainColors.whiteColor20,
                  child: Text(
                    state.codeText.value,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: state.codeStatus.value ?
                      AppMainColors.mainColor : AppMainColors.whiteColor100,
                    ),
                  ),
                  onPressed: () => logic.codeEvent(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
