import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:star_common/generated/anchor_list_model_entity.dart';

enum ListViewType {
  Game,
  Banner,
  Ranking,
  Anchor,
  Nearby,
  Marquee,
  Tip,
}

extension ListTypeExtension on ListViewType {
  static ListViewType getTypeValue(int index) {
    switch (index) {
      default:
        return ListViewType.Tip;
    }
  }
}

/// 游戏玩法数据
class HomeGameModel {
  HomeGameModel({this.gameId, this.name});
  int? gameId;
  String? name;

  HomeGameModel.fromJson(Map<String, dynamic> json) {
    gameId = json['gameId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['gameId'] = this.gameId;
    data['name'] = this.name;
    return data;
  }
}

/// 游戏信息
class HomeGameInfo {
  // 命名函数
  HomeGameInfo({this.id, this.imageUrl});
  // 图片id
  String? id;
  // 图片url
  String? imageUrl;
}

/// 跑马灯信息

class HomeMarqueeInfo {
  HomeMarqueeInfo({this.content, this.jumpPath, this.title});

  String? content;
  String? jumpPath;
  String? title;

  HomeMarqueeInfo.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    jumpPath = json['jumpPath'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['jumpPath'] = this.jumpPath;
    data['title'] = this.title;
    return data;
  }
}

/// 轮播图
class HomeBannerInfo {
  // 命名函数
  HomeBannerInfo(
      {this.id,
      this.pic,
      this.url,
      this.urlType,
      this.picType,
      this.position,
      this.duration,
      this.startTime,
      this.endTime});
  int? id;
  String? pic;
  String? url;

  int? picType;
  int? position;
  int? duration;
  String? startTime;
  String? endTime;

  //链接类型 0：内链，1：外链，2：APP页面内跳转, 3:三方游戏跳转
  int? urlType;

  HomeBannerInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pic = json['pic'];
    url = json['url'];
    urlType = json['urlType'];
    picType = json['picType'];
    position = json['position'];
    duration = json['duration'];
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['pic'] = this.pic;
    data['url'] = this.url;
    data['urlType'] = this.urlType;
    data['picType'] = this.picType;
    data['position'] = this.position;
    data['duration'] = this.duration;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;

    return data;
  }
}

/// 获取排行版
class HomeRankingInfo {
  // 命名函数
  HomeRankingInfo({
    this.username,
    this.heat,
    this.userId,
  });
  int? heat;
  int? userId;
  String? username;
  String? fireRank;

  HomeRankingInfo.fromJson(Map<String, dynamic> json) {
    heat = json['heat'];
    username = json['username'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['heat'] = this.heat;
    data['username'] = this.username;
    data['userId'] = this.userId;
    return data;
  }
}

/// 提示语类型
class HomeTipInfo {
  // 命名函数
  HomeTipInfo({
    this.tipName,
  });
  String? tipName;
}

/// 列表数据集合
class HomeInfoModel {
  HomeInfoModel({
    this.viewType,
    this.isSquare = false,
  });
  // 网格类型
  ListViewType? viewType;
  // 网格类型长度 特殊UI需要属性 只有 关注需要
  // 默认是长方形 所以是false
  bool? isSquare;
  /// 6.23 修改，将此两种类型放出
  // 剔除游戏类型
  // HomeBannerInfo bannerGame = HomeBannerInfo();
  // 剔除跑马灯类型
  // HomeMarqueeInfo marquee   = HomeMarqueeInfo();
  HomeRankingInfo ranking = HomeRankingInfo();
  HomeTipInfo tipMessage = HomeTipInfo();
  // 单个主播
  AnchorListModelEntity anchorItem = AnchorListModelEntity();
  // banner banner接口类型3
  List<HomeBannerInfo> banner = List.empty(growable: true);
}

/// 列表模型数据总控
class HomeInfoControlModel {
  HomeInfoControlModel({
    this.page = 1,
    this.showPageView = false,
    this.requesting = false,
  });

  int page;
  bool showPageView; // 是否展示了页面
  bool requesting; // 是否在请求中
  RefreshController controller = RefreshController();
  Future future = Future.value("Hello");
  List<HomeInfoModel> homeList = [];
}
