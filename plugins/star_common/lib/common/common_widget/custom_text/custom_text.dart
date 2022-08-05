/*
 *  Copyright (C), 2015-2021
 *  FileName: custom_text
 *  Author: Tonight丶相拥
 *  Date: 2021/10/21
 *  Description: 
 **/

part of appcommon;
const FontWeight w_100 = FontWeight.w100;
const FontWeight w_200 = FontWeight.w200;
const FontWeight w_300 = FontWeight.w300;
const FontWeight w_400 = FontWeight.w400;
const FontWeight w_500 = FontWeight.w500;
const FontWeight w_600 = FontWeight.w600;
const FontWeight w_700 = FontWeight.w700;
const FontWeight w_800 = FontWeight.w800;
const FontWeight w_900 = FontWeight.w900;
const FontWeight w_normal = FontWeight.normal;
const FontWeight w_bold = FontWeight.bold;

class CustomText extends Text{
  CustomText(String text, {
    Key? key,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    TextStyle? style,
    /// style
    bool inherit = true,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Locale? styleLocale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    TextDecoration decoration = TextDecoration.none,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,//'PingFang_Medium_downcc',
    List<String>? fontFamilyFallback,
    String? package
  }): super(text,
      key: key,
    strutStyle: strutStyle,
    textAlign: textAlign,
    style: style ?? (_hasValue([
      color, backgroundColor, fontSize,
      fontWeight, fontStyle, letterSpacing,
      wordSpacing, textBaseline, height,
      styleLocale, foreground, background,
      shadows, fontFeatures, decorationColor,
      decorationStyle, decorationThickness,
      debugLabel, fontFamily, fontFamilyFallback,
      package
    ]) ? TextStyle(
        inherit: inherit,
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        locale: locale,
        foreground: foreground,
        background: background,
        shadows: shadows,
        fontFeatures: fontFeatures,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        debugLabel: debugLabel,
        // fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package
    ) : null),
    textDirection: textDirection,
    locale: locale,
    softWrap: softWrap,
    overflow: overflow,
    textScaleFactor: textScaleFactor,
    maxLines: maxLines,
    semanticsLabel: semanticsLabel,
    textWidthBasis: textWidthBasis,
    textHeightBehavior: textHeightBehavior
  );

  static bool _hasValue(List values){
    return values.where((element) => element != null).toList().length != 0;
  }
}