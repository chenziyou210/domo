import '../mqtt_manager.dart';
import '../mqtt_tools.dart';

class UserStatus extends BaseStatus<UserKey> {
  UserStatus({String cmd="user"}) : super(cmd);

  @override
  List<UserKey> keys=UserKey.values;
  void subLiveStream(String id) {
    MqttTool.sheard.subscribeMessage("live/app/user/$id/#");
  }

  void unsubLiveStream(String id) {
    MqttTool.sheard.subscribeMessage("live/app/user/$id/#");
  }

}
enum UserKey {
  rank,amount,coin,isAdmin,roomForbidChat,globalForbidChat,newMsg,levelCar
}