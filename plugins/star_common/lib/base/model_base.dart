/*
 *  Copyright (C), 2015-2021
 *  FileName: model_base
 *  Author: Tonight丶相拥
 *  Date: 2021/7/13
 *  Description: 
 **/

part of app_base;

abstract class AppModel with Toast {
  Future initData(){
    return loadData();
  }

  void initializeModel (Map arguments){

  }

  Future loadData(){
    return Future.value();
  }

  void startLoading() {
    show();
  }

  void endLoading(){
    dismiss();
  }
}

abstract class CommonNotifierModel extends ChangeNotifier {
  void updateState(){
    if (this.hasListeners) {
      notifyListeners();
    }
  }
}


class PageArgumentsModel {
  PageArgumentsModel({this.model, this.arguments});
  final AppModel? model;
  final Map? arguments;

  Map toMap(){
    Map arg = arguments ?? {};
    if (model != null) {
      arg["model"] = model;
    }
    return arg;
  }
}