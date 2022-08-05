import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hjnzb/business/homepage/home_search_view/home_search_view_state.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/common_widget/live/sex_icon_widget.dart';
import 'package:star_common/common/common_widget/search_barview.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/generated/anchor_list_model_entity.dart';
import 'package:star_live/pages/rank_main/live_avatar.dart';
import '../home_list_views/homepage_logic.dart';
import 'home_search_view_logic.dart';
import 'package:star_common/config/app_layout.dart';

class HomeSearchViewPage extends StatelessWidget {
  final logic = Get.put(HomeSearchViewLogic());
  final state = Get.find<HomeSearchViewLogic>().state;
  final homePageLogic = Get.find<HomepageLogic>();

  @override
  Widget build(BuildContext context) {
    state.inputText.value = "";
    return Obx(
      () => Scaffold(
        appBar: SearchAppBarPage(
          leftIcon: R.backIconWhite,
          rightText: "搜索",
          controller: state.myController,
          focusNode: state.focusNode,
          rightTextColor: state.searchTextColor(),
          onPressedLeft: () {
            ///清空监听
            Get.back();
          },
          onPressedRight: () {
            state.isSearch.value = true;
            state.focusNode.unfocus();
            logic.requestSearchInfoData();
          },
          onValueChange: (text) {
            logic.state.inputText.value = text;
          },
          submitTap: (text) {
            state.isSearch.value = true;
            state.focusNode.unfocus();
            logic.requestSearchInfoData();
          },
        ),
        body: GetBuilder<HomeSearchViewLogic>(builder: (logic) {
          if (state.searchList.length <= 0 && state.isSearch.value) {
            return EmptyView(emptyType: EmptyType.noSearch);
          }

          return ListView.builder(
              itemCount: state.searchList.length,
              itemBuilder: (context, index) {
                HomeSearchModel model = state.searchList[index];
                AnchorListModelEntity anchorItem = AnchorListModelEntity();
                anchorItem.userId = model.userId.toString();
                anchorItem.username = model.username ?? "主播";
                anchorItem.rank = model.rank;
                anchorItem.chatRoomId = model.roomId.toString();
                anchorItem.state = model.state;
                anchorItem.roomCover = model.header;
                anchorItem.id = model.roomId.toString();

                int tempIndex = 0;
                Map<String, dynamic> args = {
                  "index": tempIndex,
                  "rooms": [model],
                  "userId": anchorItem.userId!,
                  "needToRoom": model.state == 1
                };

                /// 头像
                OnLiveAvatar onLiveChild(bool live, String? imgUrl) {
                  return OnLiveAvatar(
                    padding: EdgeInsets.all(2),
                    onLive: live,
                    imgUrl: imgUrl,
                    radius: 26,
                    locImageChild: Image.asset(
                      R.rankHeadMoren,
                      fit: BoxFit.cover,
                    ),
                    onPressed: () {
                      if (live) {
                        List anchorList =
                            homePageLogic.state.containsOnlyAnchorsArr(0);
                        bool hasAnchor = false;
                        int index = 0;
                        anchorList.forEach((element) {
                          if (element.id == anchorItem.id) {
                            hasAnchor = true;
                            index = anchorList.indexOf(element);
                            return;
                          }
                        });

                        if (!hasAnchor) {
                          anchorList.insert(index, anchorItem);
                        }
                        Map<String, dynamic> args = {
                          "index": index,
                          "rooms": anchorList
                        };
                        logic.pushAudiencePage(context, args);
                      } else {
                        logic.pushUserInfo(context, args);
                      }
                    },
                    isAnchor: true,
                  );
                }

                return ListTile(
                  leading: onLiveChild(model.state == 1, model.header),
                  title: _mainTitleView(model),
                  subtitle: _subTilteView(model),
                  onTap: () {
                    logic.pushUserInfo(context, args);
                  },
                  // isThreeLine: true,
                  // visualDensity: VisualDensity(vertical: 2),
                  // minVerticalPadding: 10,
                  // dense: true,
                  // contentPadding: EdgeInsets.symmetric(horizontal: 5),
                );
              });
        }),
      ),
    );
  }

  Widget _mainTitleView(HomeSearchModel model) {
    return Container(
      // color: Colors.red,
      height: 25,
      alignment: Alignment.topCenter,
      child: Row(
        children: [
          Text(
            model.username ?? "",
            style: AppStyles.f16w500white100,
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget _subTilteView(HomeSearchModel model) {
    return Container(
      // color: Colors.brown,
      height: 25,
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          SexIconWidget(model.sex),
          SizedBox(width: 10),
          Text(model.signature!.length <= 0 ? "TA好像忘记签名了" : model.signature!,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppMainColors.whiteColor70,
                fontSize: 14,
              )).expanded(),
        ],
      ),
    );
  }
}
