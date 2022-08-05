// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:alog/alog.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_mqtt/mqtt_manager.dart';
import 'package:flutter_mqtt/status/game.dart';
import 'package:get/get.dart';
import 'package:httpplugin/http_result_container/http_result_container.dart';
import 'package:star_common/common/storage.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:event_bus/event_bus.dart';

import 'room_base_game/room_base_game_state.dart';
import 'room_live_game_logic.dart';

///游戏接口和长链接
class GameNetWork extends _BaseGameNetWork {
  ///事件总线
  EventBus eventBus = EventBus();

  /// 实例
  static GameNetWork? _instance;

  /// 获取实例
  static GameNetWork get shared => _getInstance();

  /// 禁止外部初始化
  GameNetWork._();
  var _roomStatus = MqttManager.instance.getStatus<GameStatus>()!;

  /// 启动
  static GameNetWork _getInstance() {
    if (_instance == null) {
      _instance = GameNetWork._();
    }
    return _instance!;
  }

  String gameToken = "";
  String gameUrl = "";
  String userid = "";
  int _netIndex = 0;
  //获取游戏URL
  void getGameEnterUrl() {
    print('NEO - START-mqtt getGameEnterUrl $_netIndex');
    if (_netIndex == 5) {
      //错误5次请求就不请求了
      return;
    }
    HttpChannel.channel.gameRoomEnter().then((value) => value.finalize(
        wrapper: WrapperModel(),
        failure: (e) {
          Future.delayed(Duration(milliseconds: 3000 * _netIndex * 2), () {
            _netIndex += 1;
            getGameEnterUrl();
          });
        },
        success: (data) {
          if (data is Map) {
            GameNetWork.shared.gameToken = data["token"];
            GameNetWork.shared.gameUrl = data["httpHost"];
            GameNetWork.shared.userid = data["userId"].toString();
            getGameTimestamp((s) {});
            if(Get.isRegistered<RoomLiveGameLogic>()){
              if (Get.find<RoomLiveGameLogic>().state.gameList.isEmpty) {
                Get.find<RoomLiveGameLogic>().requestGame();
              }
            }else{
              Get.put(RoomLiveGameLogic()).requestGame();
            }
          }
        })
    );
    print('NEO - START-mqtt subAllGame $_netIndex');
    subAllGame();
  }

  ///订阅所有游戏主题
  subAllGame() {
    print('NEO - START-mqtt subAllGame');
    _roomStatus.subAllGameStream();
    _roomStatus.setListener(_gameData, GameKey.gameLottery);
  }

  _gameData(dynamic payload) {
    print('NEO - START-mqtt MqttTool_gameData: $payload');
    if (payload != null) {
      Map<String, dynamic> map = json.decode(json.encode(payload));
      print('NEO - START-mqtt MqttTool_gameData map: $map');
      GameNetWork.shared.eventBus
          .fire(GameMqttData(GameDataResult.fromJson(map)));
    }
  }

  ///取消订阅
  dispose() {
    _netIndex = 0;
    _roomStatus.unsubAllGame();
  }
}

extension GameNetWorkExtension on GameNetWork {
  ///游戏列表
  Future<HttpResultContainer> getGameList() {
    return _requestGet("game/list", {});
  }

  /// 玩法赔率
  Future<HttpResultContainer> getGameOdds(int gameId) {
    return _requestGet("odds/list", {"gameId": "$gameId"});
  }

  ///投注记录
  Future<HttpResultContainer> getGameOrder(int gameId, int page) {
    return _requestGet("order/records",
        {"gameId": "$gameId", "page": "$page", "pageSize": "15"});
  }

  /// 开奖记录
  Future<HttpResultContainer> getGameResult(int gameId, int page) {
    return _requestGet("game/results",
        {"gameId": "$gameId", "page": "$page", "pageSize": "15"});
  }

  ///获取服务器游戏时间的秒数
  getGameTimestamp(Function(int) callSeconds) async {
    var milli = DateTime.now().millisecondsSinceEpoch; //开始请求的时间
    _getSystemTimestamp().then((value) {
      var milliDone = DateTime.now().millisecondsSinceEpoch; //完成请求的时间
      if (value == 0) {
        callSeconds(DateTime.fromMillisecondsSinceEpoch(milliDone).second);
      }
      var d = DateTime.fromMillisecondsSinceEpoch(
          value + ((milliDone - milli) ~/ 2));
      callSeconds(d.second);
    });
  }

  ///获取游戏服务器的时间戳
  Future<int> _getSystemTimestamp() async {
    var dio = Dio();
    dio.options.contentType = "application/json";
    try {
      var response = await dio.get(GameNetWork.shared.gameUrl +
          "/system/clock?${DateTime.now().millisecondsSinceEpoch}");
      return int.parse("${response.data}");
    } catch (e) {
      return DateTime.now().millisecondsSinceEpoch;
    }
  }
}

class _BaseGameNetWork {
  Future<HttpResultContainer> _requestGet(
      String path, Map<String, dynamic>? dict) async {
    var dio = Dio();
    dio.options.contentType = "application/json";
    dict!["userId"] = GameNetWork.shared.userid;
    var gameid = dict["gameId"] ?? "";
    dict["sign"] = _setSign(gameid);
    try {
      var response =
          await dio.post(GameNetWork.shared.gameUrl + "/" + path, data: dict);

      if (path == "order/records" && response.data is Map) {
        //投注记录另外处理
        return HttpResultContainer(response.data["code"], data: response.data);
      }
      if (path == "odds/list") {
        //缓存玩法赔率
        StorageService.to
            .setString("gameId${dict["gameId"]}", json.encode(response.data));
      }
      if (response.data is Map) {
        Map<String, dynamic> resul = response.data;

        return HttpResultContainer(resul["code"],
            err: resul["msg"] == null ? "" : resul["msg"],
            data: resul["list"] == null ? "" : resul["list"]);
      } else {
        if (path == "odds/list" &&
            StorageService.to.getString("gameId${dict["gameId"]}").isNotEmpty) {
          String jsonStr =
              StorageService.to.getString("gameId${dict["gameId"]}");
          Map map = json.decode(jsonStr);
          return HttpResultContainer(0, err: "", data: map["list"]);
        } else {
          return response.data;
        }
      }
    } catch (e) {
      if (path == "odds/list" &&
          StorageService.to.getString("gameId${dict["gameId"]}").isNotEmpty) {
        String jsonStr = StorageService.to.getString("gameId${dict["gameId"]}");
        Map map = json.decode(jsonStr);
        return HttpResultContainer(0, err: "", data: map["list"]);
      } else {
        return HttpResultContainer(400, err: "erro");
      }
    }
  }

  ///签名
  String _setSign(String gameId) {
    String sign = "";
    if (gameId.length > 0) {
      sign =
          "${GameNetWork.shared.userid}&${gameId}&${GameNetWork.shared.gameToken}";
    } else {
      sign = "${GameNetWork.shared.userid}&${GameNetWork.shared.gameToken}";
    }
    return md5.convert(utf8.encode(sign)).toString();
  }
}

class GameMqttData {
  GameDataResult? data;
  GameMqttData(this.data);
}
