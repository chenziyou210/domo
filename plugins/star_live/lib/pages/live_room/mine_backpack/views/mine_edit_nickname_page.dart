import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/common_widget/app_dialog.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_common/manager/app_manager.dart';
import '../../../recharge/recharge/recharge_view.dart';
import '../mine_backpack_logic.dart';

class MineEditNicknamePage extends StatelessWidget with Toast {
  final logic = Get.find<MineBackpackLogic>();
  final state = Get.find<MineBackpackLogic>().state;

  MineEditNicknamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: AppLayout.appBarTitle('设置昵称'),
        centerTitle: true,
        actions: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 18.dp),
            child: AppLayout.textWhite14('保存'),
          ).gestureDetector(onTap: () {
            if (state.nicknameTEC.text ==
                AppManager.getInstance<AppUser>().username) {
              Get.back();
            } else {
              if (logic.updateNickname()) {
                if (state.haveNicknameCard) {
                  logic.reviseNicknameCardUse(context);
                } else {
                  _showTipDialog(context);
                }
              }
            }
          }),
        ],
      ),
      body: _buildBody(),
    );
  }

  _showTipDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AppDialog(
          Text.rich(
            TextSpan(children: [
              TextSpan(text: "您将消耗"),
              TextSpan(
                text: "80",
                style: TextStyle(
                    color: AppMainColors.mainColor,
                    fontSize: 14.sp,
                    fontFamily: 'Number'),
              ),
              TextSpan(text: "钻石修改用户昵称"),
            ]),
            style: TextStyle(
              color: AppMainColors.whiteColor70,
              fontSize: 14.sp,
            ),
          ),
          cancelText: "取消",
          confirm: () {
            Get.back();
            if (logic.updateNickname()) {
              show();
              logic.updateNicknameDiamondUse(context).then((value) {
                dismiss();
                if (!value) {
                  _showRechargeDialog(context);
                }
              });
            }
          },
        );
      },
    );
  }

  _showRechargeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AppDialog(
          Text(
            '很抱歉，当前钻石钱包余额不足，请前往充值或兑换',
            style:
                TextStyle(color: AppMainColors.whiteColor70, fontSize: 14.sp),
          ),
          cancelText: "取消",
          confirmText: '前往充值',
          confirm: () {
            Get.back();
            Get.to(() => RechargePage(true));
          },
        );
      },
    );
  }

  Widget _buildBody() {
    return GetBuilder<MineBackpackLogic>(
      init: logic,
      id: 'setNickname',
      builder: (logic) {
        return Container(
          height: 80.dp,
          color: AppMainColors.whiteColor6,
          padding: EdgeInsets.fromLTRB(
              AppLayout.pageSpace, 0, AppLayout.pageSpace, 4.dp),
          child: TextField(
            controller: state.nicknameTEC,
            cursorColor: AppMainColors.whiteColor100,
            style:
                TextStyle(color: AppMainColors.whiteColor100, fontSize: 16.sp),
            maxLength: 12,
            decoration: InputDecoration(
              hintText: '设置昵称~',
              hintStyle:
                  TextStyle(color: AppMainColors.whiteColor20, fontSize: 14.sp),
              helperText:
                  state.haveNicknameCard ? '使用改名卡可免费改名1次' : '需要消费80钻石更改昵称',
              helperStyle:
                  TextStyle(color: AppMainColors.whiteColor40, fontSize: 12.sp),
              counterStyle: TextStyle(
                  color: AppMainColors.whiteColor100, fontSize: 12.sp),
              border: InputBorder.none,
              suffix: InkWell(
                child: Image.asset(
                  R.iconSuffix,
                  width: 16.dp,
                  height: 16.dp,
                ),
                onTap: () {
                  state.nicknameTEC.text = '';
                },
              ),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(
                  "[`~\$!@#^&*()=|{}':;',\\[\\].<>《》/?~！@#￥……&*（）――|{}【】‘；：”“'。，、？ ]")),
              FilteringTextInputFormatter.deny(RegExp(
                  "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]")),
              FilteringTextInputFormatter.singleLineFormatter,
            ],
          ),
        );
      },
    );
  }
}
