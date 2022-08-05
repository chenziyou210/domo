import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/picker_style.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:get/get.dart';
import 'package:hjnzb/pages/my_mine/mine_edit_info/mine_edit_info_state.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/config/app_layout.dart';
import 'package:star_common/manager/user/user_info.dart';
import 'mine_edit_info_logic.dart';

class MineEditInfoPage extends StatefulWidget {
  @override
  State<MineEditInfoPage> createState() => _MineEditInfoPageState();
}

class _MineEditInfoPageState extends State<MineEditInfoPage> {
  final logic = Get.put(MineEditInfoLogic());
  final state = Get.find<MineEditInfoLogic>().state;
  final UserInfoLogic userInfoLogic = Get.find<UserInfoLogic>();
  final UserInfoState userInfoState = Get.find<UserInfoLogic>().state;

  @override
  Widget build(BuildContext context) {
    state.context = context;
    return Scaffold(
        appBar: DefaultAppBar(
          title: AppLayout.appBarTitle('编辑资料'),
          centerTitle: true,
        ),
        body: Obx(() {
          return ListView(children: [
            buildEditInfoItem(
              '头像',
              userInfoState.userInfo.value.avatar,
              InfoTypes.avatar,
              () => _editAvatar(context),
            ),
            buildEditInfoItem(
              '昵称',
              userInfoState.userInfo.value.nickname,
              InfoTypes.nickname,
              () => logic.editNickname(),
            ),
            GetBuilder<UserInfoLogic>(builder: (logic) {
              return buildEditInfoItem(
                '账号',
                logic.state.user.shortId ?? '',
                InfoTypes.account,
                () => null,
              );
            }),
            buildEditInfoItem(
              '性别',
              userInfoState.userInfo.value.sex == 0 ? '男' : '女',
              InfoTypes.sex,
              () => _editSex(context),
            ),
            Container(
              height: 8.dp,
              color: AppMainColors.string2Color('#020202'),
            ),
            buildEditInfoItem(
              '生日',
              userInfoState.userInfo.value.birthday.isEmpty
                  ? '请选择'
                  : userInfoState.userInfo.value.birthday,
              InfoTypes.birthday,
              () => _editBirthday(context),
            ),
            buildEditInfoItem(
              '情感',
              userInfoState.userInfo.value.feeling.isEmpty
                  ? '请选择'
                  : userInfoState.userInfo.value.feeling,
              InfoTypes.feeling,
              () => _editFeeling(context),
            ),
            buildEditInfoItem(
              '家乡',
              userInfoState.userInfo.value.hometown.isEmpty
                  ? '请选择'
                  : userInfoState.userInfo.value.hometown,
              InfoTypes.hometown,
              () => _editHometown(context),
            ),
            buildEditInfoItem(
              '职业',
              userInfoState.userInfo.value.profession.isEmpty
                  ? '请选择'
                  : userInfoState.userInfo.value.profession,
              InfoTypes.profession,
              () => _editProfession(context),
            ),
            buildEditInfoItem(
              '签名',
              userInfoState.userInfo.value.signature.isEmpty
                  ? 'TA好像忘记签名了'
                  : userInfoState.userInfo.value.signature,
              InfoTypes.signature,
              () => logic.editSignature(),
            ),
          ]);
        }));
  }

