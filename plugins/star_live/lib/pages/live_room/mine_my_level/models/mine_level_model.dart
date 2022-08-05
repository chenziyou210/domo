import 'dart:core';

enum LevelType {
  level1,
  level10,
  level12,
  level21,
  level30,
}

class MineLevelModel {
  MineLevelModel({
    required this.level,
    required this.levelType,
    required this.levelIcon,
    required this.lockedStatus,
    required this.lockedIcon,
    required this.unlockIcon,
    required this.lockedContent,
    required this.unlockTitle1,
    required this.unlockTitle2,
    required this.unlockTitle3,
  });

  int level;
  LevelType levelType;
  String levelIcon;
  bool lockedStatus;
  String lockedIcon;
  String unlockIcon;
  String lockedContent;
  String unlockTitle1;
  String unlockTitle2;
  String unlockTitle3;
}

