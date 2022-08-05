/*
 *  Copyright (C), 2015-2021
 *  FileName: end_draw
 *  Author: Tonight丶相拥
 *  Date: 2021/11/26
 *  Description:
 **/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/generated/anchor_list_model_entity.dart';
import 'package:star_live/pages/live/live_cell.dart';
import 'package:star_live/pages/live/live_enum.dart';
import 'end_draw_logic.dart';

class LiveRoomEndDraw extends StatefulWidget {
  LiveRoomEndDraw(this.id, {required this.onChange});
  final String id;
  final void Function(AnchorListModelEntity) onChange;
  @override
  createState() => _LiveRoomEndDrawState(id);
}

class _LiveRoomEndDrawState extends State<LiveRoomEndDraw> {
  _LiveRoomEndDrawState(String id): this._controller = EndDrawLogic();
  final EndDrawLogic _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(_controller);
    _controller.dataRefresh();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        width: context.width * 0.8,
        height: context.height,
        padding: EdgeInsets.only(top: 16),
        child: Row(
            children: [
              Column(
                  children: [
                    SizedBox(height: 90),
                    Hero(tag: "endDrawHero", child: IconButton(
                        padding: EdgeInsets.only(top: 8, left: 8, bottom: 8),
                        alignment: Alignment.centerRight,
                        onPressed: (){
                          Get.back();
                        },
                        icon: Image.asset(R.enddrawclose)))
                  ]
              ),
              Expanded(child: RefreshWidget(
                  enablePullUp: true,
                  enablePullDown: true,
                  onLoading: (c) async{
                    await _controller.loadMore();
                    if (_controller.hasMoreData) {
                      c.loadComplete();
                    }else {
                      c.loadNoData();
                    }
                  },
                  onRefresh: (c) async{
                    c.resetNoData();
                    await _controller.dataRefresh();
                    c.refreshCompleted();
                  },
                  children: [
                    Obx((){
                      if (_controller.data.length == 0) {
                        return SliverFillRemaining();
                      }

                      return SliverGrid(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8),
                          delegate: SliverChildBuilderDelegate((_, index) {
                            var model = _controller.data[index];
                            var type = LiveEnum.common.getLiveType(model.roomType ?? 0);
                            var v;
                            if (type == LiveEnum.secret) {
                              v = "***";
                            }else if (type == LiveEnum.ticker){
                              v = model.ticketAmount;
                            }else if (type == LiveEnum.timer){
                              v = model.timeDeduction;
                            }else {
                              v = "";
                            }
                            return GestureDetector(
                                onTap: () {
                                  Get.back();
                                  widget.onChange(model);
                                },
                                child: LiveCell(
                                    LiveCellViewModel(
                                        avatar: model.roomCover ?? "",//model.cover!,
                                        name: model.roomTitle ?? "",//model.name!,
                                        local: model.username ?? "",//model.city!,
                                        eventName: model.roomTitle ?? "",//model.labelName!,
                                        count: model.heat ?? 0,//model.order!
                                        liveType: model.roomType ?? 0,
                                        unit: v
                                    )
                                )
                            );
                          }, childCount: _controller.data.length));
                    })
                  ]
              ).container(
                  color: Color.fromARGB(255, 21, 23, 35)
              ))
            ]
        )
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<EndDrawLogic>();
  }
}
