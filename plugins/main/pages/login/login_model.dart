/*
 *  Copyright (C), 2015-2021
 *  FileName: login_model
 *  Author: Tonight丶相拥
 *  Date: 2021/9/16
 *  Description: 
 **/

import 'dart:async';
import 'package:star_common/base/app_base.dart';
import 'package:star_common/common/abstract_mixin/chat_salon.dart';
import 'package:star_common/common/abstract_mixin/trtc_mixin.dart';
import 'package:star_common/common/storage.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/manager/app_manager.dart';
import 'package:im_flutter_sdk/im_flutter_sdk.dart';
// import 'package:hjnzb/pages/live_room/model/TRTCLiveRoomDef.dart';

class LogInModel extends AppModel with ChatSalon, TRTCOperation {
  Future<bool> logIn(
    String account,
    String code,
  ) {
    Completer<bool> completer = Completer();
    show();
    HttpChannel.channel
        .logIn(account, code,1)
        .then((value) => value.finalize(
            wrapper: WrapperModel(),
            failure: (e) {
              showToast(e);
              completer.complete(false);
            },
            success: (data) {
              var user = AppManager.getInstance<AppUser>();
              StorageService.to.setString("token", data["token"]);
              HttpChannel.channel.userInfo().then((value) => value.finalize(
                  wrapper: WrapperModel(),
                  failure: (e) {
                    showToast(e);
                    completer.complete(false);
                  },
                  success: (json) async {
                    user.fromJson(json, false);
                    try {
                      if (await EMClient.getInstance.isLoginBefore()) {
                        await EMClient.getInstance.logout();
                      }
                      await EMClient.getInstance
                          .login(user.chatUsername!, user.chatPassword!);
                    } catch (e) {
                      print("");
                    }
                    // /// todo: im 相关
                    // trtcVoiceRoomLogIn(user.userId!,
                    //     user.userSig!);
                    // setSelfProfile(user.name!, user.header!);
                    //
                    // /// todo: 移动直播相关
                    // trtcLogin(user.userId!,
                    //     user.userSig!,
                    //     TRTCLiveRoomConfig(useCDNFirst: false));
                    dismiss();
                    completer.complete(true);
                  }));
            }));
    return completer.future;
  }
}
