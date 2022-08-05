/*
 *  Copyright (C), 2015-2021
 *  FileName: wallet
 *  Author: Tonight丶相拥
 *  Date: 2021/7/13
 *  Description: 
 **/

import 'package:flutter/material.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/toast.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WalletPage extends StatefulWidget {
  @override
  createState() => _WalletPageState();
}

class _WalletPageState extends AppStateBase<WalletPage>
    with AutomaticKeepAliveClientMixin, Toast {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  final RefreshController _controller = RefreshController();

  // var instance;
  // var whaleLottie;
  // var whaleController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // prepareLottie();
  }

  // void prepareLottie() async {
  //   var instance = Fluttie();
  //   var whaleLottie = await instance.loadAnimationFromAsset('data/lottie_animation.json');
  //   whaleController = await instance.prepareAnimation(
  //       whaleLottie,
  //       repeatCount: const RepeatCount.infinite()
  //   );
  //   setState(() { whaleController.start(); });
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);
    return Scaffold(
      appBar: DefaultAppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: CustomText("${intl.userMessage}",
            fontSize: 18.dp, color: Colors.white),
        centerTitle: true,
        leading: Text(''),
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 16),
            child: Image.asset(
              R.clearMessage,
              width: 24.dp,
              height: 24.dp,
            ),
          ).gestureDetector(onTap: () {
            showToast("清理消息");
            show();
          }),
        ],
      ),
      body: RefreshWidget(
          controller: _controller,
          onRefresh: (c) async {
            // await _viewModel.dataRefresh();
            c.refreshCompleted();
            c.resetNoData();
          },
          enablePullUp: false,
          children: [
            SliverToBoxAdapter(
                child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 18),
                    Image.asset(
                      R.systemInformation,
                      width: 36.dp,
                      height: 36.dp,
                    ),
                    SizedBox(width: 18),
                    Column(
                      children: [
                        Row(
                          children: [
                            CustomText("系统消息",
                                    fontSize: 16.dp, color: Colors.white)
                                .expanded(),
                            CustomText("05/06 12:34",
                                    fontSize: 12.dp,
                                    color: AppMainColors.whiteColor40)
                                .padding(padding: EdgeInsets.only(right: 20)),
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            CustomText("尊敬的会员你好，根据银行相关规定",
                                    fontSize: 12.dp,
                                    color: AppMainColors.whiteColor40,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis)
                                .expanded(),
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(25)),
                              child: CustomText("13",
                                      fontSize: 12.dp, color: Colors.white)
                                  .padding(
                                      padding: EdgeInsets.only(
                                          left: 10,
                                          top: 2,
                                          bottom: 2,
                                          right: 10)),
                            )
                          ],
                        ),
                      ],
                    ).expanded(),
                  ],
                ),
                Divider(height: 0.5, color: AppMainColors.whiteColor6).padding(
                    padding: EdgeInsets.only(left: 18, top: 18, bottom: 18)),
                Row(
                  children: [
                    SizedBox(width: 18),
                    Image.asset(
                      R.onlineService,
                      width: 36.dp,
                      height: 36.dp,
                    ),
                    SizedBox(width: 18),
                    Column(
                      children: [
                        Row(
                          children: [
                            CustomText("专属客服",
                                    fontSize: 16.dp, color: Colors.white)
                                .expanded(),
                            CustomText("昨天 05/06",
                                    fontSize: 12.dp,
                                    color: AppMainColors.whiteColor40)
                                .padding(padding: EdgeInsets.only(right: 20)),
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            CustomText("处理您遇到的问题",
                                    fontSize: 12.dp,
                                    color: AppMainColors.whiteColor40,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis)
                                .expanded(),
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(25)),
                              child: CustomText("13",
                                      fontSize: 12.dp, color: Colors.white)
                                  .padding(
                                      padding: EdgeInsets.only(
                                          left: 10,
                                          top: 2,
                                          bottom: 2,
                                          right: 10)),
                            )
                          ],
                        ),
                      ],
                    ).expanded(),
                  ],
                ),
                Divider(height: 0.5, color: AppMainColors.whiteColor6)
                    .padding(padding: EdgeInsets.only(left: 18, top: 18)),
                // Container( width: 280.0, height: 200.0,
                //     child: FluttieAnimation(whaleController))
                Lottie.asset(
                  "assets/data/lottie_animation.json",
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ],
            )),
          ]),
    );
  }
}
