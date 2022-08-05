
import '../mqtt_manager.dart';
import '../mqtt_tools.dart';

class RoomStatus extends BaseStatus<RoomKey> {
  RoomStatus({String cmd="room"}) : super(cmd);

  @override
  List<RoomKey> keys=RoomKey.values;

  void subLiveStream(String roomId,String userId) {
    MqttTool.sheard.subscribeMessage("live/app/sub/room/$roomId/common/#");

    MqttTool.sheard.subscribeMessage("live/app/sub/room/$roomId/$userId/#");
  }


  void unsubLiveStream(String roomId,String userId) {
    MqttTool.sheard.unsubscribeMessage("live/app/sub/room/$roomId/common/#");
    MqttTool.sheard.unsubscribeMessage("live/app/sub/room/$roomId/$userId/#");
  }

}
enum RoomKey {
  joinRoom,
  leaveRoom,
  gift,
  roomForbidChat,
  isAdmin,
  follow,
  mirror,
  pause,
  charge,
  watch,
  payWatch,
  rank,
  gameBet,
  gameBetResult,
  close,
}