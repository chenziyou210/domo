import 'package:star_common/http/cache.dart';

/// @description:
/// @author
/// @date: 2022-06-26 11:30:26
class MyMineStealthState {
  List firstList = ['入场隐身', '榜单隐身'];

  bool isAdmissionOpen =
      AppCacheManager.cache.getisAdmissionStealthOpen() ?? false;
  bool isListStealthOpen =
      AppCacheManager.cache.getisListStealthOpen() ?? false;

  int enterHide = 0;
  int rankListHide = 0;
  MyMineStealthState() {
    ///Initialize variables
  }
}
