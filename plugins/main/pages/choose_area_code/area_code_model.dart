import 'dart:convert';

import 'package:azlistview/azlistview.dart';

///搜索功能，如果通过拼音得加入拼音库
class AreaCodeModel extends ISuspensionBean {
  String? name;
  String? short;
  String? tagIndex;
  String? en;
  String? tel;
  String? pinyin;

  AreaCodeModel(
      {required this.name,
      this.tagIndex,
      this.short,
      this.en,
      required this.tel,
      this.pinyin});

  AreaCodeModel.fromJson(Map<String, dynamic> json) {
    short = json['short'];
    name = json['name'];
    en = json['en'];
    tel = json['tel'];
    pinyin = json['pinyin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['short'] = this.short;
    data['name'] = this.name;
    data['en'] = this.en;
    data['tel'] = this.tel;
    data['pinyin'] = this.pinyin;
    return data;
  }

  @override
  String getSuspensionTag() => tagIndex!;

  @override
  String toString() {
    return 'AreaCodeModel{name: $name, short: $short, tagIndex: $tagIndex, en: $en, tel: $tel, pinyin: $pinyin}';
  }
}
