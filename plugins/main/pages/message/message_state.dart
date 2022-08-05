import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'models/message_model.dart';
import 'models/mine_customer_model.dart';

class MessageState {
  late RefreshController refreshController = RefreshController();
  late RefreshController systemRefreshController = RefreshController();
  List<CustomerModel> customerList = [];
  List<MessageModel> messageList = [];
  late MessageModel messageFirst = MessageModel();
  late BuildContext context;
  int page = 1;
  int unreadNum = 0;
  String customerUrl = '';

  MessageState() {
    ///Initialize variables
  }
}
