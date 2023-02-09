import 'dart:ui';

var pixelRatio = window.devicePixelRatio;
var logicalScreenSize = window.physicalSize / pixelRatio;
var logicalWidth = logicalScreenSize.width;
var logicalHeight = logicalScreenSize.height;
var scaleRatio = logicalHeight * 0.001;

class PaddingConstants {
  static final double extraSmall = 5 * scaleRatio;

  static final double small = 10 * scaleRatio;

  static final double med = 15 * scaleRatio;

  static final double large = 20 * scaleRatio;

  static final double extraLarge = 25 * scaleRatio;
}

class RouteSetting {
  static const String main = "/main";
  static const String imageDetail = "/image_detail";
}

class ComponentSize {
  static const double buttonHeight100 = 100;
  static const double bottomBarHeight = 106;
  static const double paddingHorizontal = 27;
  
  static const double appBarSized = 40;
 
}

class Language {
  static const english = "eng";
}

class AppLocale {
  static const Locale engLocale = Locale('en', '');
}

class FontSize {
  //font size: 14
  static const double fontSize14 = 14;

  //font size: 10
  static const double fontSize10 = 10;

  //font size: 12
  static const double fontSize12 = 12;

  //font size: 16
  static const double fontSize16 = 16;

  //font size: 18
  static const double fontSize18 = 18;

  //font size: 20
  static const double fontSize20 = 20;

  //font size: 22
  static const double fontSize22 = 22;

  //font size: 24
  static const double fontSize24 = 24;
}
