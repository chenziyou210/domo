import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hjnzb/business/homepage/widget/homepage_widget.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/toast.dart';
import 'package:hjnzb/pages/game/game_list_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/lottie/lottie_view.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/manager/app_manager.dart';
import 'jump_game_logic.dart';

class JumpGameDetailPage extends StatefulWidget {
  JumpGameDetailPage(this.games);

  final List<GameItem>? games;
  @override
  createState() => _JumpGameDetailPageState();
}

class _JumpGameDetailPageState extends AppStateBase<JumpGameDetailPage>
    with Toast {
  final logic = Get.put(JumpGameLogic());
  final RefreshController refreshController = RefreshController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(
    // "JumpGameDetailPage: ${widget.gameType} ${logic.state.gameTabList.value.where((element) => element.gameType == widget.gameType).first.listData?.length}");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);
    // var gameType = widget.gameType;
    return Container(
        child: SmartRefresher(
            // child: gameType == "HOT" ? gameGridViewList(gameList) : gameListView(gameList),
            controller: refreshController,
            header: LottieHeader(),
            footer: LottieFooter(),
            child: GetBuilder<JumpGameLogic>(
              builder: (_) {
                var gameList = widget.games;
                return MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: gameGridViewList(gameList))
                    .paddingOnly(left: 16.dp, bottom: 16.dp);
              },
            ),
            onRefresh: () async {
              await HttpChannel.channel
                  .userInfo()
                  .then((value) => value.finalize(
                      wrapper: WrapperModel(),
                      success: (data) {
                        AppManager.getInstance<AppUser>().fromJson(data, false);
                        refreshController.refreshCompleted();
                      },
                      failure: (e) {
                        refreshController.refreshCompleted();
                      }));
              logic.loadGameList(true);
              return;
            }));
  }

  GridView gameGridViewList(gameList) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, //每行三列
        childAspectRatio: 0.82,
        mainAxisSpacing: 12.dp,
        crossAxisSpacing: 12.dp, //显示区域宽高相等
      ),
      itemCount: gameList?.length ?? 0,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        GameItem model = gameList[index];
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: Container(
            // padding: EdgeInsets.only(bottom: 2.dp),
            decoration: BoxDecoration(
              // color: Color(0xFF1e1e1e),
              borderRadius: BorderRadius.circular(4.dp),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CachedNetworkImageAnchor(model.gameIconUrl!).expanded(),
                // model.gameIconUrl.toString().isNotEmpty
                //     ? Image.network(
                //         model.gameIconUrl!,
                //         fit: BoxFit.fill,
                //       ).expanded()
                //     : Image.asset(
                //         AppImages.game_item_superMary,
                //         // width: ,
                //         fit: BoxFit.fill,
                //       ).expanded(),
                SizedBox(height: 4.dp),
                CustomText(
                  ((model.gameName) ?? ""),
                  fontSize: 12.sp,
                  color: Colors.white70,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
          onTap: () {
            logic.gotoGameDetail(model.gameId!);
            // gameDetail(model.gameId!);
          },
        );
      },
    );
  }
}
