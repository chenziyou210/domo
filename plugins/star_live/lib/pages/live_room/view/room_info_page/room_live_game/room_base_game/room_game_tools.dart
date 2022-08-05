//计算直播间所有游戏的结果
// ignore_for_file: slash_for_doc_comments, unused_element
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spring/spring.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_live/pages/live_room/view/room_info_page/room_live_game/room_base_game/room_base_game_state.dart';

class RoomGameTools {
  ///游戏选择赔率名称
  static Widget oddName(String name, String title) {
    if (title == "特码生肖") {
      return Text(name,
          style: TextStyle(
              color: Colors.white,
              decorationStyle: TextDecorationStyle.dashed,
              fontSize: 14.sp));
    }
    switch (name) {
      case "大":
        return Image.asset(
          R.gameCpWfDa,
          width: 48.dp,
          height: 24.dp,
          fit: BoxFit.cover,
        );
      case "大单":
        return Image.asset(
          R.gameCpWfDadan,
          width: 48.dp,
          height: 24.dp,
          fit: BoxFit.cover,
        );
      case "大双":
        return Image.asset(
          R.gameCpWfDashuang,
          width: 48.dp,
          height: 24.dp,
          fit: BoxFit.cover,
        );
      case "小":
        return Image.asset(
          R.gameCpWfXiao,
          width: 48.dp,
          height: 24.dp,
          fit: BoxFit.cover,
        );
      case "小单":
        return Image.asset(
          R.gameCpWfXiaodan,
          width: 48.dp,
          height: 24.dp,
          fit: BoxFit.cover,
        );
      case "小双":
        return Image.asset(
          R.gameCpWfXiaoshuang,
          width: 48.dp,
          height: 24.dp,
          fit: BoxFit.cover,
        );
      case "单":
        return Image.asset(
          R.gameCpWfDan,
          width: 48.dp,
          height: 24.dp,
          fit: BoxFit.cover,
        );
      case "双":
        return Image.asset(
          R.gameCpWfShuang,
          width: 48.dp,
          height: 24.dp,
          fit: BoxFit.cover,
        );
      case "龙":
        return Image.asset(
          R.gameCpWfLanfang,
          width: 48.dp,
          height: 24.dp,
          fit: BoxFit.cover,
        );
      case "虎":
        return Image.asset(
          R.gameCpWfHu,
          width: 48.dp,
          height: 24.dp,
          fit: BoxFit.cover,
        );
      case "和":
        return Image.asset(
          R.gameCpWfHe,
          width: 48.dp,
          height: 24.dp,
          fit: BoxFit.cover,
        );
      case "和大":
        return Image.asset(
          R.gameCpWfHeda,
          width: 48.dp,
          height: 24.dp,
          fit: BoxFit.cover,
        );
      case "和小":
        return Image.asset(
          R.gameCpWfHexiao,
          width: 48.dp,
          height: 24.dp,
          fit: BoxFit.cover,
        );
      case "和单":
        return Image.asset(
          R.gameCpWfDan,
          width: 48.dp,
          height: 24.dp,
          fit: BoxFit.cover,
        );
      case "和双":
        return Image.asset(
          R.gameCpWfHeshuang,
          width: 48.dp,
          height: 24.dp,
          fit: BoxFit.cover,
        );
      case "红波":
        return Image.asset(
          R.gameCpWfHongbo,
          width: 48.dp,
          height: 24.dp,
          fit: BoxFit.cover,
        );
      case "蓝波":
        return Image.asset(
          R.gameCpWfLanbo,
          width: 48.dp,
          height: 24.dp,
          fit: BoxFit.cover,
        );
      case "绿波":
        return Image.asset(
          R.gameCpWfLvbo,
          width: 48.dp,
          height: 24.dp,
          fit: BoxFit.cover,
        );
      case "蓝方胜":
        return Image.asset(
          R.gameNnWfLanfang,
          width: 48.dp,
          height: 24.dp,
          fit: BoxFit.cover,
        );
      case "红方胜":
        return Image.asset(
          R.gameNnWfHongfang,
          width: 48.dp,
          height: 24.dp,
          fit: BoxFit.cover,
        );
      default:
        return Text(name,
            style: TextStyle(
                color: Colors.white,
                decorationStyle: TextDecorationStyle.dashed,
                fontSize: 14.sp));
    }
  }

