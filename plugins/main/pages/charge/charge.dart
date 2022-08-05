/*
 *  Copyright (C), 2015-2021
 *  FileName: charge
 *  Author: Tonight丶相拥
 *  Date: 2021/11/29
 *  Description: 充值界面
 **/

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';
import 'package:star_common/common/toast.dart';
import 'charge_logic.dart';

class ChargePage extends StatefulWidget {
  ChargePage({this.arguments});
  final Map<String, dynamic>? arguments;
  @override
  createState() => _ChargePageState();
}

class _ChargePageState extends AppStateBase<ChargePage> with Toast {
  /// 控制器
  final ChargeLogic _controller = ChargeLogic();
  final TextEditingController _amountController = TextEditingController();
  late final Future _future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(_controller);
    _future = _controller.showBank();
  }

  @override
  // TODO: implement appBar
  PreferredSizeWidget? get appBar => DefaultAppBar(
          title: CustomText("${intl.chargeChannel}",
              fontSize: 16, fontWeight: w_600, color: Colors.black),
          actions: [
            IconButton(onPressed: () {}, icon: Image.asset(R.question))
                .center
          ]);

  @override
  Widget get body => LoadingWidget(
      builder: (_, __) {
        return body1;
      },
      future: _future);

  Widget get body1 => Container(
          child: Column(children: [
        SizedBox(height: 16),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          // padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 32, mainAxisSpacing: 16),
              itemCount: _controller.state.data.length,
              itemBuilder: (_, index) {
                var model = _controller.state.data[index];
                return Obx(() {
                  return Align(
                      child: _BankItem(
                              isSelected:
                                  _controller.state.index.value == index,
                              image: model.pic ?? "",
                              title: model.name ?? "")
                          .gestureDetector(onTap: () {
                    _controller.selectBank(index);
                  }));
                });
              }),
        ),
        SizedBox(height: 16),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomText("${intl.chargeAmount}",
                  fontSize: 16, fontWeight: w_600, color: Colors.black),
              SizedBox(height: 16),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 232, 232, 232)
                                .withOpacity(0.25),
                            offset: Offset(15, 20),
                            blurRadius: 45)
                      ],
                      border: Border.all(
                          color: Color.fromARGB(255, 238, 238, 238))),
                  padding: EdgeInsets.only(left: 8),
                  child: CustomTextField(
                    controller: _amountController,
                    inputFormatter: [OnlyInputInt()],
                    onChange: (_) {
                      _controller.selectIndex(-1);
                    },
                    prefixIcon: CustomText("￥",
                            fontWeight: w_500,
                            fontSize: 16,
                            color: Colors.black)
                        .container(
                            padding: EdgeInsets.only(right: 4),
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        color:
                                            Color.fromARGB(255, 225, 225, 225),
                                        width: 1)))),
                    hintText: "${intl.pleaseEnterAmount}",
                    hintTextStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: w_500,
                        color: Color.fromARGB(255, 176, 176, 177)),
                    style: TextStyle(fontSize: 14, fontWeight: w_500),
                    textAlignVertical: TextAlignVertical.top,
                  )),
              SizedBox(height: 8),
              Row(children: [
                Wrap(children: [
                  CustomText(
                      "${intl.explain}:${intl.notes}:${intl.chargeNotes}",
                      fontSize: 10,
                      fontWeight: w_400,
                      color: Color.fromARGB(255, 138, 138, 138))
                ]).expanded()
              ]),
              Obx(() {
                return Offstage(
                    offstage: _controller.state.index.value == -1,
                    child: [
                      SizedBox(height: 8),
                      Obx(() {
                        if (_controller.state.index.value == -1)
                          return SizedBox();
                        return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisExtent: 53,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) {
                              var model = _controller
                                  .state
                                  .data[_controller.state.index.value]
                                  .date![index];
                              return Align(
                                  alignment: Alignment.center,
                                  child: Obx(() {
                                    return _ExchangeItem(
                                        isSelected: index ==
                                            _controller.state.index1.value,
                                        diamond: "${model.diamond ?? "--"}",
                                        amount: "${model.amount ?? "--"}");
                                  }).gestureDetector(onTap: () {
                                    _amountController.clear();
                                    _controller.selectIndex(index);
                                  }));
                            },
                            itemCount: _controller
                                    .state
                                    .data[_controller.state.index.value]
                                    .date
                                    ?.length ??
                                0);
                      })
                    ].column());
              })
            ])),
        SizedBox(height: 37),
        Container(
                width: 148,
                height: 47,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(23.5),
                    gradient:
                        LinearGradient(colors: AppColors.buttonGradientColors)
                    // gradient: LinearGradient(
                    //   begin: Alignment.topCenter,
                    //   end: Alignment.bottomCenter,
                    //   colors: [
                    //     Color.fromARGB(255, 170, 60, 243),
                    //     Color.fromARGB(255, 116, 77, 247)
                    //   ])
                    ),
                child: CustomText("${intl.confirm}",
                    fontSize: 13, fontWeight: w_500, color: Colors.white))
            .gestureDetector(onTap: () {
          _controller.confirm(_amountController.text, (url) {
            showToast("${intl.rechargeSuccess}");
            // pushViewControllerWithName(AppRoutes.urlPage, arguments: {
            //   "url": url
            // });
          }, widget.arguments);
        }),
        SizedBox(height: 16)
      ])).visibleSingleScrollView(needBounds: false);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<ChargeLogic>();
  }
}

class _ExchangeItem extends StatelessWidget {
  _ExchangeItem(
      {required this.isSelected, required this.diamond, required this.amount});
  final bool isSelected;
  final String diamond;
  final String amount;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: isSelected
                ? null
                : Border.all(color: Color.fromARGB(255, 243, 243, 243)),
            gradient: isSelected
                ? LinearGradient(colors: AppColors.buttonGradientColors
                    // begin: Alignment.topCenter,
                    // end: Alignment.bottomCenter,
                    // colors: [
                    //   Color.fromARGB(255, 170, 60, 243),
                    //   Color.fromARGB(255, 116, 77, 247)
                    // ]
                    )
                : null),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CustomText("￥$amount",
              fontWeight: w_600,
              fontSize: 14,
              color: isSelected
                  ? Colors.white
                  : Color.fromARGB(255, 170, 60, 243)),
          SizedBox(height: 4),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(R.coin),
            SizedBox(width: 2),
            CustomText("$diamond",
                fontWeight: w_400,
                fontSize: 14,
                color: isSelected ? Colors.white : Colors.black)
          ])
        ]));
  }
}

class _BankItem extends StatelessWidget {
  _BankItem(
      {required this.isSelected, required this.image, required this.title});
  final bool isSelected;
  final String image;
  final String title;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget widget = Stack(children: [
      Container(
          margin: EdgeInsets.all(4),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 211, 209, 216).withOpacity(0.3),
                    offset: Offset(18, 18),
                    blurRadius: 36)
              ]),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ExtendedImage.network(image,
                width: 38, height: 38, enableLoadState: false),
            SizedBox(height: 4),
            CustomText("$title", textAlign: TextAlign.center)
          ])),
      if (isSelected)
        Positioned(
            child: Image.asset(R.routesSelected), bottom: 0, right: 0)
    ]).sizedBox(width: 77, height: 86);
    if (isSelected)
      return CustomGradientBorderContainer(
          gradient: LinearGradient(colors: AppColors.buttonGradientColors),
          // gradient: LinearGradient(colors: [
          //   Color.fromARGB(255, 170, 60, 243),
          //   Color.fromARGB(255, 116, 77, 247)
          // ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          child: widget);
    else
      return widget;
  }
}
