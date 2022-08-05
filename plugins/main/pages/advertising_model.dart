/*
 *  Copyright (C), 2015-2021
 *  FileName: advertising_model
 *  Author: Tonight丶相拥
 *  Date: 2021/10/18
 *  Description: 
 **/

import 'dart:async';
import 'package:get/get.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/storage.dart';
import 'package:star_common/generated/banner_entity.dart';
import 'package:star_common/http/http_channel.dart';

class AdvertisingModel extends AppModel {
  AdvertisingModel(this._timeUp);
  final void Function() _timeUp;
  Timer? _timer;

  final AdvertisingViewModel viewModel = AdvertisingViewModel();
  @override
  Future loadData() {
    // TODO: implement loadData
    Get.put(AdvertisingViewModel());
    _timerInitialize();
    userInfoReport();
    return super.loadData();
  }

  void userInfoReport() {
    if (StorageService.to.getString("token").isNotEmpty) {
      HttpChannel.channel.homeBanner(1).then((value) => value.finalize(
          wrapper: WrapperModel(),
          failure: (e) => showToast(e),
          success: (data) {
            List lst = data ?? [];
            lst = lst.map((e) => BannerEntity.fromJson(e)).toList();
            if (lst.length > 0) {
              try {
                var logic = Get.find<AdvertisingViewModel>();
                logic.splashImage = lst[0].pic!;
                logic.update();
              } catch (_) {}
              StorageService.to.setString("homeBanner", lst[0].pic!);
            }
          }));
    }
  }

  void dispose() {
    timerCancel();
    _timer = null;
    Get.delete<AdvertisingViewModel>();
  }

  /// timer 取消
  void timerCancel() {
    _timer?.cancel();
  }

  /// timer 初始化
  void _timerInitialize() {
    viewModel._count.value = 9;
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (viewModel._count.value <= 0) {
        _timeUp();
        timerCancel();
        return;
      }
      viewModel._substract();
    });
  }
}

class AdvertisingViewModel extends GetxController {
  RxInt _count = 9.obs;
  RxInt get count => _count;
  RxBool canSkip = false.obs;
  List<BannerEntity> banners = [];
  String splashImage = StorageService.to.getString("homeBanner");
  void _substract() {
    _count.value -= 1;
  }
}
