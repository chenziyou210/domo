import 'package:flutter/cupertino.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_common/util_tool/string_extension.dart';
import '../mine_income_expenditure_details_state.dart';
import '../models/income_expenditure_detail_model.dart';

class DetailsItem extends StatelessWidget {
  const DetailsItem({required this.detail, required this.type, Key? key})
      : super(key: key);

  final Detail detail;
  final DetailsType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppMainColors.whiteColor6,
      height: 66.dp,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 16.dp,
              ),
              Image.asset(
                _getDetailIconWithType(detail.consumeType ?? 0),
                width: 32.dp,
                height: 32.dp,
              ),
              SizedBox(width: 8.dp),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    (detail.itemName ?? '').isEmpty
                        ? detail.consumeTitle ?? ''
                        : '${detail.consumeTitle}-${detail.itemName}',
                    style: TextStyle(
                      color: AppMainColors.whiteColor100,
                      fontWeight: AppLayout.boldFont,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 4.dp),
                  Row(
                    children: [
                      Text(
                        dateTimeWithString(detail.consumeTime ?? ''),
                        style: TextStyle(
                          color: AppMainColors.whiteColor40,
                          fontWeight: FontWeight.w300,
                          fontSize: 12.sp,
                        ),
                      ).expanded(),
                      Text(
                        type == DetailsType.income
                            ? '+${detail.coin}钻'
                            : '${detail.coin}钻',
                        style: TextStyle(
                          color: type == DetailsType.income
                              ? AppMainColors.mainColor
                              : AppMainColors.string2Color('#78FFA6'),
                          fontSize: 14.sp,
                          fontFamily: 'Number',
                        ),
                      ),
                    ],
                  ),
                ],
              ).expanded(),
              SizedBox(
                width: 16.dp,
              ),
            ],
          ).expanded(),
          Padding(
            padding: EdgeInsets.only(left: 52.dp),
            child: Container(
              height: 1.dp,
              color: AppMainColors.whiteColor6,
            ),
          )
        ],
      ),
    );
  }

  String _getDetailIconWithType(int type) {
    if (type == 1) return R.detailLwxf;
    if (type == 2) return R.detailKtgz;
    if (type == 3) return R.detailKtsh;
    if (type == 4) return R.detailGmzj;
    if (type == 5) return R.detailFfgm;
    if (type == 6) return R.detailZbjdm;
    if (type == 7) return R.detailXtzs;
    if (type == 8) return R.detailHdjl;
    if (type == 9) return R.detailDaoju;
    if (type == 10) return R.detailDuihuan;
    if (type == 11) return R.detailMpkf;
    return R.appLogo;
  }
}
