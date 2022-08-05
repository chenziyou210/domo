import 'dart:async';
import 'dart:math';
import 'package:flutter_mqtt/status/domain.dart';
import 'package:flutter_mqtt/status/game.dart';
import 'package:flutter_mqtt/status/room.dart';
import 'package:flutter_mqtt/status/system.dart';
import 'package:flutter_mqtt/status/user.dart';
import 'package:get/utils.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'mqtt_tools.dart';


/// MqttManager
/// example：
/// void systemMsg(dynamic payload) {
///   do work
///  }
/// MqttManager.install.systemStatus.addListener(systemMsg,SystemStatus.EventMsg); //订阅
///
/// MqttManager.install.systemStatus.removeListener(systemMsg,SystemStatus.EventMsg); // 取消订阅
class MqttManager {
  MqttManager._() {
    _init();
  }

  static MqttManager? _instance;

  void Function()? loginSuccess;

  String? Function()? getDomian;

  /// 单例共享
  static MqttManager get instance =>
      _instance != null ? _instance! : MqttManager._();
  final List<BaseStatus> _status=[];

  void _init() {
    _instance = this;
    _status.add(SystemStatus());
    _status.add(UserStatus());
    _status.add(RoomStatus());
    _status.add(GameStatus());
    _status.add(DomainStatus());
  }

  void addStatus<K extends BaseStatus>(K status) {
    _status.removeWhere((element) => element is K);
    _status.add(status);
  }


  Timer? connectTimer; // 定义定时器
  String? _connectIp;
  String? _userId;

  String? get connectIp  => _connectIp;

  String? get userId  => _userId;

  bool isConnectIng = false;

  void setConnectIp(String ip){
    _connectIp = ip;
  }


  K? getStatus<K extends BaseStatus?>() {
    var result =_status.firstWhereOrNull((value) => value is K);
    return result as K?;
  }



  bool isConnected(String ip, String userId) {
    print('NEO - START MQTT GET checking if connected already? _connectIp = $_connectIp');
    print('NEO - START MQTT GET checking if connected already? _userId = $_userId');
    if (_connectIp == ip && _userId == userId) {
      var status = MqttTool.sheard.getConnectionState();
      print('NEO - START MQTT GET checking if connected already? status = $status');
      if (status == MqttConnectionState.connected ||
          status == MqttConnectionState.connecting) {
        return true;
      }
    }
    _connectIp = ip;
    _userId = userId;
    if(_userId?.isNotEmpty==true){
      loginSuccess?.call();
    }
    print('NEO - START MQTT GET checking if loginSuccess is called');
    return false;
  }

  void disConnect() {
    _connectIp = null;
    _userId = null;
    MqttTool.sheard.disconnect();
  }

  void connect(String? ip, String? userId) async {
    print('NEO - START MQTT GET START connect');
    print('NEO - START MQTT GET START1 connect: status: $isConnectIng');
    if (isConnectIng) {
      return;
    }
    isConnectIng = true;
    print('NEO - START MQTT GET START2 connect: status: $isConnectIng');
    print('NEO - START MQTT GET connect: ip: $ip');
    print('NEO - START MQTT GET connect: userId: $userId');
    if (ip?.isNotEmpty == true && userId?.isNotEmpty == true) {
      if (!isConnected(ip!, userId!)) {
        print('NEO - START MQTT GET _initConnect');
        _initConnect();
      }
    }
    isConnectIng = false;
  }
  void _initConnect(){
    connectTimer?.cancel();
    connectTimer = null;
    _connect();
    connectTimer ??= Timer.periodic(const Duration(milliseconds: 5000), (timer) {
      _connect();
    });
  }

  void _connect() async {
    if (_connectIp == null
        || _userId == null
    ) {
      connectTimer?.cancel();
      connectTimer = null;
      return;
    }
    if (!isConnected(_connectIp!, _userId!)) {
      MqttTool.sheard.connect(_connectIp!, _userId!);
    }
    print("NEO MqttManager connect Ip:$_connectIp userId:$_userId status:${MqttTool.sheard.getConnectionState()}");
    if(MqttTool.sheard.getConnectionState() == MqttConnectionState.connected){
      connectTimer?.cancel();
      connectTimer = null;
      return;
    }
  }

  void doMsg(String cmd, String event, int delay, String delayModel, dynamic payload) async {
    _status.where((element) => cmd==element.cmd).first.doMsg(delay, delayModel, event, payload);
  }
}

abstract class BaseStatus<T extends Enum> {
  BaseStatus(this.cmd);
  String cmd;
  List<T> keys=[];

  /// 监听者
  // Map<T, List<void Function(dynamic)>> _listener = {};
  final Map<T, void Function(dynamic)> _listener = {};

  dynamic payload="";
  var lastPopTime = DateTime.now();
  /// 添加观察者
  void setListener(void Function(dynamic) fn, T? event) async {
    if (event!=null) {
      if(payload == fn && DateTime.now().difference(lastPopTime) < const Duration(milliseconds: 500)){
        lastPopTime = DateTime.now();
      }else{
        _listener[event] = fn;
        payload=fn;
      }
    }
  }

  /// 通知观察者
  void notificationListener({T? event, dynamic payload, required int delay, required String delayModel}) {
    var dl = _listener[event];
    if (dl != null) {
      if (delay > 0){
        int time = 0;
        if (delayModel == 'fixed') {
          // 固定延时时间
          time = delay;
        }else{
          // 随机延时时间
          time = Random().nextInt(delay);
        }
        print("*************** delayedTime:$time *************** ");
        Future.delayed(Duration(seconds: time), () {
          dl.call(payload);
        });
      }else{
        dl.call(payload);
      }
    }
  }

  /// 移除观察者
  void removeListener(void Function(dynamic) fn, T? event,) {
    if (event != null) {
      _listener.remove(event);
    }
  }


  /// 移除所有监听
  void removeAllListener() {
    _listener.clear();
  }

  // void Function(dynamic payload)  systemMsg =(dsfsdf){
  //
  // };

  void doMsg(int delay, String delayModel, String event, dynamic payload) {
    for (var value in keys) {
      if (value.name == event){
        notificationListener(event: value, payload: payload, delay: delay, delayModel: delayModel);
        return;
      }
    }
    print("*************** miss event:$event *************** ");
  }
}








