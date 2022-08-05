/*
 *  Copyright (C), 2015-2021
 *  FileName: muting_list
 *  Author: Tonight丶相拥
 *  Date: 2021/11/2
 *  Description: 
 **/

import 'package:flutter/material.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/app_common_widget.dart';
import '';
import 'package:hjnzb/pages/black_list/black_list.dart';
import 'muting_list_mode.dart';

class MutingList extends StatefulWidget {
  MutingList({dynamic arguments}) : this.anchorId = arguments["anchorId"];
  final String anchorId;
  @override
  createState() => _MutingListState();
}

class _MutingListState extends BlackListState<MutingList> {
  @override
  // TODO: implement model
  MutingListModel get model => super.model as MutingListModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  // TODO: implement appBar
  PreferredSizeWidget? get appBar => DefaultAppBar(
      title: Text(intl.mutingList.replaceAll(" ", ""),
          style: AppStyles.f17w400c0_0_0));

  @override
  AppModel? initializeModel() {
    // TODO: implement initializeModel
    return MutingListModel(widget.anchorId)..loadData();
  }

  @override
  void onTap(int index) {
    // TODO: implement onTap
  }

  @override
  void onDelete(int index) {
    // TODO: implement onDelete
    model.delete(index);
  }
}
