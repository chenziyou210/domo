import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';

import '../mine_add_bank_logic.dart';
import 'select_bank_logic.dart';
import 'select_bank_state.dart';

/// @description:
/// @author
/// @date: 2022-06-06 12:37:04
class SelectBankPage extends StatelessWidget {
  final SelectBankLogic logic = Get.put(SelectBankLogic());
  final SelectBankState state = Get.find<SelectBankLogic>().state;
  final AddBankParms callback;

  SelectBankPage(this.callback, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(42, 65, 85, 1),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.dp), topRight: Radius.circular(8.dp)),
        ),
        child: GetBuilder<SelectBankLogic>(
            init: logic,
            global: false,
            builder: (c) {
              return Column(
                children: [
                  _header(context),
                  SizedBox(
                    child: _list(context),
                    height: 300.dp,
                  ),
                ],
              );
            }));
  }

  Widget _header(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.dp), topRight: Radius.circular(8.dp)),
        color: AppMainColors.whiteColor6,
      ),
      padding: EdgeInsets.all(10.dp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 60.dp,
            child: Text(
              "取消",
              style: TextStyle(color: AppMainColors.whiteColor70),
            ).gestureDetector(onTap: () {
              Get.back();
            }),
          ),
          Container(
            child: Text(
              "选择开户银行",
              style: TextStyle(
                  color: AppMainColors.whiteColor70,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            width: 60.dp,
          ),
        ],
      ),
    );
  }

  Widget _list(BuildContext context) {
    if (state.list.isEmpty) {
      logic.requestBankList();
      return Container(
        alignment: Alignment.center,
        child: Text(
          "数据加载中...",
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: state.list.length,
      itemBuilder: ((context, index) {
        return _item(context, index);
      }),
    );
  }

  Widget _item(BuildContext context, int index) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.dp),
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      )),
                  Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "${state.list[index]['bankIcon']}"))),
                  ),
                ],
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                state.list[index]['bankName'],
                style: TextStyle(color: AppMainColors.whiteColor70),
              ),
              Spacer(),
              index == state.showIndex
                  ? Image.asset(
                      R.icAddbankRight,
                      width: 16.dp,
                      height: 16.dp,
                    )
                  : Container(
                      width: 16.dp,
                      height: 16.dp,
                    )
            ],
          ),
        ),
        Container(
          height: 1.dp,
          margin: EdgeInsets.symmetric(horizontal: 16.dp),
          color: AppMainColors.whiteColor6,
        ),
      ],
    ).inkWell(onTap: () {
      logic.selectionData(context, index);
      var data = state.list[index];
      callback.call(data['bankName'], "${data['bankId']}");
    });
  }
}
