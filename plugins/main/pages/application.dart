/*
 *  Copyright (C), 2015-2021
 *  FileName: application
 *  Author: Tonight丶相拥
 *  Date: 2021/7/13
 *  Description: 
 **/

import 'package:easy_loading/easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mqtt/mqtt_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/abstract_mixin/chat_salon.dart';
import 'package:star_common/common/abstract_mixin/trtc_mixin.dart';
import 'package:star_common/common/storage.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/config/app_theme.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/i18n/i18n.dart';
import 'package:star_common/i18n/local_model.dart';
import 'package:star_common/manager/app_manager.dart';
import 'package:star_common/manager/user/user_info.dart';
import 'package:star_common/router/router_config.dart';
import 'package:star_live/pages/live_room/mine_backpack/mine_backpack_logic.dart';

import '../business/homepage/home_list_views/homepage_logic.dart';
import '../page_config/pages.dart';
import 'my_mine/my_mine_logic.dart';
import 'my_mine/my_mine_setting/my_mine_setting_logic.dart';

class Application extends StatefulWidget {
  @override
  createState() => _ApplicationState();
}

class _ApplicationState extends State<Application>
    with BaseWidgetImplements, ChatSalon, TRTCOperation, Toast {

  String identifier = '';

  final easyLoad = EasyLoading.init();

  final dialogBuilder = FlutterSmartDialog.init();
  final String keyAnchor = 'keyAnchor';
  @override
  void initState() {
    super.initState();
    Get.put(UserInfoLogic());
    Get.put(MyMineLogic());
    Get.put(HomepageLogic());
    Get.put(MineBackpackLogic());
    Get.put(MyMineSettingLogic());
    //客户端为false
    StorageService.to.setBool(keyAnchor, false);
    HttpChannel.channel.setUserSuccess((userId) {
      MqttManager.instance.connect(
          AppManager.getInstance<GlobalSettingModel>().viewModel.mqtt_ip,
          userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => unFocusWith(context),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: LocalModel.local),
          ChangeNotifierProvider.value(
            value: AppManager.getInstance<AppUser>(),
          ),
          ChangeNotifierProvider.value(
              value: AppManager.getInstance<GlobalSettingModel>().viewModel)
        ],
        child: Consumer<LocalModel>(
          builder: (_, localModel, __) {
            return ScreenUtilInit(
                designSize: const Size(375, 812),
                builder: (context, _) {
                  return GetMaterialApp(
                    navigatorKey: NavKey.navKey,
                    theme: themeData,
                    navigatorObservers: [FlutterSmartDialog.observer],
                    supportedLocales:
                        AppInternational.delegate.supportedLocales,
                    localizationsDelegates: [
                      AppInternational.delegate,
                      RefreshLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate
                    ],
                    locale: localModel.locale,
                    debugShowCheckedModeBanner: false,
                    title: "广岛直播",
                    getPages: AppPages.routes,
                    initialRoute:
                        StorageService.to.getString("homeBanner").isEmpty
                            ? AppRoutes.logInNew
                            : AppRoutes.advertising,
                    // home: AdvertisingPage(),
                    builder: (context, child) {
                      child = easyLoad(context, child);
                      child = dialogBuilder(context, child);
                      return MediaQuery(
                        //设置文字大小不随系统设置改变
                        data: MediaQuery.of(context)
                            .copyWith(textScaleFactor: 1.0),
                        child: child,
                      );
                    },
                  );
                });
          },
        ),
      ),
    );
  }
}
