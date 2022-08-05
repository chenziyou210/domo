import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/common_widget/live/peerage_widget.dart';
import 'package:star_common/common/common_widget/live/sex_icon_widget.dart';
import 'package:star_common/manager/user/user_info.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';
import 'package:star_common/common/toast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:star_common/lottie/refresh_lottie_foot.dart';
import 'package:star_common/lottie/refresh_lottie_head.dart';
import 'package:star_common/router/router_config.dart';
import '../../business/homepage/models/homepage_model.dart';
import '../../business/homepage/home_list_views/homepage_logic.dart';
import '../../business/homepage/widget/homepage_widget.dart';
import 'my_mine_logic.dart';
import 'my_mine_state.dart';

/// @description:
/// @author  Austin  个人中心
/// @date: 2022-05-24 16:16:17

class MyMinePage extends StatefulWidget {
  @override
  createState() => _MyMinePageState();
}

class _MyMinePageState extends AppStateBase<MyMinePage>
    with TickerProviderStateMixin, Toast {
  final MyMineLogic logic = Get.find<MyMineLogic>();
  final MyMineState state = Get.find<MyMineLogic>().state;
  final RefreshController refreshController = RefreshController();
  final UserInfoState userInfoState = Get.find<UserInfoLogic>().state;
  final UserInfoLogic userInfoLogic = Get.find<UserInfoLogic>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic.appBannerLoad();
    logic.requestGamesData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          R.appbarBg,
          width: this.width,
          height: 128.dp,
          fit: BoxFit.fill,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            leading: SizedBox(),
            actions: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(right: 16.dp,),
                child: Image.asset(
                  R.mineSetting,
                  width: 32.dp,
                  height: 32.dp,
                  fit: BoxFit.cover,
                ),
              ).gestureDetector(onTap: () {
                logic.gotoSetting(context);
              }),
            ],
          ),
          body: _buildBody(context),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      header: LottieHeader(),
      footer: LottieFooter(),
      onRefresh: () {
        userInfoLogic.requestUserInfo(failure: (e) {
          refreshController.refreshCompleted();
        }, success: () {
          refreshController.refreshCompleted();
        });
        logic.appBannerLoad();
        logic.requestGamesData();
      },
      onLoading: () {},
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.dp),
        child: Column(
          children: [
            avatar(context),
            SizedBox(height: 16.dp),
            wallet(context),
            SizedBox(height: 16.dp),
            Obx(() {
              var banner = logic.state.banner;
              if (banner != null && banner.length > 0) {
                return _bannerWidget(context);
              } else {
                return Container();
              }
            }),
            _gamesWidgets(),
            groupGbView(goupList(state.group1 ,state.title1, state.img1)),
            groupGbView(goupList(state.group2 ,state.title2, state.img2)),
            SizedBox(
              height: 8.dp,
            )
          ],
        ),
      ),
    );
  }

  Widget avatar(BuildContext context) {
    return Obx(() {
      return InkWell(
        onTap: () {
          logic.gotoUserInfo(context);
        },
        child: Row(
          children: [
            GestureDetector(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.dp),
                ),
                child: Stack(
                  clipBehavior: Clip.antiAlias,
                  children: [
                    CircleAvatar(
                      radius: 40.dp,
                      backgroundColor: Color(0xFF1E1E1E),
                      backgroundImage:
                          NetworkImage(userInfoState.userInfo.value.avatar),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 24.dp,
                        width: 80.dp,
                        alignment: Alignment.center,
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                        child: Text(
                          " 编辑 ",
                          style: TextStyle(
                              color: AppColors.main_white_opacity_7,
                              fontSize: 10.sp),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () => logic.goEditInfo(context),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.dp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userInfoState.userInfo.value.nickname,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: GetBuilder<UserInfoLogic>(builder: (logic) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            UserLevelView(logic.state.user.rank ?? 0),
                            PeerageWidget(logic.state.user.nobleLevel, 4),
                            SizedBox(
                              width:
                                  (logic.state.user.rank ?? 0) > 0 ? 4.dp : 0,
                            ),
                            SexIconWidget(userInfoState.userInfo.value.sex),
                          ],
                        );
                      }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.dp),
                      child: GetBuilder<UserInfoLogic>(builder: (logic) {
                        return Row(
                          children: [
                            Text(
                              "ID:  ${logic.state.user.shortId}",
                              style: TextStyle(
                                  color: AppColors.main_white_opacity_7,
                                  fontSize: 12.sp),
                            ),
                            SizedBox(
                              width: 6.dp,
                            ),
                            InkWell(
                              child: Container(
                                // width: 50,
                                decoration: BoxDecoration(
                                  // color: AppColors.mine_wallet_gb,
                                  border: Border.all(
                                      color: AppColors.mine_wallet_line,
                                      width: 1.dp),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4.dp),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 1.dp, horizontal: 4.dp),
                                child: Text(
                                  " 复制 ",
                                  style: TextStyle(
                                      color: AppColors.main_white_opacity_7,
                                      fontSize: 8.sp),
                                ),
                              ),
                              onTap: () {
                                Clipboard.setData(ClipboardData(
                                    text: logic.state.user.shortId ?? ""));
                                showToast("复制成功");
                              },
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            Image.asset(
              R.mineRight,
              width: 16.dp,
              height: 16.dp,
              fit: BoxFit.cover,
            ),
          ],
        ),
      );
    });
  }

  Widget wallet(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.dp),
      decoration: BoxDecoration(
        color: AppMainColors.whiteColor6,
        border: Border.all(color: AppColors.mine_wallet_line, width: 1.dp),
        borderRadius: BorderRadius.all(
          Radius.circular(8.dp),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          walletItem(R.mineWallet1, "钱包").inkWell(onTap: () {
            logic.gotoWallet(context);
          }),
          walletItem(R.mineWallet2, "提现").inkWell(onTap: () {
            // if ((userInfoState.user.phone ?? '').isEmpty) {
            //   _showBindPhoneDialog(context);
            // } else {
            //   logic.gotoWithDraw(context);
            // }
            logic.gotoWithDraw(context);
          }),
          walletItem(R.mineWallet3, "贵族").inkWell(onTap: () {
            logic.gotoNoble(context);
          }),
          walletItem(R.mineWallet4, "活动").inkWell(
            onTap: () {
              logic.gotoActive(context);
            },
          ),
          // walletItem(AppImages.mine_wallet5, "推广"),
        ],
      ),
    );
  }

  Widget walletItem(
    String iamges,
    String name,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          iamges,
          width: 48.dp,
          height: 48.dp,
          fit: BoxFit.cover,
        ),
        Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: 12.sp),
        )
      ],
    );
  }

  Widget banner() {
    return Container(
      height: 160.dp,
      alignment: Alignment.center,
      width: double.infinity,
      color: AppColors.mine_wallet_gb,
      child: Text(
        "Banner",
        style: TextStyle(color: Colors.white, fontSize: 14.sp),
      ),
    );
  }

  Widget groupGbView(Widget view) {
    return Container(
      // color: AppColors.mine_wallet_line,
      margin: EdgeInsets.only(bottom: 8.dp),
      child: view,
    );
  }

  Widget goupList(List types, List titles, List imgs) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.mine_wallet_line,
          borderRadius: BorderRadius.all(Radius.circular(8.dp))),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: ((context, index) {
          return GestureDetector(
            child: Column(
              children: [
                Container(
                  height: 49.dp,
                  padding: EdgeInsets.symmetric(horizontal: 16.dp),
                  child: Row(
                    children: [
                      Image.asset(
                        imgs[index],
                        width: 24.dp,
                        height: 24.dp,
                      ),
                      SizedBox(width: 12.dp),
                      Text(
                        titles[index],
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ).expanded(),
                      types[index] == GroupTypes.phoneApprove
                          ? GetBuilder<UserInfoLogic>(builder: (logic) {
                              String phone = userInfoState.user.phone ?? '';
                              phone = phone.isEmpty
                                  ? ''
                                  : phone.replaceFirst(
                                      new RegExp(r'\d{4}'), '****', 3);
                              return Text(
                                phone,
                                style: TextStyle(
                                    color: AppMainColors.whiteColor40,
                                    fontSize: 14.sp),
                              );
                            })
                          : Container(),
                      Image.asset(
                        R.mineRight,
                        width: 16.dp,
                        height: 16.dp,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                index == types.length - 1
                    ? Container()
                    : Container(
                        margin: EdgeInsets.only(right: 16.dp, left: 52.dp),
                        height: 1.dp,
                        color: AppColors.mine_wallet_line,
                      ),
              ],
            ),
            onTap: () {
              logic.mineItemEvent(types[index], context);
            },
          );
        }),
        itemCount: types.length,
      ),
    );
  }

  Widget _bannerWidget(BuildContext context) {
    return HomeBannerWidget(logic.state.banner, (bannerIndex) {
      var url = logic.state.banner[bannerIndex].url!;
      if (url.contains("http")) {
        Map<String, dynamic> args = {"url": url};
        homeWebPage(context, args);
      } else {
        Map<String, dynamic> args = {"url": "http://www.baidu.com"};

        ///网络跳转
        homeWebPage(context, args);
      }
    });
  }
}

// 游戏模块
Widget _gamesWidgets() {
  return Obx(() {
    final homePageLogic = Get.find<HomepageLogic>();
    final MyMineLogic logic = Get.find<MyMineLogic>();
    int count = logic.state.games.length > 4 ? 4 : logic.state.games.length;

    return count > 0
        ? Container(
            height: 48.dp,
            margin: EdgeInsets.only(top: 8.dp, bottom: 16.dp),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: count,
              // 可以滚动
              // scrollDirection: Axis.vertical,
              // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              //   mainAxisSpacing: 8,
              //   crossAxisSpacing: 8,
              //   childAspectRatio: 0.58,
              //   maxCrossAxisExtent: 50,
              // ),
              // 值展示4个
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                //mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                //childAspectRatio: 1.8,
                mainAxisExtent: 48.dp,
              ),
              itemBuilder: (context, index) {
                HomeBannerInfo gameInfo = logic.state.games[index];
                // HomeBannerInfo itemModel = HomeBannerInfo();
                return HomeGameItem(gameInfo).inkWell(onTap: () {
                  //游戏点击
                  homePageLogic.tapGameInfoMeth(context, gameInfo);
                });
              },
            ),
          )
        : Container();
  });
}
