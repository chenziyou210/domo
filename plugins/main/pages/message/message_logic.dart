import 'package:get/get.dart';
import 'package:httpplugin/http_result_container/http_result_container.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/router/router_config.dart';
import '../tab/tabbar_control/tabbar_control_logic.dart';
import 'message_state.dart';
import 'models/message_model.dart';
import 'models/mine_customer_model.dart';
import 'package:flutter/cupertino.dart';

class MessageLogic extends GetxController with Toast {
  final MessageState state = MessageState();
  final tabLogic = Get.find<TabbarControlLogic>();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    loadMessageUnreadNum();
    loadCustomerServiceList();
    loadMessageSystemList();
  }

  Future<String> getCustomerUrl() async {
    if (state.customerUrl.isNotEmpty) {
      return Future.value(state.customerUrl);
    } else {
      HttpResultContainer result =
          await HttpChannel.channel.customerServiceList();
      List list = result.data ?? [];
      List<CustomerModel> d =
          list.map((e) => customerModelFromJson(e)).toList();
      return d.first.url ?? '';
    }
  }

  void loadCustomerServiceList() {
    HttpChannel.channel.customerServiceList().then((value) {
      state.refreshController.refreshCompleted();
      value.finalize(
          wrapper: WrapperModel(),
          failure: (e) => showToast(e),
          success: (data) {
            List list = data ?? [];
            List<CustomerModel> d =
                list.map((e) => customerModelFromJson(e)).toList();
            state.customerList = d;
            state.customerUrl = d.first.url ?? '';
            update(['customer']);
          });
    });
  }

  void loadMessageSystemList() {
    HttpChannel.channel.messageSystemList(pageNum: state.page).then((value) {
      state.systemRefreshController.refreshCompleted();
      state.systemRefreshController.loadComplete();
      value.finalize(
          wrapper: WrapperModel(),
          failure: (e) => showToast(e),
          success: (data) {
            List list = data ?? [];
            List<MessageModel> d =
                list.map((e) => messageModelFromJson(e)).toList();
            if (state.page == 1) {
              state.messageList = [];
            } else {
              if (d.length <= 0) state.systemRefreshController.loadNoData();
            }
            state.messageList.addAll(d);
            state.messageFirst = state.messageList[0];
            update(['message']);
          });
    });
  }

  void loadMessageUnreadNum() {
    HttpChannel.channel.messageUnreadNum().then((value) {
      value.finalize(
          wrapper: WrapperModel(),
          success: (data) {
            state.unreadNum = data;
            tabLogic.state.unreadNum = data;
            tabLogic.update();
            update(['message']);
          });
    });
  }

  void messageRead() {
    if (state.unreadNum > 0) {
      state.unreadNum = 0;
      tabLogic.state.unreadNum = 0;
      tabLogic.update();
      update(['message']);
      HttpChannel.channel.messageRead().then((value) {});
    }
  }

  void pushCustomerPage(CustomerModel customer) {
    // Navigator.of(state.context)
    //     .pushNamed(AppRoutes.contactServicePage, arguments: {
    //   "url": customer.url ?? '',
    //   "title": customer.title ?? '客服',
    // });
    Get.toNamed(AppRoutes.contactServicePage,arguments: {
    "url": customer.url ?? '',
    "title": customer.title ?? '客服',
    });
  }

  void pushMessageSystemPage() {
    messageRead();
    Get.toNamed(AppRoutes.messageSystemPage);
  }
}
