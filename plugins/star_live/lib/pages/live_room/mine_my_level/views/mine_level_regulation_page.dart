import 'package:flutter/material.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/config/app_layout.dart';

class MineLevelRegulationPage extends StatelessWidget {
  const MineLevelRegulationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        centerTitle: true,
        title: AppLayout.appBarTitle('用户等级规则'),
      ),
      body: _buildRegulationContent(),
    );
  }

  Widget _buildRegulationContent() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRegulationItem('1.1 什么是用户等级？', '用户等级是用户在xx直播中送出礼物消费的对应等级（游戏下注金额不计入用户等级统计范围）'),
          _buildRegulationItem('1.2 等级成长值的获取方式', '送礼物、开贵族、开通守护\n1钻石=1成长值'),
          _buildRegulationItem('1.3 等级特权有什么', '身份标识、升级提醒、进房提示、酷炫进场、特权礼物等。随用户等级的升级 ，会解锁更多进阶的特权。'),
        ],
      ),
    );
  }

  Widget _buildRegulationItem(String title, String content) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppLayout.pageSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24.dp,),
          AppLayout.textWhite16(title),
          SizedBox(height: 8.dp),
          Text(content, style: TextStyle(color: AppMainColors.whiteColor40, fontSize: 14.sp), maxLines: null,)
        ],
      ),
    );
  }

}
