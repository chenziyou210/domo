// ignore_for_file: avoid_print, prefer_conditional_assignment, unnecessary_brace_in_string_interps, prefer_final_fields

import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter_mqtt/mqtt_manager.dart';
import 'package:flutter_mqtt/status/domain.dart';
import 'package:get/utils.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:typed_data/typed_buffers.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert' as convert;

typedef ConnectedCallback = void Function();

class MqttTool {
  MqttQos _qos = MqttQos.atLeastOnce;
  MqttServerClient? _client;
  static MqttTool? _instance;
  List<String> subscribeMessageTask = [];

  static MqttTool _getInstance() {
    if (_instance == null) {
      _instance = MqttTool();
    }
    return _instance!;
  }

  static MqttTool newInstance() {
    return MqttTool();
  }

  bool _isConnected = false;

  static MqttTool sheard = _getInstance();

  bool isConnected(){
    return _isConnected;
  }

  MqttConnectionState getConnectionState() {
    if (_isConnected) {
      return _client?.connectionStatus?.state ??
          MqttConnectionState.disconnecting;
    }
    return MqttConnectionState.disconnected;
  }

  /// server:服务 id:用户ID isSsl:是否加密
  Future<MqttServerClient?> connect(String server, String id,
      {bool isSsl = false}) async {
    MqttManager.instance.setConnectIp(server);
    _client = MqttServerClient.withPort(server, "live${id}", 1883);

    _client?.onConnected = onConnected;

    _client?.onSubscribed = _onSubscribed;

    _client?.autoReconnect = true;

    _client?.onSubscribeFail = _onSubscribeFail;

    _client?.onUnsubscribed = _onUnSubscribed;
    _client?.onDisconnected = _onDisconnected;
    _client?.pongCallback = () {
      print("NEO - START-mqtt MqttManager pongCallback:${_client?.server}");
    };
    _client?.setProtocolV311();
    _client?.keepAlivePeriod = 30;
    _client?.logging(on: false); //是否打印MQTT Log
    _client?.published?.listen((event) {
      print("NEO - START-mqtt published ${event}");
    });
    if (isSsl) {
      _client?.secure = true;
      _client?.onBadCertificate = (dynamic a) => true;
    }
    _tryToConnect(id);
    return _client;
  }

  void _onDisconnected() {
    var server = MqttManager.instance.connectIp;
    var id = MqttManager.instance.userId;
    if (server?.isNotEmpty == true && id?.isNotEmpty == true) {
      if (_isConnected) {
        print(
            "NEO - START-mqtt mqtt MqttManager onDisconnected:${_client?.server} ${getConnectionState()} - reconnect");
        if (_isConnected &&
            ![MqttConnectionState.connected, MqttConnectionState.connecting]
                .contains(getConnectionState())) {
          _tryToConnect(id, onError: () {
            disconnect();
            connect(MqttManager.instance.getDomian?.call()??"$server", id!);
          });
        }
      }
    }
  }

  void doMsg(Map<String, dynamic> msg) async {
    print("NEO - START-mqtt MqttTool Msg :$msg");
    if (msg.containsKey('cmd') &&
        msg.containsKey('event') &&
        (msg.containsKey('payload'))) {
      String cmd = msg['cmd'];
      String event = msg['event'];
      int delay = msg['delay'] ?? 0;
      String delayModel =
          msg['delayModel'] != null ? msg['delayModel'].toString() : '';
      dynamic payload = msg['payload'];
      print("NEO - START-mqtt MqttTool SEND Msg :$msg");
      MqttManager.instance.doMsg(cmd, event, delay, delayModel, payload);
    } else {
      print("MqttTool error Msg :" + msg.toString());
    }
  }

  ///断开MQTT连接
  disconnect() {
    _client?.onDisconnected = null;
    for (var subtopic in subscribeMessageTask) {
      _client?.unsubscribe(subtopic);
    }
    _isConnected = false;
    subscribeMessageTask.clear();
    _client?.disconnect();
    print("NEO - START-mqtt MqttManager disconnect:${_client?.server}");
  }

