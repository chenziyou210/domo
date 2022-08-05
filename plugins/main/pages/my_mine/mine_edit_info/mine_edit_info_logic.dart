import 'package:flutter/cupertino.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/manager/user/user_info.dart';
import 'package:star_common/router/router_config.dart';
import 'package:star_live/pages/live_room/mine_backpack/mine_backpack_logic.dart';
import 'mine_edit_info_state.dart';

class MineEditInfoLogic extends GetxController with Toast {
  final MineEditInfoState state = MineEditInfoState();
  final UserInfoState userInfoState = Get.find<UserInfoLogic>().state;
  final UserInfoLogic userInfoLogic = Get.find<UserInfoLogic>();

  void dismissBottomSelector() {
    Navigator.pop(state.context);
  }

  void editNickname() {
    final logic = Get.find<MineBackpackLogic>();
    logic.loadPackageList(needActivity: true);
    logic.state.nicknameTEC.text = userInfoState.userInfo.value.nickname;
    Get.toNamed(AppRoutes.mineEditNicknamePage)?.then((value) {
      if (value != null) {
        userInfoLogic.updateNickname(value.toString());
      }
    });
    // Navigator.of(state.context)
    //     .pushNamed(AppRoutes.mineEditNicknamePage)
    //     .then((value) {
    //   if (value != null) {
    //     userInfoLogic.updateNickname(value.toString());
    //   }
    // });
  }

  void editSignature() {
    state.signatureTEC.text = userInfoState.userInfo.value.signature;
    Get.toNamed(AppRoutes.mineEditSignaturePage);
  }

  void updateSignature() {
    Navigator.pop(state.context);
    userInfoLogic.updateSignature(state.signatureTEC.text);
  }

  void updateBirthday(PDuration date) {
    String birthday =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    userInfoLogic.updateBirthday(birthday);
  }

  void selectAvatarWithCamera() async {
    dismissBottomSelector();
    ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10)
        .then((value) {
      if (value != null) {
        _updateAvatar(value.path);
      }
    }).onError((error, stackTrace) {
      showToast('未开启权限，请前往设置中心开启');
    });
  }

  void selectAvatarWithPhoto() async {
    dismissBottomSelector();
    ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10)
        .then((value) {
      if (value != null) {
        _updateAvatar(value.path);
      }
    }).onError((error, stackTrace) {
      showToast('未开启权限，请前往设置中心开启');
    });
  }

  void _updateAvatar(String filePath) {
    show();
    HttpChannel.channel.uploadImage(filePath).then((value) {
      dismiss();
      value.finalize(
          wrapper: WrapperModel(),
          failure: (e) => showToast(e),
          success: (data) {
            print('上传成功:$data');
            userInfoLogic.updateAvatar(data['url']);
          });
    });
  }
}
