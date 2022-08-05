
import 'package:flutter/cupertino.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/common/common_widget/custom_gradientbutton/custom_gradientbutton.dart';
import 'package:star_common/common/common_widget/live/sex_icon_widget.dart';
import 'package:star_live/pages/rank_main/live_avatar.dart';

class AnchorAndUserItem extends StatelessWidget {
  final String? header, focusTitle, mainTitle, subTitle, level;
  final bool? onLive, needLevel, needRightBtn, needSex, isAndor, needLeftIndex;
  final int? sex;
  final void Function(int)? tapMainTitleCallBack;

  const AnchorAndUserItem(
      {Key? key,
      this.header,
      this.focusTitle,
      this.mainTitle,
      this.subTitle,
      this.level,
      this.onLive,
      this.needLevel,
      this.needRightBtn,
      this.needSex,
      this.needLeftIndex,
      this.isAndor,
      this.sex,
      this.tapMainTitleCallBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //编号
        CustomText("04", color: AppMainColors.whiteColor70, fontSize: 16),
        //头像
        OnLiveAvatar(
          padding: EdgeInsets.all(2),
          onLive: true,
          imgUrl: header,
          radius: 26,
          locImageChild: Image.asset(
            R.rankHeadMoren,
            fit: BoxFit.cover,
          ),
          onPressed: () {},
          isAnchor: true,
        ),
        //主题内容
        _contentWidget(),
        //按钮
        GradientButton(
          onPressed: () {},
          child: CustomText(
            focusTitle ?? "",
            fontSize: 12,
            color: AppMainColors.whiteColor100,
          ),
        )
      ],
    );
  }

  Widget _contentWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            //主标题
            CustomText(mainTitle ?? ""),
            //等级
            // isAndor == true ?
          ],
        ),
        Row(
          children: [
            //姓名
            needSex == true ? SexIconWidget(sex) : SizedBox(),
            //副标题
            CustomText("副标题"),
          ],
        ),
      ],
    );
  }
}
