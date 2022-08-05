import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:star_common/common/version.dart';
import 'package:star_common/http/http_channel.dart';
import '../../../../business/homepage/models/check.version.dart';
import 'my_mine_aboutus_state.dart';

/// @description:
/// @author
/// @date: 2022-07-14 17:01:50
class MyMineAboutusLogic extends GetxController {
  final state = MyMineAboutusState();

  void checkUpdate() {
    HttpChannel.channel.checkVersion().then((value) {
      var _data = CheckVersionData.fromJson(
        value.data ?? {},
      );
      PackageInfo.fromPlatform().then((info) {
        if (Version.parse(_data.versionNo) <= Version.parse(info.version)) {
          state.needUpdate.value = true;
        }else{
          state.needUpdate.value = false;
        }
      });
    });
  }

}
