import 'package:alog/alog.dart';
import 'package:get/get.dart';
import 'package:star_common/common/toast.dart';
import 'package:star_common/http/http_channel.dart';

import 'bind_wallet_address_state.dart';

/// @description:
/// @author
/// @date: 2022-06-17 13:27:41
class BindWalletAddressLogic extends GetxController with Toast {
  final state = BindWalletAddressState();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  ///获取钱包类型列表
  getWalletType() {
    HttpChannel.channel.walletTypes().then((value) => value.finalize(
        wrapper: WrapperModel(),
        failure: (e) => showToast(e),
        success: (data) {
          if (data is List) {
            state.walletAddress =
                data.map((e) => BindWalletAddressData.fromJson(e)).toList();
            state.walletAddress[0].isSeladet = true;
            state.seleData = state.walletAddress[0];
          }
          update();
        }));
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getWalletType();
  }

  seleWallet(int index) {
    state.walletAddress.map((e) => e.isSeladet = false);
    state.walletAddress[index].isSeladet =
        !state.walletAddress[index].isSeladet;
    state.seleData = state.walletAddress[index];
    update();
  }

  iputText(String text) {
    // state.controller.text = text;
    update();
  }

  //绑定钱包
  bindWalletAddress() {
    if (!(state.controller.text.length > 3 &&
        state.seleData.isSeladet == true)) {
      return;
    }
    HttpChannel.channel
        .bindWalletAddress(
            state.controller.text, state.seleData.walletType ?? "")
        .then((value) => value.finalize(
            wrapper: WrapperModel(),
            failure: (e) => showToast(e),
            success: (data) {
              if (data is String) {
                showToast("绑定成功");
                Get.back(result: 1);
              }
            }));
  }
}
