import 'dart:async';
import 'dart:io';
import 'package:alog/alog.dart';
import 'package:appscheme/appscheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mqtt/mqtt_manager.dart';
import 'package:get/get.dart';
import 'package:hjnzb/pages/my_mine/my_mine_setting/my_mine_setting_logic.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/http/domain_manager.dart';
import 'package:star_common/manager/app_manager.dart';
import 'package:hjnzb/pages/application.dart';
import 'package:httpplugin/httpplugin.dart';
import 'package:im_flutter_sdk/im_flutter_sdk.dart';
import 'package:star_common/config/config.dart';
import 'package:star_common/http/cache.dart';
import 'package:star_common/http/containers.dart';
import 'package:star_common/http/error_deal.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/common/storage.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  ScreenUtil().initialize();
  Alog.init(true);
  WidgetsFlutterBinding.ensureInitialized();
  // if (Platform.isIOS || Platform.isAndroid) {
  //   var httpProxy = await HttpProxy.createHttpProxy();
  //   HttpOverrides.global = httpProxy;
  // }
  var options = EMOptions(
    appKey: appKey,
    deleteMessagesAsExitGroup: true,
    deleteMessagesAsExitChatRoom: true,
    autoAcceptGroupInvitation: true,
    debugModel: true,
  );
  // EMOptions options = EMOptions(appKey: appKey, autoLogin: false, debugModel: true);
  await EMClient.getInstance.init(options);
  await Get.putAsync<StorageService>(() => StorageService().init());
  var model = AppManager.getInstance<GlobalSettingModel>();
  await HttpChannel.channel.setUpChannel(
      config: HttpConfig(
          ip: model.viewModel.ip,
          port: model.viewModel.port,
          maxSlave: 8,
          maxLongRunningSlave: 5,
          statusCodeIgnoreRetry: [401, 403],
          errorDeal: CustomErrorDeal(tokenInvalid: () {
            (Get.find<MyMineSettingLogic>())
                .tokenLoginOut(NavKey.navKey.currentContext!);
          }),
          slaveCloseTime: 600,
          enableOauth: false,
          enableRedirect: false),
      cache: AppCacheManager.cache);

  HttpChannel.channel.addTickContainers(AppRequest.request);
  DomainManager.manager.init(model.viewModel.mqtt_ip);
  MqttManager.instance.loginSuccess = () {
    HttpChannel.channel.domainList()
      ..then((value) => value.finalize(
          wrapper: WrapperModel(),
          success: (data) {
            for (var key in ["list", "direct", "embedded", "emergency"]) {
              if (data[key] != null) {
                DomainManager.manager.domainValid({"list": data[key]});
              }
            }
            if (data["version"] != null) {
              StorageService.to
                  .setString("DOMAIN_VERSION", "${data["version"]}");
            }
          }));
  };

  var appScheme = AppSchemeImpl.getInstance();

  appScheme?.getInitScheme().then((value) {
    if (value != null) {
      print("the scheme value is $value ---- ");
    }
  });

  appScheme?.getLatestScheme().then((value) {
    if (value != null) {
      print("the getLatestScheme value is $value ---- ");
    }
  });

  appScheme?.registerSchemeListener().listen((value) {
    if (value != null) {
      print("the registerSchemeListener value is ${value.dataString} --- ");
    }
  });

  try {
    SystemUiOverlayStyle systemUiOverlayStyle;
    if (Platform.isAndroid) {
      // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
      systemUiOverlayStyle = SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    } else {
      // systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarBrightness: Brightness.light);
    }


    //异常捕获
    void reportErrorAndLog(FlutterErrorDetails details) {
      final errorMsg = {
        "exception": details.exceptionAsString(),
        "stackTrace": details.stack.toString(),
      };
      print("reportErrorAndLog 异常捕获 : $errorMsg");
      /// 这里可以上报错误

    }

    FlutterErrorDetails makeDetails(Object error, StackTrace stackTrace) {
      // 构建错误信息
      return FlutterErrorDetails(stack: stackTrace, exception: error);
    }

    FlutterError.onError = (FlutterErrorDetails details) {
      //获取 widget build 过程中出现的异常错误
      reportErrorAndLog(details);
    };
    //同步异步异常都能收集
    runZonedGuarded(
          () {
            SystemChrome.setPreferredOrientations(
                [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
                .then((value) {
              runApp(Application());
            });
      },
          (error, stackTrace) {
        //没被我们catch的异常
        reportErrorAndLog(makeDetails(error, stackTrace));
      },
    );

  } catch (_) {
    runApp(Application());
  }
}
