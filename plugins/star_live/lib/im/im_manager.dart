
import 'package:im_flutter_sdk/im_flutter_sdk.dart';
import 'package:star_common/manager/app_manager.dart';

class ImManager{
  static Future<void> imLogIn() async {
    try {
      if (await EMClient.getInstance.isLoginBefore()) {
        await EMClient.getInstance.logout();
      }
      var user = AppManager.getInstance<AppUser>();
      await EMClient.getInstance.login(user.chatUsername!, user.chatPassword!);
      await EMClient.getInstance.chatManager.loadAllConversations();
    } catch (e) {
      print("");
    }
  }
}