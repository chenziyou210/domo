import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:hjnzb/pages/my_mine/mine_income_expenditure_details/views/dashed_line.dart';
import 'package:star_common/config/app_layout.dart';

class MineCustomizeDate extends StatelessWidget {
  MineCustomizeDate(
      {required this.startDate,
      required this.endDate,
      required this.quitEvent,
      required this.sureEvent,
      Key? key})
      : super(key: key);

  Function(DateTime startDate, DateTime endDate) quitEvent;
  Function(DateTime startDate, DateTime endDate) sureEvent;
  DateTime startDate;
  DateTime endDate;

  final now = DateTime.now();
  final minDate = DateTime.now().subtract(Duration(days: 180));

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: ScreenUtil().screenHeight,
      color: AppMainColors.blackColor60,
      child: Container(
        color: AppMainColors.string2Color('#161722'),
        height: 308.dp,
        child: Column(
          children: [
            Container(
              child: Stack(
                children: [
                  Positioned(
                    left: 16.dp,
                    top: 16.dp,
                    bottom: 16.dp,
                    child: _buildStartEndCard(),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    top: 0,
                    left: 72.dp,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: AppLayout.pageSpace),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildTopDateSelect(),
                          Container(height: 1.dp, color: AppMainColors.whiteColor6),
                          _buildBottomDateSelect()
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ).expanded(),
            _buildBottomCard()
          ],
        ),
      ),
    );
  }

  Widget _buildStartEndCard() {
    return Container(
      width: 56.dp,
      decoration: BoxDecoration(
          color: AppMainColors.string2Color('#0FEEFF87'),
          borderRadius: BorderRadius.circular(29.dp)),
      padding: EdgeInsets.symmetric(vertical: 24.dp),
      child: Column(
        children: [
          Text('起',
              style: TextStyle(
                  color: AppMainColors.string2Color('#EEFF87'), fontSize: 14.sp)),
          Container(
                  child: DashedLine(axis: Axis.vertical, count: 8),
                  padding: EdgeInsets.symmetric(vertical: 8.dp))
              .expanded(),
          Text('止',
              style: TextStyle(
                  color: AppMainColors.string2Color('#EEFF87'), fontSize: 14.sp)),
        ],
      ),
    );
  }

  Widget _buildTopDateSelect() {
    return Container(
      child: CupertinoTheme(
          data: CupertinoThemeData(
              textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle: TextStyle(
                      color: AppMainColors.whiteColor100, fontSize: 16))
          ),
          child: CupertinoDatePicker(
              backgroundColor: Colors.transparent,
              mode: CupertinoDatePickerMode.date, // 展示模式, 默认为 dateAndTime
              initialDateTime: DateTime(
                  startDate.year, startDate.month, startDate.day), // 默认选中日期
              minimumDate:
                  DateTime(minDate.year, minDate.month, minDate.day), // 最小可选日期
              maximumDate: DateTime(now.year, now.month, now.day), // 最大可选日期
              minimumYear: minDate.year, // 最小可选年份
              maximumYear: now.year, // 最大可选年份
              onDateTimeChanged: (DateTime value) {
                startDate = value;
              })),
      height: 120.dp,
    );
  }

  Widget _buildBottomDateSelect() {
    return Container(
      child: CupertinoTheme(
          data: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
              dateTimePickerTextStyle: TextStyle(color: AppMainColors.whiteColor100, fontSize: 16,),
            ),
          ),
          child: CupertinoDatePicker(
              backgroundColor: Colors.transparent,
              mode: CupertinoDatePickerMode.date, // 展示模式, 默认为 dateAndTime
              initialDateTime:
                  DateTime(endDate.year, endDate.month, endDate.day), // 默认选中日期
              minimumDate:
                  DateTime(minDate.year, minDate.month, minDate.day), // 最小可选日期
              maximumDate: DateTime(now.year, now.month, now.day), // 最大可选日期
              minimumYear: minDate.year,
              maximumYear: now.year,
              onDateTimeChanged: (DateTime value) {
                endDate = value;
              })),
      height: 120.dp,
    );
  }

  Widget _buildBottomCard() {
    return Container(
      height: 64.dp,
      color: AppMainColors.whiteColor6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            child: Container(
              child: AppLayout.textWhite16('取消'),
              alignment: Alignment.center,
              height: 40.dp,
              width: 150.dp,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.dp),
                  color: AppMainColors.whiteColor20),
            ),
            onTap: () {
              quitEvent(startDate, endDate);
            },
          ),
          GestureDetector(
              child: Container(
                child: AppLayout.textWhite16('确定'),
                alignment: Alignment.center,
                height: 40.dp,
                width: 150.dp,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.dp),
                    gradient: LinearGradient(
                        colors: AppMainColors.commonBtnGradient)),
              ),
              onTap: () {
                sureEvent(startDate, endDate);
              }),
        ],
      ),
    );
  }
}
