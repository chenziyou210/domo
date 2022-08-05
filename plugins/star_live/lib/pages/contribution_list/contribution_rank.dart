import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_live/pages/rank_main/rank_main_view.dart';
import 'contribution_item_view.dart';
import 'contribution_list_logic.dart';

class ContributionRankPage extends StatelessWidget {
  final bool isAnchor;
  final String userId;
  ContributionRankPage(this.isAnchor,this.userId);
  final logic = Get.put(ContributionListLogic());
  final state = Get.find<ContributionListLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.dp),
                topRight: Radius.circular(12.dp)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child:  Container(
                decoration: BoxDecoration(
                  color: AppMainColors.blackContribution,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.dp),
                      topRight: Radius.circular(12.dp)),
                ),
              ),
            ),
          ),
        ),
        Column(children: [
          Container(
            height: 46.dp,
            width: Get.width,
            alignment: Alignment.center,
            color: AppMainColors.whiteColor6,
            child: CustomText(
              intl.contributionList,
              style:  TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
          _header(context),
          _body().paddingOnly(bottom: context.height*0.4).expanded()
        ])
      ],
    );
  }

  Widget _body() {
    return PageView.builder(
      controller: state.pageController,
      itemCount: 4,
      itemBuilder: (c, i) {
        return ContributionPage(i,isAnchor);
      },
      onPageChanged: (i) {
        state.setFollowOrFans(i);
        logic.requestPage();
      },
    );
  }

  //header

  _header(BuildContext context) {
    logic.setUserId(userId);
    return Obx(() {
      var index = Get.find<ContributionListLogic>().state.tabIndex;
      return Container(
        margin: EdgeInsets.only(left:16.dp,top:12.dp,right: 16.dp,bottom: 16.dp),
        width: Get.width,
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          _rankItem(index, 0),
          _rankItem(index, 1),
          _rankItem(index, 2),
          _rankItem(index, 3),
          Spacer(),
          Image.asset(
            R.iconHomeRank,
            width: 24.dp,
            height: 24.dp,
          ).gestureDetector(onTap: () {
            Get.to(() => RankMainPage());
          })
        ]),
      );
    });
  }

  Widget _rankItem(RxInt index, int clickPos) {
    bool isSelected = index.value == clickPos;
    return Container(
            width: 48.dp,
            height: 24.dp,
            margin: EdgeInsets.only(right: 12.dp),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: isSelected ? AppMainColors.mainColor : Colors.white10,
                borderRadius: BorderRadius.circular(12.dp),
                border: Border.all(
                    color: isSelected
                        ? Colors.white
                        : AppMainColors.whiteColor40)),
            child: CustomText(state.titles[clickPos],
                style: TextStyle(
                    color: isSelected
                        ? AppMainColors.whiteColor100
                        : Colors.white70,
                    fontSize: 12.sp
                ,fontWeight: w_400)))
        .gestureDetector(onTap: () {
      state.setFollowOrFans(clickPos);
    });
  }



}
