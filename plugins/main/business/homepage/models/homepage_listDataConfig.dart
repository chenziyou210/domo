import 'package:star_common/generated/anchor_list_model_entity.dart';
import 'package:star_common/util_tool/stringutils.dart';

class ListDataConfig {
  ListDataConfig({
    required this.anchorItem,
  });

  final AnchorListModelEntity anchorItem;

  ///*1.房间名字 房间背景图片*/
  String roomTitle() {
    String key = "";
    switch (anchorItem.barType) {
      case 2:
        // key = anchorItem.distance.toString();
        key = anchorItem.username ?? "";
        break;
      default:
        key = anchorItem.roomTitle ?? "";
        break;
    }
    return key;
  }
  String roomCover() => anchorItem.roomCover ?? "";

  ///*2.是否展示房间图标 */
  bool showRoomWidget() {
    var key = anchorItem.barType != 2
        && anchorItem.gameName != null
        && anchorItem.gameName!.length > 0;
    return key;
  }
  String roomName() => anchorItem.gameName ?? "";

  ///*3.是否展示直播icon*/
  bool showLiveWidget() {
    var key = (anchorItem.state == 1
            && anchorItem.barType == 2);
    return key;
  }

  ///4.*======.富文本内容控制 ========*/
  // 计费相关
  bool showTopWidget() {
    var key = anchorItem.rank != 0;
    switch (anchorItem.barType) {
      //附近不用展示
      case 2:key = false;
        break;
      default:break;
    }
    return key;
  }
  String showTopText() => "TOP${anchorItem.rank}";


  // 计费相关
  bool showBillWidget() {
    bool key = false;
    if (anchorItem.feeType == 1) {
      key = true;
    }
    if (anchorItem.feeType == 2) {
      key = true;
    }
    return key;
  }

  String showBillText() {
    String key = "";
    if (anchorItem.feeType == 1) {
      key = "${anchorItem.timeDeduction!}钻/分钟";
    } else if (anchorItem.feeType == 2) {
      key = "${anchorItem.ticketAmount!}钻/场";
    }
    return key;
  }

  String showCityText() {
    var key = anchorItem.region ?? "火星";
    if(key.length <= 0){ key = "火星";}
    return key;
  }

  String showHeatText() => StringUtils.showNmberOver10k(anchorItem.heat);
}
