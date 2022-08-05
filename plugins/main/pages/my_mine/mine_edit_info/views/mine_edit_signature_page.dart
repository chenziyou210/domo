import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/config/app_layout.dart';
import '../mine_edit_info_logic.dart';

class MineEditSignaturePage extends StatelessWidget {
  final logic = Get.put(MineEditInfoLogic());
  final state = Get.find<MineEditInfoLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        centerTitle: true,
        title: AppLayout.appBarTitle('设置签名'),
        actions: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 18.dp),
            child: AppLayout.textWhite14('保存'),
          ).gestureDetector(
            onTap: () => logic.updateSignature(),
          ),
        ],
      ),
      body: Container(
          height: 88.dp,
          color: AppMainColors.whiteColor6,
          padding: EdgeInsets.fromLTRB(
              AppLayout.pageSpace, 0, AppLayout.pageSpace, 4.dp),
          child: TextField(
            controller: state.signatureTEC,
            maxLines: null,
            maxLength: 32,
            cursorColor: AppMainColors.whiteColor100,
            style: TextStyle(color: AppMainColors.whiteColor100, fontSize: 16.sp),
            expands: true,
            decoration: InputDecoration(
              hintText: '留下你的签名吧~',
              hintStyle: TextStyle(color: AppMainColors.whiteColor20, fontSize: 14.sp),
              counterStyle: TextStyle(color: AppMainColors.whiteColor100, fontSize: 12.sp),
              border: InputBorder.none,
              suffix: InkWell(
                child: Image.asset(
                  R.iconSuffix,
                  width: 16.dp,
                  height: 16.dp,
                ),
                onTap: () {
                  state.signatureTEC.text = '';
                },
              ),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.singleLineFormatter,
            ],
          )),
    );
  }
}
