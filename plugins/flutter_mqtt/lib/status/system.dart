import '../mqtt_manager.dart';
import '../mqtt_tools.dart';

class SystemStatus extends BaseStatus<SystemKey> {
  SystemStatus({String cmd="system"}) : super(cmd);

  void subLiveMerchantStream(String channelNo) {
    MqttTool.sheard.subscribeMessage("live/app/sub/system/$channelNo/#");
  }

  void unsubLiveMerchantStream(String channelNo) {
    MqttTool.sheard.unsubscribeMessage("live/app/sub/system/$channelNo#");
  }

  void subLiveStream() {
    MqttTool.sheard.subscribeMessage("live/app/sub/system/#");
  }

  void unsubLiveStream() {
    MqttTool.sheard.unsubscribeMessage("live/app/sub/system/#");
  }

  @override
  List<SystemKey> keys=SystemKey.values;

}
enum SystemKey {
  announce,anchorRank,surroundWatch
}