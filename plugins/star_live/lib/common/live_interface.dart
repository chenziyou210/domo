import 'package:flutter/widgets.dart';

abstract class LiveInterface{
  Widget getBetRecordPage();
}

class LiveManager{
  static LiveManager install =LiveManager();

  LiveInterface? _liveInterface;
  void setLiveInterface(LiveInterface? _liveInterface){
    this._liveInterface;
  }

}