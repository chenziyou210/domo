/*
 *  Copyright (C), 2015-2021
 *  FileName: bank_recharge
 *  Author: Tonight丶相拥
 *  Date: 2021/7/22
 *  Description: 
 **/

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';
import 'package:star_common/i18n/i18n.dart';

class BankRechargeView extends StatefulWidget {
  @override
  createState() => _BankRechargeViewState();
}

class _BankRechargeViewState extends AppStateBase<BankRechargeView>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  final EdgeInsets padding = EdgeInsets.symmetric(horizontal: 15);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);
    return SingleChildScrollView(child: body);
  }

  @override
  // TODO: implement body
  Widget get body =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: 15),
        Container(
            padding: padding,
            child: Row(children: [
              Container(
                  width: 4,
                  height: 16,
                  decoration: BoxDecoration(
                      color: AppColors.c106_69_255,
                      borderRadius: BorderRadius.circular(2.5))),
              SizedBox(width: 8),
              Text(intl.pleaseSelectPaymentChannel,
                  style: AppStyles.f16w500c66_68_69)
            ])),
        SizedBox(height: 15),
        Container(
            height: 56,
            width: 107,
            margin: padding,
            decoration: BoxDecoration(
                color: AppColors.c248_245_255,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.c106_69_255, width: 1)),
            child: Stack(alignment: Alignment.center, children: [
              Text(intl.bankTransfer, style: AppStyles.f14w400c106_69_255),
              Positioned(
                  child: Image.asset(R.bankCardSelectedMark),
                  right: 0,
                  bottom: 0)
            ])),
        SizedBox(height: 14),
        Padding(
            padding: padding,
            child: Text(intl.rechargeAmount + "100-50000",
                style: AppStyles.f14w400c252_57_62)),
        SizedBox(height: 12),
        Padding(
            padding: padding,
            child: _BankCardWidget(
                _BankCardModel(
                    cardNumber: "150400 3301205095771",
                    bankAccount: "ICBC",
                    branch: "XX District Sub-branch",
                    payee: "xiaochuan"),
                this.intl)),
        SizedBox(height: 13),
        Container(
            padding: padding,
            decoration:
                BoxDecoration(color: AppColors.c165_59_227.withOpacity(0.05)),
            height: 38,
            child: Row(children: [
              Image.asset(R.rechargeRewards),
              SizedBox(width: 10),
              Text(intl.rechargeRewards + "3%",
                  style: AppStyles.f13w400c165_59_227)
            ])),
        SizedBox(height: 12),
        Padding(
            padding: padding,
            child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: {
                  0: IntrinsicColumnWidth(),
                  1: FlexColumnWidth()
                },
                children: [
                  TableRow(children: [
                    Text(intl.remittance + "：", style: AppStyles.f16w400c0_0_0),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: AppColors.c231_231_231, width: 1)),
                      child: CustomTextField(
                          contentPadding: EdgeInsets.zero,
                          textAlignVertical: TextAlignVertical.center,
                          hintTextStyle:
                              AppStyles.f16w400c0_0_0.withOpacity(0.35),
                          hintText: intl.pleaseEnter,
                          style: AppStyles.f16w400c0_0_0),
                    )
                  ]),
                  TableRowMargin(2, 10),
                  TableRow(children: [
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text(intl.name + "：",
                            style: AppStyles.f16w400c0_0_0)),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: AppColors.c231_231_231, width: 1)),
                      child: CustomTextField(
                          contentPadding: EdgeInsets.zero,
                          textAlignVertical: TextAlignVertical.center,
                          hintTextStyle:
                              AppStyles.f16w400c0_0_0.withOpacity(0.35),
                          hintText: intl.pleaseEnter,
                          style: AppStyles.f16w400c0_0_0),
                    )
                  ])
                ])),
        SizedBox(height: 27),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text.rich(TextSpan(
              text: intl.contactCustomerService,
              style: AppStyles.f16w400c106_69_255
                  .copyWith(decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()..onTap = () {}))
        ]),
        SizedBox(height: 25),
        Align(
            alignment: Alignment.center,
            child: GestureDetector(
                onTap: () {},
                child: Stack(alignment: Alignment.center, children: [
                  Image.asset(R.icConfirmButton,
                      height: 46, width: 223, fit: BoxFit.fill),
                  Text(intl.confirmRecharge,
                      style: AppStyles.f15w400c255_255_255)
                ]))),
        SizedBox(height: 33)
      ]);
}

class _BankCardWidget extends StatelessWidget {
  _BankCardWidget(this.entity, this.intl);
  final _BankCardModel entity;
  final AppInternational intl;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: EdgeInsets.only(left: 10, right: 15, top: 17, bottom: 23),
        decoration: BoxDecoration(
            color: AppColors.c249_249_249,
            border: Border.all(color: AppColors.c106_69_255, width: 1),
            borderRadius: BorderRadius.circular(6)),
        child: Table(children: [
          TableRow(children: [
            Text(intl.cardNumber + "：",
                style: AppStyles.f14w400c0_0_0.withOpacity(0.9)),
            Text(entity.cardNumber, style: AppStyles.f14w400c0_0_0),
            Image.asset(R.idCopy)
          ]),
          TableRowMargin(3, 10),
          TableRow(children: [
            Text(intl.payee + "：",
                style: AppStyles.f14w400c0_0_0.withOpacity(0.9)),
            Text(entity.payee, style: AppStyles.f14w400c0_0_0),
            Image.asset(R.idCopy)
          ]),
          TableRowMargin(3, 10),
          TableRow(children: [
            Text(intl.bankAccount + "：",
                style: AppStyles.f14w400c0_0_0.withOpacity(0.9)),
            Text(entity.bankAccount, style: AppStyles.f14w400c0_0_0),
            Image.asset(R.idCopy)
          ]),
          TableRowMargin(3, 10),
          TableRow(children: [
            Text(intl.branch + "：",
                style: AppStyles.f14w400c0_0_0.withOpacity(0.9)),
            Text(entity.branch, style: AppStyles.f14w400c0_0_0),
            Image.asset(R.idCopy)
          ])
        ], columnWidths: {
          0: IntrinsicColumnWidth(),
          1: FlexColumnWidth(),
          2: IntrinsicColumnWidth()
        }));
  }
}

class _BankCardModel {
  _BankCardModel(
      {required this.cardNumber,
      required this.bankAccount,
      required this.branch,
      required this.payee});
  final String cardNumber;
  final String payee;
  final String bankAccount;
  final String branch;
}
