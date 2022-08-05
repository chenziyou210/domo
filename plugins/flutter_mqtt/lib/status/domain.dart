import 'package:mqtt_client/mqtt_client.dart';

import '../mqtt_manager.dart';
import '../mqtt_tools.dart';

class DomainStatus extends BaseStatus<DomainKey> {
  var needConnect = false;
  List<dynamic> pushMessageTask = [];

  DomainStatus({String cmd = "domain"}) : super(cmd);

  @override
  List<DomainKey> keys = DomainKey.values;

  void subDomainStream() {
    MqttTool.sheard.subscribeMessage("live/app/sub/domain/receive");
  }

  void unsubDomainStream() {
    MqttTool.sheard.unsubscribeMessage("live/app/sub/domain/receive");
  }

  void checkConnectOperation() {
    if (needConnect && pushMessageTask.isNotEmpty) {
      reportFailDomain(pushMessageTask,needFilter: false);
    }
  }

  void reportFailDomain(List<dynamic> hosts, {bool needFilter = true}) {
    List<dynamic> needReportDomains = [];
    if (needFilter) {
      for (var domainInfo in hosts) {
        var same = pushMessageTask
            .where((element) => element["domain"] == domainInfo["domain"]);
        if (same.isNotEmpty != true) {
          pushMessageTask.add(domainInfo);
          needReportDomains.add(domainInfo);
        }
      }
    } else {
      needReportDomains = hosts;
    }
    print("mqtt report:${needReportDomains.length} "
        "pushMessageTask:${pushMessageTask.length} "
        "isConnected:${MqttTool.sheard.isConnected()}");
    if (needReportDomains.isEmpty) {
      return;
    }
    if (!MqttTool.sheard.isConnected()) {
      needConnect = true;
      return;
    }
    var userId = MqttManager.instance.userId ?? "default";
    MqttTool.sheard.publishMessage("live/app/pub/$userId/domain/report", {
      "msg": "domain",
      "event": "report",
      "list": needReportDomains,
      "device": {"os": "", "model": "iPhone", "udid": ""},
      "app": {"name": "live", "bundle": "com.live.startapp", "version": "1.0"},
      "ext": "",
      "ts": DateTime.now().millisecondsSinceEpoch,
      "version": 1
    });
  }
}

enum DomainKey { valid, drop }

enum DomainPushKey { report }
/*
小土豆, [Jul 10, 2022 at 16:53:00]:
可发布的主题
live/app/pub/<userId>/domain/report 上报域名的主题

live/app/pub/<userId>/domain/report

小土豆, [Jul 10, 2022 at 17:35:42]:
默认用户密码（无userId时使用）
live/app/sub/default/domain/receive 订阅域名
live/app/pub/default/domain/report 发布域名

测试环境 liveAppUser/462f3738dbe188
 */
