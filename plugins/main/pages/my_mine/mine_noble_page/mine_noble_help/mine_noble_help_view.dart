import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/common/app_common_widget.dart';

import 'mine_noble_help_logic.dart';
import 'mine_noble_help_state.dart';

/// @description:
/// @author
/// @date: 2022-06-13 16:42:26
class MineNobleHelpPage extends StatelessWidget {
  final MineNobleHelpLogic logic = Get.put(MineNobleHelpLogic());
  final MineNobleHelpState state = Get.find<MineNobleHelpLogic>().state;

  MineNobleHelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(16, 16, 16, 1),
        appBar: DefaultAppBar(
            centerTitle: true,
            title: Text(
              "贵族FAQ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.dp,
                  fontWeight: FontWeight.bold),
            )),
        body: GetBuilder<MineNobleHelpLogic>(
            init: logic,
            builder: (c) {
              return Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(50, 197, 255, 0.1),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                margin: EdgeInsets.all(16.dp),
                padding: EdgeInsets.all(16.dp),
                height: 255.dp,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c.state.title,
                      style: TextStyle(color: Colors.white, fontSize: 14.dp),
                    ),
                    SizedBox(
                      height: 15.dp,
                    ),
                    Text(c.state.contents,
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.7),
                            fontSize: 12.dp))
                  ],
                ),
              );
            }));
  }
}
