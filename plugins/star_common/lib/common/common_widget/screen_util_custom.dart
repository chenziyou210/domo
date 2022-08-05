/*
 *  Copyright (C), 2015-2021
 *  FileName: screen_util_custom
 *  Author: Tonight丶相拥
 *  Date: 2021/11/3
 *  Description: 
 **/

part of appcommon;

class ScreenUtil {
  ScreenUtil._();
  // 静态变量指向自身
  static final ScreenUtil _instance = ScreenUtil._();

  // 方案1：静态方法获得实例变量
  static ScreenUtil getInstance() => _instance;

  // 方案2：工厂构造方法获得实例变量
  factory ScreenUtil() => _instance;

  // 方案3：静态属性获得实例变量
  static ScreenUtil get instance => _instance;

  double _screenWidth = 0;
  double _screenHeight = 0;
  double _density = 1;
  double _pixelRatio = 3;

  void initialize({double designWidth = 375}) {
    _screenWidth = window.physicalSize.width / window.devicePixelRatio;
    _screenHeight = window.physicalSize.height / window.devicePixelRatio;
    _density = _screenWidth / designWidth;
    _pixelRatio = window.devicePixelRatio;
  }

  double get screenWidth => _screenWidth;
  double get screenHeight => _screenHeight;
  double get density => _density;
  double get pixelRatio => _pixelRatio;

  /// 根据屏幕宽度计算高度
  double screenScale(double height) {
    return screenWidth / 375 * height;
  }
}

extension IntExtension on int {
  double get dp {
    return star.ScreenUtil.getInstance().getWidth(toDouble());
  }

  double get sp {
    return star.ScreenUtil.getInstance().getSp(toDouble());
  }
}

extension DoubleExtension on double {
  double get dp {
    return star.ScreenUtil.getInstance().getWidth(this);
  }

  double get sp {
    return star.ScreenUtil.getInstance().getSp(this);
  }
}
