import 'package:flutter/cupertino.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'package:star_common/config/app_layout.dart';

class LevelUpgradeTips extends StatelessWidget {
  LevelUpgradeTips(this.level, {Key? key, this.tip, this.allRadius = true}) : super(key: key);

  final int level;
  String? tip;
  bool allRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(4.dp, 4.dp, 8.dp, 4.dp),
        height: 24.dp,
        decoration: BoxDecoration(
          borderRadius: allRadius ? BorderRadius.circular(12.dp) : BorderRadius.circular(8.dp),
          gradient: LinearGradient(
            colors: allRadius ? _getAllRadiusBgColors(level) : _getBgColors(level),
          ),
        ),
        child: Row(
          children: [
            level == 10 ? Container() : UserLevelView(level),
            SizedBox(width: 4.dp),
            Text(
              (tip ?? '').isEmpty ? '恭喜用户等级升至Lv$level' : tip ?? '',
              style: TextStyle(
                fontSize: 12.sp,
                color: allRadius ? AppMainColors.whiteColor100 : AppMainColors.backgroudColor,
                fontWeight: allRadius ? AppLayout.boldFont : FontWeight.w400,
              ),
            ),
          ],
        )
    );
  }

  List<Color> _getBgColors(int level) {
    if (level < 10) return [Color(0xFFFFFFFF), Color(0xFFDAC181)];
    if (level == 10) return [Color(0xFFDE8EAB), Color(0xFFE25E86)];
    if (level <= 20) return [Color(0xFFFFFFFF), Color(0xFF699CE9)];
    if (level <= 30) return [Color(0xFFFFFFFF), Color(0xFF47D3A7)];
    if (level <= 40) return [Color(0xFFFFFFFF), Color(0xFFB07AF4)];
    if (level <= 50) return [Color(0xFFFFFFFF), Color(0xFFF66CFB)];
    return [Color(0xFFFFFFFF), Color(0xFFFE7878)];
  }

  List<Color> _getAllRadiusBgColors(int level) {
    if (level == 10) return [Color(0xFFFF649C), Color(0xFFFF2E6C)];
    if (level <= 30) return [Color(0xFF84E8CA), Color(0xFF47D3A7)];
    if (level <= 40) return [Color(0xFFB98EEF), Color(0xFFB07AF4)];
    if (level <= 50) return [Color(0xFFED92F0), Color(0xFFF66CFB)];
    return [Color(0xFFF19292), Color(0xFFFE7878)];
  }

}
