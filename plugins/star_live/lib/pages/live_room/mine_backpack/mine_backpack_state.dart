import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:star_common/generated/car_list_entity.dart';
import 'models/mine_bag_model.dart';

class MineBackpackState {
  final List<String> titles = ["座驾", "背包"];
  late RefreshController carRefreshController = RefreshController();
  late RefreshController bagRefreshController = RefreshController();
  late RefreshController roomRefreshController = RefreshController();
  late TextEditingController nicknameTEC = TextEditingController();
  late BuildContext context;
  late BuildContext carContext;

  RxList<CarListEntity> carList = RxList();
  RxList<MineBagModel> bagList = RxList();
  String gifUrl = "";
  bool isAnimation = false;
  bool haveNicknameCard = false;

  MineBackpackState() {
    ///Initialize variables
  }
}
