import 'dart:io';
import 'package:get/get.dart';
import 'package:hjnzb/business/homepage/models/check.version.dart';
import 'package:url_launcher/url_launcher.dart';

class UpgradeLogic extends GetxController {
  bool updateing = false;

  CheckVersionData data = CheckVersionData();

  void setData({required CheckVersionData data}) {
    this.data = data;
  }

  void upgrade([bool reload = false]) async {
    if (updateing) {
      return;
    }
    // if (await canLaunchUrl(Uri.parse(data.downloadUrl))) {
    // }
    updateing = true;
    await _safeLaunch(data.downloadUrl);
    updateing = false;
  }

  Future<bool> _safeLaunch(String url) async {
    try {
      return await launchUrl(
        Uri.parse(url.trim()),
        mode: Platform.isAndroid
            ? LaunchMode.externalNonBrowserApplication
            : LaunchMode.externalApplication,
      );
    } catch (e) {
      return false;
    }
  }
}
