import 'package:get/get.dart';
import 'package:hjnzb/pages/game/game_list_model.dart';
import 'package:spring/spring.dart';
import 'package:star_live/pages/live/live_home_data.dart';
import '../../business/homepage/models/homepage_model.dart';
// import 'game_model.dart';

class JumpGameState {
  RxList<GameList> _games = <GameList>[].obs;
  RxList<GameList> get games => _games;

  RxList<HomeBannerInfo> _banner = <HomeBannerInfo>[].obs;
  RxList<HomeBannerInfo> get banner => _banner;
  dynamic queryUserBalanceData;

  // RxList<HomeAnnouncementEntity> _homeAnnouncement =
  //     <HomeAnnouncementEntity>[].obs;
  // RxList<HomeAnnouncementEntity> get homeAnnouncement => _homeAnnouncement;
  RxString _announcementString = "".obs;
  RxString get announcementString => _announcementString;

  void addGames(List<GameList> gameList) {
    _games.value = gameList;
  }

  void setAnnouncementData(List<HomeAnnouncementEntity> value) {
    // _homeAnnouncement.value = value;
    if (value.length > 0) {
      String tempContent = "";
      value.forEach((element) {
        tempContent = "$tempContent ${element.content}";
      });
      _announcementString.value = tempContent + "    ";
    } else {
      _announcementString.value = "欢迎来到广岛直播" + "    ";
    }
  }

  void addBanner(List<HomeBannerInfo> gameList) {
    _banner.value = gameList;
  }
}
