

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:star_common/base/app_base.dart';

class AnchorRechargePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AnchorRechargePageState();
}

class _AnchorRechargePageState extends AppStateBase<AnchorRechargePage> with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget get body => Obx((){
    return Row(children: []);
  });
}