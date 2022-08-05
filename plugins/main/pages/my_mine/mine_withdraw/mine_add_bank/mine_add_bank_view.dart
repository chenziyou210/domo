import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';
import 'package:star_common/common/common_widget/custom_gradientbutton/custom_gradientbutton.dart';

import 'mine_add_bank_logic.dart';
import 'mine_add_bank_state.dart';

/// @description:
/// @author
/// @date: 2022-06-03 18:27:11
///

class MineAddBankPage extends StatelessWidget {
  final MineAddBankLogic logic = Get.put(MineAddBankLogic());
  final MineAddBankState state = Get.find<MineAddBankLogic>().state;

  MineAddBankPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: Text("绑定银行卡",
            style: TextStyle(color: Colors.white, fontSize: 18.sp)),
        centerTitle: true,
      ),
      body: GetBuilder<MineAddBankLogic>(
        init: logic,
        global: false,
        builder: (controller) {
          return _body(context);
        },
      ),
    );
  }

  Widget _body(BuildContext context) {
    print(state.list);
    return SingleChildScrollView(
      padding: EdgeInsets.all(18.dp),
      child: Column(
        children: [
          _item(context, "持卡人", "请输入持卡人姓名", true, state.nameController, [
            FilteringTextInputFormatter.allow(
                RegExp("[a-zA-Z]|[\u4e00-\u9fa5]")),
            //只能输入汉字或者字母或数字
            LengthLimitingTextInputFormatter(10), //最大长度
          ], (text) {
            logic.onChange();
          }),
          _item(context, "开户银行", "请选择开户银行", false, state.bankController, null,
              (text) {
            logic.onChange();
          }).gestureDetector(onTap: () {
            logic.dialogBankList(context);
          }),
          _item(context, "银行卡号", "请输入银行卡号", true, state.cardNumberController,
              [LengthLimitingTextInputFormatter(19)], (text) {
            logic.onChange();
          }),
          _item(context, "开户支行", "请输入开户支行", true,
              state.accountOpenBankController, [
            LengthLimitingTextInputFormatter(19),
            FilteringTextInputFormatter.allow(
                RegExp("[a-zA-Z]|[\u4e00-\u9fa5]|[0-9]")),
          ], (text) {
            logic.onChange();
          }),
          SizedBox(
            height: 48,
          ),
          _but(context),
          Text(
            "*请妥善填写银行卡信息，绑定后不可更改持卡人",
            style:
                TextStyle(color: AppMainColors.whiteColor40, fontSize: 12.sp),
          )
        ],
      ),
    );
  }

  Widget _item(
      BuildContext context,
      String name,
      String hint,
      bool eidtOrtext,
      TextEditingController? controller,
      List<TextInputFormatter>? inputFormatter,
      Function(String) onChange) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.dp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(color: Colors.white70),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 6.dp),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                      enable: eidtOrtext,
                      onChange: (p0) {
                        onChange(p0);
                      },
                      controller: controller,
                      hintText: hint,
                      inputFormatter: inputFormatter,
                      keyboardType: name == "银行卡号"
                          ? TextInputType.number
                          : TextInputType.text,
                      hintTextStyle: AppStyles.f14w400c255_255_255.copyWith(
                          color: AppColors.c255_255_255.withOpacity(0.4)),
                      style: AppStyles.f14w400c255_255_255),
                ),
                eidtOrtext
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Image.asset(
                          R.icRightArrow,
                          width: 20.dp,
                          height: 20.dp,
                          color: AppMainColors.whiteColor70,
                        ),
                      )
              ],
            ),
          ),
          Container(
            height: 0.5.dp,
            color: AppMainColors.whiteColor6,
          )
        ],
      ),
    );
  }

  Widget _but(BuildContext context) {
    return Obx(() => Opacity(
          opacity: state.binds.value == false ? 0.5 : 1,
          child: Container(
            height: 38.dp,
            width: double.infinity,
            margin: EdgeInsets.all(16.dp),
            child: GradientButton(
              child: Text(
                '绑定',
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
              onPressed: () {
                if (state.binds.value == false) {
                  return;
                }
                logic.requestBindBank(context);
              },
            ),
          ),
        ));
  }
}