  ///订阅
  int? publishMessage(String pTopic, dynamic msg) {
    print("NEO - START-mqtt_发送数据-topic:$pTopic,playLoad:$msg");
    Uint8Buffer uint8buffer = Uint8Buffer();
    var codeUnits = jsonEncode(msg).codeUnits;
    uint8buffer.addAll(codeUnits);
    return _client?.publishMessage(pTopic, _qos, uint8buffer, retain: false);
  }

  ///发布消息
  int? publishRawMessage(String pTopic, List<int> list) {
    print("NEO - START-mqtt_发送数据-topic:${130102699},playLoad:$list");
    Uint8Buffer uint8buffer = Uint8Buffer();
    uint8buffer.addAll(list);
    return _client?.publishMessage(pTopic, _qos, uint8buffer, retain: false);
  }

  ///订阅消息
  Subscription? subscribeMessage(String subtopic) {
    if (_client?.subscriptionsManager?.tryGetExistingSubscription(subtopic) !=
        null) {
      return null;
    }
    if (!subscribeMessageTask.contains(subtopic)) {
      subscribeMessageTask.add(subtopic);
    }
    if (getConnectionState() == MqttConnectionState.connected) {
      print("NEO - START-mqtt subscribeMessage 订阅消息 $subtopic");
      return _client?.subscribe(subtopic, _qos);
    }
    return null;
  }

  ///取消订阅
  void unsubscribeMessage(String? unSubtopic) {
    print("NEO - START-mqtt unsubscribeMessage 取消订阅");
    subscribeMessageTask.remove(unSubtopic);
    if (unSubtopic?.isNotEmpty == true) {
      if (_isConnected) {
        _client?.unsubscribe(unSubtopic!);
      }
    }
  }

  ///MQTT状态
  MqttClientConnectionStatus? getMqttStatus() {
    return _client?.connectionStatus;
  }

  ///连接的回调
  Function()? onConnected() {
    _isConnected = true;
    print("NEO - START MqttManager onConnected:${_client?.server}");
    MqttManager.instance.getStatus<DomainStatus>()?.subDomainStream();
    var keys = subscribeMessageTask.toList();
    print("NEO - START MqttManager keys:${keys}");
    while (keys.isNotEmpty) {
      var subtopic = keys.removeLast();
      print("NEO - START MqttManager subtopic:${subtopic}");
      if (_client?.subscriptionsManager?.tryGetExistingSubscription(subtopic) ==
          null) {
        print("NEO - START MqttManager try to subscribe:${subtopic}");
        _client?.subscribe(subtopic, _qos);
      }
    }
    MqttManager.instance.getStatus<DomainStatus>()?.checkConnectOperation();
    return _client?.onConnected;
  }

  ///订阅成功
  _onSubscribed(String topic) {
    print("NEO - START-mqtt __onSubscribed 订阅主题成功---topic:$topic");
     _isConnected = true;
  }

  ///取消订阅
  _onUnSubscribed(String? topic) {
    print("NEO - START-mqtt __onUnSubscribed 取消订阅主题成功---topic:$topic");
  }

  ///订阅失败
  _onSubscribeFail(String topic) {
    print("NEO - START-mqtt 订阅失败");
  }

  Future _tryToConnect(id, {Function? onError}) async {
    if (_client != null) {
      try {
        await _client?.connect("live" + id,
            md5.convert(utf8.encode("u" + id)).toString().substring(8, 24));
        _client?.updates?.listen((event) {
          //接收消息
          print("NEO - START _tryToConnect- Listen ${event}");
          var message = event[0].payload as MqttPublishMessage;
          // var strMsg = MqttPublishPayload.bytesToStringAsString(message.payload.message);
          var strMsg = const Utf8Decoder().convert(message.payload.message);
          Map<String, dynamic> map = convert.jsonDecode(strMsg);
          doMsg(map);
        });
        _isConnected = true;
      } catch (e) {
        print("NEO - START error _tryToConnect:${e.runtimeType}");
        e.printError();
        onError?.call();
      }
    } else {
      _isConnected = false;
    }
  }
}

