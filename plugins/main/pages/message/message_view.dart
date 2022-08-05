import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_common/lottie/lottie_view.dart';
import 'package:star_common/util_tool/string_extension.dart';
import 'message_logic.dart';

class MessagePage extends StatelessWidget {
  final logic = Get.put(MessageLogic());
  final state = Get.find<MessageLogic>().state;

  @override
  Widget build(BuildContext context) {
    state.context = context;
    return Stack(
      children: [
        Image.asset(
          R.appbarBg,
          width: MediaQuery.of(context).size.width,
          height: 128.dp,
          fit: BoxFit.fill,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            title: AppLayout.appBarTitle('消息'),
            centerTitle: true,
            leading: SizedBox(),
            actions: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(right: 16.dp,),
                child: Image.asset(
                  R.clearMessage,
                  width: 24.dp,
                  height: 24.dp,
                ),
              ).gestureDetector(onTap: () {
                logic.messageRead();
              }),
            ],
          ),
          body: _buildBody(),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SmartRefresher(
      controller: state.refreshController,
      enablePullDown: true,
      header: LottieHeader(),
      footer: LottieFooter(),
      onRefresh: () {
        logic.loadCustomerServiceList();
        logic.loadMessageUnreadNum();
        state.page = 1;
        logic.loadMessageSystemList();
      },
      child: CustomScrollView(
        slivers: [
          _buildMessageSystem(),
          _buildCustomer(),
        ],
      ),
    );
  }

  Widget _buildMessageSystem() {
    return SliverToBoxAdapter(
      child: GetBuilder<MessageLogic>(
        init: logic,
        id: 'message',
        builder: (logic) {
          return InkWell(
            child: Container(
              padding: EdgeInsets.only(
                left: AppLayout.pageSpace,
              ),
              height: 75.dp,
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        R.systemInformation,
                        width: 40.dp,
                        height: 40.dp,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 12.dp,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                "系统消息",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                  fontWeight: AppLayout.boldFont,
                                ),
                              ).expanded(),
                              CustomText(
                                  dateTimeTodayWithString(
                                      state.messageFirst.updateTime ?? ''),
                                  fontSize: 12.sp,
                                  color: AppMainColors.whiteColor40),
                              SizedBox(
                                width: 16.dp,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4.dp,
                          ),
                          state.messageList.length > 0
                              ? Row(
                                  children: [
                                    CustomText(
                                      state.messageFirst.content ?? '',
                                      fontSize: 12.sp,
                                      color: AppMainColors.whiteColor40,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ).expanded(),
                                    state.unreadNum > 0
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
                                                    BorderRadius.circular(
                                                        8.dp)),
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
                                    SizedBox(
                                      width: 16.dp,
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      ).expanded(),
                    ],
                  ).expanded(),
                  Container(
                    height: 1.dp,
                    color: AppMainColors.whiteColor6,
                  ),
                ],
              ),
            ),
            onTap: () => logic.pushMessageSystemPage(),
          );
        },
      ),
    );
  }

  Widget _buildCustomer() {
    return GetBuilder<MessageLogic>(
      id: 'customer',
      builder: (logic) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final customer = state.customerList[index];
              return InkWell(
                child: Container(
                  padding: EdgeInsets.only(
                    left: AppLayout.pageSpace,
                  ),
                  height: 75.dp,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: customer.icon ?? '',
                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
                              radius: 20.dp,
                              backgroundColor: Color(0xFF1E1E1E),
                              backgroundImage: imageProvider,
                            ),
                            placeholder: (context, string) {
                              return Container(
                                color: Color(0xFF1E1E1E),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return Container(
                                color: Color(0xFF1E1E1E),
                              );
                            },
                          ),
                          SizedBox(
                            width: 12.dp,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                customer.title ?? '',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                  fontWeight: AppLayout.boldFont,
                                ),
                              ),
                              SizedBox(
                                height: 4.dp,
                              ),
                              AppLayout.text40White12(customer.remark ?? ''),
                            ],
                          ),
                        ],
                      ).expanded(),
                      Container(
                        height: 1.dp,
                        color: AppMainColors.whiteColor6,
                      ),
                    ],
                  ),
                ),
                onTap: () => logic.pushCustomerPage(customer),
              );
            },
            childCount: state.customerList.length,
          ),
        );
      },
    );
  }
}
