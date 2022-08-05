part of appcommon;

class AppMainColors {
  ///随机色
  static Color RandomColor = Color.fromRGBO(
      Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1);

  /// 透明色
  static const Color transparent = Color.fromRGBO(0, 0, 0, 0);

  ///主题色
  /* 用于重要场景、主按钮、icon选中、文字*/
  static const Color mainColor = Color.fromRGBO(255, 30, 175, 1);
  static const Color mainColor20 = Color.fromRGBO(255, 30, 175, 0.2);
  static const Color mainColor30 = Color.fromRGBO(255, 30, 175, 0.3);
  static const Color mainColor70 = Color.fromRGBO(255, 30, 175, 0.7);
  static const Color mainColor60 = Color.fromRGBO(255, 30, 175, 0.6);

  // 1  0
  // 0  1 对脚线渐变
  static const Color mainGradientStartColor = Color.fromRGBO(255, 101, 200, 1);
  static const Color mainGradientEndColor = mainColor;

  ///点缀色
  /*用于重要icon、次要按钮、金额、提示文*/
  static const Color adornColor = Color.fromRGBO(50, 197, 255, 1);
  // 1  0
  // 0  1 对脚线渐变
  static const Color adornGradientStartColor = Color.fromRGBO(155, 165, 255, 1);
  static const Color adornGradientEndColor = adornColor;

  ///背景色
  /*用于页面背景*/
  static const Color backgroudColor = Color.fromRGBO(16, 16, 16, 1);

  ///appbae背景色
  /*用于页面背景*/
  static const Color appbarColor = Color.fromRGBO(36, 36, 36, 1);

  ///搜索边框色
  static const Color searchBorderColor = Color.fromRGBO(255, 255, 1, 0.6);

  ///辅助色
  /*用于数字上升、金额变动为正数*/
  static const Color assistColor = Color.fromRGBO(236, 151, 24, 1);

  static const Color chatSkinColor = Color.fromRGBO(158, 122, 67, 0.3);
  static const Color chatSkinborderColor = Color.fromRGBO(255, 190, 91, 0.6);

  ///中奖背景
  static const Color winningPushColor = Color.fromRGBO(244, 62, 64, 0.4);

  ///白色
  /*用于重要突出文字、正标题、输入后文字  数字代表透明度*/
  static const Color whiteColor100 = Color.fromRGBO(255, 255, 255, 1);
  /*用于副标题、长篇正文*/
  static const Color whiteColor70 = Color.fromRGBO(255, 255, 255, 0.7);
  static const Color whiteColor60 = Color.fromRGBO(255, 255, 255, 0.6);

  static const Color trySeeColor60 = Color.fromRGBO(236, 187, 60, 0.6);

  /*用于层次较弱文字、未输入前提示文字*/
  static const Color whiteColor40 = Color.fromRGBO(255, 255, 255, 0.4);
  /*用于层次较弱文字、未输入前提示文字度*/
  static const Color textColor20 = Color.fromRGBO(255, 255, 255, 0.2);

  static const Color whiteColor20 = Color.fromRGBO(255, 255, 255, 0.2);
  /*用于层次较弱文字、未输入前提示文字度*/
  static const Color whiteColor15 = Color.fromRGBO(255, 255, 255, 0.15);
  /*用于层次较弱文字、未输入前提示文字度*/
  static const Color whiteColor10 = Color.fromRGBO(255, 255, 255, 0.1);
  /*用于层次较弱文字、未输入前提示文字度*/
  static const Color whiteColor0 = Color.fromRGBO(255, 255, 255, 0);

  static const Color whiteColor6 = Color.fromRGBO(255, 255, 255, 0.06);

  static const Color blickColor90 = Color.fromRGBO(22, 23, 34, 0.9);

  static const Color roomNotification = Color.fromRGBO(155, 249, 255, 1);

  static const Color systembuttonColor = Color.fromRGBO(51, 255, 153, 0.17);

  ///黑色
  /*用于层次较弱文字、未输入前提示文字度*/
  static const Color blackColor0 = Color.fromRGBO(0, 0, 0, 0);
  /*用于层次较弱文字、未输入前提示文字度*/
  static const Color blackColor70 = Color.fromRGBO(0, 0, 0, 0.7);
  /*用于层次较弱文字、未输入前提示文字度*/
  static const Color blackColor40 = Color.fromRGBO(0, 0, 0, 0.4);
  static const Color blackColor30 = Color.fromRGBO(0, 0, 0, 0.3);
  static const Color blackColor60 = Color.fromRGBO(0, 0, 0, 0.6);

  static const Color blackContribution = Color.fromRGBO(22, 23, 34, 0.9);

  ///分割线
  /*用于顶部条或底部条分层分割 && 用于卡片底色、内容底色  数字代表透明度*/
  static const Color separaLineColor10 = Color.fromRGBO(255, 255, 255, 0.1);
  /*用于卡片底色、内容底色*/
  static const Color separaLineColor6 = Color.fromRGBO(255, 255, 255, 0.06);
  static const Color separaLineColor4 = Color.fromRGBO(255, 255, 255, 0.04);

