/*
 *  Copyright (C), 2015-2021
 *  FileName: live_detail_page
 *  Author: Tonight丶相拥
 *  Date: 2021/8/9
 *  Description: 
 **/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/common_widget/components/components_view.dart';
import 'package:star_common/generated/anchor_list_model_entity.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../live_cell.dart';
import '../live_enum.dart';
import '../live_home_data.dart';
import 'live_detail_model.dart';

class LiveDetailPage extends StatefulWidget {
  LiveDetailPage(this.type, {this.onTap, this.onTap1});

  final void Function(AnchorListModelEntity)? onTap;
  final void Function(List<AnchorListModelEntity> data, int index)? onTap1;

  // final AnchorType type;
  final int? type;

  @override
  createState() => _LiveDetailPageState();
}

class _LiveDetailPageState extends AppStateBase<LiveDetailPage>
    with AutomaticKeepAliveClientMixin {
  late final LiveViewModel _viewModel;
  late Future _future;
  final RefreshController _controller = RefreshController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewModel = LiveViewModel(widget.type);
    _future = _viewModel.dataRefresh();
    EventBus.instance.addListener(_onHomeLabelChange,
        name: homeLabelChange + "${widget.type}");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    EventBus.instance.removeListener(_onHomeLabelChange,
        name: homeLabelChange + "${widget.type}");
  }

  void _onHomeLabelChange(dynamic value) {
    _viewModel.type = value;
    _viewModel.show();
    _viewModel.dataRefresh();
    // _controller.requestRefresh();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    super.build(context);
    return ChangeNotifierProvider.value(value: _viewModel, child: body);
  }

  @override
  // TODO: implement body
  Widget get body => LoadingWidget(

      builder: (_, __) {
        print("初始化视图控制器");

        return RefreshWidget(
            controller: _controller,
            children: [
              // SliverPadding(
              //     padding: EdgeInsets.zero,
              //     sliver: SelectorCustom<SettingViewModel,
              //             List<HomeHotGameEntity>>(
              //         builder: (value) {
              //           if (value.length == 0) {
              //             return SizedBox();
              //           }
              //           return [
              //             SizedBox(height: 8),
              //             Row(
              //               children: [
              //                 CustomText("${intl.hotGame}",
              //                     fontSize: 16.dp,
              //                     fontWeight: w_500,
              //                     color: Colors.black),
              //                 Spacer(),
              //                 Row(children: [
              //                   CustomText("${intl.more}",
              //                       fontSize: 12.dp,
              //                       fontWeight: w_400,
              //                       color: Color.fromARGB(255, 78, 75, 75)),
              //                   SizedBox(width: 8),
              //                   Image.asset(AppImages.forwardGray)
              //                 ]).cupertinoButton(onTap: () {
              //                   var index = 2;
              //                   EventBus.instance.notificationListener(
              //                       name: homeHotGameMoreTaped,
              //                       parameter: index);
              //                 })
              //               ],
              //             ),
              //             SizedBox(height: 8),
              //             SingleChildScrollView(
              //               scrollDirection: Axis.horizontal,
              //               child: Row(
              //                 children: value.map((e) {
              //                   return Column(children: [
              //                     ExtendedImage.network(e.icon,
              //                             width: 60,
              //                             height: 60,
              //                             fit: BoxFit.fill)
              //                         .clipRRect(
              //                             radius: BorderRadius.circular(6)),
              //                     SizedBox(height: 4),
              //                     CustomText("${e.name}",
              //                         fontSize: 12.dp,
              //                         fontWeight: w_400,
              //                         color: Colors.black)
              //                   ])
              //                       .sizedBox(width: 60)
              //                       .padding(
              //                           padding: EdgeInsets.only(right: 16))
              //                       .gestureDetector(onTap: () {
              //                     pushViewControllerWithName(
              //                         AppRoutes.contactServicePage,
              //                         arguments: {
              //                           "url": e.gameUrl,
              //                           "title": "",
              //                         });
              //                   });
              //                 }).toList(),
              //               ),
              //             ),
              //             SizedBox(height: 8)
              //           ]
              //               .column(
              //                   crossAxisAlignment: CrossAxisAlignment.start)
              //               .padding(
              //                   padding: EdgeInsets.symmetric(horizontal: 16));
              //         },
              //         selector: (s) => s.hotGame).offstage.sliverToBoxAdapter),
              SliverToBoxAdapter(
                child: UniversalBanner(Get.put(LiveHomeData()).state.homeBanner),
              ),
              SliverToBoxAdapter(
                child: UniversalAnnouncement(Get.find<LiveHomeData>().state.announcementString),
              ),
              SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16.dp),
                  sliver: SelectorCustom<LiveViewModel,
                          List<AnchorListModelEntity>>(
                      builder: (data) {
                        return NullWidget<List<AnchorListModelEntity>>(data,
                            builder: (_, value) {
                              return SliverGrid(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 0.74,
                                          mainAxisSpacing: 8,
                                          crossAxisSpacing: 8),
                                  delegate:
                                      SliverChildBuilderDelegate((_, index) {
                                    var model = data[index];
                                    var type = LiveEnum.common
                                        .getLiveType(model.roomType ?? 0);
                                    var v;
                                    if (type == LiveEnum.secret) {
                                      v = "***";
                                    } else if (type == LiveEnum.ticker) {
                                      v = model.ticketAmount;
                                    } else if (type == LiveEnum.timer) {
                                      v = model.timeDeduction;
                                    } else {
                                      v = "";
                                    }
                                    return GestureDetector(
                                        onTap: () {
                                          widget.onTap?.call(model);
                                          widget.onTap1?.call(data, index);
                                        },
                                        child: LiveCell(LiveCellViewModel(
                                            avatar: model.roomCover ?? "",
                                            //model.cover!,
                                            name: model.roomTitle ?? "",
                                            //model.name!,
                                            local: model.username ?? "",
                                            //model.city!,
                                            eventName: model.roomTitle ?? "",
                                            //model.labelName!,
                                            count: model.heat ?? 0,
                                            //model.order!
                                            liveType: model.roomType ?? 0,
                                            unit: v)));
                                  }, childCount: value.length));
                            },
                            predict: (d) => d.length == 0,
                            placeHolder: SliverFillRemaining(
                              child: EmptyView(emptyType: EmptyType.noMessage)
                            ));
                      },
                      selector: (l) => l.data))
            ],
            enablePullUp: true,
            onRefresh: (c) async {
              await _viewModel.dataRefresh();
              c.refreshCompleted();
              c.resetNoData();
            },
            onLoading: (c) async {
              if (_viewModel.hasMoreData) await _viewModel.loadMore();
              if (_viewModel.hasMoreData) {
                c.loadComplete();
              } else {
                c.loadNoData();
              }
            });
      },
      future: _future);
}
