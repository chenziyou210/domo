/*
 *  Copyright (C), 2015-2021
 *  FileName: live_model
 *  Author: Tonight丶相拥
 *  Date: 2021/7/14
 *  Description: 
 **/

import 'package:star_common/base/app_base.dart';
import 'package:star_common/generated/banner_entity.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/manager/app_manager.dart';

class LiveModel extends AppModel {

  /// 视图模型
  final LiveViewModel viewModel = LiveViewModel();

  @override
  Future loadData() {
    // TODO: implement loadData
    return Future.wait([HttpChannel.channel.homeBanner(3)..then((value) => value.finalize(
        wrapper: WrapperModel(),
        success: (data) {
          List lst = data ?? [];
          List<BannerEntity> banner = lst.map((e) => BannerEntity.fromJson(e)).toList();
          viewModel._setBanner(banner);
        }
    )), HttpChannel.channel.gameConfig()..then((value)=>
        value.finalize(
          wrapper: WrapperModel(),
          success: (value) {
            AppManager.getInstance<Game>().initializeGame(value);
          }
        ))]);
  }

  // /// 房间验证
  // Future<WrapperModel> verify(String roomId, state, value) async{
  //   show();
  //   var result = await HttpChannel.channel.verifyLiveRoom(roomId: roomId,
  //       state: state ? 1 : 2, value: value).then((value) =>
  //       value.finalize<WrapperModel>(
  //         wrapper: WrapperModel(),
  //         failure: (e) => showToast(e),
  //         success: (_) {
  //           dismiss();
  //         }
  //       ));
  //   return result;
  // }
}


class LiveViewModel extends CommonNotifierModel {
  List<BannerEntity> _banner = [];
  List<BannerEntity> get banner => _banner;

  void _setBanner(List<BannerEntity> banners){
    this._banner = banners;
    updateState();
  }
}