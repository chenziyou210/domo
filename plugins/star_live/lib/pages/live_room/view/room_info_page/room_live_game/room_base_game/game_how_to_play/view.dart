import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';

import 'logic.dart';

class GameHowToPlayPage extends StatelessWidget {
  final logic = Get.put(GameHowToPlayLogic());
  final state = Get.find<GameHowToPlayLogic>().state;

  GameHowToPlayPage(this.view);

  final Container view;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: HowtoPlayView(view),
    );
  }

  Column HowtoPlayView(Container view) {
    return Column(
      children: [
        Spacer(),
        Container(
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                "玩法说明",
                style: TextStyle(
                    color: Colors.white, fontSize: 14.sp, fontWeight: w_500),
              ).center,
              Text(
                "关闭",
                style: TextStyle(
                    color: Colors.white, fontSize: 12.sp, fontWeight: w_400),
              ).gestureDetector(onTap: () {
                Get.back();
              }).position(right: 16.dp),

            ],
          ),
          width: Get.width,
          height: 40.dp,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(255, 101, 200, 1),
                Color.fromRGBO(255, 30, 175, 1)
              ]),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.dp),
                  topRight: Radius.circular(12.dp))),
        ),
        view,
        Container(
          color: Color.fromRGBO(22, 23, 34, 0.9),
          height: 33.dp,
        )
      ],
    );
  }
}
