import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/storage.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_common/generated/anchor_list_model_entity.dart';
import 'package:star_common/generated/rank_new_entity.dart';
import 'package:star_live/pages/rank_main/rank_main_logic.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../live_room/live_room_new.dart';
import 'live_avatar.dart';
import 'top_rank_item.dart';


/// 列表总容器
class RankListContentWidget extends StatefulWidget {
  @override
  State<RankListContentWidget> createState() => _RankListContentWidgetState();
}

class _RankListContentWidgetState extends State<RankListContentWidget> with SingleTickerProviderStateMixin {
  final logic = Get.put(RankMainLogic());
  final state = Get.find<RankMainLogic>().state;
  late TabController _subController;

  @override
  // TODO: implement wantKeepAlive
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _subController = TabController(length: 3, vsync: this,initialIndex: 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    logic.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Tab内容
        Container(
          height: 40.dp,
          alignment: Alignment.center,
          // color: Colors.brown,
          child: CustomTabBar(
            tabs: (_) => state.subMenuTitles.map((e) => Container(
                      alignment: Alignment.center,
                      height: 24,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppMainColors.whiteColor40)),
                      child: CustomText(
                        e,
                        fontSize: 12,
                      ))).toList(),
            controller: _subController,
            isScrollable: true,
            unselectedLabelColor: Colors.white70,
            labelColor: AppMainColors.whiteColor100,
            // indicatorPadding: EdgeInsets.symmetric(vertical: 10),
            indicatorWeight: 0,
            borderSide: const BorderSide(width: 0, color: Colors.transparent),
            decoration: BoxDecoration(
                color: AppMainColors.mainColor,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white)
            ),
            labelPadding: const EdgeInsets.only(left: 6, right: 6),
            onTap: (index){
              state.setSubIndex(index);
              logic.dataRefresh();
            },
          ).padding(padding: EdgeInsets.only(left: 16, top: 10.dp)),
        ),
        CustomTabBarView(
          controller: _subController,
          children: state.subMenuTitles.map((e) {

              late RankListView view;
              String meunKey = state.mainMenuTitles[state.menuIndex.value];
              String key = "$e$meunKey";

              if(state.listWidgetMap.containsKey(key)){
                view = state.listWidgetMap[key] as RankListView;

              }else{
                view = RankListView(key);

              }
              return view;

           }).toList(),
          onPageChange: (index){
            state.setSubIndex(index);
            logic.dataRefresh(refreshKey: state.getRefreshKey());
          },
        ).expanded(),
      ],
    );
  }
}

const double HeaderHeight = 240;
const double ListItemHeight = 64;

class RankListView extends StatefulWidget {
  final String rankType;
  const RankListView(this.rankType,{Key? key }) : super(key: key);

  @override
  State<RankListView> createState() => _RankListViewState();
}

class _RankListViewState extends AppStateBase<RankListView> with AutomaticKeepAliveClientMixin {
  final logic = Get.find<RankMainLogic>();
  final state = Get.find<RankMainLogic>().state;
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //日榜主播榜初始化请求
    if(state.menuIndex == 0 && state.subAnchorIndex == 0){
      logic.dataRefresh(refreshKey: state.getRefreshKey());
    }
    //日榜土豪榜初始化请求
    else if (state.menuIndex == 1 && state.subUserIndex == 0){
      logic.dataRefresh(refreshKey: state.getRefreshKey());
    }
  }

  @override
  Widget build(BuildContext context) {

    double instTop =  MediaQuery.of(context).padding.top;
    double topHeight = (44 + 30).dp;
    double headerHeight = HeaderHeight.dp.ceilToDouble();
    double contentHeight = (this.height - topHeight - headerHeight - instTop).ceilToDouble();

    return GetBuilder<RankMainLogic>(
        id: widget.rankType,
        builder: (logic) {
          List tempList = state.currentListData(tempKey: widget.rankType);
          return RefreshWidget(
            physics: ClampingScrollPhysics(),
            controller: RefreshController(),
            children: [
              //第一 二 三 名 列表头
              SliverToBoxAdapter(
                child: SizedBox(
                  height: headerHeight,
                  child: Stack(
                    fit: StackFit.loose,
                    alignment: AlignmentDirectional.bottomCenter,
                    children: List.generate(3, (index) {
                      late Widget content;
                      content = HeaderItem(index, logic, tempList);
                      ///分配位置
                      if(index == 0){
                        return content.position(bottom: 0,right: 20.dp);

                      }else if (index == 1){
                        return content.position(bottom: 0,left: 20.dp);

                      }else{
                        return content.position(bottom: 0);

                      }
                    }),
                  ),
                ),
              ),
              //列表
              SliverToBoxAdapter(
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: Container(
                    ///约束最小显示高度控件  ，再让listview 对高度 自适应
                    ///为什么不在item里的contaner 直接给色值，可以省去2层 Contanier
                    ///1.因为整体渐变布局，所以已渐变作为低，不管是上拉，滑动，切换 都不会出现渐变断层
                    ///2.适配安卓的 纯黑适配的高度容易透底 可能系统原因
                    constraints: BoxConstraints(minHeight: contentHeight,),
                    child:
                    Container(
                      color: Color(0xff101010),
                      padding: EdgeInsets.only(top: 10),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (_,index){
                          // ///数据从下标3 开始
                          return RankItemList(index, logic, tempList);
                        },
                        itemCount: tempList.length - 3,
                        shrinkWrap: true,
                      ),
                    ),
                  ),
                )
              )

            ],
            enablePullUp: false,
            onRefresh: (c) async {
              await logic.dataRefresh(refreshKey: widget.rankType);
              c.refreshCompleted();
              c.resetNoData();
            },
          ) ;
        });

  }
}

