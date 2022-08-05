import 'package:flutter/material.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';

enum DateSelectItemTypes { today, yesterday, sevenday, thirtyday, customize }

class MineDateSelect extends StatefulWidget {
  MineDateSelect({required this.type, required this.itemEvent, Key? key})
      : super(key: key);

  Function(DateSelectItemTypes type) itemEvent;
  DateSelectItemTypes type;

  @override
  State<MineDateSelect> createState() => _MineDateSelectState();
}

class _MineDateSelectState extends State<MineDateSelect> {
  final List<ItemModel> items = [
    ItemModel('今日', DateSelectItemTypes.today),
    ItemModel('昨日', DateSelectItemTypes.yesterday),
    ItemModel('近7日', DateSelectItemTypes.sevenday),
    ItemModel('近30日', DateSelectItemTypes.thirtyday),
    ItemModel('自定义', DateSelectItemTypes.customize)
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.dp,
      child: Column(children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.dp, vertical: 6.dp),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (_, index) {
                final item = items[index];
                return InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(right: 16.dp),
                    child: Column(
                      children: [
                        Text(item.title,
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: widget.type == item.type
                                    ? AppMainColors.whiteColor100
                                    : AppMainColors.whiteColor70)),
                        SizedBox(height: 4.dp),
                        widget.type == item.type
                            ? Image.asset(R.icLineColors, width: 12.dp, height: 2.dp,)
                            : Container(),
                      ],
                    ),
                  ),
                  onTap: () {
                    widget.itemEvent(item.type);
                    setState(() {
                      widget.type = item.type;
                    });
                  },
                );
              }),
        ).expanded(),
        Container(height: 1.dp, color: AppMainColors.whiteColor10)
      ]),
    );
  }
}

class ItemModel {
  ItemModel(this.title, this.type);

  String title;
  DateSelectItemTypes type;
}
