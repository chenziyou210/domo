import 'package:star_common/http/cache.dart';

/// @description:
/// @author
/// @date: 2022-05-25 11:30:29
class MyMineSettingState {
  List firstList = ['支付密码', '贵族隐身', 'App应用锁', '礼物特效', '座驾特效', '版本', '退出登录'];

  // 1 返回按钮 2 开关  3 更新   4 退出
  List endList = [1, 1, 2, 2, 2, 3, 0];

  // 应用，震动，特效，礼物
  bool isLockOpen = AppCacheManager.cache.getisLockOpen() ?? false;
  //bool isShakeOpen = AppCacheManager.cache.getiShakeOpen() ?? false;
  bool isGiftOpen = AppCacheManager.cache.getiGiftOpen() ?? true;
  bool isDriveOpen = AppCacheManager.cache.getiDriveOpen() ?? true;

  String version = "";

  MyMineSettingState() {
    ///Initialize variables
  }
}