/// 头部组件Widget
Widget HeaderItem(int index, RankMainLogic logic, List lst){

  late String topIconStr,numberIconStr;
  late EdgeInsets nameEdge;
  late int tapIndex;
  double  itemWidth = 112.0.dp;
  double  itemHeight = 198.dp;
  switch(index){
    case 0:{
      topIconStr = R.icRankThird;
      numberIconStr = R.rankNumberThree;
      nameEdge = EdgeInsets.only(left: 20.dp.ceilToDouble(),right: 10,top: 5);
      tapIndex = 2;
    }break;
    case 1:{
      topIconStr = R.icRankSecond;
      numberIconStr = R.rankNumberTwo;
      nameEdge = EdgeInsets.only(left: 12,right: 15.dp.ceilToDouble(),top: 5);
      tapIndex = 1;
    }break;
    case 2:{
      topIconStr = R.icRankFirst;
      numberIconStr = R.rankNumberOne;
      nameEdge = EdgeInsets.only(left: 12,right: 12);
      itemHeight = 214.dp;
      tapIndex = 0;
    }break;
  }

  RankNewEntity itemModel = lst[tapIndex];
  bool showFoucse = (StorageService.to.getBool('keyAnchor') == false && itemModel.isAnchor == true);

      return SizedBox(
    width: itemWidth.ceilToDouble(),
    height: itemHeight.ceilToDouble(),
    child: TopRankItem(
      avatarChild: onLiveChild(
          itemModel.isLive ?? false,
          itemModel.header,
          itemModel.isInvisible,
          itemModel.isAnchor ?? false,
          topIconStr,
          itemModel.roomId,
          itemModel.roomCover,
          index == 2 ? 28 : 25
      ),
      nikeNameEdge: nameEdge,
      localNumIcon: numberIconStr,
      nikeName: (itemModel.isAnchor! && itemModel.isInvisible == 1)
          ? "低调的大佬"
          : itemModel.username,
      level: itemModel.rank,
      showLevel: !itemModel.isAnchor!,
      rankFire: itemModel.heatString ?? "",
      showFocusBtn: showFoucse ,
      isFocus: itemModel.attention,
      topSpaceHeight: index == 2 ? 10.dp : 0,
      shadow: index == 2 ? BoxShadow(
        color: Color(0x336486FF),
        offset: Offset(0.0, -4.0),
        blurRadius: 8,
        spreadRadius: 2,
      ) : BoxShadow(),
      onPressed: () {
        // _toggleAttentionAtIndex(tapIndex);
        logic.toggleAttentionAtIndex(itemModel,tapIndex);
      },
    ),
  );
}

///主播列表itemWidget

