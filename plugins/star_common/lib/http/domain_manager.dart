import 'dart:convert';

import 'package:flutter_mqtt/mqtt_manager.dart';
import 'package:flutter_mqtt/status/domain.dart';
import 'package:get/utils.dart';

import '../common/storage.dart';
import '../generated/json/base/json_field.dart';
import 'config.dart';

class DomainManager {
  String REMOTE_KEY = "REMOTE_KEY";

  DomainManager._() {
    _init();
  }

  static DomainManager? _manager;

  /// 单例共享
  static DomainManager get manager =>
      _manager != null ? _manager! : DomainManager._();

  late List<BaseDomain> prepareDomains;

  late List<BaseDomain> remoteDomains;

  late List<BaseDomain> mqttDomains;

  void _init() {
    _manager = this;
    prepareDomains =
        getDomains(DomainTypeKey.apiLocal, defaultValue: prepareUrls)
            .map((e) => LocalDomain(e, isEncrypt: false))
            .toList();
    remoteDomains = getDomains(DomainTypeKey.api)
        .map((host) => RemoteDomain(host))
        .toList();
    mqttDomains = getDomains(DomainTypeKey.mqtt)
        .map((host) => RemoteDomain(host))
        .toList();
  }

  void init(String defaultIp) {
    var domain = MqttManager.instance.getStatus<DomainStatus>();
    domain?.setListener(domainValid, DomainKey.valid);
    domain?.setListener(domainDrop, DomainKey.drop);
    MqttManager.instance.getDomian = getMqttDomain;
    MqttManager.instance.setConnectIp(defaultIp);
  }

  // 有效域名
  void domainValid(dynamic payload) {
    print("MqttManager domainValid payload::: $payload");
    try {
      var list = payload["list"];
      if (list is List) {
        Map<String, List<String>> addList = {};
        for (var domain in list) {
          String host = getDomainFormat("${domain["protocol"]}",
              "${domain["domain"]}", "${domain["port"] ?? ""}");
          if ("${domain["state"]}" == "5") {
            //域名状态 3:可使用 5:停用
            remoteDomains.removeWhere((element) => element.getHost() == host);
            continue;
          }
          String use =
              "${domain["use"]}"; // API：APP接口使用的域名 h5：h5页面使用的域名 mq：mqtt连接地址
          String group = "${(domain["group"] ?? domain["groupType"] ?? 2)}";
          List<String> domainList;
          // 1:预埋域名 2:直接使用 3:紧急备用 (，)
          if (use == DomainTypeKey.api.name) {
            if (group == "1") {
              use = DomainTypeKey.apiLocal.name; //1.预埋域名 策略继续添加
              domainList = prepareDomains.map((e) => e.getHost()).toList();
            } else {
              domainList = addList[use] ?? []; //2、3 远程域名 策略直接替换
            }
          } else {
            //api 以外类型暂未使用，不处理
            domainList = addList[use] ?? [];
          }
          domainList.add(host);
          addList[use] = domainList;
        }
        addList.forEach((key, value) {
          if (key == DomainTypeKey.apiLocal.name) {
            prepareDomains = value.map((host) => LocalDomain(host)).toList();
          }
          if (key == DomainTypeKey.api.name) {
            remoteDomains = value.map((host) => RemoteDomain(host)).toList();
          }
          if (key == DomainTypeKey.mqtt.name) {
            mqttDomains = value.map((host) => RemoteDomain(host)).toList();
          }
          saveDomainsForKey(key, value);
        });
      }
    } catch (e) {
      e.printError();
    }
  }

  String getDomainFormat(String protocol, String host, String? port) {
    String domain;
    if (port?.isNotEmpty == true) {
      domain = "$protocol://$host:$port";
    } else {
      domain = "$protocol://$host";
    }
    return domain;
  }

  // 失效域名
  void domainDrop(dynamic payload) {
    print("MqttManager domainDrop payload::: $payload");
    try {
      List<String> removeList = [];
      var list = payload["list"];
      if (list is List) {
        for (var domain in list) {
          String host = getDomainFormat(
              domain["protocol"], domain["domain"], domain["port"]);
          removeList.add(host);
        }
      }
      prepareDomains
          .removeWhere((element) => removeList.contains(element.getHost()));
      remoteDomains
          .removeWhere((element) => removeList.contains(element.getHost()));
      saveDomains(
          DomainTypeKey.api, remoteDomains.map((e) => e.getHost()).toList());
      saveDomains(DomainTypeKey.apiLocal,
          prepareDomains.map((e) => e.getHost()).toList());
    } catch (e) {
      e.printError();
    }
  }

  String? getMqttDomain() {
    for (var domain in mqttDomains) {
      if (domain.getHost() == MqttManager.instance.connectIp) {
        domain.isFail = true;
      }
    }
    return _getDomain(mqttDomains);
  }

  String? getApiDomain() {
    var remoteDomain = _getDomain(remoteDomains);
    return remoteDomain ?? _getDomain(prepareDomains);
  }

  String? _getDomain(List<BaseDomain> domains) {
    var domain = domains.where((element) => !element.isFail);
    if (domain.isNotEmpty) {
      return domain.first.getHost();
    }
    return null;
  }

  void setFail(String url) {
    for (var domain in prepareDomains) {
      if (domain.getHost() == url) {
        domain.isFail = true;
      }
    }
    for (var domain in remoteDomains) {
      if (domain.getHost() == url) {
        domain.isFail = true;
      }
    }
  }

  // void addRemoteApiDomains(List<String> hosts, String type) {
  //   var remoteHosts = remoteDomains.map((e) => e.getHost());
  //   var needAddHosts = hosts.where((element) => !remoteHosts.contains(element));
  //   if (needAddHosts.isEmpty) {
  //     return;
  //   }
  //   needAddHosts.forEach((element) {
  //     remoteDomains.add(RemoteDomain(element));
  //   });
  //   saveDomains(
  //       DomainTypeKey.api, remoteDomains.map((e) => e.getHost()).toList());
  // }

  String getDomainTypeKey(DomainTypeKey typeKey) {
    return "${REMOTE_KEY}${typeKey.name}";
  }

  void saveDomainsForKey(String key, List<String> domains) {
    DomainTypeKey.values.forEach((element) {
      if (key == element.name) {
        saveDomains(element, domains);
        return;
      }
    });
    print("not have domain key:${key}!!!");
  }

  void saveDomains(DomainTypeKey typeKey, List<String> domains) {
    StorageService.to.setList(getDomainTypeKey(typeKey), domains);
  }

  List<String> getDomains(DomainTypeKey typeKey, {List<String>? defaultValue}) {
    return StorageService.to
        .getList(getDomainTypeKey(typeKey), defaultValue: defaultValue);
  }
}

enum DomainTypeKey {
  api,
  apiLocal,
  mqtt,
  h5,
}

@JsonSerializable()
abstract class BaseDomain {
  int ping;
  bool isFail = false;
  bool isEncrypt;
  String type;

  BaseDomain(this._host,
      {this.ping = 9999, this.type = "api", this.isEncrypt = false});

  String _host;

  String getHost() {
    if (this.isEncrypt) {
      //解密操作
    }
    return _host;
  }
}

class RemoteDomain extends BaseDomain {
  RemoteDomain(host, {isEncrypt, ping})
      : super(host, ping: ping, isEncrypt: isEncrypt);
}

class LocalDomain extends BaseDomain {
  LocalDomain(host, {isEncrypt}) : super(host, isEncrypt: isEncrypt);
}
