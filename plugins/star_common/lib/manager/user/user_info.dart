import 'package:get/get.dart';
import '../../common/toast.dart';
import '../../http/http_channel.dart';
import '../app_manager.dart';

class UserInfoLogic extends GetxController with Toast {
  final UserInfoState state = UserInfoState();

  void updateFeeling(String feeling) {
    if (feeling != state.userInfo.value.feeling) {
      state.userInfo.value = UserInfoModel(feeling: feeling);
      saveUserInfo();
    }
  }

  void updateSex(String sexText, int index) {
    if (index != state.userInfo.value.sex) {
      state.userInfo.value = UserInfoModel(sex: index);
      saveUserInfo();
    }
  }

  void updateHometown(String province, String opacity, String town) {
    String hometown = opacity == '市辖区' ? '$province-$town' : '$province-$opacity';
    if (hometown != state.userInfo.value.hometown) {
      state.userInfo.value = UserInfoModel(hometown: hometown);
      saveUserInfo();
    }
  }

  void updateBirthday(String birthday) {
    if (birthday != state.userInfo.value.birthday) {
      state.userInfo.value = UserInfoModel(birthday: birthday);
      saveUserInfo(needRequestUserInfo: true);
    }
  }

  void updateProfession(String profession) {
    if (profession != state.userInfo.value.profession) {
      state.userInfo.value = UserInfoModel(profession: profession);
      saveUserInfo();
    }
  }

  void updateNickname(String nickname) {
    state.userInfo.value = UserInfoModel(nickname: nickname);
    AppManager.getInstance<AppUser>().userUpdateNickName(nickname);
  }

  void updateSignature(String signature) {
    if (signature != state.userInfo.value.signature) {
      state.userInfo.value = UserInfoModel(signature: signature);
      saveUserInfo();
    }
  }

  void updateAvatar(String avatar) {
    state.userInfo.value = UserInfoModel(avatar: avatar);
    saveUserInfo();
  }

  void updateRoomCover(String cover) {
    state.userInfo.value = UserInfoModel(cover: cover);
    saveUserInfo();
  }

  void updateAppUser({AppUser? user}) {
    if (user != null) {
      state.user = user;
    }else{
      state.user = AppManager.getInstance<AppUser>();
    }
    state.userInfo.value = UserInfoModel(
      avatar: state.user.header,
      nickname: state.user.username,
      sex: state.user.sex,
      birthday: state.user.birthday,
      feeling: state.user.feeling,
      hometown: state.user.hometown,
      profession: state.user.profession,
      signature: state.user.signature,
      cover: state.user.roomCover,
      background: state.user.roomBackground,
    );
    update();
  }

  void saveUserInfo({needRequestUserInfo = false}) {
    final model = state.userInfo.value;
    HttpChannel.channel.editUserInfo(
        profession: model.profession,
        emotion: model.feeling,
        birthday: model.birthday,
        sex: model.sex,
        signature: model.signature,
        city: model.hometown,
        avatar: model.avatar
    ).then((value) {
      value.finalize(
          wrapper: WrapperModel(),
          failure: (e) => showToast(e),
          success: (_){
            AppManager.getInstance<AppUser>().userUpdate(model);
            state.user = AppManager.getInstance<AppUser>();
            update();
            if (needRequestUserInfo) {
              requestUserInfo();
            }
          });
    });
  }

  void requestUserInfo({void Function(String)? failure, void Function()? success}) {
    HttpChannel.channel.userInfo().then((value) => value.finalize(
        wrapper: WrapperModel(),
        failure: (e) {
          showToast(e);
          failure?.call(e);
        },
        success: (data) {
          if (data != null) {
            var user = AppManager.getInstance<AppUser>();
            user.fromJson(data, false);
            updateAppUser(user: user);
            success?.call();
          }
        }));
  }

}

class UserInfoState {
  final List feelings = ['恋爱', '单身', '未婚', '已婚', '保密'];
  final List sexList = ['男', '女'];
  final List professions = ['歌手', '演员', '模特', '空姐', '设计师', '化妆师', '美容师', '摄影师', '主持人', '白领', '学生', '老师', '护士', '自由职业', '全职主播'];

  AppUser user = AppManager.getInstance<AppUser>();
  final userInfo = UserInfoModel().obs;

  UserInfoState() {
    userInfo.value = UserInfoModel(
      avatar: user.header,
      nickname: user.username,
      sex: user.sex,
      birthday: user.birthday,
      feeling: user.feeling,
      hometown: user.hometown,
      profession: user.profession,
      signature: user.signature,
      cover: user.roomCover,
      background: user.roomBackground,
    );
  }

}

class UserInfoModel {
  String avatar;
  String nickname;
  int sex;
  String birthday;
  String feeling;
  String hometown;
  String profession;
  String signature;
  String cover;
  String background;

  static var _catheInfo = UserInfoModel(
      avatar: '',
      nickname: '',
      sex: 0,
      birthday: '',
      feeling: '',
      hometown: '',
      profession: '',
      signature: '',
      cover: '',
      background: '',
  );

  factory UserInfoModel({
    String? avatar,
    String? nickname,
    int? sex,
    String? birthday,
    String? feeling,
    String? hometown,
    String? profession,
    String? signature,
    String? cover,
    String? background,
  }) {
    final i = UserInfoModel._init(
      avatar ?? _catheInfo.avatar,
      nickname ?? _catheInfo.nickname,
      sex ?? _catheInfo.sex,
      birthday ?? _catheInfo.birthday,
      feeling ?? _catheInfo.feeling,
      hometown ?? _catheInfo.hometown,
      profession ?? _catheInfo.profession,
      signature ?? _catheInfo.signature,
      cover ?? _catheInfo.cover,
      background ?? _catheInfo.background,
    );
    _catheInfo = i;
    return i;
  }

  UserInfoModel._init(
      this.avatar,
      this.nickname,
      this.sex,
      this.birthday,
      this.feeling,
      this.hometown,
      this.profession,
      this.signature,
      this.cover,
      this.background,
      );
}