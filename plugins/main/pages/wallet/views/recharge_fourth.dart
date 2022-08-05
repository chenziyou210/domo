/*
 *  Copyright (C), 2015-2021
 *  FileName: recharge_fourth
 *  Author: Tonight丶相拥
 *  Date: 2021/7/23
 *  Description: 
 **/

import 'package:flutter/material.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';

class RechargeFourth extends StatefulWidget {
  @override
  createState() => _RechargeFourthState();
}

class _RechargeFourthState extends AppStateBase<RechargeFourth>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  final EdgeInsets padding = EdgeInsets.symmetric(horizontal: 15);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);
    return body;
  }

  @override
  // TODO: implement body
  Widget get body => CustomScrollView(slivers: [
        SliverToBoxAdapter(
          child: SizedBox(height: 15),
        ),
        SliverToBoxAdapter(
          child: Container(
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
        ),
        SliverToBoxAdapter(child: SizedBox(height: 15)),
        SliverPadding(
            padding: padding,
            sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((_, index) {
                  if (index == 2) return _CellSelected(text: "300-1000");
                  return _Cell(text: "300-1000");
                }, childCount: 6),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 56,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 10))),
        SliverToBoxAdapter(child: SizedBox(height: 10)),
        SliverPadding(
            padding: padding,
            sliver: SliverToBoxAdapter(
                child: Container(
                    child: Text(intl.note + ":" + intl.noteContent,
                        style: AppStyles.f14w400c252_57_62)))),
        SliverToBoxAdapter(child: SizedBox(height: 15)),
        SliverToBoxAdapter(
            child: Container(
                padding: padding,
                child: Row(children: [
                  Container(
                      width: 4,
                      height: 16,
                      decoration: BoxDecoration(
                          color: AppColors.c106_69_255,
                          borderRadius: BorderRadius.circular(2.5))),
                  SizedBox(width: 8),
                  Text(intl.pleaseSelectTheRechargeAmount,
                      style: AppStyles.f16w500c66_68_69)
                ]))),
        SliverToBoxAdapter(child: SizedBox(height: 15)),
        SliverPadding(
            padding: padding,
            sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((_, index) {
                  if (index == 2) return _CellSelected(text: "300-1000");
                  return _Cell(text: "300-1000");
                }, childCount: 6),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 56,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 10))),
      ]);
}

class _Cell extends StatelessWidget {
  _Cell({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.c231_231_231, width: 1)),
        child: Text(text, style: AppStyles.f16w400c0_0_0));
  }
}

class _CellSelected extends StatelessWidget {
  _CellSelected({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: [
      Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.c106_69_255, width: 1)),
          child: Text(text, style: AppStyles.f16w400c106_69_255)),
      Positioned(
          child: Stack(children: [
            Image.asset(R.bankCardSelectedMark),
            Positioned(
                child: Image.asset(R.selectedMark,
                    width: 12,
                    height: 8,
                    fit: BoxFit.cover,
                    color: AppColors
                        .c255_255_255), //Text("", style: AppStyles.f16w400c255_255_255),
                right: 2,
                bottom: 4)
          ]),
          right: 0,
          bottom: 0)
    ]);
  }
}
