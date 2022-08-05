import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/colors.dart';
import 'package:star_common/common/common_widget/live/peerage_widget.dart';
import 'package:star_common/common/common_widget/live/sex_icon_widget.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_live/pages/personal_information/personal_data/personal_data_logic.dart';
import '../../contribution_list/contribution_rank.dart';

class PersonalDataPage extends StatefulWidget {
  PersonalDataPage({dynamic arguments}) : this.userId = arguments["userId"], this.isMine = arguments["isMine"] ?? false;

  final String userId;
  final bool isMine;

  @override
  State<PersonalDataPage> createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  final logic = Get.put(PersonalDataLogic());
  final state = Get.find<PersonalDataLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    state.userId = widget.userId;
    state.isMine = widget.isMine;
    logic.loadPersonalData(needHub: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<PersonalDataLogic>(builder: (logic) {
        return state.loading == true ? Container() : ListView(
          children: [
            _buildHeader(context),
            _buildInformation(context),
            _buildUserInfo(),
          ],
        );
      }),
    );
  }

  /// 头像背景区域
  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        _buildHeaderBg(),
        _buildHeaderNav(context),
        Positioned(
          bottom: 16.dp,
          left: 24.dp,
          right: 0,
          child: _buildHeaderContent(context),
        ),
      ],
    );
  }

  // 头像背景
  Widget _buildHeaderBg() {
    return Opacity(
      opacity: 0.2,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Image.network(
          state.personalModel.header.toString(),
          width: double.infinity,
          height: 300.dp,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // 导航栏
  Widget _buildHeaderNav(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.all(12.dp),
            child: Image.asset(
              R.backIconWhite,
              width: 24.dp,
              height: 24.dp,
            ),
          ),
        ),
        widget.isMine ? GestureDetector(
          onTap: () {
            logic.pushEditUserInfoPage(context);
          },
          child: Padding(
            padding: EdgeInsets.all(12.dp),
            child: Image.asset(
              R.icEditProfile,
              width: 24.dp,
              height: 24.dp,
            ),
          ),
        ) : Container(),
      ],
    );
  }

  // 头部内容
  Widget _buildHeaderContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeaderContentAvatarRow(),
        SizedBox(height: 16.dp,),
        _buildHeaderContentNameRow(),
        SizedBox(height: 8.dp,),
        Padding(
          padding: EdgeInsets.only(right: 24.dp),
          child: Text(
            "${state.personalModel.signature ?? ''}".isEmpty
                ? "TA好像忘记签名了"
                : "${state.personalModel.signature}",
            style:
            TextStyle(color: AppColors.mine_wallet_text, fontSize: 12.sp),
          ),
        ),
      ],
    );
  }

  // 头像所在行内容
  Widget _buildHeaderContentAvatarRow() {
    return Row(
      children: [
        CircleAvatar(
          radius: 40.dp,
          backgroundColor: Color(0xFF1E1E1E),
          backgroundImage:
          NetworkImage(state.personalModel.header.toString()),
        ),
        Expanded(child: state.personalModel.openLiveFlag == 0
            ? _buildTextItem("${state.personalModel.attentionNum ?? 0}", "关注", allowClick: true)
            : _buildTextItem("${state.personalModel.fansNum ?? 0}", "粉丝", allowClick: true),
        ),
        Expanded(child: state.personalModel.openLiveFlag == 0
              ? _buildTextItem("${state.personalModel.sendGiftNum ?? 0}", "送出礼物")
              : _buildTextItem("${state.personalModel.receivedGiftNum ?? 0}", "收到礼物"),
        ),
      ],
    );
  }

  // 关注  粉丝  礼物
  Widget _buildTextItem(String value, String name, {bool allowClick = false}) {
    return InkWell(
      onTap: () {
        if (allowClick) {
          logic.pushFloowAndFansPage();
        }
      },
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontFamily: "Number",
            ),
          ),
          SizedBox(height: 8.dp,),
          Text(
            name,
            style: TextStyle(
              color: AppColors.mine_wallet_text,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
    // return
  }

  // 昵称所在行内容
  Widget _buildHeaderContentNameRow() {
    return Padding(
      padding: EdgeInsets.only(right: 24.dp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "${state.personalModel.username ?? ''}",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.dp,
                fontWeight: AppLayout.boldFont),
          ),
          SizedBox(
            width: 8.dp,
          ),
          state.personalModel.openLiveFlag == 0
              ? UserLevelView(state.personalModel.rank ?? 0)
              : Container(
            width: 28.dp,
            height: 14.dp,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.dp),
                color: AppMainColors.mainColor60),
            child: CustomText(
              '主播',
              style: TextStyle(
                  color: AppMainColors
                      .whiteColor100, //rgba(1, 154, 231, 1)
                  fontSize: 10.sp,
                  fontWeight: w_400),
            ),
          ),
          PeerageWidget(state.personalModel.nobleType, 4),
          Container(
            margin: EdgeInsets.only(left: 4.dp),
            child: SexIconWidget(state.personalModel.sex),
          ),
        ],
      ),
    );
  }

  ///  资料
  Widget _buildInformation(BuildContext context) {
    return Container(
      color: AppMainColors.backgroudColor,
      padding: EdgeInsets.only(top: 24.dp, left: 24.dp, right: 24.dp, bottom: 16.dp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(right: 6.dp),
                child: Text(
                  "资料",
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: AppMainColors.mainColor,
                      fontWeight: AppLayout.boldFont),
                ),
              ),
              Positioned(
                child: Image.asset(
                  R.mineInfoEllipse,
                  width: 16.dp,
                  height: 16.dp,
                ),
                bottom: 0,
                right: 0,
              )
            ],
          ),
          _buildInformationRank(),
        ],
      ),
    );
  }

  // 贡献榜
  Widget _buildInformationRank() {
    return Container(
      margin: EdgeInsets.only(top: 12.dp),
      padding: EdgeInsets.all(16.dp),
      decoration: BoxDecoration(
          color: AppColors.mine_wallet_gb,
          border: Border.all(color: AppColors.mine_wallet_line, width: 1.dp),
          borderRadius: BorderRadius.all(Radius.circular(8.dp)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              state.personalModel.openLiveFlag == 0
                  ? Image.asset(
                R.attentionText,
                width: 42.dp,
                height: 12.dp,
              )
                  : Image.asset(
                R.fanAttentionText,
                width: 69.dp,
                height: 15.dp,
              ),
              SizedBox(
                height: 8.dp,
              ),
              Text(
                state.personalModel.openLiveFlag == 0
                    ? '贡献${state.personalModel.heat ?? 0}火力值'
                    : '贡献${state.personalModel.totalHeat ?? 0}火力值',
                style: TextStyle(
                    color: AppMainColors.whiteColor40, fontSize: 12.sp),
              ),
            ],
          ),
          _buildRankAvatar(),
        ],
      ),
    ).gestureDetector(onTap: () {
      if (state.personalModel.openLiveFlag == 1) {
        customShowModalBottomSheet(
            context: context,
            builder: (_) {
              return ContributionRankPage(
                false,
                widget.userId,
              );
            },
            fixedOffsetHeight: ScreenUtil().screenHeight * 0.6,
            isScrollControlled: false,
            barrierColor: Colors.transparent,
            backgroundColor: Colors.transparent);
      } else {
        logic.pushRankIntegrationPage(context);
      }
    });
  }

  // 贡献榜头像
  Widget _buildRankAvatar() {
    return Row(
      children: [
        SizedBox(
          width: 80.dp,
          child: Stack(
            children: [
              Positioned(
                child: _buildAvatarRankItem(
                    0,
                    (state.personalModel.rankUserList ?? [])
                        .length >=
                        1
                        ? state.personalModel.rankUserList![0]
                        : ''),
              ),
              Positioned(
                left: 24.dp,
                child: _buildAvatarRankItem(
                    1,
                    (state.personalModel.rankUserList ?? [])
                        .length >=
                        2
                        ? state.personalModel.rankUserList![1]
                        : ''),
              ),
              Positioned(
                left: 44.dp,
                child: _buildAvatarRankItem(
                    2,
                    (state.personalModel.rankUserList ?? [])
                        .length >=
                        3
                        ? state.personalModel.rankUserList![2]
                        : ''),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.dp,),
        Image.asset(
          R.mineRight,
          width: 16.dp,
          height: 16.dp,
        ),
      ],
    );
  }

  Widget _buildAvatarRankItem(int index, String value) {
    return Container(
      width: 34.dp,
      height: 34.dp,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17.dp),
        border: Border.all(
          color: Colors.white,
          width: 1.dp,
        ),
      ),
      child: value.isEmpty ? Container(
        width: 32.dp,
        height: 32.dp,
        decoration: BoxDecoration(
          color: Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16.dp),
        ),
      ) : CircleAvatar(
        backgroundColor: Color(0xFF1E1E1E),
        radius: 16.dp,
        backgroundImage: NetworkImage(value),
      ),
    );
  }

  ///  个人信息
  Widget _buildUserInfo() {
    var list = ["ID:", "家乡:", "职业:", "生日:", "年龄:", "感情:"];
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.dp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "个人信息",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: AppLayout.boldFont),
          ),
          Container(
            margin: EdgeInsets.only(top: 14.dp, bottom: 16.dp),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: ((context, index) {
                var value = "";
                switch (index) {
                  case 0:
                    value = state.personalModel.shortId.toString();
                    break;
                  case 1:
                    value = state.personalModel.city ?? '';
                    value = value.isEmpty ? "火星" : value;
                    break;
                  case 2:
                    value = state.personalModel.profession ?? '';
                    value = value.isEmpty ? "未知" : value;
                    break;
                  case 3:
                    value = state.personalModel.birthday ?? '';
                    value = value.isEmpty ? "未知" : value;
                    break;
                  case 4:
                    value = state.personalModel.age != null
                        ? state.personalModel.age.toString()
                        : '';
                    value = value.isEmpty ? "未知" : value;
                    break;
                  case 5:
                    value = state.personalModel.emotion ?? '';
                    value = value.isEmpty ? "未知" : value;
                    break;
                  default:
                }
                return _userInfoItem(list[index], value);
              }),
              itemCount: list.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _userInfoItem(String name, String value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.dp),
      child: Row(
        children: [
          SizedBox(
            width: 60.dp,
            child: Text(
              name,
              style:
              TextStyle(color: AppColors.mine_wallet_text, fontSize: 14.sp),
            ),
          ),
          Text(
            value,
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
