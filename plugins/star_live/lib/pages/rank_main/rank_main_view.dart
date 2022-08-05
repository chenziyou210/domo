import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_live/pages/rank_main/rank_list_content.dart';

import 'rank_main_logic.dart';

class RankMainPage extends StatelessWidget {
  final logic = Get.put(RankMainLogic());
  final state = Get.find<RankMainLogic>().state;
  @override

  Widget build(BuildContext context) {

   return  Scaffold(
     body: Stack(
       children: [
         //渐变背景
         Container(
           decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: AppMainColors.LeaderboardGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.center,
              ),
            ),
         ),
         //返回箭头
        CustomBackButton(
           icon: Image.asset(R.backIconWhite, width: 20.dp,height: 20.dp,fit: BoxFit.cover,),
           onPressed: ()=>  Get.back(),
         ).paddingOnly(left: 16,top: 44.dp),
        //内容主体
         Column(
           children: [
             //菜单部分
              Obx(() => ToggleButtons(
                             children: List.generate(2, (index) {
                               return  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 20.dp),
                                    alignment: Alignment.center,
                                    child: state.titleText(index),
                                  );
                             }),
                             isSelected: [state.menuIndex == 0, state.menuIndex == 1],
                             renderBorder: false,
                             fillColor: Colors.transparent,
                             splashColor: Colors.transparent,
                             selectedColor: Colors.transparent,
                             onPressed: (index) => logic.changeMenuTitle(index),
                             color: Colors.transparent).paddingOnly(top: 44.dp)),

             //列表部分
             CustomTabBarView(
                 controller: state.mainController,
                 children: List.generate(2, (index) => RankListContentWidget())
             ).expanded(),
           ],
         )
       ],
     )
   );
  }
}
