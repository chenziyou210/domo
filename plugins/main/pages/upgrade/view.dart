import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hjnzb/business/homepage/models/check.version.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/version.dart';
import 'package:star_common/http/http_channel.dart';
import 'package:star_common/common/app_common_widget.dart';
import 'logic.dart';

void checkUpgrade({
  required BuildContext context,
  required ValueChanged onError,
}) {
  HttpChannel.channel.checkVersion().then((value) {
    if (value.statusCode != 200) {
      onError(value.err.isEmpty ? '未知错误' : value.err);
      return;
    }
    var _data = CheckVersionData.fromJson(
      value.data["data"] ?? {},
    );
    PackageInfo.fromPlatform().then((info) {
      if (Version.parse(_data.versionNo) <= Version.parse(info.version)) {
        onError('已是最新版本');
        return;
      }
      _upgrade(context: context, data: _data);
    });
  });
}

bool _showing = false;

Future<void> _upgrade({
  required BuildContext context,
  required CheckVersionData data,
}) async {
  if (_showing) {
    return;
  }
  UpgradeLogic _logic;
  try {
    _logic = Get.find<UpgradeLogic>();
  } catch (e) {
    _logic = Get.put<UpgradeLogic>(UpgradeLogic());
  }
  if (_logic.updateing) {
    return;
  }
  // _logic.data = data;
  _logic.setData(data: data);
  _showing = true;
  await _centerDialog(
    context: context,
    builder: (_) {
      return _UpgradePage(logic: _logic);
    },
  );
  _showing = false;
}

Future<T?> _centerDialog<T>({
  required BuildContext context,
  // String? content,
  // String? image,
  required WidgetBuilder builder,
  EdgeInsets? padding,
  Color barrierColor = Colors.black,
}) async {
  return await showDialog(
    context: context,
    useSafeArea: false,
    barrierColor: barrierColor.withOpacity(0.8),
    builder: (_) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          child: SizedBox(
            child: SingleChildScrollView(
              padding: padding,
              child: builder.call(context),
            ),
          ),
        ),
      );
    },
  );
}

class _UpgradePage extends StatelessWidget {
  final UpgradeLogic logic;

  const _UpgradePage({
    Key? key,
    required this.logic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.dp),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 74.dp,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16.dp, 10.dp, 16.dp, 16.dp),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(8.dp),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 110.dp),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: logic.data.remark.isNotEmpty,
                            child: Column(
                              children: [
                                Text(
                                  '更新内容',
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 16.dp,
                                  ),
                                ),
                                SizedBox(height: 12.dp),
                                Text(
                                  logic.data.remark,
                                  style: TextStyle(
                                    color: Color(0xFF666666),
                                    fontSize: 14.dp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8.dp),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Visibility(
                                visible: logic.data.isForce == 0,
                                child: InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    width: 120.dp,
                                    height: 40.dp,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF0F0F0),
                                      borderRadius:
                                          BorderRadius.circular(20.dp),
                                    ),
                                    child: Text(
                                      '取消',
                                      style: TextStyle(
                                        color: Color(0xFF666666),
                                        fontSize: 16.dp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  logic.upgrade();
                                },
                                child: Container(
                                  width:
                                      logic.data.isForce == 1 ? 248.dp : 120.dp,
                                  height: 40.dp,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFFF65C8),
                                        Color(0xFFFF1EAf),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20.dp),
                                  ),
                                  child: Text(
                                    '立即升级',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.dp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              child: Stack(
                children: [
                  Image.asset(R.appUpgrade),
                  Positioned(
                    top: 109.dp,
                    left: 20.dp,
                    child: Text(
                      'V${logic.data.versionNo}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.dp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
