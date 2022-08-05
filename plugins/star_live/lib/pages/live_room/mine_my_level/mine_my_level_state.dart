import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:star_common/generated/user_grade_entity.dart';
import 'package:star_common/manager/app_manager.dart';
import 'models/mine_level_model.dart';
import 'models/mine_level_privilege_model.dart';

class MineMyLevelState {
  late UserGradeEntity userGrade = UserGradeEntity();
  late int userLevel;
  final refreshController = RefreshController();
  late BuildContext context;
  late int selectIndex = 0;
  bool loadDateDone = false;
  late List<LevelPrivilegeModel> pages;
  List<MineLevelModel> levelModels = [];
  List<MineLevelModel> lockedList = [];
  List<MineLevelModel> unLockList = [];

  MineMyLevelState() {
    userLevel = AppManager.getInstance<AppUser>().rank ?? 0;
    final model1 = LevelPrivilegeModel(
      level: 1,
      levelType: LevelType.level1,
      tag1: '身份标识',
      tag2: '彰显身份',
      synopsisList: ['用户等级身份生效时，将拥有专属身份标识。'],
    );
    final model2 = LevelPrivilegeModel(
      level: 10,
      levelType: LevelType.level10,
      tag1: '升级提醒',
      tag2: '彰显身份',
      synopsisList: [
        '1.用户Lv1-Lv10的升级，将拥有仅自己可见的专属升级提醒',
        '2.用户Lv10及以上的升级时，将拥有在当前直播间主播和所有用户可见的升级提醒及自己可见的专属升级提醒',
      ],
    );
    final model3 = LevelPrivilegeModel(
      level: 12,
      levelType: LevelType.level12,
      tag1: '特权礼物',
      tag2: '彰显身份',
      synopsisList: ['用户等级身份生效时，您的礼物特权栏将装备普通用户没有的专属特权礼物，彰显您的独特身份'],
      giftList: [
        '独角木马',
        '灯塔',
        '神印王座'
      ],
      giftRemarkList: [
        '让人沉浸在生活的小确幸中',
        '无尽汪洋中的一座灯塔',
        '手握日月摘星辰,世间无我这般人'
      ],
      giftLevelList: [12, 34, 37],
    );
    final model4 = LevelPrivilegeModel(
      level: 21,
      levelType: LevelType.level21,
      tag1: '彰显身份',
      tag2: '特权入场',
      synopsisList: ['用户等级身份生效时，将拥有进入直播间专属进房提示'],
    );
    final model5 = LevelPrivilegeModel(
      level: 30,
      levelType: LevelType.level30,
      tag1: '酷炫排面',
      tag2: '彰显身份',
      synopsisList: [
        '用户等级达到指定等级后，您将装备当前身份专属的座骑，在进场时除了专属的进房提示，还会有坐骑显示',
        '注：\n1.您如果升级到更高用户等级，您的坐骑样式也会同步更新',
        '2.连续30日不消费，坐骑特权即将被冻结，最近30天消费对应余额可重新获得',
      ],
      carDiamondList: [
        '，消费50钻石可重新获得',
        '，消费100钻石可重新获得',
        '，消费200钻石可重新获得',
        '，消费300钻石可重新获得',
        '，消费1000钻石可重新获得',
        '，消费2000钻石可重新获得',
        '，拥有豁免权益，即无需消费可获得',
      ],
      carList: [
        '卡丁车坐骑',
        '黄色战神坐骑',
        '劲动法拉利坐骑',
        '奔跑白鹿坐骑',
        '兰博坐骑',
        '小马车坐骑',
        '红色跑车坐骑',
      ],
      carLevelList: [30, 35, 38, 42, 45, 49, 54],
    );
    pages = [model1, model2, model3, model4, model5];
  }

}
