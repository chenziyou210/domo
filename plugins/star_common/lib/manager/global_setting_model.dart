/*
 *  Copyright (C), 2015-2021
 *  FileName: setting_model
 *  Author: Tonight丶相拥
 *  Date: 2021/8/3
 *  Description:
 **/

part of appmanager;

class GlobalSettingModel with Toast {
  GlobalSettingModel._();
  SettingViewModel viewModel = SettingViewModel();

  Future getSystemParam() {
    return HttpChannel.channel.systemParameter().then((value) => value.finalize(
        wrapper: WrapperModel(),
        success: (data) {
          Map dic = data ?? {};
          String homeBar = dic["APP_HOME_LAB"]["paramValue"];
          String url1 = dic["APP_HOME_TAB_2_URL"]["paramValue"];
          String url2 = dic["APP_HOME_TAB_3_URL"]["paramValue"];
          String version = dic["APP_UPGRADE_VERSION"]["paramValue"];
          viewModel._setVersion(version);
          List lst = [];
          try {
            lst = jsonDecode(homeBar);
          } catch (e) {}
          viewModel._setImage(url1, url2);
          viewModel._setUpHomeBar(
              lst.map((e) => HomeItemEntity(e["id"], e["name"])).toList());
          String timeCondition = dic["APP_QUERY_PARAM"]["paramValue"];
          lst = [];
          try {
            lst = jsonDecode(timeCondition);
          } catch (e) {}
          viewModel._setUpTimeCondition(
              lst.map((e) => HomeItemEntity(e["id"], e["name"])).toList());
          String? routes = dic["APP_LIVE_ROUTE"]["paramValue"];
          lst = [];
          try {
            lst = jsonDecode(routes ?? "");
          } catch (e) {}
          viewModel._setUpRoutes(lst
              .map((e) => HomeItemEntity(e["route"], e["address"]))
              .toList());
          String url = dic["APP_SERVICE_URL"]["paramValue"];
          viewModel._setServiceUrl(url);
          String? g = dic["APP_INDEX_GAME"]?["paramValue"];
          lst = [];
          try {
            lst = jsonDecode(g ?? "");
          } catch (e) {}
          viewModel._setHomeHotGame(lst
              .map((e) => HomeHotGameEntity(
                  gameId: e["gameid"],
                  gameUrl: e["game_url"],
                  name: e["name"],
                  icon: e["icon"]))
              .toList());

          String? appShare = dic["SHARE_LINK_PARAM"]["paramValue"];
          if (appShare != null && appShare.isNotEmpty) {
            Map<String, dynamic> map = {};
            try {
              map = jsonDecode(appShare);
            } catch (e) {}
            viewModel._setShareApp(map);
          }
        }));
  }

  late Stream<String> _stream;

  void _submitToken(String token) {
    HttpChannel.channel.firebaseSubmit(token).then((value) {
      if (!value.isSuccess) {
        _submitToken(token);
      }
    });
  }

  /// 更新数据
  Future<bool> appUpgrade() {
    return PackageInfo.fromPlatform().then((info) {
      return HttpChannel.channel
          .upgradeVersion(version: info.version)
          .then((value) {
        return value
            .finalize<WrapperModel>(
                wrapper: WrapperModel(),
                success: (data) {
                  if (data == null) return;
                  viewModel._entity = UpgradeEntity.fromJson(data);
                })
            .isSuccess;
      });
    });
  }

  // Future loadData() {
  //   // TODO: implement loadData
  //   // show();
  //   return HttpChannel.channel.settingInfo()..then(
  //           (value) => value.finalize(
  //           wrapper: WrapperModel(),
  //           failure: (e) => showToast(e),
  //           success: (data) {
  //             viewModel.fromJson(data);
  //             // dismiss();
  //           }
  //       ));
  // }
  //
  // /// 系统参数
  // Future loadSystemParameter(){
  //   return HttpChannel.channel.systemParameter().then((value)
  //     => value.finalize(
  //       wrapper: WrapperModel(),
  //       success: (data) {
  //
  //       }
  //     ));
  // }
  //
  // // 保存
  // void _onSave(void Function() callback, {
  //   String? accountSecurity, String? language,
  //   int? appLock, void Function()? failure
  // }){
  //   show();
  //   HttpChannel.channel.settingUpdate(
  //       accountSecurity: accountSecurity ?? viewModel.accountSecurity,
  //       appLock: appLock ?? viewModel.appLock,
  //       id: viewModel._id,
  //       language: language ?? viewModel.language).then((value)
  //   => value.finalize(
  //       wrapper: WrapperModel(),
  //       failure: (e) {
  //         showToast(e);
  //         failure?.call();
  //       },
  //       success: (_) {
  //         callback();
  //         dismiss();
  //       }
  //   ));
  // }
  //
  // // 更新账号安全
  // void updateAccountSecurity(String state){
  //   _onSave((){
  //     viewModel.updateAccountSecurity(state);
  //   }, accountSecurity: state);
  // }
  //
  // // 更新app 锁定
  // void updateAppLock(int lock){
  //   _onSave((){
  //     viewModel.updateAppLock(lock);
  //   }, appLock: lock,
  //       failure: (){
  //         viewModel.updateAppLock(viewModel.appLock);
  //       });
  // }
  //
  // // 更新app语言
  // void updateLanguage(String language, int index){
  //   _onSave(() {
  //     viewModel.updateLanguage(language);
  //     LocalModel.local.changeLocal(index + 1);
  //   }, language: language);
  // }

