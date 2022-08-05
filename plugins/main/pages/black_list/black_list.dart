/*
 *  Copyright (C), 2015-2021
 *  FileName: black_list
 *  Author: Tonight丶相拥
 *  Date: 2021/8/4
 *  Description: 
 **/

import 'package:flutter/material.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';
import 'package:star_common/generated/favorite_entity.dart';
import 'package:provider/provider.dart';
import 'black_list_model.dart';
import 'cell.dart';

// const String _url = "https://img2.baidu.com/it/u=1077360284,2857506492&fm=26&fmt=auto&gp=0.jpg";
class BlackList extends StatefulWidget {
  @override
  createState() => BlackListState<BlackList>();
}

class BlackListState<T extends StatefulWidget> extends AppStateBase<T> {
  final ScrollController _controller = ScrollController();

  @override
  // TODO: implement model
  BlackListModel get model => super.model as BlackListModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  // TODO: implement appBar
  PreferredSizeWidget? get appBar => DefaultAppBar(
      title: Text(intl.blacklist, style: AppStyles.f17w400c0_0_0));

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider.value(value: model, child: super.scaffold);
  }

  @override
  // TODO: implement body
  Widget get body => RefreshWidget(
      enablePullUp: true,
      children: [selector],
      onLoading: (c) async {
        if (model.hasMoreData) await model.loadMore();
        if (model.hasMoreData) {
          c.loadComplete();
        } else {
          c.loadNoData();
        }
      },
      onRefresh: (c) async {
        await model.dataRefresh();
        c.refreshCompleted();
        c.resetNoData();
      });

  @override
  // TODO: implement bodyColor
  Color? get bodyColor => AppColors.c255_255_255;

  Widget get selector => SelectorCustom<BlackListModel, List<FavoriteEntity>>(
      builder: (data) {
        return sliverList;
      },
      selector: (b) => b.data);

  Widget get sliverList => SliverActionList(
      builder: (_, index) {
        var model = this.model.data[index];
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 70,
            child: Column(children: [
              Expanded(
                  child: PersonCell(PersonModel(
                      avatar: model.header ?? "",
                      signature: model.signature ?? "",
                      name: model.name ?? "",
                      level: model.rank ?? 0))),
              CustomDivider(height: 1, color: AppColors.c239_239_239)
            ]),
            color: Colors.white);
      },
      length: this.model.data.length,
      functions: [onDelete],
      titles: [title],
      colors: [Colors.red],
      cellTapped: onTap,
      controller: _controller);

  String get title => intl.remove;

  @override
  AppModel? initializeModel() {
    // TODO: implement initializeModel
    return BlackListModel()..loadData();
  }

  void onTap(int index) {}

  void onDelete(int index) {}
}
