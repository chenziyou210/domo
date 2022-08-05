

import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:star_common/common/toast.dart';

import 'area_code_model.dart';

class CityLogic extends GetxController with Toast {
  final _CityState state = _CityState();

  @override
  void onInit() {
    super.onInit();
    SuspensionUtil.setShowSuspensionStatus(state.cityList);
    loadData();
  }

  void loadData() async {
    initHotCity();
    rootBundle.loadString('assets/data/areacode.json').then((value) {
      state.cityList.clear();
      List list = jsonDecode(value);
      state.cityList.value =
          list.map((e) => AreaCodeModel.fromJson(e)).toList();
      _handleList(state.cityList);
    });
  }

  void _handleList(List<AreaCodeModel> list) {
    if (list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String? tag = list[i].pinyin?.substring(0, 1).toUpperCase();
      if (RegExp('[A-Z]').hasMatch(tag!)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = '#';
      }
    }
    SuspensionUtil.sortListBySuspensionTag(list);
    SuspensionUtil.setShowSuspensionStatus(state.cityList);
    ///这个tagIndex设置是不放在[A-Z]，随便写得
    state.cityList.insert(0, AreaCodeModel(name: '非', tel: '86', tagIndex: "dd"));
  }

  void search(String txt) {
    state.txtSearch.value = txt;
    if(txt.isEmpty){
      initHotCity();
      return;
    }

    List<AreaCodeModel> list = List.empty(growable: true);
    state.cityList.forEach((element) {
      if((element.name?.contains(txt)??false)
          || (element.tel?.contains(txt)??false)){
        list.add(element);
      }
    });

    state.hotCityList.value = list;
  }

  initHotCity() {
    state.hotCityList.value = [
      AreaCodeModel(name: '中国', tel: '86', pinyin: "dd"),
      AreaCodeModel(name: '中国香港', tel: '852', pinyin: "dd"),
      AreaCodeModel(name: '中国澳门', tel: '853', pinyin: "dd"),
      AreaCodeModel(name: '中国台湾', tel: '886', pinyin: "dd"),
    ];
  }
}
class _CityState {
  TextEditingController txtController = TextEditingController();
  RxString txtSearch = ''.obs;
  RxList<AreaCodeModel> cityList = List<AreaCodeModel>.empty(growable: true).obs;
  get listChars => [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
  ];

  RxList<AreaCodeModel> hotCityList = List<AreaCodeModel>.empty(growable: true).obs;
}
