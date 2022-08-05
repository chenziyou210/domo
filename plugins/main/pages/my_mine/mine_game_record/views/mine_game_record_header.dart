import 'package:flutter/cupertino.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/config/app_layout.dart';

class MineGameRecordHeader extends StatelessWidget {
  const MineGameRecordHeader(
      {required this.betAmount, required this.bonusAmount, Key? key})
      : super(key: key);

  final String betAmount;
  final String bonusAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppLayout.pageSpace),
      height: 45.dp,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildItem('下注总金额', betAmount),
          _buildItem('中奖总金额', bonusAmount)
        ],
      ),
    );
  }

  Widget _buildItem(String content, String value) {
    return Container(
      child: Row(
        children: [
          AppLayout.text70White12(content),
          SizedBox(width: 8.dp),
          Text(value, style: AppStyles.number12w400white,),
        ],
      ),
    );
  }
}
