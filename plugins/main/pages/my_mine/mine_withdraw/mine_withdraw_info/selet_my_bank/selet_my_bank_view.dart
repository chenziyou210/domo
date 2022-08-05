import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/generated/bank_list_entity.dart';

import 'selet_my_bank_logic.dart';
import 'selet_my_bank_state.dart';

/// @description:
/// @author
/// @date: 2022-06-07 15:55:38
class SeletMyBankPage extends StatefulWidget {
  SeletMyBankPage(this.type, this.dataInfo);
  final int type;

  ///银行卡信息
  final dataInfo;
  @override
  createState() => _SeletMyBankPageState();
}

class _SeletMyBankPageState extends State<SeletMyBankPage> {
  final SeletMyBankLogic logic = Get.put(SeletMyBankLogic());
  final SeletMyBankState state = Get.find<SeletMyBankLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic.requestMyBankList(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(42, 65, 85, 1),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.dp),
                topRight: Radius.circular(8.dp))),
        child: GetBuilder<SeletMyBankLogic>(
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
          },
        ));
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
              widget.type == 0 ? "选择到账银行卡" : "选择到账钱包",
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
    if (state.bankList.length == 0 && state.walletList.length == 0) {
      logic.requestMyBankList(widget.type);
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
      itemCount: widget.type == 0
          ? state.bankList.length + 1
          : state.walletList.length + 1,
      itemBuilder: ((context, index) {
        return _item(context, index);
      }),
    );
  }

  Widget _item(BuildContext context, int index) {
    return index ==
            (widget.type == 0 ? state.bankList.length : state.walletList.length)
        ? Offstage(
            offstage: widget.type == 0
                ? state.bankList.length >= 3
                : state.walletList.length >= 3,
            child: Column(children: [
              Container(
                height: 48.dp,
                padding: EdgeInsets.only(
                    left: 16.dp, right: 16.dp, top: 12.dp, bottom: 12.dp),
                alignment: Alignment.center,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Image.asset(
                        R.icWithdrawBank,
                        width: 24.dp,
                        height: 24.dp,
                      ),
                    ),
                    Text(
                      widget.type == 0 ? "添加新的银行卡" : "添加新的钱包",
                      style: TextStyle(
                          color: AppMainColors.whiteColor70, fontSize: 14.sp),
                    ).marginOnly(left: 12.dp),
                    Spacer(),
                    Image.asset(
                      R.icRightArrow,
                      width: 16.dp,
                      height: 16.dp,
                    ),
                  ],
                ),
              ).inkWell(onTap: () {
                if (widget.type == 0) {
                  logic.gotoAddNewWithdrawType(context);
                } else {
                  logic.gotoAddNewWalletType(context);
                }
              }),
              Container(
                height: 1.dp,
                margin: EdgeInsets.symmetric(horizontal: 16.dp),
                color: AppMainColors.whiteColor6,
              ),
            ]),
          )
        : Column(
            children: [
              Container(
                height: 48.dp,
                padding: EdgeInsets.only(
                    left: 16.dp, right: 16.dp, top: 12.dp, bottom: 12.dp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                            width: 24.dp,
                            height: 24.dp,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.dp)),
                            )),
                        Container(
                          width: 16.dp,
                          height: 16.dp,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(getItemIcon(index)))),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 12.dp,
                    ),
                    Text(
                      getItemText(index),
                      style: TextStyle(
                          color: AppMainColors.whiteColor70, fontSize: 14.sp),
                    ),
                    Spacer(),
                    index == checkSelectIndex()
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
            Get.back(
                result: widget.type == 0
                    ? state.bankList[index]
                    : state.walletList[index]);
          });
  }

  int checkSelectIndex() {
    if (widget.type == 0) {
      ///银行卡信息
      BankListData bankCardInfo = widget.dataInfo;
      for (int i = 0, length = state.bankList.length; i < length; i++) {
        if (state.bankList[i].bankId == bankCardInfo.bankId) {
          return i;
        }
      }
    } else {
      //钱包信息
      BindWalletListEntity walletinfo = widget.dataInfo;
      for (int i = 0, length = state.walletList.length; i < length; i++) {
        if (state.walletList[i].walletAddress == walletinfo.walletAddress) {
          return i;
        }
      }
    }
    return 0;
  }

  String getItemIcon(int index) {
    String itemText = "";
    if (widget.type == 0) {
      itemText = state.bankList[index].bankIcon!;
    } else {
      itemText = state.walletList[index].walletIcon!;
    }
    return itemText;
  }

  String getItemText(int index) {
    String itemText = "";
    if (widget.type == 0) {
      String cardNumber = index == state.bankList.length
          ? ""
          : state.bankList[index].cardNumber ?? "";
      itemText = (state.bankList[index].bankName ?? "") +
          "   (尾号${cardNumber.substring(cardNumber.length - 4)})";
    } else {
      String cardNumber = index == state.walletList.length
          ? ""
          : state.walletList[index].walletAddress ?? "";

      itemText = (state.walletList[index].walletName ?? "") +
          "   (${cardNumber.substring(0, 4)}****${cardNumber.substring(cardNumber.length - 4)})";
    }
    return itemText;
  }
}
