import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mqtt/mqtt_manager.dart';
import 'package:get/get.dart';
import 'package:hjnzb/pages/upgrade/view.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:hjnzb/pages/my_mine/my_mine_view.dart';
import 'package:hjnzb/pages/tab/tabbar_control/tabbar_control_logic.dart';
import 'package:provider/provider.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_common/manager/app_manager.dart';
import 'package:star_common/manager/user/user_balance_logic.dart';
import 'package:star_common/manager/user/config_info_logic.dart';
import 'package:star_live/common/user_info_operation.dart';
import 'package:star_live/pages/live_room/mine_backpack/mine_backpack_logic.dart';
import '../../../business/homepage/live_mainview/live_mainview_view.dart';
import '../../game/jump_game_view.dart';
import '../../message/message_view.dart';
import 'package:star_live/pages/recharge/recharge/recharge_view.dart';

class TabbarControlPage extends StatefulWidget {
  const TabbarControlPage({Key? key}) : super(key: key);

  @override
  State<TabbarControlPage> createState() => _TabbarControlPageState();
}

class _TabbarControlPageState extends AppStateBase<TabbarControlPage>
    with Toast, AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  final logic = Get.put(TabbarControlLogic());
  final state = Get.find<TabbarControlLogic>().state;
  var lastPopTime = DateTime.now();

  /// 通过pageveiw创建tab栏
  var _pages = [
    LiveMainViewPage(),
    JumpGamePage(),
    RechargePage(false),
    MessagePage(),
    MyMinePage()
  ];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var setting = AppManager.getInstance<GlobalSettingModel>();
    setting.appUpgrade();
    try {
      var user = AppManager.getInstance<AppUser>();
      if (user.userId?.isNotEmpty == true) {
        MqttManager.instance.connect(setting.viewModel.mqtt_ip, user.userId);
      }
    } catch (e) {
      e.printError(info: "TabBarControlPage");
    }
    Get.put(UserBalanceLonic());
    Get.put(ConfigInfoLonic());
    Get.find<MineBackpackLogic>().loadCarList(false);
    UserInfoOperation.getGiftList(
        success: (list) {}, specialSuccess: (list) {});

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    logic.removeSystemMsgListener();
    logic.removeUserMsgListener();
    logic.state.pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    checkUpgrade(
      context: context,
      onError: (error) {
        // showToast(error);
      },
    );
    return WillPopScope(
        child: ChangeNotifierProvider.value(
          value: null,
          child: Scaffold(
            body: PageView.builder(
                physics: NeverScrollableScrollPhysics(), //禁止页面左右滑动切换
                controller: logic.state.pageController,
                // onPageChanged: _pageChanged,//回调函数
                itemCount: _pages.length,
                itemBuilder: (context, index) => _pages[index]),
            bottomNavigationBar: GetBuilder<TabbarControlLogic>(
              builder: (logic) {
                List<BottomNavigationBarItem> _batList =
                    List.generate(5, (index) {
                  return BottomNavigationBarItem(
                      label: logic.state.titleWithType(index),
                      tooltip: "",
                      icon: logic.state.tabIndex == index
                          ? changeSeledImage(index, true)
                          : changeSeledImage(index, false));
                });

                return Stack(
                  children: [
                    BottomNavigationBar(
                      items: _batList,
                      backgroundColor: AppMainColors.appbarColor,
                      onTap: (index) {
                        logic.toggleBottomType(index);
                      },
                      type: BottomNavigationBarType.fixed,
                      currentIndex: logic.state.tabIndex,
                    ),
                    Divider(height: 1,color: AppMainColors.whiteColor10).position(top: 0,left: 0,right: 0),
                  ],
                );
              },
            ),
          ),
        ),
        onWillPop: () {
          if (DateTime.now().difference(lastPopTime) > Duration(seconds: 2)) {
            lastPopTime = DateTime.now();
            showToast("${intl.exitApp}");
            return Future.value(false);
          } else {
            // 退出app
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            return Future.value(true);
          }
        });
  }

  Widget changeSeledImage(int index, bool isCureentIndex) {
    var tempImgStr = "";
    tempImgStr =
        isCureentIndex ? state.seletedImgs[index] : state.normalImgs[index];
    return index == 3
        ? messageItem(tempImgStr)
        : Image.asset(
            tempImgStr,
            width: 24.dp,
            height: 24.dp,
            fit: BoxFit.fill,
          );
  }

  Widget messageItem(String tempImgStr) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset(
          tempImgStr,
          width: 24.dp,
          height: 24.dp,
          fit: BoxFit.fill,
        ),
        Positioned(
          right: -10.dp,
          top: 0,
          child: state.unreadNum > 0
              ? Container(
            height: 16.dp,
            padding: EdgeInsets.symmetric(
              horizontal: 6.dp,
            ),
            decoration: BoxDecoration(
                color:
                AppMainColors.string2Color(
                    '#F23A3A'),
                borderRadius:
                BorderRadius.circular(8.dp)),
            child: Text(
              '${state.unreadNum}',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white,
                fontFamily: 'Number',
              ),
            ),
          )
              : Container(),
        ),
      ],
    );
  }
}

///弹窗
// Future<dynamic> showLoginDialog(BuildContext context) {
//   return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => WillPopScope(
//             onWillPop: () async => false,
//             child: AlertDialog(
//               title: Text('${intl.selectPaymentChannel}'),
//               content: Text("${intl.selectDetailsLogin}"),
//               actions: <Widget>[
//                 new FlatButton(
//                   child: new Text("${intl.guestLogin}"),
//                   onPressed: () {
//                     // guestLogin();
//                     Future.delayed(Duration(seconds: 1), () {
//                       Navigator.of(context).pop();
//                       AppCacheManager.cache.setisGuest(false);
//                     });
//                   },
//                 ),
//                 new FlatButton(
//                   child: new Text("${intl.mobileLoginRegistration}"),
//                   onPressed: () {
//                     Navigator.of(context).pushNamed(AppRoutes.logInNew);
//                   },
//                 ),
//               ],
//             ),
//           ));
// }
