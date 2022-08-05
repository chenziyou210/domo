import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/generated/car_list_entity.dart';
import 'package:star_common/manager/app_manager.dart';
import 'package:star_common/manager/user/user_balance_logic.dart';
import 'package:star_common/manager/user/user_info.dart';
import 'package:star_common/router/router_config.dart';
import '../view/svga/SVAGPlayer.dart';
import '../mine_my_level/mine_my_level_logic.dart';
import 'mine_backpack_state.dart';
import 'models/mine_bag_model.dart';

class MineBackpackLogic extends GetxController with Toast {
  final MineBackpackState state = MineBackpackState();

/// 座驾
  void loadCarList(bool needActivity){
    if (needActivity) {
      show();
    }
    HttpChannel.channel.carList().then((value) {
      state.carRefreshController.refreshCompleted();
      dismiss();
      value.finalize(
          wrapper: WrapperModel(),
          failure: (e)=> showToast(e),
          success: (data) {
            List lst = data ?? [];
            List<CarListEntity> d = lst.map((e) => CarListEntity.fromJson(e)).toList();
            VideoManager.instance.cacheFiles(
                lst.map((e) => e['carGifUrl'].toString()).toList());
            state.carList.value = d;
          }
      );
    });
  }

  void useCar(int id,String carGifUrl){
    List<String> carGifList = [carGifUrl];
    show();
    HttpChannel.channel.useCar(id: id).then((value) {
      dismiss();
      value.finalize(wrapper: WrapperModel(),
          failure: (e)=> showToast(e),
          success: (_) {
            AppManager.getInstance<AppUser>().chargeCarUrl(carGifUrl);
            loadCarList(false);
          }
      );
    });
  }

  Future buyCar(int id) async {
    final result = await HttpChannel.channel.carBuy(id: id, type: 0);
    return Future.value(result);
  }

  void play(CarListEntity model) {
    state.gifUrl = model.carGifUrl;
    state.isAnimation = true;
    update();
  }

  void playComplete(){
    state.gifUrl = "";
    state.isAnimation = false;
    update();
  }

  String getButtonText(CarListEntity model) {
    if (model.carBuyState == 0) {
      if (model.type == 1) {
        return '购买';
      }
      if (model.type == 2) {
        return '特权获取';
      }
    }
    if (model.carBuyState == 1) {
      return '使用';
    }
    if (model.carBuyState == 2) {
      return '使用中';
    }
    if (model.carBuyState == 3) {
      return '已过期';
    }
    if (model.carBuyState == 4) {
      return '冻结中';
    }
    return '';
  }

  void pushLevelPrivilege() {
    final logic = Get.put(MineMyLevelLogic());
    logic.state.selectIndex = 4;
    logic.state.context = state.context;
    logic.getLockedList();
    logic.getUnLockList();
    Get.toNamed(AppRoutes.mineLevelPrivilegePage);
  }

/// 背包
  void loadPackageList({bool needActivity = false}) {
    if (needActivity) {
      show();
    }
    HttpChannel.channel.userPackageList().then((value) {
      state.bagRefreshController.refreshCompleted();
      state.roomRefreshController.refreshCompleted();
      dismiss();
      value.finalize(
          wrapper: WrapperModel(),
          failure: (e)=> showToast(e),
          success: (data) {
            List list = data ?? [];
            List<MineBagModel> d = list.map((e) => mineBagModelFromJson(e)).toList();
            state.bagList.value = d;
            updateNicknameCard();
          }
      );
    });
  }

  void updateNicknameCard() {
    state.haveNicknameCard = false;
    for (var value in state.bagList.value) {
      if(value.itemTag == 3002){
        state.haveNicknameCard = true;
        break;
      }
    }
    update(['setNickname']);
  }

  void editNickname(BuildContext context) {
    final AppUser user = AppManager.getInstance<AppUser>();
    state.nicknameTEC.text = user.username ?? '';
    Get.toNamed(AppRoutes.mineEditNicknamePage);
    // Navigator.of(context).pushNamed(AppRoutes.mineEditNicknamePage);
  }

  bool updateNickname() {
    if (state.nicknameTEC.text.length > 12) {
      showToast("昵称最多12个字符");
      return false;
    }
    if (state.nicknameTEC.text.isEmpty){
      showToast("没有输入昵称，请重新填写");
      return false;
    }
    return true;
  }

  void reviseNicknameCardUse(BuildContext context) {
    show();
    HttpChannel.channel.bagUseItem(itemTag: 3002, useItemNum: 1, userName: state.nicknameTEC.text).then((value) {
      dismiss();
      value.finalize(
        wrapper: WrapperModel(),
        failure: (e)=> showToast(e),
        success: (data) {
          showToast('修改成功');
          AppManager.getInstance<AppUser>().userUpdateNickName(state.nicknameTEC.text);
          Get.find<UserInfoLogic>().updateAppUser();
          Get.back();
          loadPackageList();
        },
      );
    });
  }

  Future<bool> updateNicknameDiamondUse(BuildContext context) async {
    final result = await HttpChannel.channel.updateUsername(username: state.nicknameTEC.text);
    if (result.data['code'] == 0) {
      showToast('修改成功');
      final nickname = state.nicknameTEC.text;
      AppManager.getInstance<AppUser>().userUpdateNickName(nickname);
      Get.find<UserInfoLogic>().updateAppUser();
      Get.back(result:  nickname);
      // Navigator.of(context).pop(nickname);
      return Future.value(true);
    }else {
      if (result.data['code'] == 3001) {
        return Future.value(false);
      }else {
        showToast(result.err);
        return Future.value(true);
      }
    }
  }

  void diamondCardUse(MineBagModel model) {
    show();
    HttpChannel.channel.bagUseItem(itemTag: 3003, useItemNum: model.num ?? 1).then((value) {
      dismiss();
      value.finalize(
        wrapper: WrapperModel(),
        failure: (e)=> showToast(e),
        success: (data) {
          showToast('钻石已添加至钻石钱包');
          Get.find<UserBalanceLonic>().userBalanceData();
          loadPackageList();
        },
      );
    });
  }

  Future bagUseItem(int itemTag,int useNum,void Function() success) {
   return HttpChannel.channel.bagUseItem(itemTag: itemTag, useItemNum: useNum).then((value) {
      dismiss();
      value.finalize(
        wrapper: WrapperModel(),
        failure: (e)=> showToast(e),
        success: (data) {
          success();
          loadPackageList();
        },
      );
    });
  }


  Future sendScreenMsg(int hornTag, String? message, String? roomId,void Function() success) {
    return HttpChannel.channel.sendScreenMsg(hornTag,message,roomId).then((value) {
      dismiss();
      value.finalize(
        wrapper: WrapperModel(),
        failure: (e)=> showToast(e),
        success: (data) {
          success();
        },
      );
    });
  }

  void sendGiftBag(int giftTag,String? roomId,int useGiftNum){
    show();
    HttpChannel.channel.sendGiftBag(giftTag,roomId,useGiftNum).then((value) {
      dismiss();
      value.finalize(wrapper: WrapperModel(),
          failure: (e)=> showToast(e),
          success: (data) {
            //数量减一
            print("成功"+data.toString());
            Get.back();
          }
      );
    });
  }

  int hasHorn() {
    int num=0;
    for (var value in state.bagList.value) {
      if(value.itemTag == 3001){
        num+= value.num??0;
      }
    }
    return num;
  }

}