Widget RankItemList(int index, RankMainLogic logic, List lst){

  int numberIndex = index + 3;
  RankNewEntity itemModel = lst[numberIndex];
  //需要去除小数点后位数，不然滑动时会有非常小的间距差，透出底色
  double height = ListItemHeight.dp.ceilToDouble();
  return
    Container(
      height: height,
      child: Stack(
        fit: StackFit.loose,
        alignment: AlignmentDirectional.center,
        children: [
          //内容主题
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //序列 数据为第3开始算 + 1 与下标差1
              Text(logic.state.indexString(numberIndex + 1),
                  style: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: "Number",
                      color: AppMainColors.whiteColor70
                  )).marginOnly(left: 16.dp),
              //间距
              SizedBox(width:24.dp),
              //头像 是否主播 土豪等
              onLiveChild(
                  itemModel.isLive ?? false,
                  itemModel.header,
                  itemModel.isInvisible,
                  itemModel.isAnchor ?? false,
                  "",
                  itemModel.roomId,
                  itemModel.roomCover,
                  20
              ),
              //间距
              SizedBox(width:16.dp),
              //昵称 等级 火力
              RichText(text: TextSpan(
                   //昵称
                  text: "${itemModel.username}  ",///空出2个字节间距
                  style: TextStyle(fontSize: 14.sp, fontWeight: w_500, color: Colors.white,overflow: TextOverflow.ellipsis,height: 0),
                  children: [
                    //是否展示等级
                    WidgetSpan(
                        child: itemModel.isAnchor!
                            ? SizedBox()
                            : UserLevelView(itemModel.rank ?? 0)
                    ),
                    //换行
                    TextSpan(text: "\n"),
                    //火力值
                    WidgetSpan(
                        child: itemModel.heat == null || itemModel.heat == 0
                            ? SizedBox()
                            : Text("${itemModel.heatString}${intl.firepower}",
                            style: TextStyle(
                                fontSize: 13.sp,
                                fontFamily: "Number",
                                overflow: TextOverflow.ellipsis,
                                color: AppMainColors.whiteColor40,
                                height: 1.8
                            ))),
                  ]
              )).expanded(),
              ///1.是客户端
              ///.是主播榜 才有关注
              ///2.主播端都不需要关系
              (StorageService.to.getBool('keyAnchor') == false
                  && itemModel.isAnchor == true)
                  ? Container(
                      width: 50, height: 28,
                      margin: EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 0.5,
                            color: !itemModel.attention! ? Colors.transparent : AppMainColors.whiteColor70),
                        borderRadius: BorderRadius.circular(14),
                        gradient: LinearGradient(
                            colors: itemModel.attention! ? [ AppMainColors.whiteColor6, AppMainColors.whiteColor10] : AppMainColors.commonBtnGradient,
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight),

                      ),
                      alignment: Alignment.center,
                      child: CustomText("${itemModel.attention! ? intl.followed : intl.following}",
                          fontSize: 12,
                          color:
                          !itemModel.attention! ? AppMainColors.whiteColor100 : AppMainColors.whiteColor70)
                  ).inkWell(onTap: (){
                    //关注请求
                    logic.toggleAttentionAtIndex(itemModel, numberIndex);
                  })
                  : SizedBox(),

            ],
          ),
          //细线
          Divider(height: 1,color: AppMainColors.whiteColor10).paddingOnly(left: 110.dp).position(bottom: 0,left: 0,right: 0),
        ],
      ),
    );
}

/// 主播头像Widget
OnLiveAvatar onLiveChild(
    bool? live,
    String? imgUrl,
    int? isvisible,
    bool isAnchor,
    String chamionIcon,
    String? roomId,
    String? roomCover,
    double radius,) {

  if(isAnchor == false){
    live = false;
  }

  return OnLiveAvatar(
    championIcon: chamionIcon,
    onLive: live ?? false,
    imgUrl: imgUrl,
    radius: radius,
    isInvisible: isvisible,
    locImageChild: Image.asset(
      R.rankHeadMoren,
      fit: BoxFit.cover,
    ),
    onPressed: () {
      if ( StorageService.to.getBool('keyAnchor') == false
          && live == true
          && StorageService.to.isOpenRoom == false)
      {
        AnchorListModelEntity model = AnchorListModelEntity();
        int tempIndex = 0;
        model.id = roomId;
        model.roomCover = roomCover;
        Map<String, dynamic> args = {
          "index": tempIndex,
          "rooms": [model]
        };
        //在线跳转直播间
        Get.to(() => AudienceNewPage(arguments: args));
        // Get.to(AudienceNewPage(), arguments: args);
      } else {
        // Get.to(OtherUserInfo(), arguments: {
        //   "userId": dataValue['userId'].toString()
        // });
      }
    },
    isAnchor: isAnchor,
  );
}


