import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/toast.dart';

import 'report_page_logic.dart';

class ReportPagePage extends StatelessWidget with Toast {
  final logic = Get.put(ReportPageLogic());
  final state = Get.find<ReportPageLogic>().state;

  final List<String> reportList = ["政治谣言", "色情低俗", "商业广告", "侮辱谩骂"];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 307.dp,
      decoration: BoxDecoration(color: AppMainColors.commonPopupBg),
      child: Column(
        children: [
          guardRankList(),
          SizedBox(height: 16.dp),
          CustomText(
            "取消",
            style: TextStyle(
                fontWeight: w_500, fontSize: 16.sp, color: Colors.white),
          ).gestureDetector(onTap: () {
            Get.back();
            // Navigator.of(context).pop();
          })
        ],
      ),
    );
  }

  Widget guardRankList() {
    return ListView.builder(
        itemCount: reportList.length,
        shrinkWrap: true,
        itemBuilder: (widgetContext, index) {
          return Column(
            children: [
              Container(
                height: 53.dp,
                alignment: Alignment.center,
                child: CustomText(reportList[index],
                    style: TextStyle(
                        fontWeight: w_400,
                        fontSize: 16.dp,
                        color: AppMainColors.whiteColor100)),
              ),
              CustomDivider(
                  color: AppMainColors.separaLineColor6,
                  height: index == reportList.length - 1 ? 4.dp : 1.dp)
            ],
          ).gestureDetector(onTap: () {
            showToast("您已举报成功");
          });
        });
  }
}
