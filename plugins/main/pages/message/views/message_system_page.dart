import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_common/lottie/lottie_view.dart';
import 'package:star_common/util_tool/string_extension.dart';
import '../message_logic.dart';
import '../models/message_model.dart';

class MessageSystemPage extends StatefulWidget {
  @override
  State<MessageSystemPage> createState() => _MessageSystemPageState();
}

class _MessageSystemPageState extends State<MessageSystemPage> {
  final logic = Get.put(MessageLogic());
  final state = Get.find<MessageLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (state.messageList.isEmpty) {
      state.page = 1;
      logic.loadMessageSystemList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: AppLayout.appBarTitle('系统消息'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GetBuilder<MessageLogic>(
          init: logic,
          id: 'message',
          builder: (logic) {
            return SmartRefresher(
              controller: state.systemRefreshController,
              enablePullDown: true,
              enablePullUp: true,
              header: LottieHeader(),
              footer: LottieFooter(),
              onRefresh: () {
                state.page = 1;
                logic.loadMessageSystemList();
              },
              onLoading: () {
                state.page++;
                logic.loadMessageSystemList();
              },
              child: state.messageList.isEmpty
                  ? EmptyView(emptyType: EmptyType.noMessage)
                  : ListView.builder(
                      itemCount: state.messageList.length,
                      itemBuilder: (context, index) {
                        return _buildItem(state.messageList[index]);
                      },
                    ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildItem(MessageModel model) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          AppLayout.pageSpace, 24.dp, AppLayout.pageSpace, 0),
      child: Column(
        children: [
          Container(
            child: AppLayout.text70White12(
              dateTimeTodayWithString(model.updateTime ?? ''),
            ),
          ),
          SizedBox(
            height: 8.dp,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.dp, vertical: 8.dp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.dp),
              color: AppMainColors.whiteColor6,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppLayout.textWhite14(model.title ?? ''),
                SizedBox(
                  height: 4.dp,
                ),
                Text(
                  model.content ?? '',
                  style: TextStyle(
                    color: AppMainColors.whiteColor70,
                    fontSize: 12.sp,
                  ),
                  maxLines: null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
