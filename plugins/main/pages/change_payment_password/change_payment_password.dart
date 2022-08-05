/*
 *  Copyright (C), 2015-2021
 *  FileName: change_payment_password
 *  Author: Tonight丶相拥
 *  Date: 2021/11/16
 *  Description: 
 **/

import 'package:flutter/material.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/app_common_widget.dart';
import '';

class ChangePaymentPasswordPage extends StatefulWidget {
  @override
  createState() => _ChangePaymentPasswordPageState();
}

class _ChangePaymentPasswordPageState
    extends AppStateBase<ChangePaymentPasswordPage> {
  @override
  // TODO: implement appBar
  PreferredSizeWidget? get appBar => DefaultAppBar(
      title: CustomText("${intl.changePaymentPassword}",
          style: AppStyles.f17w400c0_0_0));

  @override
  // TODO: implement body
  Widget get body => Column(children: [
        SizedBox(height: 8),
        Container(
            color: Colors.white,
            width: this.width,
            child: Column(children: [])).expanded()
      ]);
}