  // 粉色0.2
  static Color pink20 = Color.fromRGBO(255, 30, 175, 0.2);
  // 蓝色 0.2
  static Color blue20 = Color.fromRGBO(50, 197, 255, 0.2);
  static Color blue10 = Color.fromRGBO(50, 197, 255, 0.1);

  static const Color witheOpacity6 = Color.fromRGBO(255, 255, 255, 0.06);

  static const Color witheOpacity70 = Color.fromRGBO(255, 255, 255, 0.7);
  //通用
  static const Color commonPopupBg = Color.fromRGBO(42, 65, 85, 1);

  // static const Color item_grey_bg = Color.fromRGBO(255, 255, 255, 0.06);

  // 颜色值转换
  static Color string2Color(String colorString) {
    int? value = 0x00000000;
    if (colorString.isNotEmpty) {
      if (colorString[0] == '#') {
        colorString = colorString.substring(1);
      }
      value = int.tryParse(colorString, radix: 16);
      if (value != null) {
        if (value < 0xFF000000) {
          value += 0xFF000000;
        }
      }
    }
    return Color(value!);
  }

  //首页推荐，直播item-左上角标签

  static const List<Color> homeItemDefaultGradient = [
    Color.fromRGBO(30, 30, 30, 1),
    Color.fromRGBO(38, 38, 38, 1)
  ];

  static const List<Color> homeItemGameBgTipGradient = [
    Color.fromRGBO(255, 30, 175, 1),
    Color.fromRGBO(252, 104, 104, 1),
  ];

  static const List<Color> homeItembillGradient = [
    Color.fromRGBO(0, 0, 0, 0.2),
    Color.fromRGBO(255, 255, 255, 0.2),
  ];

  static const List<Color> gameLabelGradient = [
    Color.fromRGBO(255, 30, 175, 1),
    Color.fromRGBO(252, 104, 104, 1),
  ];

  static const List<Color> rankBgGradient = [
    Color.fromRGBO(236, 151, 24, 1),
    Color.fromRGBO(236, 187, 60, 1),
  ];

  static const List<Color> fireGradient = [
    Color.fromRGBO(255, 78, 248, 1),
    Color.fromRGBO(255, 165, 114, 1),
  ];
  static const List<Color> anchorGradient = [
    Color.fromRGBO(155, 165, 255, 1),
    Color.fromRGBO(50, 197, 255, 1),
  ];

  //关注并退出
  static const List<Color> commonBtnGradient = [
    Color.fromRGBO(255, 101, 200, 1),
    Color.fromRGBO(255, 30, 175, 1),
  ];
  static const List<Color> commonInactiveGradient = [
    Color.fromRGBO(255, 101, 200, 0.4),
    Color.fromRGBO(255, 30, 175, 0.4),
  ];
  //排行榜
  static const List<Color> LeaderboardGradient = [
    Color.fromRGBO(145, 86, 255, 1),
    Color.fromRGBO(89, 150, 255, 1),
  ];

  //排行榜
  static const List<Color> LeaderboardOne = [
    Color.fromRGBO(249, 196, 58, 1),
    Color.fromRGBO(249, 196, 58, 0.7),
    Color.fromRGBO(249, 196, 58, 0.06),
  ];
  //排行榜
  static const List<Color> LeaderboardTwo = [
    Color.fromRGBO(121, 132, 140, 1),
    Color.fromRGBO(121, 132, 140, 0.7),
    Color.fromRGBO(121, 132, 140, 0.06),
  ];
  //排行榜
  static const List<Color> LeaderboardThree = [
    Color.fromRGBO(121, 82, 52, 1),
    Color.fromRGBO(121, 82, 52, 0.7),
    Color.fromRGBO(121, 82, 52, 0.06),
  ];
  //排行榜
  static const List<Color> LeaderboardFour = [
    Color.fromRGBO(0, 0, 0, 0.2),
    Color.fromRGBO(0, 0, 0, 0.4),
    Color.fromRGBO(0, 0, 0, 0.06),
  ];

  ///公聊皮肤
  static const List<Color> ChatSkin = [
    Color.fromRGBO(255, 190, 91, 0.6),
    Color.fromRGBO(192, 130, 67, 0.4),
  ];

  ///中奖皮肤
  static const List<Color> winningSkin = [
    Color.fromRGBO(244, 62, 64, 0.6),
    Color.fromRGBO(244, 62, 64, 0.4),
  ];

  ///普通皮肤
  static const List<Color> normalSkin = [
    Color.fromRGBO(0, 0, 0, 0.3),
    Color.fromRGBO(0, 0, 0, 0.3),
  ];

  ///收费金额
  static const List<Color> chargeAmount = [
    Color.fromRGBO(0, 0, 0, 0.6),
    Color.fromRGBO(255, 255, 255, 0.6),
  ];
}
