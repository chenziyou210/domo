import 'package:flutter/material.dart';
import 'package:star_common/common/app_common_widget.dart';

import '../../../app_images/r.dart';
import 'admin_icon_Widget.dart';
import 'guard_icon_widget.dart';
import 'peerage_widget.dart';

/**
 * 弹幕消息Item
 */
class DanmuWidget extends StatelessWidget {
  DanmuWidget(
    this.headUrl,
    this.name,
    this.nobleType,
    this.level,
    this.adminFlag,
    this.guardLevel,
    this.message, {
    Key? key,
  }) : super(key: key);
  final String? headUrl;
  final String? name;
  final int? nobleType;
  final int? level;
  final int? adminFlag; //是否是管理员 0不是 1 是
  final int? guardLevel; //是否是守护 0  非 0 是
  final String? message;
  List<String> avatars = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
                left: 6.dp, right: 12.dp, top: 4.dp, bottom: 4.dp),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22.dp),
                color: Colors.black.withOpacity(0.3)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 16.dp,
                  backgroundImage: NetworkImage(headUrl ?? ""),
                ),
                SizedBox(
                  width: 9.dp,
                ),
                Flexible(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 2.dp,),
                        CustomText(
                          name?.isNotEmpty == false ? "" : name!,
                          fontWeight: w_500,
                          color: AppMainColors.string2Color('#EEFF87'),
                          fontSize: 14.sp,
                        ),
                        SizedBox(width: 4.dp),
                        UserLevelView(level ?? 0),
                        PeerageWidget(
                          nobleType,
                          4,
                        ),
                        GuardIconWidget(guardLevel, 4),
                        AdminIconWidget(adminFlag),
                      ],
                    ),
                    //由于是弹幕，如果文字加长会导致外层容器变形。现在这边最多15个字
                    FittedBox(
                        fit: BoxFit.contain,
                        child: Container(
                          child: Text(
                            message ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle( fontWeight: w_500,
                              color: Colors.white,
                              fontSize: 14.sp,
                           ),

                            maxLines: 1,
                          ),
                        ),)
                  ],
                ))
              ],
            ),
          ),
          _buildNobelCover(nobleType)
        ],
      ),
    );
  }

  String getTitleNoble(int? type) {
    switch (type) {
      case 1001:
        return R.nobleAvatarYouxia;
      case 1002:
        return R.nobleAvatarQishi;
      case 1003:
        return R.nobleAvatarZijue;
      case 1004:
        return R.nobleAvatarBojue;
      case 1005:
        return R.nobleAvatarHoujue;
      case 1006:
        return R.nobleAvatarGongjue;
      case 1007:
        return R.nobleAvatarGuowang;
      default:
        return R.nobleAvatarYouxia;
    }
  }

  Widget _buildNobelCover(int? type) {
    if (type != null && type > 1000 && type < 1008) {
      return Image.asset(
        getTitleNoble(type),
        width: 46.dp,
        height: 46.dp,
      );
    } else {
      return Container();
    }
  }
}
