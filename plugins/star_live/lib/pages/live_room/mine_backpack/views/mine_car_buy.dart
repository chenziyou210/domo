import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/common_widget/app_dialog.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/generated/car_list_entity.dart';
import 'package:star_common/config/app_layout.dart';
import '../../../recharge/recharge/recharge_view.dart';
import '../mine_backpack_logic.dart';

class MineCarBuy extends StatefulWidget {
  final CarListEntity model;
  MineCarBuy(this.model);

  @override
  createState() => _CarBuyState(model);
}

class _CarBuyState extends State<MineCarBuy> with Toast {
  final CarListEntity model;
  _CarBuyState(this.model);

  final logic = Get.find<MineBackpackLogic>();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 362.dp,
        decoration: BoxDecoration(
          color: AppMainColors.string2Color('#161722'),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          image: DecorationImage(
              image: AssetImage(R.carBuyBg),
              alignment: Alignment.topCenter),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 16.dp,
            ),
            ExtendedImage.network(model.carStaticUrl,
                height: 193.dp, width: 193.dp),
            Container(
              padding: EdgeInsets.fromLTRB(
                  AppLayout.pageSpace, 12.dp, AppLayout.pageSpace, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.carName,
                      style: TextStyle(
                          color: AppMainColors.adornColor, fontSize: 16.sp)),
                  SizedBox(
                    height: 8.dp,
                  ),
                  Container(
                    child: Row(
                      children: [
                        AppLayout.text70White12('原件: ${model.monthPrice}钻/月'),
                        SizedBox(
                          width: 24.dp,
                        ),
                        AppLayout.text70White12(
                            '续费: ${model.monthRenewalPrice}钻/月'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24.dp,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          child: Image.asset(R.rechargeZuanshi),
                          width: 18,
                          height: 18,
                        ),
                        SizedBox(
                          width: 2.dp,
                        ),
                        AppLayout.textWhite12('钻石'),
                        SizedBox(
                          width: 2.dp,
                        ),
                        AppLayout.textWhite14(
                                '${model.carBuyState == 0 ? model.monthPrice : model.monthRenewalPrice}')
                            .expanded(),
                        GestureDetector(
                          child: Container(
                            width: 80.dp,
                            height: 28.dp,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.dp),
                              gradient: LinearGradient(
                                colors: AppMainColors.commonBtnGradient,
                              ),
                            ),
                            child: AppLayout.textWhite12(
                                model.carBuyState == 0 ? '确认购买' : '确认续费'),
                          ),
                          onTap: () => _showTipDialog(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  _showTipDialog(BuildContext context) {
    String dimand =
        '${model.carBuyState == 0 ? model.monthPrice : model.monthRenewalPrice}';
    showDialog(
      context: context,
      builder: (_) {
        return AppDialog(
          Text.rich(
            TextSpan(children: [
              const TextSpan(text: "您将消耗"),
              TextSpan(
                text: dimand,
                style: TextStyle(
                    color: AppMainColors.mainColor,
                    fontSize: 14.sp,
                    fontFamily: 'Number'),
              ),
              TextSpan(
                  text:
                      "钻石${model.carBuyState == 0 ? '兑换' : '续费'}座驾${model.carName}"),
            ]),
            style: TextStyle(
              color: AppMainColors.whiteColor70,
              fontSize: 14.sp,
            ),
          ),
          title: model.carBuyState == 0 ? '购买' : '续费',
          cancelText: "取消",
          confirm: () {
            Get.back();
            show();
            logic.buyCar(model.id).then((result) {
              dismiss();
              if (result.data['code'] == 0) {
                showToast('购买成功并使用');
                logic.loadCarList(false);
                Navigator.pop(logic.state.carContext);
              } else {
                if (result.data['code'] == 3001) {
                  _showRechargeDialog(context);
                } else {
                  showToast(result.err);
                }
              }
            });
          },
        );
      },
    );
  }

  _showRechargeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AppDialog(
          Text(
            '很抱歉，当前钻石钱包余额不足，请前往充值或兑换',
            style: TextStyle(
              color: AppMainColors.whiteColor70,
              fontSize: 14.sp,
            ),
          ),
          cancelText: "取消",
          confirmText: '前往充值',
          confirm: () {
            Get.back();
            Get.to(() => RechargePage(true));
          },
        );
      },
    );
  }
}
