import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:star_common/manager/app_manager.dart';
import '../models/homepage_model.dart';
import '../widget/homepage_widget.dart';
import 'nearby_alert_logic.dart';
import 'package:star_common/common/app_common_widget.dart';

import 'nerby_alert_model.dart';

class NearbyAlertView extends StatelessWidget {
  final logic = Get.put(NearbyAlertLogic());
  final state = Get.find<NearbyAlertLogic>().state;

  final Function(String? cityName, int cityId)? onTap;
  NearbyAlertView({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List lst =  logic.alertItems();
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 10, left: 16, bottom: 8, right: 16),
        height: 375.dp,
        width: MediaQuery.of(context).size.width,
        color: AppMainColors.backgroudColor,
        child:
        MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child:  StaggeredGridView.countBuilder(
                // physics: NeverScrollableScrollPhysics(), //禁用滑动事件
                // physics: BouncingScrollPhysics(),
                  crossAxisCount: 16,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 9,
                  shrinkWrap: true,
                  itemCount: lst.length,
                  itemBuilder: (BuildContext context, int index) {
                    HomeNearAlertItemModel item = lst[index];
                    if(item.viewType == "Tip"){
                      HomeTipInfo tip = HomeTipInfo();
                      tip.tipName = item.name;
                      return HomeTipItem(
                        tip,
                        textColor:AppMainColors.whiteColor40,
                        fontSize: 12,
                      );

                    }else{
                      item.backgroudColor = state.getBgroudColor(state.currentCityIndex.value == index);
                      item.textColor = state.getTextColor(state.currentCityIndex.value == index);
                      item.borderColor = state.getBorderColor(state.currentCityIndex.value == index);
                      item.seletecd = state.currentCityIndex.value == index;
                      return HomeNearAlertItem(alertItem: item).inkWell(onTap: (){
                         state.currentCityIndex.value = index;
                         onTap?.call(item.name, 100);
                      });

                    }

                  },

                  /// 构建 排列样式
                  staggeredTileBuilder: (int index) {
                    HomeNearAlertItemModel item = logic.alertItems()[index];
                    var tempTileExtent = StaggeredTile.extent(4, 32.dp);
                    switch(item.viewType){
                      case "Tip":tempTileExtent = StaggeredTile.extent(16, 40.dp);break;
                      case "Item":tempTileExtent = StaggeredTile.extent(4, 32.dp);break;
                    }
                    return tempTileExtent;
                  }),
            )
      ),
    );
  }
}

/// 性别弹窗
class GenderAlertView extends StatelessWidget {
  final logic = Get.put(NearbyAlertLogic());
  final state = Get.find<NearbyAlertLogic>().state;
  final Function(String cityName, int cityId)? onTap;
  GenderAlertView({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 5, bottom: 10, right: 5),
      width: MediaQuery.of(context).size.width,
      height: 90.dp,
      color: AppMainColors.backgroudColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding:
            EdgeInsets.only(top: 5, right: 5, bottom: 10, left: 10),
            child: Text(
              "性别",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppMainColors.whiteColor40,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _genderItemView(
                    state.genders[0], logic.currentGenderIndex() == 0),
                _genderItemView(
                    state.genders[1], logic.currentGenderIndex() == 1),
                _genderItemView(
                    state.genders[2], logic.currentGenderIndex() == 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _genderItemView(String name, bool isSeleted) {
    return Container(
      width: 80.dp,
      height: 32.dp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.dp),
        color: logic.state.getBgroudColor(isSeleted),
        border: Border.all(
            color: logic.state.getBorderColor(isSeleted),
            width: isSeleted ? 1 : 0,
            style: BorderStyle.solid),
      ),
      alignment: Alignment.center,
      child: Text(name,
          style: TextStyle(
            fontSize: 12.sp,
            color: logic.state.getTextColor(isSeleted),
          )),
    ).inkWell(onTap: () {
      logic.state.currentGenter.value = name;
      onTap!.call(name, 100);
    });
  }
}
