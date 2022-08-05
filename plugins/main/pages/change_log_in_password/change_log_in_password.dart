/*
 *  Copyright (C), 2015-2021
 *  FileName: change_log_in_password
 *  Author: Tonight丶相拥
 *  Date: 2021/11/13
 *  Description: 
 **/

import 'package:flutter/material.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/app_common_widget.dart';
import '';
import 'package:star_common/common/colors.dart';

class ChangeLogInPasswordPage extends StatefulWidget {
  @override
  createState() => _ChangeLogInPasswordPageState();
}

class _ChangeLogInPasswordPageState
    extends AppStateBase<ChangeLogInPasswordPage> {
  /// 行高
  final double _rowHeight = 50;

  /// border
  final Border _border =
      Border(bottom: BorderSide(color: AppColors.c244_244_244));

  /// 旧密码
  final TextEditingController _oldPassword = TextEditingController();

  /// 新密码
  final TextEditingController _enterNewPassword = TextEditingController();

  /// 确认新密码
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  // TODO: implement appBar
  PreferredSizeWidget? get appBar => DefaultAppBar(
      title: CustomText("${intl.modifyLoginPassword}",
          style: AppStyles.f17w400c0_0_0));

  @override
  // TODO: implement body
  Widget get body => Container(
        child: Column(children: [
          SizedBox(height: 8),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              color: Colors.white,
              width: this.width,
              child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: {
                    0: IntrinsicColumnWidth(),
                    1: FlexColumnWidth()
                  },
                  children: [
                    TableHeightRow(
                        alignment: Alignment.centerLeft,
                        rowHeight: _rowHeight,
                        decoration: BoxDecoration(border: _border),
                        children: [
                          CustomText("${intl.email}",
                              style: AppStyles.f13w400c255_255_255
                                  .copyWith(color: AppColors.c153_153_153)),
                          CustomText("13699996666@gmail.com",
                                  style: AppStyles.f13w400c255_255_255
                                      .copyWith(color: AppColors.c153_153_153))
                              .padding(padding: EdgeInsets.only(left: 8))
                        ]),
                    TableHeightRow(
                        decoration: BoxDecoration(border: _border),
                        alignment: Alignment.centerLeft,
                        rowHeight: _rowHeight,
                        children: [
                          CustomText("${intl.oldPassword}",
                                  style: AppStyles.f12w400c0_0_0)
                              .container(
                                  height: _rowHeight,
                                  alignment: Alignment.centerLeft),
                          CustomTextField(
                              hintText: intl.enter + " " + intl.oldPassword,
                              controller: _oldPassword,
                              hintTextStyle:
                                  AppStyles.f13w400c255_255_255.copyWith(
                                color: AppColors.c204_204_204,
                              ),
                              style: AppStyles.f13w400c255_255_255
                                  .copyWith(color: Colors.black))
                        ]),
                    TableHeightRow(
                        alignment: Alignment.centerLeft,
                        rowHeight: _rowHeight,
                        decoration: BoxDecoration(border: _border),
                        children: [
                          CustomText("${intl.newPassword}",
                              style: AppStyles.f12w400c0_0_0),
                          CustomTextField(
                              hintText: intl.enter + " " + intl.oldPassword,
                              controller: _enterNewPassword,
                              hintTextStyle:
                                  AppStyles.f13w400c255_255_255.copyWith(
                                color: AppColors.c204_204_204,
                              ),
                              style: AppStyles.f13w400c255_255_255
                                  .copyWith(color: Colors.black))
                        ]),
                    TableHeightRow(
                        decoration: BoxDecoration(border: _border),
                        alignment: Alignment.centerLeft,
                        rowHeight: _rowHeight,
                        children: [
                          CustomText("${intl.confirmAgain}",
                              style: AppStyles.f12w400c0_0_0),
                          CustomTextField(
                              hintText: intl.enter + " " + intl.oldPassword,
                              controller: _confirmPassword,
                              hintTextStyle:
                                  AppStyles.f13w400c255_255_255.copyWith(
                                color: AppColors.c204_204_204,
                              ),
                              style: AppStyles.f13w400c255_255_255
                                  .copyWith(color: Colors.black))
                        ])
                  ])).expanded()
        ]),
      );
}
