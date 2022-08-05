import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/config/app_layout.dart';

import 'room_guardian_notes_logic.dart';
import 'room_guardian_notes_state.dart';

/// @description:
/// @author
/// @date: 2022-06-16 16:30:33
/// 守护说明
class RoomGuardianNotesPage extends StatelessWidget {
  final RoomGuardianNotesLogic logic = Get.put(RoomGuardianNotesLogic());
  final RoomGuardianNotesState state = Get.find<RoomGuardianNotesLogic>().state;

  RoomGuardianNotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Scaffold();
    return GetBuilder<RoomGuardianNotesLogic>(
        init: logic,
        builder: (c) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Color.fromRGBO(16, 16, 16, 1),
            appBar: DefaultAppBar(
              elevation: 0,
              backgroundColor: c.state.isScroll
                  ? Color.fromRGBO(16, 16, 16, 1)
                  : Colors.transparent,
              centerTitle: true,
              title: Text(
                "守护说明",
                style: TextStyle(color: Colors.white, fontSize: 18.sp),
              ),
            ),
            body: SingleChildScrollView(
                controller: logic.state.controller,
                child: Column(
                  children: [
                    Container(
                      height: 234.dp,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(R.guardianNotesTopBgIcon),
                              fit: BoxFit.fill)),
                    ),
                    item(state.title1, state.conten1),
                    item(state.title2, state.conten2),
                    table(),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      margin:
                          EdgeInsets.only(top: 30.dp, left: 16.dp, bottom: 10),
                      height: 20.dp,
                      child: Text(
                        "如何开通守护",
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                    ),
                    presentationItem(
                        R.icWeeklyGuard, "周·守护", state.week),
                    presentationItem(
                        R.icMonthlyGuard, "月·守护", state.monthly),
                    presentationItem(
                        R.icYearlyGuard, "真爱年·守护", state.yearly),
                    item(state.title3, state.conten3),
                    table1(),
                    item(state.title4, state.conten4),
                    item(state.title5, state.conten5),
                    SizedBox(
                      height: AppLayout.safeBarHeight + 15.dp,
                    )
                  ],
                )),
          );
        });
  }

  Widget item(String title, String conten) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.dp, 40.dp, 16.dp, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
          ),
          SizedBox(
            height: 5.dp,
          ),
          Text(
            conten,
            style:
                TextStyle(color: AppMainColors.whiteColor70, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }

//表格
  Widget table() {
    return Container(
      margin: EdgeInsets.fromLTRB(16.dp, 5.dp, 16.dp, 0),
      height: 131.dp,
      decoration: BoxDecoration(
          border: Border.all(
              color: Color.fromRGBO(255, 255, 255, 0.06), width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(4.dp))),
      child: Column(
        children: [
          Container(
            height: 32.dp,
            color: Color.fromRGBO(255, 255, 255, 0.06),
            child: cell("守护类型", "守护时效"),
          ),
          Container(
            height: 32.dp,
            child: cell("周守护", "7日"),
          ),
          Container(
            height: 32.dp,
            child: cell("月守护", "30日"),
          ),
          Container(
            height: 32.dp,
            child: cell("真爱年守护", "360日"),
          ),
        ],
      ),
    );
  }

//表格的cell
  Widget cell(String title, String title1) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 12.sp),
        ),
        Spacer(),
        Text(
          title1,
          style: TextStyle(color: Colors.white, fontSize: 12.sp),
        ),
        Spacer()
      ],
    );
  }

  //第二个表格,
  Widget table1() {
    return Container(
        margin: EdgeInsets.only(top: 10),
        height: 124,
        child: Column(children: [
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            height: 40,
            color: Color.fromRGBO(50, 197, 255, 0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "守护类型",
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                ),
                Text(
                  "身份标识",
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                ),
                Text(
                  "进场特效",
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                ),
                Text(
                  "专属礼物",
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                ),
                Text(
                  "防踢禁言",
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                ),
              ],
            ),
          ),
          Container(
            color: Color.fromRGBO(255, 255, 255, 0.06),
            padding:
                EdgeInsets.only(left: 16.dp, right: 16.dp, top: 5, bottom: 5),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "周守护",
                      style: TextStyle(
                          color: AppMainColors.whiteColor70, fontSize: 12.sp),
                    ),
                    Text(
                      "月守护",
                      style: TextStyle(
                          color: AppMainColors.whiteColor70, fontSize: 12.sp),
                    ),
                    Text(
                      "真爱年守护",
                      style: TextStyle(
                          color: AppMainColors.whiteColor70, fontSize: 12.sp),
                    ),
                  ],
                ),
                SizedBox(
                  width: 30.dp,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check,
                      size: 20.dp,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.check,
                      size: 20.dp,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.check,
                      size: 20.dp,
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(
                  width: 50,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check,
                      size: 20.dp,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.check,
                      size: 20.dp,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.check,
                      size: 20.dp,
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(
                  width: 60.dp,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(),
                    Icon(
                      Icons.check,
                      size: 20.dp,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.check,
                      size: 20.dp,
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(
                  width: 50.dp,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(),
                    Container(),
                    Icon(
                      Icons.check,
                      size: 20.dp,
                      color: Colors.white,
                    ),
                  ],
                )
              ],
            ),
          ).expanded()
        ]));
  }

  //介绍
  Widget presentationItem(
      String img, String title, List<GuardianNote> contens) {
    return Container(
      height: 20 + contens.length * 80,
      margin: EdgeInsets.fromLTRB(16.dp, 5.dp, 16.dp, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            img,
            width: 24,
            height: 24,
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
                span(contens),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget span(List<GuardianNote> contens) {
    var views = contens.map((e) {
      return Column(
        children: [
          RichText(
            text: TextSpan(
                text: e.title,
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
                children: [
                  TextSpan(
                      text: e.conten,
                      style: TextStyle(
                          color: AppMainColors.whiteColor70, fontSize: 14.sp))
                ]),
          ),
          SizedBox(
            height: 5,
          )
        ],
      );
    }).toList(); //富文本数组
    return Column(
      children: views,
    );
  }
}
