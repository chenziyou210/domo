/*
 *  Copyright (C), 2015-2022
 *  FileName: package_view
 *  Author: Tonight丶相拥
 *  Date: 2022/4/25
 *  Description: 
 **/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/generated/gift_entity.dart';
import 'package:star_common/common/colors.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/i18n/i18n.dart';
import '../../../live/change_diamond_widget.dart';
import '../gift_card/gift_card.dart';

import 'package:star_common/generated/package_gift_entity.dart';

class PackageView extends StatefulWidget {
  @override
  createState() => _PackageViewState();
}

class _PackageViewState extends State<PackageView>
    with AutomaticKeepAliveClientMixin {
  List<PackageGiftEntity> _gifts = [];

  late final Future future;

  /// 页码控制器
  final PageController _controller = PageController();

  /// 礼物坐标
  GiftIndex _index = GiftIndex();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    future = HttpChannel.channel.userPackageList();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);
    var intl = AppInternational.of(context);

    return Container(
        child: [
      LoadingWidget(
              placeHolderBuilder: (_) =>
                  Column(mainAxisSize: MainAxisSize.min, children: [
                    Image.asset(R.packageEmpty),
                    SizedBox(height: 16),
                    CustomText("${intl.dataEmpty}",
                        fontSize: 14,
                        fontWeight: w_500,
                        color: Color.fromARGB(255, 109, 112, 133))
                  ]),
              builder: (_, snapshot) {
                List data = snapshot.data.data["data"];
                _gifts =
                    data.map((e) => PackageGiftEntity.fromJson(e)).toList();
                return Container(
                    child: Column(children: [
                  Expanded(
                      child: PageView.builder(
                          itemCount: _gifts.length % 8 != 0
                              ? (_gifts.length ~/ 8 + 1)
                              : _gifts.length ~/ 8,
                          itemBuilder: (_, int page) {
                            List<PackageGiftEntity> data =
                                (page + 1) * 8 > _gifts.length
                                    ? _gifts
                                        .getRange(page * 8, _gifts.length)
                                        .toList()
                                    : _gifts
                                        .getRange(page * 8, (page + 1) * 8)
                                        .toList();
                            // var e = widget.gifts[index];
                            return GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8,
                                        mainAxisExtent: 113),
                                itemBuilder: (_, index) {
                                  var model = data[index];
                                  Widget widget = GiftCard(GiftEntity()
                                    ..picUrl = model.giftImg
                                    ..coins = model.remainQuantity
                                    ..name = model.giftName);
                                  if (page == _index.page &&
                                      index == _index.index) {
                                    widget = Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color.fromARGB(255, 31, 34, 51)
                                              .withOpacity(0.5)),
                                      child: widget,
                                    );
                                    widget = CustomGradientBorderContainer(
                                      child: widget,
                                      strokeWidth: 0.5,
                                      radius: 10,
                                      gradient: LinearGradient(
                                          colors:
                                              AppColors.buttonGradientColors),
                                    );
                                    widget = CustomGradientBorderContainer(
                                      child: widget,
                                      strokeWidth: 0.5,
                                      radius: 10,
                                      gradient: LinearGradient(
                                          colors:
                                              AppColors.buttonGradientColors),
                                    );
                                  } else {
                                    widget = GestureDetector(
                                        child: widget,
                                        onTap: () {
                                          _index.setLocation(page, index);
                                          setState(() {});
                                        });
                                  }
                                  return widget;
                                },
                                //physics: NeverScrollableScrollPhysics(),
                                itemCount: data.length);
                          },
                          controller: _controller)),
                  SizedBox(height: 8),
                  DotsIndicatorNormal(
                      controller: _controller,
                      unSelectColor: Colors.red,
                      onPageSelected: (index) {
                        _controller.animateToPage(index,
                            duration: Duration(milliseconds: 100),
                            curve: Curves.easeIn);
                      },
                      itemCount: _gifts.length % 8 != 0
                          ? (_gifts.length ~/ 8 + 1)
                          : _gifts.length ~/ 8),
                  SizedBox(height: 8),
                ]));
              },
              future: future)
          .expanded(),
      SizedBox(height: 16),
      Row(children: [
        ChangeDiamondWidget(),
        Spacer(),
        Container(
          margin: EdgeInsets.only(left: 8.dp),
          padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: AppMainColors.commonBtnGradient),
              // color: AppColors.c252_103_250,
              borderRadius: BorderRadius.circular(20)),
          child: Text(intl.giving, style: AppStyles.f12w400white),
        ).cupertinoButton(onTap: () {
          if (!_index.isZero()) {
            Get.back();
            return;
          }
          var model = _gifts[_index.page * 8 + _index.index];
          Get.back(result: GiftModel(model.giftId ?? 1, _number, model.giftName!, 2));
          // Navigator.of(context)
          //     .pop(GiftModel(model.giftId ?? 1, _number, model.giftName!, 2));
        }),
        SizedBox(width: 8)
      ]),
      SizedBox(height: 40),
    ].column());
  }

  int _number = 1;

  AppInternational get intl => AppInternational.current;
}
