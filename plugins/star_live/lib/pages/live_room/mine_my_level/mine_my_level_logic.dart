import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/generated/user_grade_entity.dart';
import 'package:star_common/router/router_config.dart';
import 'mine_my_level_state.dart';
import 'models/mine_level_model.dart';

class MineMyLevelLogic extends GetxController with Toast {
  final MineMyLevelState state = MineMyLevelState();

  MineLevelModel getLevelModel(LevelType type, bool status) {
    String levelIcon = '';
    String lockedIcon = '';
    String unlockIcon = '';
    String lockedContent = '';
    String unlockTitle1 = '';
    String unlockTitle2 = '';
    String unlockTitle3 = '';
    late int level;

    switch (type) {
      case LevelType.level1:
        {
          level = 1;
          levelIcon = R.icLeverFirst;
          lockedIcon = R.mineLevelIdentity;
          unlockIcon = R.mineLevelIdentityUnlock;
          lockedContent = '身份标识';
          unlockTitle1 = '解锁新勋章';
          unlockTitle2 = '解锁专属升级弹窗';
        }
        break;
      case LevelType.level10:
        {
          level = 10;
          levelIcon = R.icLeverFirst;
          lockedIcon = R.mineLevelUpgradeTips;
          unlockIcon = R.mineLevelUpgradeTipsUnlock;
          lockedContent = '升级提示';
          unlockTitle1 = '解锁直播间公屏升级通知';
        }
        break;
      case LevelType.level12:
        {
          level = 12;
          levelIcon = R.icLeverSecond;
          lockedIcon = R.mineLevelExclusiveGift;
          unlockIcon = R.mineLevelExclusiveGiftUnlock;
          lockedContent = '专属礼物';
          unlockTitle1 = '解锁特权礼物：独角木马';
          unlockTitle2 = '解锁新等级勋章';
          unlockTitle3 = '解锁专属升级弹窗';
        }
        break;
      case LevelType.level21:
        {
          level = 21;
          levelIcon = R.icLeverSecond;
          lockedIcon = R.mineLevelRoomHint;
          unlockIcon = R.mineLevelRoomHintUnlock;
          lockedContent = '进房提示';
          unlockTitle1 = '解锁新进房提示';
        }
        break;
      case LevelType.level30:
        {
          level = 30;
          levelIcon = R.icLeverThird;
          lockedIcon = R.mineLevelIdentityMount;
          unlockIcon = R.mineLevelIdentityMountUnlock;
          lockedContent = '身份坐骑';
          unlockTitle1 = '解锁专属座驾新进房提示';
        }
        break;
    }
    final model = MineLevelModel(
      level: level,
      levelType: type,
      levelIcon: levelIcon,
      lockedStatus: status,
      lockedIcon: lockedIcon,
      unlockIcon: unlockIcon,
      lockedContent: lockedContent,
      unlockTitle1: unlockTitle1,
      unlockTitle2: unlockTitle2,
      unlockTitle3: unlockTitle3,
    );
    return model;
  }

  void getGrade(){
    show();
    HttpChannel.channel.gradeList().then((value) {
      dismiss();
      state.refreshController.refreshCompleted();
      value.finalize(
          wrapper: WrapperModel(),
          failure: (e)=> showToast(e),
          success: (data) {
            state.levelModels = [];
            state.lockedList = [];
            state.unLockList = [];
            state.loadDateDone = true;
            state.userGrade = UserGradeEntity.fromJson(data);
            state.userLevel = state.userGrade.userLevel ?? 0;
            getLockedList();
            getUnLockList();
          }
      );
    });
  }

  void getLockedList() {
    if (state.userLevel >= 1) {
      final model1 = getLevelModel(LevelType.level1, true);
      state.levelModels.add(model1);
      state.lockedList.add(model1);
    }
    if (state.userLevel >= 10) {
      final model10 = getLevelModel(LevelType.level10, true);
      state.levelModels.add(model10);
      state.lockedList.add(model10);
    }
    if (state.userLevel >= 12) {
      final model12 = getLevelModel(LevelType.level12, true);
      state.levelModels.add(model12);
      state.lockedList.add(model12);
    }
    if (state.userLevel >= 21) {
      final model21 = getLevelModel(LevelType.level21, true);
      state.levelModels.add(model21);
      state.lockedList.add(model21);
    }
    if (state.userLevel >= 30) {
      final model30 = getLevelModel(LevelType.level30, true);
      state.levelModels.add(model30);
      state.lockedList.add(model30);
    }
  }

  void getUnLockList() {
    if (state.userLevel < 1) {
      final model1 = getLevelModel(LevelType.level1, false);
      state.levelModels.add(model1);
      state.unLockList.add(model1);
    }
    if (state.userLevel < 10) {
      final model10 = getLevelModel(LevelType.level10, false);
      state.levelModels.add(model10);
      state.unLockList.add(model10);
    }
    if (state.userLevel < 12) {
      final model12 = getLevelModel(LevelType.level12, false);
      state.levelModels.add(model12);
      state.unLockList.add(model12);
    }
    if (state.userLevel < 21) {
      final model21 = getLevelModel(LevelType.level21, false);
      state.levelModels.add(model21);
      state.unLockList.add(model21);
    }
    if (state.userLevel < 30) {
      final model30 = getLevelModel(LevelType.level30, false);
      state.levelModels.add(model30);
      state.unLockList.add(model30);
    }
    update();
  }

  void pushLevelRegulationPage() {
    Get.toNamed(AppRoutes.mineLevelRegulationPage);

  }

  void pushLevelPrivilegePage(MineLevelModel model) {
    if (model.levelType == LevelType.level1) {state.selectIndex = 0;}
    if (model.levelType == LevelType.level10) {state.selectIndex = 1;}
    if (model.levelType == LevelType.level12) {state.selectIndex = 2;}
    if (model.levelType == LevelType.level21) {state.selectIndex = 3;}
    if (model.levelType == LevelType.level30) {state.selectIndex = 4;}
    Get.toNamed(AppRoutes.mineLevelPrivilegePage);
  }

}
