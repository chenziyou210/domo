import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:star_common/manager/app_manager.dart';

import 'nearby_alert_state.dart';
import 'nerby_alert_model.dart';

class NearbyAlertLogic extends GetxController {
  final NearbyAlertState state = NearbyAlertState();

  /// 返回当前下标
  int currentCityIndex() {
    int index = -1;
    index = state.citys.indexOf(state.tapCity.value);
    return index;
  }

  int currentGenderIndex() {
    int index = 0;
    index = state.genders.indexOf(state.currentGenter.value);
    return index;
  }

  List<HomeNearAlertItemModel> alertItems(){

   return List.generate(state.citys.length + 3, (index){
      var name, viewType;
      HomeNearAlertItemModel temp = HomeNearAlertItemModel();
      switch (index) {
        case 0:
          name = "我的地区";
          viewType = "Tip";
          break;
        case 1:
          name = AppManager.getInstance<AppUser>().region ?? "火星";
          viewType = "Item";
          break;
        case 2:
          name = "所有地区";
          viewType = "Tip";
          break;
        default:{
          name = state.citys[index - 3];
          viewType = "Item";
        }
        break;
      }
      temp.name = name;
      temp.viewType = viewType;
      return temp;
    });



  }


}
