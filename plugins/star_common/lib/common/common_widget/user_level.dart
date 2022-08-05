part of appcommon;

/**
 * 用户等级，包含图标和级别数字
 * 这个布局不要动了。已经UI走查了。
 */
class UserLevelView extends StatelessWidget {
  UserLevelView(this.level, {this.name = ""});

  final int level;
  final String name; //增加主播展示

  @override
  Widget build(BuildContext context) {
    if (level == 0 && name.isEmpty) {
      return Container();
    }
    return _getLevelImg(level, name);
  }
}

Widget _getLevelImg(int level, String name) {
  if (0 < level && level <= 10) {
    return levelItem(Color(0x99FFBC13), R.icLeverFirst, level, name);
  } else if (level > 10 && level <= 20) {
    return levelItem(Color(0x994085EF), R.icLeverSecond, level, name);
  } else if (level > 20 && level <= 30) {
    return levelItem(Color(0x9900BA7F), R.icLeverThird, level, name);
  } else if (level > 30 && level <= 40) {
    return levelItem(Color(0x998222FF), R.icLeverFourth, level, name);
  } else if (level > 40 && level <= 50) {
    return levelItem(Color(0x99ED23F1), R.icLeverFifth, level, name);
  } else if (level > 50 && level <= 60) {
    return levelItem(Color(0x99FF2B2B), R.icLeverSix, level, name);
  }
  return levelItem(Color(0x99FFBC13), R.icLeverFirst, 0, name);
}

Container levelItem(Color bgColor, String urlPath, int level, String nameStr) {
  bool showStr = nameStr.length > 0;
  Color tempColor = showStr ? AppMainColors.mainColor70 : bgColor;
  double imageSize = showStr ? 0 : 12;
  return Container(
      // padding: EdgeInsets.symmetric(horizontal: 5.dp),
      padding: EdgeInsets.only(left: 2.dp, right: 2.dp),
      height: 14.dp,
      width: 28.dp,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.dp), color: tempColor),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(urlPath, width: imageSize.dp, height: imageSize.dp),
            //由于数字有1位或俩位，按照UI说的，严格居中。
            Container(
              width: 12.dp,
              height: 12.dp,
              alignment: Alignment.topCenter,
              child: CustomText(
                nameStr.length > 0 ? nameStr : "$level",
                style: TextStyle(
                    fontFamily: 'Number',
                    color: AppMainColors.whiteColor100, //rgba(1, 154, 231, 1)
                    fontSize: 10.sp,
                    fontWeight: w_400),
              ),
            )
          ]));
}
