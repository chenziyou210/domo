/*
 *  Copyright (C), 2015-2021
 *  FileName: wallet_model
 *  Author: Tonight丶相拥
 *  Date: 2021/7/22
 *  Description: 
 **/

import 'package:star_common/base/app_base.dart';

class WalletModel extends AppModel {
  final WalletViewModel viewModel = WalletViewModel();

  void changeIndex(int index) {
    viewModel._changeIndex(index);
  }
}

class WalletViewModel extends CommonNotifierModel {
  int _index = 1;
  int get index => _index;

  void _changeIndex(int index) {
    _index = index;
    updateState();
  }
}
