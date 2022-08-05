import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/toast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:star_common/lottie/lottie_view.dart';
import 'package:star_common/util_tool/stringutils.dart';
import 'contribution_list_logic.dart';
import 'contribution_list_state.dart';

class ContributionPage extends StatefulWidget {
  final int type;

  final bool isAnchor;

  ContributionPage(this.type, this.isAnchor);

  @override
  createState() => _ContributionPageState();
}

class _ContributionPageState extends AppStateBase<ContributionPage> with Toast {
  /// 房间控制器
  final logic = Get.find<ContributionListLogic>();
  final state = Get.find<ContributionListLogic>().state;

  final RefreshController refreshController = RefreshController();

  @override
  Widget get body => _page(widget.type);

  _page(int index) {
    return Obx(() {
      var dataValue = state.contributeData;
      return SmartRefresher(
        controller: refreshController,
        enablePullDown: true,
        enablePullUp: false,
        header: LottieHeader(),
        footer: LottieFooter(),
        onRefresh: () {
          logic.requestPage(failure: (e) {
            refreshController.refreshCompleted();
          }, success: () {
            refreshController.refreshCompleted();
          });
        },
        child: dataValue.isEmpty
            ? EmptyView(emptyType: EmptyType.noData, topOffset: 200)
            : ListView.builder(
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: dataValue.length,
                itemBuilder: ((context, index) {
                  return _item(state.contributeData[index], index);
                }),
              ),
      );
    });
  }

  String _getNick(ContributeDataEntity model) {
    if (!widget.isAnchor && model.isInvisible == 1) {
      return "低调大佬";
    } else {
      return model.username.toString();
    }
  }

  _item(ContributeDataEntity dataValue, int index) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 16.dp, right: 16.dp),
      child: Row(
        children: [
          Container(
            child: getRank(index),
          ),
          SizedBox(width: 16.dp),
          _buildHead(dataValue),
          SizedBox(width: 16.dp),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.dp),
                Row(
                  children: [
                    SizedBox(
                      child: Text(
                        _getNick(dataValue),
                        style: TextStyle(color: AppMainColors.whiteColor100,fontWeight: w_500,fontSize: 14.sp),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(
                      width: 8.dp,
                    ),
                    UserLevelView(dataValue.rank!)
                  ],
                ),
                SizedBox(
                  height: 4.dp,
                ),
                Text(
                  "${"${StringUtils.showNmberOver10k(dataValue.heat)}${intl.firepower}"}",
                  maxLines: 1,
                  style: TextStyle(
                      color: AppMainColors.whiteColor40,
                      fontSize: 12.sp,
                      fontWeight: w_400),
                ),
                SizedBox(
                  height: 16.dp,
                ),
                Divider(height: 1, color: AppMainColors.whiteColor6),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHead(ContributeDataEntity model) {
    //榜单隐身
    if (!widget.isAnchor && model.isInvisible == 1) {
      return Image.asset(
        R.icHideOn,
        width: 40.dp,
        height: 40.dp,
      );
    } else {
      return CircleAvatar(
        radius: 20.dp,
        backgroundColor: Color(0xFF1E1E1E),
        backgroundImage: NetworkImage("${model.header}"),
        child: Container(
          alignment: Alignment(0, .5),
        ),
      );
    }
  }

  getRank(int index) {
    if (index == 0) {
      return Image.asset(
        R.icRankFirst,
        width: 24.dp,
        height: 24.dp,
      );
    } else if (index == 1) {
      return Image.asset(
        R.icRankSecond,
        width: 24.dp,
        height: 24.dp,
      );
    } else if (index == 2) {
      return Image.asset(
        R.icRankThird,
        width: 24.dp,
        height: 24.dp,
      );
    } else if (index < 10) {
      return Text(
        "0${index + 1}",
        style: TextStyle(
            fontWeight: w_400,
            fontSize: 16.sp,
            fontFamily: 'Number',
            color: Colors.white70),
      );
    } else {
      return Text(
        "$index",
        style: TextStyle(
            fontWeight: w_400,
            fontSize: 16.sp,
            fontFamily: 'Number',
            color: Colors.white70),
      );
    }
  }
}