  Future<void> getPackageVersion() async {
    PackageInfo value1 = await PackageInfo.fromPlatform();
    viewModel._setPackageInfo(value1.version);
    return;
  }
}

class SettingViewModel extends CommonNotifierModel {
  SettingViewModel() {
    String data = StorageService.to.getString(_key);
    if (data.isNotEmpty) {
      Map? dic = jsonDecode(data);
      if (dic != null) {
        this._index = dic["index"];
        this._ip = dic["ip"];
        this._port = dic["port"];
      }
    }
  }

  /// 更新数据
  UpgradeEntity? _entity;
  UpgradeEntity? get upgrade => _entity;

  /// 数据
  List<HomeItemEntity> _items = [];
  List<HomeItemEntity> get items => _items;

  /// 时间条件
  List<HomeItemEntity> _timeCondition = [];
  List<HomeItemEntity> get timeCondition => _timeCondition;

  /// 首页热门游戏
  List<HomeHotGameEntity> _hotGame = [];
  List<HomeHotGameEntity> get hotGame => _hotGame;

  /// 线路
  List<HomeItemEntity> _routes = [];
  List<HomeItemEntity> get routes => _routes;

  /// 分享app
  ShareAppLinkEntity? _shareApp;
  ShareAppLinkEntity? get shareApp => _shareApp;

  // final GetStorage _box = GetStorage();

  String? _url1;
  String? get url1 => _url1;
  String? _url2;
  String? get url2 => _url2;

  String? _serviceUrl;
  String? get serviceUrl => _serviceUrl;

  int _index = -1;
  int get index => _index;

  String _ip = baseUrl; //"http://api.222live.live";//a.baseUrl
  String get ip => _ip;

  String _mqtt_ip = baseMqtt; //"http://api.222live.live";//a.baseUrl
  String get mqtt_ip => _mqtt_ip;

  String _port = ""; //"";//a.port
  String get port => _port;

  String _version = "";
  // String get version => _version;

  String? _packageVersion;
  bool get isSameVersion => _packageVersion == _version;

  void _setPackageInfo(String value) {
    _packageVersion = value;
  }

  final String _key = "hjnCircuitLocal";
  void setIndex(int index, String ip, String port) {
    _index = index;
    String dic = jsonEncode({"index": index, "ip": ip, "port": port});
    StorageService.to.setString(_key, dic);
  }

  void _setShareApp(Map<String, dynamic> json) {
    _shareApp = ShareAppLinkEntity.fromJson(json);
  }

  void _setUpHomeBar(List<HomeItemEntity> items) async {
    EventBus.instance
        .notificationListener(name: homeTabItemChange, parameter: items.length);
    await Future.delayed(Duration(milliseconds: 10));
    _items = items;
    updateState();
  }

  void _setUpTimeCondition(List<HomeItemEntity> items) {
    _timeCondition = items;
    updateState();
  }

  void _setUpRoutes(List<HomeItemEntity> items) {
    _routes = items;
    updateState();
  }

  void _setVersion(String version) {
    _version = version;
  }

  void _setImage(String url1, String url2) {
    _url1 = url1;
    _url2 = url2;
    updateState();
  }

  void _setServiceUrl(String url) {
    _serviceUrl = url;
  }

  void _setHomeHotGame(List<HomeHotGameEntity> games) {
    _hotGame = games;
    updateState();
  }
  // late String _id;
  // String accountSecurity = "";
  // int appLock = 1;
  // String language = "";
  // // 数据设置
  // void fromJson(Map<String, dynamic> json){
  //   this._id = json["id"];
  //   this.accountSecurity = json["accountSecurity"];
  //   this.appLock = json["appLock"];
  //   this.language = json["language"];
  //   updateState();
  // }
  //
  // void updateAccountSecurity(String state){
  //   this.accountSecurity = state;
  //   updateState();
  // }
  //
  // void updateAppLock(int lock){
  //   this.appLock = lock;
  //   updateState();
  // }
  //
  // void updateLanguage(String language){
  //   this.language = language;
  //   updateState();
  // }
}

class HomeItemEntity {
  HomeItemEntity(this.id, this.name);
  final String id;
  final String name;
}

class HomeHotGameEntity {
  HomeHotGameEntity(
      {required this.gameId,
      required this.gameUrl,
      required this.name,
      required this.icon});
  final int gameId;
  final String icon;
  final String name;
  final String gameUrl;
}
