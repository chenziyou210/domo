import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/router/router_config.dart';
import 'package:star_live/pages/personal_information/personal_data/personal_data_state.dart';
import '../../rank_main/rank_main_view.dart';
import '../my_fans/my_fans_view.dart';
import 'models/personal_model.dart';

class PersonalDataLogic extends GetxController with Toast {
  final PersonalDataState state = PersonalDataState();

  void loadPersonalData({needHub = false}) {
    if (needHub) {
      show();
    }
    HttpChannel.channel.getUserInfo(state.userId).then((value) {
      dismiss();
        value.finalize(
            wrapper: WrapperModel(),
            failure: (e) {
              if (needHub) {
                showToast(e);
              }
            },
            success: (data) {
              state.loading = false;
              state.personalModel = personalModelFromJson(data);
              update();
            });
      });
  }

  void pushEditUserInfoPage(BuildContext context) {
    Get.toNamed(AppRoutes.mineEditInfo)?.then((value) {
      if (state.isMine == true) {
        loadPersonalData();
      }
    });
  }

  void pushRankIntegrationPage(BuildContext context) {
    // Get.to(() =>RankMainPage(arguments: {"index": state.personalModel.openLiveFlag == 0 ? 1 : 0}))?.then((value) {
    //   if (state.isMine == true) {
    //     loadPersonalData();
    //   }
    // });

    Get.toNamed(AppRoutes.rankIntegration,arguments:state.personalModel.openLiveFlag == 0 ? 1 : 0)?.then((value) {
      if(state.isMine == true){
        loadPersonalData();
      }
    });
  }

  void pushFloowAndFansPage() {
    Get.to(() =>MyFansPage(arguments: {
      "type": state.personalModel.openLiveFlag == 0 ? 0 : 1,
      "userId": state.userId,}))?.then((value) {
      if (state.isMine == true) {
        loadPersonalData();
      }
    });
  }

}
