import 'mine_level_model.dart';

class LevelPrivilegeModel {
  LevelPrivilegeModel({
    required this.level,
    required this.levelType,
    required this.tag1,
    required this.tag2,
    required this.synopsisList,
    this.giftList,
    this.giftLevelList,
    this.giftRemarkList,
    this.carList,
    this.carDiamondList,
    this.carLevelList,
  });

  int level;
  LevelType levelType;
  String tag1;
  String tag2;
  List<String> synopsisList;
  List<String>? giftList;
  List<String>? giftRemarkList;
  List<int>? giftLevelList;
  List<String>? carList;
  List<String>? carDiamondList;
  List<int>? carLevelList;
}