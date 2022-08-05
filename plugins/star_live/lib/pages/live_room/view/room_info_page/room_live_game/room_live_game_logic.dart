// ignore_for_file: deprecated_member_use, unused_import

import 'package:alog/alog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mqtt/mqtt_manager.dart';
import 'package:flutter_mqtt/status/game.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/router/router_config.dart';
import 'package:star_live/pages/live_room/view/room_info_page/room_live_game/room_base_game/room_base_game_view.dart';
import 'package:star_live/star_live.dart';

import '/pages/live_room/view/room_info_page/room_live_game/game_net_work.dart';
import '../room_info_page.dart';
import 'game_net_work.dart';
import 'room_live_game_state.dart';
import 'web_view_game_page/web_view_game_page_view.dart';

/// @description:
/// @author
/// @date: 2022-06-20 15:58:22
class RoomLiveGameLogic extends GetxController
    with SingleGetTickerProviderMixin, Toast {
  final state = RoomLiveGameState();
  final Map gameMap = {
    1: R.gameYfk3,
    2: R.gameYflhc,
    3: R.gameYfkc,
    4: R.gameYxx,
    5: R.gameBrnn,
    6: R.gameSsc
  };
  requestGame() async {
    HttpChannel.channel.gameList().then((value) {
      value.finalize(
          wrapper: WrapperModel(),
          failure: (e) => showToast(e),
          success: (data) {
            List lst = data ?? [];
            if (lst.length > 0) {
              List<GameListData> dtas =
                  lst.map((e) => GameListData.fromJson(e)).toList();
              dtas.first.isSeledet = true;
              state.setUpdateGameListData(dtas);
              state.tabController =
                  TabController(length: state.gameListData.length, vsync: this);
            } else {
              state.setUpdateGameListData(
                  [GameListData(name: "热门", isSeledet: true)]);
              state.tabController = TabController(length: 1, vsync: this);
            }
          });
    });
    GameNetWork.shared.getGameList().then((value) {
      if (value.statusCode == 0) {
        if (value.data != null) {
          if (value.data is List) {
            List list = value.data;
            List<RoomLiveGameList> games =
                list.map((e) => RoomLiveGameList.fromJson(e)).toList();
            state.setUpdataGameList(games);
          }
        }
      } else {
        showToast(value.err);
      }
      // update();
    });
  }

  //到游戏界面
  showGame(BuildContext? context, RoomLiveGameList data, Widget? chatBox,
      Widget? controlWidget, VoidCallback callBack) {
    if (context == null) return;
    bottomSheetCallBack?.call(true);

    controllEventBack = () {
      Get.back();
    };

    Get.bottomSheet(
            RoomBaseGamePage(
              data: data,
              controlWidget: controlWidget,
              chatBox: chatBox,
              roomId: state.roomId,
              isAnchor: state.isAnchor,
            ),
            barrierColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            enableDrag: true,
            isScrollControlled: true)
        .then(
      (value) {
        Alog.i(value);
        bottomSheetCallBack?.call(false);
        callBack.call();
        Get.back();
      },
    );
  }

  seledetd(int index) {
    for (var i = 0; i < state.gameListData.length; i++) {
      state.gameListData[i].isSeledet = i == index ? true : false;
      // state.gameListData[i].setUpdateIsSeledet(i == index ? true : false);
    }
    update();
  }

  List<Widget> gameViews(void Function(int) onTap) {
    return state.gameListData.map((element) {
      return ((element.name == "热门" && (state.gameList.length) == 0) ||
              (element.name != "热门" && element.game?.length == 0))
          ? EmptyView(emptyType: EmptyType.noData)
          : GridView.builder(
              padding: EdgeInsets.only(left: 5.dp, right: 5.dp),
              shrinkWrap: true,
              itemCount: element.name == "热门"
                  ? state.gameList.length
                  : element.game?.length ?? 0,
              // physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10.dp,
                  crossAxisSpacing: 10.dp,
                  childAspectRatio: 0.8),
              itemBuilder: (context, index) {
                return element.name == "热门"
                    ? hotItem(
                        state.gameList[index].id, state.gameList[index].name,
                        () {
                        onTap(index);
                      })
                    : item(element.game?[index].gameIconUrl,
                        element.game?[index].gameName, () {
                        onTap(-10);
                        gotoGameDetail("${element.game?[index].gameId}");
                      });
              });
    }).toList();
  }

  Widget item(String? image, String? gameName, void Function() onTap) {
    return Column(
      children: [
        FadeInImage(
          width: 68.dp,
          height: 68.dp,
          fit: BoxFit.fill,
          placeholder: AssetImage(R.gamePlaceholder),
          image: NetworkImage(image ?? ""),
        ),
        SizedBox(
          height: 8.dp,
        ),
        Text(
          gameName ?? "",
          style: TextStyle(
              color: AppMainColors.whiteColor70,
              fontSize: 12.sp,
              fontWeight: w_400),
        ),
      ],
    ).gestureDetector(onTap: () {
      onTap();
    });
  }

  Widget hotItem(int? gameId, String? gameName, void Function() onTap) {
    print('NEO gameName: $gameName');
    return Column(
      children: [
        Image.asset(
            gameMap[gameId],
            width: 68.dp,
            height: 68.dp,
            fit: BoxFit.fill),
        SizedBox(
          height: 8.dp,
        ),
        Text(
          gameName ?? "",
          style: TextStyle(
              color: AppMainColors.whiteColor70,
              fontSize: 12.sp,
              fontWeight: w_400),
        ),
      ],
    ).gestureDetector(onTap: () {
      onTap();
    });
  }
  gotoGameDetail(String gameId) {
    show();
    HttpChannel.channel.gameUrl(gameId: gameId).then((value) {
      value.finalize(
          wrapper: WrapperModel(),
          failure: (e) => showToast(e),
          success: (data) {
            dismiss();
            var gameUrl = data["gameUrl"];
            Get.to(() => WebViewGamePagePage(), arguments: {
              "url": gameUrl,
              "gameId": gameId,
            });
          });
    });
  }


  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    requestGame();
  }
}