  ///直播间游戏播报
  static Widget roomGameNotification(GameDataResult resutl) {
    if (resutl.gameId == 0 || resutl.number == null) {
      return Container();
    }
    int? gameId = resutl.gameId;
    var style = TextStyle(color: Colors.white, fontSize: 12.sp);
    var decoration = BoxDecoration(
        color: Color.fromRGBO(50, 197, 255, 0.4),
        borderRadius: BorderRadius.all(Radius.circular(4)));
    if (gameId == 1) {
      //快三
      return spring(Container(
        width: 166.dp,
        height: 77.dp,
        decoration: decoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "一分快三 ${resutl.issueId}",
              style: style,
            ).marginOnly(bottom: 5),
            Row(
              children: _views(_yifenkuaisan(resutl), 9.dp, imgSize: 38),
            ).marginOnly(right: 10)
          ],
        ),
      ));
    } else if (gameId == 2) {
      //六合彩
      return spring(Container(
        width: 200.dp,
        height: 61.dp,
        decoration: decoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "六合彩 ${resutl.issueId}",
              style: style,
            ).marginOnly(left: 5, bottom: 10),
            Row(children: _liuhe(resutl)),
          ],
        ),
      ));
    } else if (gameId == 3) {
      return spring(Container(
          width: 196.dp,
          height: 61.dp,
          decoration: decoration,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "快车 ${resutl.issueId}",
                  style: style,
                ).marginOnly(bottom: 5.dp, left: 8.dp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _kuaiche(resutl),
                ),
              ])));
    } else if (gameId == 4) {
      //鱼虾蟹
      return spring(Container(
          width: 166.dp,
          height: 81.dp,
          decoration: decoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "鱼虾蟹 ${resutl.issueId}",
                style: style,
              ).marginOnly(bottom: 5.dp),
              Row(
                children: _yuxiaxie(resutl, imgSize: 40),
              ),
            ],
          ).marginOnly(left: 8.dp)));
    } else if (gameId == 5) {
      return spring(Container(
          width: 228.dp,
          height: 97.dp,
          decoration: decoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "百人牛牛 ${resutl.issueId}",
                style: style,
              ).marginOnly(bottom: 5.dp),
              Row(
                children: _niuniuResutl(resutl),
              ),
            ],
          ).marginOnly(left: 8.dp)));
    } else if (gameId == 6) {
      return spring(Container(
          width: 157.dp,
          height: 61.dp,
          decoration: decoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "时时彩 ${resutl.issueId}",
                style: style,
              ).marginOnly(bottom: 5.dp),
              Row(
                children: _sscai(resutl),
              ),
            ],
          ).marginOnly(left: 8.dp)));
    }

    return Container();
  }

  static Widget spring(Widget view) {
    return Spring.slide(
        withFade: true,
        delay: Duration(milliseconds: 200),
        animDuration: Duration(milliseconds: 1000),
        slideType: SlideType.slide_in_right,
        child: view);
  }

  //开奖记录
  static Widget lotteryRecords(GameDataResult resutl, int gameId) {
    if (resutl.number == null) {
      return Container();
    }
    if (gameId == 1) {
      return Row(
        children: [
          Row(
            children: _views(_yifenkuaisan(resutl), 5, imgSize: 20),
          ),
          SizedBox(
            width: 40.dp,
          ),
          Row(
            children: _kuaiSanResults(
                [resutl.hitSum!, resutl.hitParity!, resutl.hitSize!]),
          )
        ],
      );
    } else if (gameId == 2) {
      //六合
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: _liuhe(resutl),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: _liuheLast(resutl),
          )
        ],
      );
    } else if (gameId == 3) {
      //快车
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: _kuaiche(resutl),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: _kuaicheTotal(resutl),
          )
        ],
      );
    } else if (gameId == 4) {
      //鱼虾蟹
      return Row(
        children: _yuxiaxie(resutl, imgSize: 32),
      );
    } else if (gameId == 5) {
      //牛牛
      return Row(
        children: _niuniuResutl(resutl),
      );
    } else if (gameId == 6) {
      //时时彩
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: _sscai(resutl),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: _sscaiResutl(resutl),
          )
        ],
      );
    }
    return Container();
  }

  ///resutl 开奖号码,gameId游戏ID
  static Widget gameResutl(GameDataResult? resutl, int gameId) {
    if (resutl?.number == null ||
        resutl == null ||
        resutl.number?.length == 0) {
      return Container();
    }
    if (gameId == 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: _views(_yifenkuaisan(resutl), 5),
          ),
          SizedBox(
            height: 7.dp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: _kuaiSanResults(
                [resutl.hitSum!, resutl.hitSize!, resutl.hitParity!]),
          ),
        ],
      );
    } else if (gameId == 2) {
      //六合
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: _liuhe(resutl),
          ),
          SizedBox(
            height: 5.dp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: _liuheLast(resutl),
          )
        ],
      );
    } else if (gameId == 3) {
      //快车
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: _kuaiche(resutl),
          ),
          SizedBox(
            height: 8.dp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: _kuaicheTotal(resutl),
          )
        ],
      );
    } else if (gameId == 4) {
      //鱼虾蟹
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: _yuxiaxie(resutl),
      );
    } else if (gameId == 5) {
      //牛牛
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: _niuniuResutl(resutl),
      );
    } else if (gameId == 6) {
      //时时彩
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: _sscai(resutl),
          ),
          SizedBox(
            height: 8.dp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: _sscaiResutl(resutl),
          )
        ],
      );
    }
    return Container();
  }

  /*******************************一分快三 ************************************/
  //快捷生成图片Widget
  static List<Widget> _views(List<String> list, double size,
      {double imgSize = 30}) {
    return list
        .map(
          (e) => Image.asset(
            e,
            width: imgSize.dp,
            height: imgSize.dp,
          ).marginOnly(left: size),
        )
        .toList();
  }

  static List<Widget> _kuaiSanResults(List<String> list) {
    List<Widget> widget = [];
    var alignment = Alignment(0, 0);
    var borderRadius = BorderRadius.all(Radius.circular(2));
    for (var i = 0; i < list.length; i++) {
      var text = Text(
        list[i],
        style: TextStyle(
            color: i == 0 ? Color.fromRGBO(255, 62, 62, 1) : Colors.white,
            fontSize: 12.sp),
      );
      if (i == 0) {
        var view = Container(
          width: 16.dp,
          height: 16.dp,
          decoration:
              BoxDecoration(borderRadius: borderRadius, color: Colors.white),
          child: text,
          alignment: alignment,
        );
        widget.add(view);
        widget.add(SizedBox(
          width: 3,
        ));
      } else if (i == 1) {
        var view = Container(
          width: 16.dp,
          height: 16.dp,
          decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: Color.fromRGBO(77, 159, 254, 1)),
          child: text,
          alignment: alignment,
        );
        widget.add(view);
        widget.add(SizedBox(
          width: 3,
        ));
      } else {
        var view = Container(
          width: 16.dp,
          height: 16.dp,
          decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: Color.fromRGBO(255, 129, 75, 1)),
          child: text,
          alignment: alignment,
        );
        widget.add(view);
      }
    }
    return widget;
  }

  //一分快三 骰子
  static List<String> _yifenkuaisan(GameDataResult resutl) {
    List<String> list = resutl.number!.split(",");
    List<String> datas = [];
    for (var i = 0; i < list.length; i++) {
      switch (list[i]) {
        case "1":
          datas.add(R.dicegame1);
          break;
        case "2":
          datas.add(R.dicegame2);
          break;
        case "3":
          datas.add(R.dicegame3);
          break;
        case "4":
          datas.add(R.dicegame4);
          break;
        case "5":
          datas.add(R.dicegame5);
          break;
        case "6":
          datas.add(R.dicegame6);
          break;
        default:
      }
    }
    return datas;
  }

  /*******************************六合彩 ************************************/
  static List<Widget> _liuhe(GameDataResult resutl) {
    List<String> list = resutl.number!.split(",");
    var views = list
        .map(
          (e) => Padding(
            padding: EdgeInsets.only(left: 4.dp),
            child: Container(
              width: 20.dp,
              height: 20.dp,
              alignment: Alignment(0, 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.dp)),
                  gradient: LinearGradient(
                      colors: _liuheColor(_liuheGameBo(int.parse(e))),
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
              child: Text(
                e,
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
              ),
            ),
          ),
        )
        .toList();
    List<Widget> view = [];
    for (var i = 0; i < views.length; i++) {
      if (views.length - 1 == i) {
        view.add(
          Padding(
            padding: EdgeInsets.only(left: 4.dp),
            child: Image.asset(
              R.icPlus,
              width: 16.dp,
              height: 16.dp,
            ),
          ),
        );
        view.add(views[i]);
      } else {
        view.add(views[i]);
      }
    }
    return view;
  }

  ///六合最后一个计算大小单双 flag:生肖
  static List<Widget> _liuheLast(GameDataResult resutl) {
    List<String> list = resutl.number!.split(",");
    int lastNum = int.parse(list.last);
    var dxColor = lastNum > 24
        ? Color.fromRGBO(77, 159, 254, 1)
        : Color.fromRGBO(255, 129, 75, 1);

    var dsColor = lastNum > 24
        ? Color.fromRGBO(255, 129, 75, 1)
        : Color.fromRGBO(77, 159, 254, 1);

    var colors = _liuheColor(_liuheGameBo(lastNum));
    List<String> res = [
      "$lastNum",
      resutl.hitParity!,
      resutl.hitSize!,
      resutl.hitColor!.substring(0, 1),
      resutl.hitSx!
    ];
    List<Widget> views = [];
    var borderRadius = BorderRadius.all(Radius.circular(3));
    for (var i = 0; i < res.length; i++) {
      if (i == 0 || i == 4) {
        var view = Padding(
          padding: EdgeInsets.only(left: 4.dp),
          child: Container(
            width: 16.dp,
            height: 16.dp,
            alignment: Alignment(0, 0),
            decoration:
                BoxDecoration(borderRadius: borderRadius, color: Colors.white),
            child: Text(
              res[i],
              style: TextStyle(
                  color: Color.fromRGBO(255, 62, 62, 1), fontSize: 12.sp),
            ),
          ),
        );
        views.add(view);
      } else if (i == 1 || i == 2) {
        var view = Padding(
          padding: EdgeInsets.only(left: 4.dp),
          child: Container(
            width: 16.dp,
            height: 16.dp,
            alignment: Alignment(0, 0),
            decoration: BoxDecoration(
                borderRadius: borderRadius, color: i == 1 ? dxColor : dsColor),
            child: Text(
              res[i],
              style: TextStyle(color: Colors.white, fontSize: 12.sp),
            ),
          ),
        );
        views.add(view);
      } else if (i == 3) {
        var view = Padding(
            padding: EdgeInsets.only(left: 4.dp),
            child: Container(
              width: 16.dp,
              height: 16.dp,
              alignment: Alignment(0, 0),
              decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  gradient: LinearGradient(
                      colors: colors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
              child: Text(
                res[i],
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
              ),
            ));
        views.add(view);
      }
    }
    return views;
  }

  // 0红波 1 蓝波 2绿波
  static String _liuheGameBo(int bo) {
    var listHong = [
      1,
      2,
      7,
      8,
      12,
      13,
      18,
      19,
      23,
      24,
      29,
      30,
      34,
      35,
      40,
      45,
      46
    ];
    var listLan = [3, 4, 9, 10, 14, 15, 20, 25, 26, 31, 36, 37, 41, 42, 47, 48];
    // var listLv = [5, 6, 11, 16, 17, 21, 22, 27, 28, 32, 33, 38, 39, 43, 44, 49];
    return listHong.contains(bo) ? "红" : (listLan.contains(bo) ? "蓝" : "绿");
  }

  //六合波的颜色
  static List<Color> _liuheColor(String bo) {
    if (bo == "红") {
      //红波
      return [Color.fromRGBO(252, 116, 105, 1), Color.fromRGBO(226, 32, 0, 1)];
    } else if (bo == "蓝") {
      //蓝波
      return [Color.fromRGBO(103, 139, 255, 1), Color.fromRGBO(16, 46, 239, 1)];
    } else {
      return [Color.fromRGBO(147, 207, 72, 1), Color.fromRGBO(61, 190, 0, 1)];
    }
  }

  /*******************************快车 ************************************/

  ///快车冠亚和
  static List<Widget> _kuaicheTotal(GameDataResult resutl) {
    // List<String> list = resutl.number!.split(",");
    // int sum = int.parse(list.first) + int.parse(list[1]);
    int sum = int.parse(resutl.hitGySum!);
    // var dx = sum > 9 ? "大" : "小";
    // var ds = sum % 2 == 0 ? "双" : "单";
    var dxColor = sum > 9
        ? Color.fromRGBO(77, 159, 254, 1)
        : Color.fromRGBO(255, 129, 75, 1);

    var dsColor = sum > 9
        ? Color.fromRGBO(255, 129, 75, 1)
        : Color.fromRGBO(77, 159, 254, 1);
    List<String> res = ["$sum", resutl.hitGjSize!, resutl.hitGjParity!];
    List<Widget> views = [];
    for (var i = 0; i < res.length; i++) {
      if (i == 0) {
        var view = Row(
          children: [
            Container(
              alignment: Alignment(0, 0),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  color: Colors.white),
              child: Text(
                res[i],
                style: TextStyle(
                    color: Color.fromRGBO(255, 62, 62, 1), fontSize: 12.sp),
              ),
            ),
            SizedBox(
              width: 3,
            )
          ],
        );
        views.add(view);
      } else {
        var view = Row(
          children: [
            Container(
              alignment: Alignment(0, 0),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  color: i == 1 ? dxColor : dsColor),
              child: Text(
                res[i],
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            SizedBox(
              width: 3,
            )
          ],
        );
        views.add(view);
      }
    }
    return views;
  }

  ///快车的开奖结果
  static List<Widget> _kuaiche(GameDataResult resutl) {
    List<String> list = resutl.number!.split(",");
    return list
        .map((e) => Row(
              children: [
                Container(
                  alignment: Alignment(0, 0),
                  width: 16,
                  height: 20,
                  decoration: BoxDecoration(
                      color: _kuaiCheColor(int.parse(e)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Text(
                    e,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
              ],
            ))
        .toList();
  }

  static Color _kuaiCheColor(int r) {
    switch (r) {
      case 1:
        return Color.fromRGBO(200, 170, 16, 1);
      case 2:
        return Color.fromRGBO(16, 111, 200, 1);
      case 3:
        return Color.fromRGBO(48, 68, 87, 1);
      case 4:
        return Color.fromRGBO(200, 104, 16, 1);
      case 5:
        return Color.fromRGBO(29, 164, 172, 1);
      case 6:
        return Color.fromRGBO(37, 68, 243, 1);
      case 7:
        return Color.fromRGBO(133, 133, 133, 1);
      case 8:
        return Color.fromRGBO(191, 41, 41, 1);
      case 9:
        return Color.fromRGBO(126, 46, 0, 1);
      case 10:
        return Color.fromRGBO(50, 140, 70, 1);
      default:
        return Colors.transparent;
    }
  }

  /******************************* 时时彩 ************************************/
  static List<Widget> _sscai(GameDataResult resutl) {
    List<String> list = resutl.number!.split(",");
    return list
        .map((e) => Row(
              children: [
                Container(
                  alignment: Alignment(0, 0),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color.fromRGBO(103, 139, 255, 1),
                        Color.fromRGBO(16, 46, 239, 1),
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Text(
                    e,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                SizedBox(
                  width: 3,
                )
              ],
            ))
        .toList();
  }

  static List<Widget> _sscaiResutl(GameDataResult resutl) {
    List<String> list = resutl.number!.split(",");
    var sum = list.reduce(
        (value, element) => "${(int.parse(value) + int.parse(element))}");

    var intSum = int.parse(sum);

    var dxColor = intSum > 22
        ? Color.fromRGBO(77, 159, 254, 1)
        : Color.fromRGBO(255, 129, 75, 1);

    var dsColor = intSum > 9
        ? Color.fromRGBO(255, 129, 75, 1)
        : Color.fromRGBO(77, 159, 254, 1);

    var lhhColor = resutl.hitDragonTiger == "龙"
        ? Color.fromRGBO(77, 159, 254, 1)
        : (resutl.hitDragonTiger == "和"
            ? Color.fromRGBO(61, 190, 0, 1)
            : Color.fromRGBO(255, 129, 75, 1));
    List<String> sums = [
      sum,
      resutl.hitSize!,
      resutl.hitParity!,
      resutl.hitDragonTiger!
    ];
    List<Widget> views = [];
    for (var i = 0; i < sums.length; i++) {
      if (i == 0) {
        var view = Row(
          children: [
            Container(
              width: 20,
              height: 20,
              alignment: Alignment(0, 0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              child: Text(
                sums[i],
                style: TextStyle(
                    color: Color.fromRGBO(255, 62, 62, 1), fontSize: 12),
              ),
            ),
            SizedBox(
              width: 3,
            )
          ],
        );
        views.add(view);
      } else if (i == 1 || i == 2) {
        var view = Row(
          children: [
            Container(
              width: 20,
              height: 20,
              alignment: Alignment(0, 0),
              decoration: BoxDecoration(
                  color: i == 1 ? dxColor : dsColor,
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              child: Text(
                sums[i],
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            SizedBox(
              width: 3,
            )
          ],
        );
        views.add(view);
      } else {
        var view = Row(
          children: [
            Container(
              width: 20,
              height: 20,
              alignment: Alignment(0, 0),
              decoration: BoxDecoration(
                  color: lhhColor,
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              child: Text(
                sums[i],
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            SizedBox(
              width: 3,
            )
          ],
        );
        views.add(view);
      }
    }
    return views;
  }

  /******************************* 鱼虾蟹 ************************************/
  static List<Widget> _yuxiaxie(GameDataResult resutl, {double imgSize = 40}) {
    List<String> list = resutl.number!.split(",");
    var imgList = [
      R.fishprawncrabgame61,
      R.fishprawncrabgame62,
      R.fishprawncrabgame63,
      R.fishprawncrabgame64,
      R.fishprawncrabgame65,
      R.fishprawncrabgame66,
    ];
    return list
        .map((e) => Row(
              children: [
                Container(
                  width: imgSize,
                  height: imgSize,
                  decoration: BoxDecoration(
                      color: AppMainColors.whiteColor10,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Image.asset(
                    imgList[int.parse(e) - 1],
                    width: 27,
                    height: 27,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: 5,
                )
              ],
            ))
        .toList();
  }

  /******************************* 百人牛牛 ************************************/
  static List<Widget> _niuniuResutl(GameDataResult resutl) {
    List<String> list = resutl.number!.split(",");
    List<String> blues = []; //图片
    List<String> reds = []; //图片
    List<String> bluesNum = [];
    List<String> redNum = [];
    for (var i = 0; i < list.length; i++) {
      if (i < 5) {
        //蓝
        blues.add(_pai(list[i]));
        bluesNum.add(list[i].split("_").first);
      } else {
        //红
        reds.add(_pai(list[i]));
        redNum.add(list[i].split("_").first);
      }
    }
    var bluesNiu = blues
        .map((e) => Row(
              children: [
                SizedBox(
                  width: 1,
                ),
                Image.asset(
                  e,
                  width: 18.dp,
                  height: 28.dp,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  width: 1,
                )
              ],
            ))
        .toList();
    var redsNiu = reds
        .map((e) => Row(
              children: [
                SizedBox(
                  width: 1,
                ),
                Image.asset(
                  e,
                  width: 18.dp,
                  height: 28.dp,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  width: 1,
                )
              ],
            ))
        .toList();

    var bluesView = Container(
      width: 106.dp,
      height: 56.dp,
      padding: EdgeInsets.only(left: 3.dp, right: 3.dp),
      decoration: BoxDecoration(
          color: Color.fromRGBO(29, 46, 107, 1),
          borderRadius: BorderRadius.all(Radius.circular(8.dp))),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "蓝方",
                style: TextStyle(
                    color: AppMainColors.whiteColor40, fontSize: 12.sp),
              ),
              SizedBox(
                width: 4.dp,
              ),
              Text(
                // _niu(bluesNum),
                resutl.hitBlue ?? "",
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
              ),
              Spacer(),
              Offstage(
                offstage: resutl.hitWinLose != "1" || resutl.hitWinLose == null,
                child: Image.asset(
                  R.icGamWin,
                  width: 16.dp,
                  height: 18.dp,
                ),
              )
            ],
          ),
          SizedBox(
            height: 5.dp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: bluesNiu,
          )
        ],
      ),
    );
    var redView = Container(
      width: 106.dp,
      height: 56.dp,
      padding: EdgeInsets.only(left: 3, right: 3),
      decoration: BoxDecoration(
          color: Color.fromRGBO(86, 26, 26, 1),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "红方",
                style:
                    TextStyle(color: AppMainColors.whiteColor40, fontSize: 12),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                resutl.hitRed ?? "",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              Spacer(),
              Offstage(
                offstage: resutl.hitWinLose == "1" || resutl.hitWinLose == null,
                child: Image.asset(
                  R.icGamWin,
                  width: 16.dp,
                  height: 18.dp,
                ),
              )
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: redsNiu,
          )
        ],
      ),
    );
    return [bluesView, redView];
  }

  //牌
  static String _pai(String str) {
    List<String> list = str.split("_");
    switch (int.parse(list.last)) {
      case 1: //黑
        return _heitao(int.parse(list.first));
      case 2: //红
        return _hongtao(int.parse(list.first));
      case 3: //梅
        return _meihua(int.parse(list.first));
      case 4: //方
        return _fangpian(int.parse(list.first));
      default:
        return "";
    }
  }

  //黑桃
  static String _heitao(int i) {
    String datda = R.baccaratgameBm;
    switch (i) {
      case 1:
        datda = R.baccaratgameHeitao1;
        break;
      case 2:
        datda = R.baccaratgameHeitao2;
        break;
      case 3:
        datda = R.baccaratgameHeitao3;
        break;
      case 4:
        datda = R.baccaratgameHeitao4;
        break;
      case 5:
        datda = R.baccaratgameHeitao5;
        break;
      case 6:
        datda = R.baccaratgameHeitao6;
        break;
      case 7:
        datda = R.baccaratgameHeitao7;
        break;
      case 8:
        datda = R.baccaratgameHeitao8;
        break;
      case 9:
        datda = R.baccaratgameHeitao9;
        break;
      case 10:
        datda = R.baccaratgameHeitao10;
        break;
      case 11:
        datda = R.baccaratgameHeitaoj;
        break;
      case 12:
        datda = R.baccaratgameHeitaoq;
        break;
      case 13:
        datda = R.baccaratgameHeitaok;
        break;
      default:
    }
    return datda;
  }

//红桃
  static String _hongtao(int i) {
    String datda = R.baccaratgameBm;
    switch (i) {
      case 1:
        datda = R.baccaratgameHt1;
        break;
      case 2:
        datda = R.baccaratgameHt2;
        break;
      case 3:
        datda = R.baccaratgameHt3;
        break;
      case 4:
        datda = R.baccaratgameHt4;
        break;
      case 5:
        datda = R.baccaratgameHt5;
        break;
      case 6:
        datda = R.baccaratgameHt6;
        break;
      case 7:
        datda = R.baccaratgameHt7;
        break;
      case 8:
        datda = R.baccaratgameHt8;
        break;
      case 9:
        datda = R.baccaratgameHt9;
        break;
      case 10:
        datda = R.baccaratgameHt10;
        break;
      case 11:
        datda = R.baccaratgameHtj;
        break;
      case 12:
        datda = R.baccaratgameHtq;
        break;
      case 13:
        datda = R.baccaratgameHtk;
        break;
      default:
    }
    return datda;
  }

//梅花
  static String _meihua(int i) {
    String datda = R.baccaratgameBm;
    switch (i) {
      case 1:
        datda = R.baccaratgameMh1;
        break;
      case 2:
        datda = R.baccaratgameMh2;
        break;
      case 3:
        datda = R.baccaratgameMh3;
        break;
      case 4:
        datda = R.baccaratgameMh4;
        break;
      case 5:
        datda = R.baccaratgameMh5;
        break;
      case 6:
        datda = R.baccaratgameMh6;
        break;
      case 7:
        datda = R.baccaratgameMh7;
        break;
      case 8:
        datda = R.baccaratgameMh8;
        break;
      case 9:
        datda = R.baccaratgameMh9;
        break;
      case 10:
        datda = R.baccaratgameMh10;
        break;
      case 11:
        datda = R.baccaratgameMhj;
        break;
      case 12:
        datda = R.baccaratgameMhq;
        break;
      case 13:
        datda = R.baccaratgameMhk;
        break;
      default:
    }
    return datda;
  }

//方片
  static String _fangpian(int i) {
    String datda = R.baccaratgameBm;
    switch (i) {
      case 1:
        datda = R.baccaratgameFk1;
        break;
      case 2:
        datda = R.baccaratgameFk2;
        break;
      case 3:
        datda = R.baccaratgameFk3;
        break;
      case 4:
        datda = R.baccaratgameFk4;
        break;
      case 5:
        datda = R.baccaratgameFk5;
        break;
      case 6:
        datda = R.baccaratgameFk6;
        break;
      case 7:
        datda = R.baccaratgameFk7;
        break;
      case 8:
        datda = R.baccaratgameFk8;
        break;
      case 9:
        datda = R.baccaratgameFk9;
        break;
      case 10:
        datda = R.baccaratgameFk10;
        break;
      case 11:
        datda = R.baccaratgameFkj;
        break;
      case 12:
        datda = R.baccaratgameFkq;
        break;
      case 13:
        datda = R.baccaratgameFkk;
        break;
      default:
    }
    return datda;
  }

// static const niuniu = ["一", "二", "三", "四", "五", "六", "七", "八", "九"];
//计算牛几
// static String _niu(List<String> arr) {
//   var list = arr.map((e) => int.parse(e)).toList();
//   if (list.contains(0)) {
//     return "";
//   }

//   if (_niuNum(list) == 10) {
//     return "牛牛";
//   } else if (_niuNum(list) == -1) {
//     return "无牛";
//   } else {
//     return "牛" + niuniu[_niuNum(list)];
//   }
// }

//牛数
// static int _niuNum(List<int> list) {
//   for (var i = 0; i < list.length; i++) {
//     //大于等于10算牛
//     list[i] = list[i] >= 10 ? 10 : list[i];
//   }
//   for (var i = 0; i < list.length - 2; i++) {
//     for (var j = i + 1; j < list.length - 1; j++) {
//       for (var k = j + 1; k < list.length; k++) {
//         if ((list[i] + list[j] + list[k]) % 10 == 0) {
//           list[i] = 10;
//           list[j] = 10;
//           list[k] = 10;
//           var subList = list.where((element) => element < 10).toList(); //过滤
//           var result = 0;
//           subList.forEach((element) {
//             result += element; //剩下的元素相加,计算牛几
//           });
//           if (result % 10 == 0) {
//             return 10;
//           } else {
//             return result % 10 - 1;
//           }
//         }
//       }
//     }
//   }
//   return -1;
// }

  ///计算2个牛牛的大小  1:蓝方赢 2:红方赢
//   static int _niuniuSize(List<String> list) {
//     List<int> blues = []; // 牌
//     List<int> bluesHs = []; //花色
//     List<int> reds = []; // 牌
//     List<int> redsHs = []; //花色
//     for (var i = 0; i < list.length; i++) {
//       if (i < 5) {
//         //蓝
//         blues.add(int.parse(list[i].split("_").first));
//         bluesHs.add(int.parse(list[i].split("_").last));
//       } else {
//         //红
//         reds.add(int.parse(list[i].split("_").first));
//         redsHs.add(int.parse(list[i].split("_").last));
//       }
//     }

//     List<int> b = [];
//     List<int> r = [];
//     for (var i = 0; i < blues.length; i++) {
//       if (blues[i] == 0) {
//         return 3;
//       } else {
//         b.add(blues[i]);
//       }
//     }
//     for (var i = 0; i < reds.length; i++) {
//       if (reds[i] == 0) {
//         return 3;
//       } else {
//         r.add(reds[i]);
//       }
//     }
//     var blueNiu = _niuNum(b);
//     var redNiu = _niuNum(r);

//     if (blueNiu > redNiu) {
//       return 1;
//     } else if (blueNiu < redNiu) {
//       return 2;
//     } else {
//       //计算牌一样,无牛或者牛几
//       //点数一样
//       var blueMax = blues.reduce(max);
//       var redMax = reds.reduce(max);
//       if (blueMax > redMax) {
//         return 1;
//       } else if (blueMax < redMax) {
//         return 2;
//       } else {
//         //牌一样大,计算花色
//         var bhs = 0; //蓝方的花色 黑1 >, 红 2, >梅 3, >方 4
//         var rhs = 0; //红方的花色 黑1 >, 红 2, >梅 3, >方 4
//         for (var i = 0; i < blues.length; i++) {
//           if (blues[i] == blueMax) {
//             bhs = bluesHs[i];
//           }
//         }
//         for (var i = 0; i < reds.length; i++) {
//           if (reds[i] == redMax) {
//             rhs = redsHs[i];
//           }
//         }
//         if (bhs > rhs) {
//           return 2;
//         } else {
//           return 1;
//         }
//       }
//     }
//   }
}
