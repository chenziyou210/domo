import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/config/app_layout.dart';
import '../models/game_record_model.dart';
import 'mine_game_record_content_item.dart';

class MineGameRecordItem extends StatelessWidget {
  const MineGameRecordItem(
      {required this.record, required this.itemEvent, Key? key})
      : super(key: key);
  final Record record;
  final Function() itemEvent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.fromLTRB(
            AppLayout.pageSpace, 0, AppLayout.pageSpace, 12.dp),
        padding: EdgeInsets.symmetric(horizontal: 12.dp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.dp),
          color: AppMainColors.whiteColor6,
        ),
        child: Column(
          children: [
            _buildCellTop(record),
            Container(height: 1.dp, color: AppMainColors.whiteColor6),
            _buildCellBottom(record),
          ],
        ),
      ),
      onTap: () => itemEvent(),
    );
  }

  Widget _buildCellTop(Record model) {
    return Container(
      height: 48.dp,
      child: Row(
        children: [
          CachedNetworkImage(
            fit: BoxFit.cover,
            width: 24.dp,
            height: 24.dp,
            imageUrl: model.icon ?? "",
            placeholder: (context, string) {
              return Container(color: Color(0xFF1E1E1E),);
            },
            errorWidget: (context, url, error) {
              return Container(color: Color(0xFF1E1E1E),);
            },
          ),
          SizedBox(width: 8.dp),
          AppLayout.textWhite14(model.companyName ?? '').expanded(),
          Image.asset(R.comArrowRight, width: 16.dp, height: 16.dp),
        ],
      ),
    );
  }

  Widget _buildCellBottom(Record model) {
    return Container(
      height: 62.dp,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MineGameRecordContentItem(
              title: '下单注量',
              value: model.betCnt ?? '',
              valueColor: AppMainColors.whiteColor70),
          MineGameRecordContentItem(
              title: '下注金额',
              value: '¥ ${model.bet ?? ''}',
              valueColor: AppMainColors.string2Color('#78FFA6')),
          MineGameRecordContentItem(
              title: '中奖金额',
              value: '¥ ${model.win ?? ''}',
              valueColor: AppMainColors.string2Color('#32C5FF')),
        ],
      ),
    );
  }
}
