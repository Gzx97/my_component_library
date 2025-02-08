import 'package:flutter/material.dart';
import '../../../my_component_library.dart';

/// 计时组件计时方向
enum OeTimeCounterDirection {
  /// 倒计时
  down,

  /// 正向计时
  up
}

/// 计时组件尺寸
enum OeTimeCounterSize {
  /// 小
  small,

  /// 中等
  medium,

  /// 大
  large,
}

/// 计时组件风格
enum OeTimeCounterTheme {
  /// 默认
  defaultTheme,

  /// 圆形
  round,

  /// 方形
  square,
}

/// 计时组件样式
class OeTimeCounterStyle {
  OeTimeCounterStyle({
    this.timeWidth,
    this.timeHeight,
    this.timePadding,
    this.timeMargin,
    this.timeBox,
    this.timeFontFamily,
    this.timeFontSize,
    this.timeFontHeight,
    this.timeFontWeight,
    this.timeColor,
    this.splitFontSize,
    this.splitFontHeight,
    this.splitFontWeight,
    this.splitColor,
    this.space,
  });

  /// 时间容器宽度
  double? timeWidth;

  /// 时间容器高度
  double? timeHeight;

  /// 时间容器内边距
  EdgeInsets? timePadding;

  /// 时间容器外边距
  EdgeInsets? timeMargin;

  /// 时间容器装饰
  BoxDecoration? timeBox;

  /// 时间字体
  FontFamily? timeFontFamily;

  /// 时间字体尺寸
  double? timeFontSize;

  /// 时间字体行高
  double? timeFontHeight;

  /// 时间字体粗细
  FontWeight? timeFontWeight;

  /// 时间字体颜色
  Color? timeColor;

  /// 分隔符字体尺寸
  double? splitFontSize;

  /// 分隔符字体行高
  double? splitFontHeight;

  /// 分隔符字体粗细
  FontWeight? splitFontWeight;

  /// 分隔符字体颜色
  Color? splitColor;

  /// 时间与分隔符的间隔
  double? space;

  /// 生成默认样式
  OeTimeCounterStyle.generateStyle(
    BuildContext context, {
    OeTimeCounterSize? size,
    OeTimeCounterTheme? theme,
    bool? splitWithUnit,
  }) {
    timeFontFamily = OeTheme.defaultData().numberFontFamily;
    late Font? font;
    switch (size ?? OeTimeCounterSize.medium) {
      case OeTimeCounterSize.small:
        if (theme == OeTimeCounterTheme.defaultTheme) {
          timeWidth = timeHeight = null;
          font = OeTheme.of(context).fontBodyMedium;
          timeFontSize = splitFontSize = font?.size ?? 14;
          timeFontHeight =
              splitFontHeight = font?.height ?? (22 / timeFontSize!);
        } else {
          timeWidth = timeHeight = 20;
          font = OeTheme.of(context).fontBodySmall;
          timeFontSize = splitFontSize = font?.size ?? 12;
          timeFontHeight = splitFontHeight = null;
        }
        space = OeTheme.of(context).spacer4 / 2;
        break;
      case OeTimeCounterSize.medium:
        if (theme == OeTimeCounterTheme.defaultTheme) {
          timeWidth = timeHeight = null;
          font = OeTheme.of(context).fontBodyLarge;
          timeFontSize = splitFontSize = font?.size ?? 16;
          timeFontHeight =
              splitFontHeight = font?.height ?? (24 / timeFontSize!);
        } else {
          timeWidth = timeHeight = 24;
          font = OeTheme.of(context).fontBodyMedium;
          timeFontSize = splitFontSize = font?.size ?? 14;
          timeFontHeight = splitFontHeight = null;
        }
        space = OeTheme.of(context).spacer8 / 2;
        break;
      case OeTimeCounterSize.large:
        if (theme == OeTimeCounterTheme.defaultTheme) {
          timeWidth = timeHeight = null;
          font = OeTheme.of(context).fontBodyExtraLarge;
          timeFontSize = splitFontSize = font?.size ?? 18;
          timeFontHeight =
              splitFontHeight = font?.height ?? (26 / timeFontSize!);
        } else {
          timeWidth = timeHeight = 28;
          font = OeTheme.of(context).fontBodyLarge;
          timeFontSize = splitFontSize = font?.size ?? 16;
          timeFontHeight = splitFontHeight = null;
        }
        space = OeTheme.of(context).spacer12 / 2;
    }

    switch (theme ?? OeTimeCounterTheme.defaultTheme) {
      case OeTimeCounterTheme.round:
        timeBox = BoxDecoration(
          shape: BoxShape.circle,
          color: OeTheme.of(context).errorColor6,
        );
        timeColor = OeTheme.of(context).fontWhColor1;
        splitColor = OeTheme.of(context).errorColor6;
        break;
      case OeTimeCounterTheme.square:
        timeBox = BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(OeTheme.of(context).radiusSmall),
          color: OeTheme.of(context).errorColor6,
        );
        timeColor = OeTheme.of(context).fontWhColor1;
        splitColor = OeTheme.of(context).errorColor6;
        break;
      case OeTimeCounterTheme.defaultTheme:
        timeBox = null;
        timeColor = splitColor = OeTheme.of(context).fontGyColor1;
        timeWidth = null;
        timeHeight = null;
    }

    if (splitWithUnit ?? false) {
      splitColor = OeTheme.of(context).fontGyColor1;
    }
  }
}
