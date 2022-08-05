/*
 *  Copyright (C), 2015-2021
 *  FileName: audience_online_logic
 *  Author: Tonight丶相拥
 *  Date: 2021/12/11
 *  Description: 
 **/

import 'package:get/get.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/generated/audience_online_entity.dart';
import 'package:star_common/http/http_channel.dart';

import 'package:star_common/generated/living_audience_entity.dart';

class AudienceOnlineLogic extends GetxController
    with PagingMixin<LivingAudienceEntity>, Toast {
  final _AudienceOnlineState state = _AudienceOnlineState();
  late final String roomId;

  @override
  Future dataRefresh() {
    // TODO: implement dataRefresh
    page = 1;
    return _getData(page, roomId, (data) {
      page++;
      state._setData(data);
    });
  }

  // @override
  // Future loadMore() {
  //   // TODO: implement loadMore
  //   return _getData(page, roomId, (data) {
  //     page++;
  //     state._moreData(data);
  //   });
  // }

  Future _getData(int page, String roomId,
      void Function(List<LivingAudienceEntity>) success) {
    return HttpChannel.channel.audienceNumber(roomId).then((value) {
      return value.finalize(
          wrapper: WrapperModel(),
          failure: (e) => showToast(e),
          success: (data) {
            List lst = data["audienceList"] ?? [];
            state._setOnlineNum(data["onlineNum"]);
            success(lst.map((e) => LivingAudienceEntity.fromJson(e)).toList());
          });
    });
  }

  void showNoble(bool value) {
    state._showNoble(value);
  }
}

class _AudienceOnlineState {
  RxList<LivingAudienceEntity> _onlineData = <LivingAudienceEntity>[].obs;

  RxList<LivingAudienceEntity> get onlineData => _onlineData;

  RxList<LivingAudienceEntity> _nobleData = <LivingAudienceEntity>[].obs;

  RxList<LivingAudienceEntity> get nobleData => _nobleData;

  RxInt _onlineNum = (0).obs;

  RxInt get onlineNum => _onlineNum;
  RxBool _isNoble = true.obs;

  RxBool get isNoble => _isNoble;

  void _setData(List<LivingAudienceEntity> data) {
    _onlineData.clear();
    _nobleData.clear();
    data.forEach((element) {
      if (element.nobleType == 0) {
        _onlineData.add(element);
      } else {
        _nobleData.add(element);
        _onlineNum.value = _onlineNum.value - 1;
      }
    });
    _onlineData.sort((a, b) => (b.heat!).compareTo(a.heat!));
    _nobleData.sort((a, b) => (b.heat!).compareTo(a.heat!));
  }

  void _setOnlineNum(int onlineNum) {
    _onlineNum.value = onlineNum;
  }

  void _moreData(List<LivingAudienceEntity> data) {
    data.forEach((element) {
      if (element.nobleType == 0) {
        _onlineData.add(element);
      } else {
        _nobleData.add(element);
      }
    });
    _onlineData.sort((a, b) => (b.heat!).compareTo(a.heat!));
    _nobleData.sort((a, b) => (b.heat!).compareTo(a.heat!));
  }

  void _showNoble(bool value) {
    _isNoble.value = value;
  }
}

class AnchorOnlineLogic extends AudienceOnlineLogic {
  Future _getData(int page, String roomId,
      void Function(List<LivingAudienceEntity>) success) {
    return HttpChannel.channel.audienceNumber(roomId).then((value) {
      return value.finalize(
          wrapper: WrapperModel(),
          failure: (e) => showToast(e),
          success: (data) {
            List lst = data["audienceList"] ?? [];
            state._setOnlineNum(data["onlineNum"]);
            success(lst.map((e) => LivingAudienceEntity.fromJson(e)).toList());
          });
    });
  }
}
