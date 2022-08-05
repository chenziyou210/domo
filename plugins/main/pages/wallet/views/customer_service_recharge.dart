/*
 *  Copyright (C), 2015-2021
 *  FileName: customer_service_recharge
 *  Author: Tonight丶相拥
 *  Date: 2021/7/22
 *  Description: 
 **/

import 'package:flutter/material.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';
import 'package:extended_image/extended_image.dart';
import 'package:star_common/i18n/i18n.dart';

class CustomServiceRecharge extends StatefulWidget {
  @override
  createState() => _CustomServiceRechargeState();
}

class _CustomServiceRechargeState extends AppStateBase<CustomServiceRecharge>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);
    return body;
  }

  final EdgeInsets padding = EdgeInsets.symmetric(horizontal: 15);

  @override
  // TODO: implement body
  Widget get body => Column(children: [
        Container(
            width: double.infinity,
            color: AppColors.c255_255_255,
            padding: padding + EdgeInsets.symmetric(vertical: 10),
            child: Text(intl.customerServiceInsteadOfRecharge,
                style: AppStyles.f14w400c252_57_62)),
        Container(
            width: double.infinity, height: 10, color: AppColors.c243_243_243),
        SizedBox(height: 9),
        Expanded(
            child: Padding(
                padding: padding,
                child: Container(
                  child: Column(children: [
                    Row(children: [
                      Container(
                          width: 4,
                          height: 16,
                          decoration: BoxDecoration(
                              color: AppColors.c106_69_255,
                              borderRadius: BorderRadius.circular(2.5))),
                      SizedBox(width: 8),
                      Text(intl.customService,
                          style: AppStyles.f16w500c66_68_69)
                    ]),
                    SizedBox(height: 9),
                    Expanded(
                        child: ListView.separated(
                            padding: EdgeInsets.zero,
                            itemBuilder: (_, index) {
                              return InkWell(
                                  onTap: () {},
                                  child: CustomServiceCell(
                                      _CustomServiceViewModel(
                                          avatar: "",
                                          signature: "Exclusive recharge",
                                          name: "Name",
                                          label: "idle")));
                            },
                            separatorBuilder: (_, __) => CustomDivider(
                                height: 1, color: AppColors.c239_239_239),
                            itemCount: 4))
                  ]),
                )))
      ]);
}

const String _url =
    "https://img2.baidu.com/it/u=1077360284,2857506492&fm=26&fmt=auto&gp=0.jpg";

class CustomServiceCell extends StatelessWidget {
  CustomServiceCell(this.entity);
  final _CustomServiceViewModel entity;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10) + EdgeInsets.only(top: 1),
        child: Row(children: [
          ClipRRect(
              child: ExtendedImage.network(_url,
                  enableLoadState: false,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(25)),
          SizedBox(width: 13),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Row(children: [
                  Text("${entity.name}", style: AppStyles.f16w400c0_0_0),
                  SizedBox(width: 16),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                          color: AppColors.c66_205_107,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text("${entity.label}",
                          style: AppStyles.f12w400c255_255_255))
                ]),
                SizedBox(height: 2),
                Text("${entity.signature}",
                    style: AppStyles.f14w400c0_0_0.withOpacity(0.35)),
              ])),
          GestureDetector(
              onTap: () {},
              child: Stack(alignment: Alignment.center, children: [
                Image.asset(R.icConfirmButton,
                    width: 74, height: 28, fit: BoxFit.fill),
                Text(AppInternational.of(context).recharge,
                    style: AppStyles.f12w400c255_255_255)
              ]))
        ]));
  }
}

class _CustomServiceViewModel {
  _CustomServiceViewModel(
      {required this.signature,
      required this.name,
      required this.avatar,
      required this.label});

  final String avatar;
  final String name;
  final String label;
  final String signature;
}
