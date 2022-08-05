// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_live/pages/custom_service/contact_service_page.dart';
import 'package:hjnzb/pages/game/webview_game_page.dart';
import 'package:hjnzb/pages/my_mine/mine_active/mine_active_state.dart';

class MineActiveSubPage extends StatefulWidget {
  final List<MineActiveList>? list;
  MineActiveSubPage({
    Key? key,
    required this.list,
  }) : super(key: key);
  @override
  createState() => _MineActiveSubPageState();
}

class _MineActiveSubPageState extends AppStateBase<MineActiveSubPage> {
  @override
  Widget build(BuildContext context) {
    var list = widget.list;
    return list?.length == 0
        ? EmptyView(emptyType: EmptyType.noData)
        : ListView.builder(
            itemCount: list?.length ?? 0,
            itemBuilder: (c, index) {
              return item(list?[index]);
            });
  }

  Widget item(MineActiveList? data) {
    // double itemHeight = ScreenUtil().screenScale(126);
    // print("itemHeight ${itemHeight}");
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
          height: 126.dp,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              image: DecorationImage(
                image: NetworkImage(data?.activityImage ?? ""),
                fit: BoxFit.cover,
              )),
        ).gestureDetector(onTap: () {
          Get.to(() => ContactServicePage(
                arguments: {
                  "title": data?.activityContent ?? "",
                  "url": data?.activityLinkAddress ?? ""
                },
              ));
        }),
        Container(
          alignment: Alignment(0, 0),
          margin: EdgeInsets.only(left: 15, top: 15),
          height: 24,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Color.fromRGBO(0, 0, 0, 0.6),
              border:
                  Border.all(color: AppMainColors.whiteColor60, width: 0.6)),
          child: Text(
            "活动时间：${data?.isForever == 1 ? "永久" : "临时"}",
            style: TextStyle(color: AppMainColors.whiteColor70, fontSize: 12.sp),
          ),
        ),
      ],
    );
  }
}
