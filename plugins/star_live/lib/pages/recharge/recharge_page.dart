// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unnecessary_new, prefer_is_empty

import 'package:extended_image/extended_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';

import 'package:star_common/common/toast.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/lottie/refresh_lottie_foot.dart';
import 'package:star_common/lottie/refresh_lottie_head.dart';
import 'package:star_common/base/app_base.dart';

import 'package:star_common/manager/app_manager.dart';
import 'package:get/get.dart';
import 'package:star_common/manager/user/user_balance_logic.dart';
import 'package:star_common/router/router_config.dart';

import 'recharge/recharge_logic.dart';
import 'recharge/recharge_state.dart';

class RechargePageView extends StatefulWidget {
  RechargePageView();

  @override
  createState() => _RechargePageState();
}

class _RechargePageState extends AppStateBase<RechargePageView> with Toast {
  final RechargeLogic logic = Get.find<RechargeLogic>();
  int channelsIndex = 0;
  int payTypeIndex = -1;
  int channelsChildIndex = 0;

  TextEditingController _textController = TextEditingController();
  final RefreshController refreshController = RefreshController();
  // final FocusNode _node = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (logic.state.rechargeList.isEmpty) {
      return Container();
    }
    List<RechargeChannelList>? listData =
        logic.state.rechargeList[channelsIndex].channelList;
    if (listData == null || listData.isEmpty) {
      return Container();
    }
    // //隐藏键盘
    // FocusScope.of(context).requestFocus(_node);
    RechargeChannelList channel = listData[channelsChildIndex];
    return Container(
        child: SmartRefresher(
            controller: refreshController,
            header: LottieHeader(),
            footer: LottieFooter(),
            child: CustomScrollView(slivers: [
              Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    SizedBox(height: 8),
                    CustomText("${intl.selectPaymentChannel}",
                        fontSize: 12.sp,
                        fontWeight: w_500,
                        color: Colors.white70),
                    SizedBox(height: 8.dp),
                    rechargeChannelSelection(context),
                    SizedBox(height: 24.dp),
                    CustomText("支付通道",
                        fontSize: 12.sp,
                        fontWeight: w_500,
                        color: Colors.white70),
                    SizedBox(height: 8),
                    rechargeChannelSelectionItem(),
                    SizedBox(height: 24),
                    CustomText("${intl.selectRechargeAmount}  (1元=1金币)",
                        fontSize: 12.sp,
                        fontWeight: w_500,
                        color: Colors.white70),
                    SizedBox(height: channel.isFix == 1 ? 0 : 15),
                    Offstage(
                      offstage: channel.isFix == 1,
                      child: Row(
                        children: [
                          CustomText(
                            "￥",
                            style: TextStyle(
                                fontSize: 16.dp,
                                fontWeight: w_500,
                                color: Colors.white),
                          ),
                          CustomTextField(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8.dp, vertical: 8.dp),
                            hintText: channel.isFix == 0
                                ? "存款金额, 单笔存款 ${channel.minAmount}-${channel.maxAmount}"
                                : "请选择金额",
                            textInputAction: TextInputAction.send,
                            controller: _textController,
                            textAlignVertical: TextAlignVertical.bottom,
                            onChange: (text) {
                              setState(() {
                                payTypeIndex = -1;
                              });
                            },
                            enableInteractiveSelection: false, //禁止复制,粘贴
                            inputFormatter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9]")), //限制数字
                            ],
                            hintTextStyle: AppStyles.number(14,
                                color: AppMainColors.whiteColor20),
                            style: AppStyles.number(20,
                                color: AppColors.mainColor),
                            keyboardType: TextInputType.number,
                          ).expanded(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: channel.isFix == 1 ? 0 : 11.dp,
                    ),
                    Offstage(
                        offstage: channel.isFix == 1,
                        child: CustomDivider(
                          color: AppMainColors.separaLineColor6,
                        )),
                    SizedBox(
                      height: 11.dp,
                    ),
                    rechargeAmountSelection(),
                    SizedBox(height: 16),
                    Text.rich(TextSpan(
                        text: "注：",
                        style: TextStyle(
                          color: AppMainColors.mainColor,
                          fontWeight: w_400,
                          fontSize: 12.dp,
                        ),
                        children: [
                          TextSpan(
                            text:
                                "会员必须在90秒内支付、 超时支付、修改号码、 修改金额、重复支付 商家自行负责，以运营商后台时间为准",
                            style: TextStyle(
                              color: AppMainColors.whiteColor40,
                              fontSize: 12.dp,
                            ),
                          ),
                        ])),
                    SizedBox(height: 24),
                    Text.rich(TextSpan(
                        text: "如未到账～点击",
                        style: TextStyle(
                          color: AppMainColors.whiteColor70,
                          fontWeight: w_400,
                          fontSize: 12.dp,
                        ),
                        children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = getCustomerService,
                              text: "联系客服",
                              style: TextStyle(
                                color: AppMainColors.mainColor,
                              )),
                        ])).center,
                    SizedBox(height: 10),
                    CustomText(
                      "确认充值",
                      style: TextStyle(
                        color: AppMainColors.whiteColor100,
                        fontWeight: w_400,
                        fontSize: 16.dp,
                      ),
                    )
                        .container(
                            height: 40.dp,
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 10.dp),
                            padding: EdgeInsets.symmetric(vertical: 9.dp),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: AppMainColors.commonBtnGradient),
                                borderRadius: BorderRadius.circular(20.dp)))
                        .gestureDetector(onTap: () {
                      if (_textController.text.isEmpty) {
                        showToast("请输入充值金额...");
                        return;
                      }
                      logic.requestChargeMoney(
                          _textController, "${channel.channelId}", context);
                    }),
                    SizedBox(height: 24),
                  ])).sliverToBoxAdapter
            ]),
            onRefresh: () async {
              await HttpChannel.channel
                  .userInfo()
                  .then((value) => value.finalize(
                      wrapper: WrapperModel(),
                      success: (data) {
                        AppManager.getInstance<AppUser>().fromJson(data, false);
                      }));
              logic.requestQueryChannelList();
              logic.announcement();
              Get.find<UserBalanceLonic>().userBalanceData();
              refreshController.refreshCompleted();
              return;
            }));
  }

  Future<dynamic> showRechargeDialog(BuildContext context, int index) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('温馨提示'),
              content: Text("确定充吗？"),
              actions: <Widget>[
                new TextButton(
                  child: new Text("取消"),
                  onPressed: () {
                    Get.back();
                  },
                ),
                new TextButton(
                  child: new Text("确定"),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            ));
  }

  // 支付方式
  Widget rechargeChannelSelection(BuildContext context) {
    var crossAxisCount = 3;
    var childAspectRatio = 2.7;
    var w = (MediaQuery.of(context).size.width - 40) / crossAxisCount;
    var h = w / childAspectRatio;
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: GridView.builder(
        physics: new NeverScrollableScrollPhysics(),
        //禁用滑动事件
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount, //每行三列
          childAspectRatio: childAspectRatio,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: logic.state.rechargeList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                setState(() {
                  channelsIndex = index;
                  payTypeIndex = -1;
                  channelsChildIndex = 0;
                  _textController.clear();
                });
              },
              child: Container(
                  decoration: new BoxDecoration(
                    color: channelsIndex == index
                        ? AppMainColors.mainColor.withAlpha(25)
                        : AppMainColors.separaLineColor6,
                    //设置四周圆角 角度
                    borderRadius: BorderRadius.all(Radius.circular(h / 2)),
                    //设置四周边框
                    border: new Border.all(
                        width: 1,
                        color: channelsIndex == index
                            ? AppMainColors.mainColor.withOpacity(0.3)
                            : Colors.transparent),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10.dp,
                      ),
                      ExtendedImage.network(
                          logic.state.rechargeList[index].iconUrl ?? "",
                          width: 24.dp,
                          height: 24.dp,
                          fit: BoxFit.fill),
                      SizedBox(
                        width: 6.dp,
                      ),
                      CustomText(logic.state.rechargeList[index].name ?? "",
                          fontSize: 14.sp,
                          fontWeight: w_400,
                          color: channelsIndex == index
                              ? AppMainColors.mainColor
                              : Colors.white)
                    ],
                  )));
        },
      ),
    );
  }

  // 支付通道
  Widget rechargeChannelSelectionItem() {
    List<RechargeChannelList> listData =
        logic.state.rechargeList[channelsIndex].channelList!;
    var crossAxisCount = 3;
    var childAspectRatio = 3.4;
    var w = (MediaQuery.of(context).size.width - 40) / crossAxisCount;
    var h = w / childAspectRatio;
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: GridView.builder(
        physics: new NeverScrollableScrollPhysics(),
        //禁用滑动事件
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount, //每行三列
          childAspectRatio: childAspectRatio,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: listData.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                setState(() {
                  channelsChildIndex = index;
                  payTypeIndex = -1;
                  _textController.clear();
                });
              },
              child: Container(
                  decoration: new BoxDecoration(
                    color: channelsChildIndex == index
                        ? AppMainColors.string2Color("FF1EAF").withOpacity(0.1)
                        : AppMainColors.separaLineColor6,
                    //设置四周圆角 角度
                    borderRadius: BorderRadius.all(Radius.circular(h / 2)),
                    //设置四周边框
                    border: new Border.all(
                        width: 1,
                        color: channelsChildIndex == index
                            ? AppMainColors.string2Color("FF1EAF")
                                .withOpacity(0.3)
                            : Colors.transparent),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(listData[index].channelName ?? "",
                          fontSize: 14.sp,
                          fontWeight: w_400,
                          color: channelsChildIndex == index
                              ? AppMainColors.mainColor
                              : Colors.white)
                    ],
                  )));
        },
      ),
    );
  }

  // 支付金额
  Widget rechargeAmountSelection() {
    var listData = logic
        .state.rechargeList[channelsIndex].channelList![channelsChildIndex];
    if (listData.isFix == 0 && (listData.fixAmount ?? "").length == 0) {
      return Container();
    }
    List amountList = listData.fixAmount.toString().split(',');
    var crossAxisCount = 4;
    var childAspectRatio = 2.46;
    var w = (MediaQuery.of(context).size.width - 50) / crossAxisCount;
    var h = w / childAspectRatio;
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: GridView.builder(
        physics: new NeverScrollableScrollPhysics(),
        //禁用滑动事件
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount, //每行三列
          childAspectRatio: childAspectRatio,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10, //显示区域宽高相等
        ),
        itemCount: amountList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                setState(() {
                  payTypeIndex = index;
                });
                FocusScope.of(context).requestFocus(FocusNode());
                _textController.text = amountList[index];
              },
              child: Container(
                  alignment: Alignment(0, 0),
                  decoration: new BoxDecoration(
                    color: index == payTypeIndex
                        ? AppMainColors.mainColor.withAlpha(25)
                        : AppMainColors.whiteColor6,
                    //设置四周圆角 角度
                    borderRadius: BorderRadius.all(
                      Radius.circular(h / 2),
                    ),
                    border: new Border.all(
                        width: 1,
                        color: index == payTypeIndex
                            ? AppMainColors.mainColor.withOpacity(0.3)
                            : Colors.transparent),
                  ),
                  child: CustomText(
                    amountList[index],
                    style: AppStyles.number(14.sp,
                        color: index == payTypeIndex
                            ? AppMainColors.string2Color("FF1EAF")
                            : AppMainColors.whiteColor70),
                  )));
        },
      ),
    );
  }

  getCustomerService() {
    show();
    //todo 联系客服
    getCustomerUrl().then((url) {
      dismiss();
      Get.toNamed(AppRoutes.contactServicePage, arguments: {
        "url": url,
        "title": "${intl.customService}",
      });
    });
  }

  Future<String> getCustomerUrl() async {
    final result = await HttpChannel.channel.customerServiceList();
    List list = result.data['data'] ?? [];
    if (list.isNotEmpty) {
      return list.first['url'].toString();
    } else {
      return "";
    }
  }
}
