import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';

import 'game_list_model.dart';
import 'jump_game_detail_list.dart';

class _GamesController extends GetxController {
  final PageController controller = PageController();
  final RxInt current = 0.obs;
}

class Games extends StatelessWidget {
  final List<GameList> games;
  const Games({Key? key, required this.games}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<_GamesController>(
      init: _GamesController(),
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.only(left: 16.dp, top: 16.dp, right: 16.dp),
          child: Row(
            children: [
              SizedBox(
                width: 54.dp,
                child: ListView.separated(
                  padding: EdgeInsets.all(0),
                  scrollDirection: Axis.vertical,
                  itemCount: games.length,
                  itemBuilder: (_, index) {
                    return Obx(() {
                      return InkWell(
                        onTap: () {
                          controller.current.value = index;
                          controller.controller.jumpToPage(index);
                        },
                        child: Image.asset(
                          () {
                            if (controller.current.value == index) {
                              switch (games[index].name) {
                                case '热门':
                                  return R.remenSelected;
                                case '真人':
                                  return R.zhenrenSelected;
                                case '棋牌':
                                  return R.qipianSelected;
                                case '捕鱼':
                                  return R.puyuSelected;
                                case '电子':
                                  return R.dianzhiSelected;
                                case '体育':
                                  return R.tiyuSelected;
                                case '彩票':
                                  return R.caipiaoSelected;
                                default:
                                  return R.remenSelected;
                              }
                            } else {
                              switch (games[index].name) {
                                case '热门':
                                  return R.remenNormal;
                                case '真人':
                                  return R.zhenrenNormal;
                                case '棋牌':
                                  return R.qipianNormal;
                                case '捕鱼':
                                  return R.puyuNormal;
                                case '电子':
                                  return R.dianzhiNormal;
                                case '体育':
                                  return R.tiyuNormal;
                                case '彩票':
                                  return R.caipiaoNormal;
                                default:
                                  return R.remenNormal;
                              }
                            }
                          }(),
                          width: 54.dp,
                          height: 54.dp,
                        ),
                      );
                    });
                  },
                  separatorBuilder: (_, __) {
                    return SizedBox(height: 8.dp);
                  },
                ),
              ),
              PageView.builder(
                itemCount: games.length,
                controller: controller.controller,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return JumpGameDetailPage(games[index].game);
                },
                onPageChanged: (index) {
                  controller.current.value = index;
                },
              ).expanded()
            ],
          ),
        );
      },
    );
  }
}
