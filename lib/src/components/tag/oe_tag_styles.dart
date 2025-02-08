import 'package:flutter/material.dart';
import '../../../my_component_library.dart';

/// Tag展示类型
enum OeTagTheme {
  /// 默认
  defaultTheme,

  /// 常规
  primary,

  /// 警告
  warning,

  /// 危险
  danger,

  /// 成功
  success,
}

/// 标签尺寸
enum OeTagSize { extraLarge, large, medium, small, custom }

/// 标签形状
enum OeTagShape { square, round, mark }

/// 标签样式
class OeTagStyle {
  OeTagStyle(
      {this.context,
      this.textColor,
      this.backgroundColor,
      this.font,
      this.fontWeight,
      this.border = 0,
      this.borderColor,
      this.borderRadius});

  /// 上下文，方便获取主题内容
  BuildContext? context;

  /// 文字颜色
  Color? textColor;

  /// 背景颜色
  Color? backgroundColor;

  /// 边框颜色
  Color? borderColor;

  /// 圆角
  BorderRadiusGeometry? borderRadius;

  /// 字体尺寸
  Font? font;

  /// 字体粗细
  FontWeight? fontWeight;

  /// 线框粗细
  double border = 0;

  /// 字体颜色，与属性不同名，方便子类自定义处理
  Color get getTextColor => textColor ?? OeTheme.of(context).fontWhColor1;

  /// 背景颜色，与属性不同名，方便子类自定义处理
  Color get getBackgroundColor =>
      backgroundColor ?? OeTheme.of(context).brandNormalColor;

  /// 线框颜色，与属性不同名，方便子类自定义处理
  Color get getBorderColor => borderColor ?? Colors.transparent;

  /// 圆角，，与属性不同名，方便子类自定义处理
  BorderRadiusGeometry get getBorderRadius =>
      borderRadius ?? BorderRadius.circular(0);

  /// 根据主题生成填充Tag样式
  OeTagStyle.generateFillStyleByTheme(
      BuildContext context, OeTagTheme? theme, bool light, OeTagShape shape) {
    this.context = context;
    switch (theme) {
      case OeTagTheme.primary:
        textColor = light
            ? OeTheme.of(context).brandNormalColor
            : OeTheme.of(context).whiteColor1;
        backgroundColor = light
            ? OeTheme.of(context).brandLightColor
            : OeTheme.of(context).brandNormalColor;
        break;
      case OeTagTheme.warning:
        textColor = light
            ? OeTheme.of(context).warningNormalColor
            : OeTheme.of(context).whiteColor1;
        backgroundColor = light
            ? OeTheme.of(context).warningLightColor
            : OeTheme.of(context).warningNormalColor;
        break;
      case OeTagTheme.danger:
        textColor = light
            ? OeTheme.of(context).errorNormalColor
            : OeTheme.of(context).whiteColor1;
        backgroundColor = light
            ? OeTheme.of(context).errorLightColor
            : OeTheme.of(context).errorNormalColor;
        break;
      case OeTagTheme.success:
        textColor = light
            ? OeTheme.of(context).successNormalColor
            : OeTheme.of(context).whiteColor1;
        backgroundColor = light
            ? OeTheme.of(context).successLightColor
            : OeTheme.of(context).successNormalColor;
        break;
      case OeTagTheme.defaultTheme:
      default:
        textColor = OeTheme.of(context).fontGyColor1;
        backgroundColor = light
            ? OeTheme.of(context).grayColor1
            : OeTheme.of(context).grayColor3;
    }
    switch (shape) {
      case OeTagShape.square:
        borderRadius = BorderRadius.circular(OeTheme.of(context).radiusSmall);
        break;
      case OeTagShape.round:
        borderRadius = BorderRadius.circular(OeTheme.of(context).radiusRound);
        break;
      case OeTagShape.mark:
        borderRadius = BorderRadius.only(
            topRight: Radius.circular(OeTheme.of(context).radiusRound),
            bottomRight: Radius.circular(OeTheme.of(context).radiusRound));
        break;
    }
    borderColor = backgroundColor;
  }

  /// 根据主题生成描边Tag样式
  OeTagStyle.generateOutlineStyleByTheme(
      BuildContext context, OeTagTheme? theme, bool light, OeTagShape shape) {
    this.context = context;
    switch (theme) {
      case OeTagTheme.primary:
        borderColor = OeTheme.of(context).brandNormalColor;
        textColor = OeTheme.of(context).brandNormalColor;
        backgroundColor = light
            ? OeTheme.of(context).brandLightColor
            : OeTheme.of(context).whiteColor1;
        break;
      case OeTagTheme.warning:
        borderColor = OeTheme.of(context).warningNormalColor;
        textColor = OeTheme.of(context).warningNormalColor;
        backgroundColor = light
            ? OeTheme.of(context).warningLightColor
            : OeTheme.of(context).whiteColor1;
        break;
      case OeTagTheme.danger:
        borderColor = OeTheme.of(context).errorNormalColor;
        textColor = OeTheme.of(context).errorNormalColor;
        backgroundColor = light
            ? OeTheme.of(context).errorLightColor
            : OeTheme.of(context).whiteColor1;
        break;
      case OeTagTheme.success:
        borderColor = OeTheme.of(context).successNormalColor;
        textColor = OeTheme.of(context).successNormalColor;
        backgroundColor = light
            ? OeTheme.of(context).successLightColor
            : OeTheme.of(context).whiteColor1;
        break;
      case OeTagTheme.defaultTheme:
      default:
        borderColor = OeTheme.of(context).fontGyColor4;
        textColor = OeTheme.of(context).fontGyColor1;
        backgroundColor = light
            ? OeTheme.of(context).grayColor1
            : OeTheme.of(context).whiteColor1;
    }
    switch (shape) {
      case OeTagShape.square:
        borderRadius = BorderRadius.circular(OeTheme.of(context).radiusSmall);
        break;
      case OeTagShape.round:
        borderRadius = BorderRadius.circular(OeTheme.of(context).radiusRound);
        break;
      case OeTagShape.mark:
        borderRadius = BorderRadius.only(
            topRight: Radius.circular(OeTheme.of(context).radiusRound),
            bottomRight: Radius.circular(OeTheme.of(context).radiusRound));
        break;
    }
    border = 1;
  }

  /// 根据主题生成禁用Tag样式
  OeTagStyle.generateDisableSelectStyle(
      BuildContext context, bool isOutline, OeTagShape shape) {
    borderColor = OeTheme.of(context).grayColor4;
    textColor = OeTheme.of(context).fontGyColor4;
    backgroundColor = OeTheme.of(context).grayColor2;
    switch (shape) {
      case OeTagShape.square:
        borderRadius = BorderRadius.circular(OeTheme.of(context).radiusSmall);
        break;
      case OeTagShape.round:
        borderRadius = BorderRadius.circular(OeTheme.of(context).radiusRound);
        break;
      case OeTagShape.mark:
        borderRadius = BorderRadius.only(
            topRight: Radius.circular(OeTheme.of(context).radiusRound),
            bottomRight: Radius.circular(OeTheme.of(context).radiusRound));
        break;
    }
    border = isOutline ? 1 : 0;
  }
}
