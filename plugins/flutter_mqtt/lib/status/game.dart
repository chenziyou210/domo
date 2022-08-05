import '../mqtt_manager.dart';
import '../mqtt_tools.dart';

class GameStatus extends BaseStatus<GameKey> {
  GameStatus({String cmd = "game"}) : super(cmd);

  @override
  List<GameKey> keys = GameKey.values;

  ///订阅游戏
  void subGameStream(String gameID) {
    MqttTool.sheard.subscribeMessage("live/app/sub/game/${gameID}/#");
  }

  ///订阅所有游戏
  void subAllGameStream() {
    MqttTool.sheard.subscribeMessage("live/app/sub/game/#");
  }

  ///取消订阅
  void unsubGameStream(String gameID) {
    MqttTool.sheard.unsubscribeMessage("live/app/sub/game/${gameID}/#");
  }

  ///取消所有游戏订阅
  void unsubAllGame() {
    MqttTool.sheard.unsubscribeMessage("live/app/sub/game/#");
  }
}

enum GameKey { gameLottery }
