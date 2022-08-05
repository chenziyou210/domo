/*
 *  Copyright (C), 2015-2021
 *  FileName: gift_view
 *  Author: Tonight丶相拥
 *  Date: 2021/9/15
 *  Description: 
 **/

// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/common_widget/app_dialog.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_live/pages/live_room/open_guide/open_guide_view.dart';
import '../../live/change_diamond_widget.dart';
import '../live_room_new_logic.dart';
import 'gift_card/gift_card.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/generated/gift_entity.dart';
import 'package:star_common/manager/app_manager.dart';

class GiftView extends StatefulWidget {
  GiftView({required this.gifts, required this.type, required this.isAnchor});

  final int type;
  final bool isAnchor;
  final List<GiftEntity> gifts;

  @override
  createState() => _GiftViewState();
}

class _GiftViewState extends AppStateBase<GiftView>
    with AutomaticKeepAliveClientMixin, Toast {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  /// 页码控制器
  final PageController _controller = PageController();

  /// 礼物坐标
  GiftIndex _index = GiftIndex();

  /// 数量
  int _number = 1;
  bool _offstage = true;
  bool _showDialog = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);

    List<GiftEntity> lst = widget.gifts;
    // widget.gifts.addAll(lst);
    int count = widget.gifts.length;
    // count = count > 8 ? 8 : count;

    return Stack(children: [
      Container(
          width: ScreenUtil.instance.screenWidth,
          child: count == 0
              ? Container(
                  child: Center(
                      child: Text("", style: AppStyles.f14w400c255_255_255)),
                )
              : Column(children: [
                  widget.isAnchor ? Container() : SizedBox(height: 6),
                  Expanded(
                      child: PageView.builder(
                          physics: BouncingScrollPhysics(),
                          onPageChanged: (index){
                            _CustomNotification("下标是$index");
                          },
                          clipBehavior: Clip.none,
                          itemCount: count % 8 != 0
                              ? (count ~/ 8 + 1)
                              : count ~/ 8,
                          itemBuilder: (_, int page) {
                            List<GiftEntity> data =
                                (page + 1) * 8 > count
                                    ? widget.gifts
                                        .getRange(page * 8, count)
                                        .toList()
                                    : widget.gifts
                                        .getRange(page * 8, (page + 1) * 8)
                                        .toList();
                            // var e = widget.gifts[index];
                            return GridView.builder(
                                clipBehavior: Clip.none,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        mainAxisSpacing: 0,
                                        crossAxisSpacing: 0,
                                        mainAxisExtent: 105.dp),
                                itemBuilder: (_, index) {
                                  if (page == _index.page &&
                                      index == _index.index) {
                                    return Container(
                                      // padding: EdgeInsets.symmetric(
                                      //         horizontal: 8.dp) +
                                      //     EdgeInsets.only(top: 8.dp),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0.5.dp,
                                              color: AppMainColors.textColor20),
                                          borderRadius:
                                              BorderRadius.circular(8.dp),
                                          color:
                                              AppMainColors.separaLineColor6),
                                      child:
                                          GiftCard(data[index], isSelect: true),
                                    );
                                  } else {
                                    return GestureDetector(
                                        child: GiftCard(data[index]),
                                        onTap: () {
                                          _index.setLocation(page, index);
                                          unFocus();
                                          setState(() {});
                                          if (data[index].coins == 1) {
                                            _showDialog = true;
                                            _offstage= false;
                                          } else {
                                            _showDialog = false;
                                            _offstage= true;
                                          }
                                        });
                                  }
                                }, //physics: NeverScrollableScrollPhysics(),
                                itemCount: data.length);
                          },
                          controller: _controller)),
                  DotsIndicatorNormal(
                      controller: _controller,
                      unSelectColor: Colors.white,
                      onPageSelected: (index) {
                        //间距太小，不好操作，直接不加
                        // _controller.animateToPage(index,
                        //     duration: Duration(milliseconds: 100),
                        //     curve: Curves.easeIn);
                      },
                      itemCount: count % 8 != 0
                          ? (count ~/ 8 + 1)
                          : count ~/ 8),
                  widget.isAnchor ? Container() : SizedBox(height: 8.dp),
                  widget.isAnchor
                      ? Container()
                      : Row(children: [
                          SizedBox(
                            width: 16.dp,
                          ),
                          ChangeDiamondWidget(),
                          Spacer(),
                          _buildGiveWidget().marginOnly(right: 16.dp),
                        ]),
                  SizedBox(height: 8.dp + AppLayout.safeBarHeight)
                ])),
      Positioned(
          child: Offstage(
            offstage: _offstage,
            child:
                Container(
                  padding: EdgeInsets.only(right: 12.dp),
                  decoration: BoxDecoration(
                    color: AppMainColors.commonPopupBg,
                    borderRadius: BorderRadius.all(Radius.circular(8.dp)),
                    border: Border.all(
                        color: AppMainColors.whiteColor10, width: 1.dp),
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _buildGifNumItem(AppMainColors.mainColor, _gift[0],
                    roundCorner: true),
              _buildGifNumItem(Color(0xFF35FFCF), _gift[1]),
              _buildGifNumItem(Color(0xFFCCB5FF), _gift[2]),
              _buildGifNumItem(Color(0xFFEEFF87), _gift[3]),
              _buildGifNumItem(null, _gift[4]),
              _buildGifNumItem(null, _gift[5]),
              _buildGifNumItem(
                  null,
                  _gift[6],
                  bottomRadius: true,
              ),
            ]).singleScrollView(),
                ),
          ),
          right: 44.dp,
          bottom: 44.dp + AppLayout.safeBarHeight)
    ]);
  }

  Widget _buildGifNumItem(Color? numberColor, GiftDescriptionEntity e,
      {bool roundCorner = false, bool bottomRadius = false}) {
    return Container(
        padding: EdgeInsets.only(left: 7.dp),
        height: 28.dp,
        decoration: BoxDecoration(
            borderRadius: roundCorner
                ? BorderRadius.only(
                    topRight: Radius.circular(8.dp),
                    topLeft: Radius.circular(8.dp))
                : bottomRadius ?  BorderRadius.only(
                bottomLeft: Radius.circular(8.dp),
                bottomRight: Radius.circular(8.dp)) : BorderRadius.zero,
            gradient: numberColor != null
                ? LinearGradient(colors: [
                    numberColor.withOpacity(0.3),
                    numberColor.withOpacity(0.0)
                  ])
                : LinearGradient(colors: [
                    AppMainColors.commonPopupBg,
                    AppMainColors.commonPopupBg
                  ])),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: 32.dp,
            alignment: Alignment.center,
            child: CustomText(
              "${e.number}",
              fontSize: 12.sp,
              fontWeight: w_400,
              fontFamily: 'Number',
              color: numberColor ?? Colors.white,
            ),
          ),
          SizedBox(width: 8.dp),
          CustomText("${e.description}",
              fontSize: 12.sp, fontWeight: w_400, color: Colors.white)
        ])).gestureDetector(
      onTap: () {
        _offstage = !_offstage;
        _number = e.number;
        setState(() {});
      },
    );
  }

  List<GiftDescriptionEntity> get _gift => [
        GiftDescriptionEntity(1314, "${intl.inAllOnesLife}"),
        GiftDescriptionEntity(888, "发发发"),
        GiftDescriptionEntity(520, "${intl.iLoveYou}"),
        GiftDescriptionEntity(188, "${intl.wantToHug}"),
        GiftDescriptionEntity(66, "${intl.sixSixLucky}"),
        GiftDescriptionEntity(10, "${intl.perfect}"),
        GiftDescriptionEntity(1, "${intl.undividedAttention}")
      ];

  Widget _buildGiveBtn() {
    return GestureDetector(
        onTap: () {
          var user = AppManager.getInstance<AppUser>();

          var model = widget.gifts[_index.page * 8 + _index.index];

          if (model.type == 2) {
            int levelLimit = model.levelLimit ?? 0;
            int rank = user.rank ?? 0;
            if (levelLimit > rank) {
              showToast("您未到达指定等级");
            } else {
              Get.back(result: GiftModel(model.id!, _number, model.name!, model.type ?? 1));
            }
          } else if (model.type == 3) {
            if (Get.find<LiveRoomNewLogic>().state.guard.value > 2001) {
              Get.back(result: GiftModel(model.id!, _number, model.name!, model.type ?? 1));
            } else {
              _showTipDialog();
            }
          } else {
            if (!_index.isZero()) {
              Get.back();
              return;
            }
            Get.back(result: GiftModel(model.id!, _number, model.name!, model.type ?? 1));
          }
        },
        child: Container(
          width: 48.dp,
          height: 28.dp,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient:
                  const LinearGradient(colors: AppMainColors.commonBtnGradient),
              // color: AppColors.c252_103_250,
              borderRadius: BorderRadius.circular(14.dp)),
          child: Text(intl.giving, style: AppStyles.f12w400white),
        ));
  }

  _showTipDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AppDialog(
          CustomText(
            "需要开通月守护，才可对主播赠送守护特权礼物，是否开通守护？",
            style: TextStyle(
                fontSize: 14.sp, fontWeight: w_400, color: Colors.white70),
          ),
          cancelText: "取消",
          confirm: () {
            Get.back();
            Get.bottomSheet(OpenGuidePage());
          },
        );
      },
    );
  }

  Widget _buildGiveWidget() {
    if (_showDialog) {
      return Stack(
        children: [
          Container(
              width: 106.dp,
              height: 28.dp,
              padding: EdgeInsets.only(left: 9.dp),
              decoration: BoxDecoration(
                color: AppMainColors.separaLineColor6,
                borderRadius: BorderRadius.circular(14.dp),
              ),
              child: Row(children: [
                Text(
                  "$_number",
                  style: AppStyles.f12w400white,
                ),
                Image.asset(
                  R.icUpArrow,
                  width: 16.dp,
                  height: 16.dp,
                ),
              ])).gestureDetector(onTap: () {
            _offstage = !_offstage;
            setState(() {});
          }),
          _buildGiveBtn().position(left: 58.dp)
        ],
      );
    } else {
      _buildGiveBtn();
    }
    return _buildGiveBtn();
  }
}

class _CustomNotification extends Notification {
  _CustomNotification(this.msg);

  final String msg;
}