  /// item样式
  Widget buildEditInfoItem(
      String title, String subtitle, InfoTypes type, Function() tapEvent) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.dp),
        height: 55.dp,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                type == InfoTypes.avatar
                    ? AppLayout.textWhite16(title).expanded()
                    : AppLayout.textWhite16(title),
                type == InfoTypes.avatar
                    ? _buildAvatar()
                    : Text(
                  subtitle,
                  style: TextStyle(
                      fontSize: 14.sp, color: AppMainColors.whiteColor70),
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ).expanded(),
                SizedBox(width: 8.dp,),
                (type == InfoTypes.account)
                    ? Container()
                    : Image.asset(R.comArrowRight,
                    width: 16.dp, height: 16.dp)
              ],
            ).expanded(),
            type == InfoTypes.sex
                ? Container()
                : Container(height: 1.dp, color: AppMainColors.separaLineColor4)
          ],
        ),
      ),
      onTap: tapEvent,
    );
  }

  /// 头像
  Widget _buildAvatar() {
    return ClipOval(
        child: Image.network(
      userInfoState.userInfo.value.avatar,
      width: 48.dp,
      height: 48.dp,
      fit: BoxFit.cover,
    ));
  }

  /// 编辑头像
  void _editAvatar(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: AppMainColors.blackColor70,
        builder: (BuildContext context) {
          return Container(
            height: 200.dp,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppMainColors.commonPopupBg,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.dp),
                topRight: Radius.circular(8.dp),
              ),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              _buildSelectItem('拍照', () => logic.selectAvatarWithCamera()),
              Container(height: 1, color: AppMainColors.whiteColor6),
              _buildSelectItem('从相册选择', () => logic.selectAvatarWithPhoto()),
              Container(height: 4, color: AppMainColors.whiteColor6),
              _buildSelectItem('取消', () => logic.dismissBottomSelector())
            ]),
          );
        });
  }

  /// 底部选择item样式
  Widget _buildSelectItem(String title, Function() itemEvent) {
    return GestureDetector(
      child: Container(
        color: AppMainColors.commonPopupBg,
        width: double.infinity,
        height: 50.dp,
        alignment: Alignment.center,
        child: AppLayout.textWhite16(title),
      ),
      onTap: itemEvent,
    );
  }

  /// 编辑性别
  void _editSex(BuildContext context) {
    Pickers.showSinglePicker(context,
        data: userInfoState.sexList,
        selectData: userInfoState.userInfo.value.sex == 0 ? '男' : '女',
        pickerStyle: _getPickerStyle(), onConfirm: (sex, int index) {
      userInfoLogic.updateSex(sex, index);
    });
  }

  /// 编辑生日
  void _editBirthday(BuildContext context) {
    DateTime now = DateTime.now();
    Pickers.showDatePicker(
      context,
      maxDate: PDuration(year: (now.year - 18), month: now.month, day: now.day),
      minDate: PDuration(year: (now.year - 40), month: 1, day: 1),
      pickerStyle: _getPickerStyle(),
      onConfirm: (PDuration date) => logic.updateBirthday(date),
    );
  }

  /// 编辑情感
  void _editFeeling(BuildContext context) {
    Pickers.showSinglePicker(context,
        data: userInfoState.feelings,
        selectData: '单身',
        pickerStyle: _getPickerStyle(), onConfirm: (feeling, index) {
      userInfoLogic.updateFeeling(feeling);
    });
  }

  /// 编辑家乡
  void _editHometown(BuildContext context) {
    Pickers.showAddressPicker(context,
        addAllItem: false,
        initTown: '',
        pickerStyle: _getPickerStyle(), onConfirm: (province, opacity, town) {
      userInfoLogic.updateHometown(province, opacity, town ?? '');
    });
  }

  /// 编辑职业
  void _editProfession(BuildContext context) {
    Pickers.showSinglePicker(context,
        data: userInfoState.professions,
        selectData: userInfoState.userInfo.value.profession,
        pickerStyle: _getPickerStyle(), onConfirm: (profession, index) {
      userInfoLogic.updateProfession(profession);
    });
  }

  /// 选择器公用样式
  PickerStyle _getPickerStyle() {
    return PickerStyle(
        title: Container(
          alignment: Alignment.center,
          height: 40.dp,
          color: AppMainColors.whiteColor6,
          child: CustomText(
            '选择',
            textAlign: TextAlign.center,
            color: AppMainColors.whiteColor70,
            fontSize: 16.sp,
          ),
        ),
        backgroundColor: AppMainColors.commonPopupBg,
        textColor: AppMainColors.whiteColor100,
        textSize: 16.sp,
        cancelButton: Container(
          width: 96.dp,
          height: 40.dp,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.dp),
            ),
            color: AppMainColors.whiteColor6,
          ),
        ),
        commitButton: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 16.dp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8.dp),
            ),
            color: AppMainColors.whiteColor6,
          ),
          width: 96.dp,
          height: 40.dp,
          child: CustomText(
            '确定',
            textAlign: TextAlign.right,
            color: AppMainColors.whiteColor70,
            fontSize: 14.sp,
          ),
        ),
        pickerHeight: 170.dp,
        pickerTitleHeight: 40.dp,
        pickerItemHeight: 40.dp,
        headDecoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8.dp),
            topLeft: Radius.circular(8.dp),
          ),
          color: AppMainColors.commonPopupBg,
        ),
        itemOverlay: Container()
    );
  }

}
