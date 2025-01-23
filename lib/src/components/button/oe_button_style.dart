import 'package:flutter/material.dart';

import '../../../my_component_library.dart';

/// OeButton按钮样式
class OeButtonStyle {
  /// 背景颜色
  Color? backgroundColor;

  /// 边框颜色
  Color? frameColor;

  /// 文字颜色
  Color? textColor;

  /// 边框宽度
  double? frameWidth;

  /// 自定义圆角
  BorderRadiusGeometry? radius;

  OeButtonStyle(
      {this.backgroundColor,
      this.frameColor,
      this.textColor,
      this.frameWidth,
      this.radius});

  /// 生成不同主题的填充按钮样式
  OeButtonStyle.generateFillStyleByTheme(
      BuildContext context, OeButtonTheme? theme, OeButtonStatus status) {
    switch (theme) {
      case OeButtonTheme.primary:
        textColor = OeTheme.of(context).fontWhColor1;
        backgroundColor = _getBrandColor(context, status);
        break;
      case OeButtonTheme.danger:
        textColor = OeTheme.of(context).fontWhColor1;
        backgroundColor = _getErrorColor(context, status);
        break;
      case OeButtonTheme.light:
        textColor = _getBrandColor(context, status);
        backgroundColor = _getLightColor(context, status);
        break;
      case OeButtonTheme.defaultTheme:
      default:
        textColor = _getDefaultTextColor(context, status);
        backgroundColor = _getDefaultBgColor(context, status);
    }
    frameColor = backgroundColor;
  }

  /// 生成不同主题的描边按钮样式
  OeButtonStyle.generateOutlineStyleByTheme(
      BuildContext context, OeButtonTheme? theme, OeButtonStatus status) {
    switch (theme) {
      case OeButtonTheme.primary:
        textColor = _getBrandColor(context, status);
        backgroundColor = status == OeButtonStatus.active
            ? OeTheme.of(context).grayColor3
            : OeTheme.of(context).whiteColor1;
        frameColor = textColor;
        break;
      case OeButtonTheme.danger:
        textColor = _getErrorColor(context, status);
        backgroundColor = status == OeButtonStatus.active
            ? OeTheme.of(context).grayColor3
            : OeTheme.of(context).whiteColor1;
        frameColor = textColor;
        break;
      case OeButtonTheme.light:
        textColor = _getBrandColor(context, status);
        backgroundColor = _getLightColor(context, status);
        frameColor = textColor;
        break;
      case OeButtonTheme.defaultTheme:
      default:
        textColor = _getDefaultTextColor(context, status);
        backgroundColor = _getOutlineDefaultBgColor(context, status);
        frameColor = OeTheme.of(context).grayColor4;
    }
    frameWidth = 1;
  }

  /// 生成不同主题的文本按钮样式
  OeButtonStyle.generateTextStyleByTheme(
      BuildContext context, OeButtonTheme? theme, OeButtonStatus status) {
    switch (theme) {
      case OeButtonTheme.primary:
        textColor = _getBrandColor(context, status);
        backgroundColor = status == OeButtonStatus.active
            ? OeTheme.of(context).grayColor3
            : Colors.transparent;
        break;
      case OeButtonTheme.danger:
        textColor = _getErrorColor(context, status);
        backgroundColor = status == OeButtonStatus.active
            ? OeTheme.of(context).grayColor3
            : Colors.transparent;
        break;
      case OeButtonTheme.light:
        textColor = _getBrandColor(context, status);
        backgroundColor = status == OeButtonStatus.active
            ? OeTheme.of(context).grayColor3
            : Colors.transparent;
        break;
      case OeButtonTheme.defaultTheme:
      default:
        textColor = _getDefaultTextColor(context, status);
        backgroundColor = status == OeButtonStatus.active
            ? OeTheme.of(context).grayColor3
            : Colors.transparent;
    }
    frameColor = backgroundColor;
  }

  /// 生成不同主题的幽灵按钮样式
  OeButtonStyle.generateGhostStyleByTheme(
      BuildContext context, OeButtonTheme? theme, OeButtonStatus status) {
    switch (theme) {
      case OeButtonTheme.primary:
        textColor = status == OeButtonStatus.disable
            ? OeTheme.of(context).fontWhColor4
            : _getBrandColor(context, status);
        break;
      case OeButtonTheme.danger:
        textColor = status == OeButtonStatus.disable
            ? OeTheme.of(context).fontWhColor4
            : _getErrorColor(context, status);
        break;
      case OeButtonTheme.light:
        textColor = status == OeButtonStatus.disable
            ? OeTheme.of(context).fontWhColor4
            : _getBrandColor(context, status);
        break;
      case OeButtonTheme.defaultTheme:
      default:
        switch (status) {
          case OeButtonStatus.active:
            textColor = OeTheme.of(context).fontWhColor2;
            break;
          case OeButtonStatus.disable:
            textColor = OeTheme.of(context).fontWhColor4;
            break;
          default:
            textColor = OeTheme.of(context).fontWhColor1;
        }
    }
    backgroundColor = Colors.transparent;
    frameColor = textColor;
    frameWidth = 1;
  }

  Color _getBrandColor(BuildContext context, OeButtonStatus status) {
    switch (status) {
      case OeButtonStatus.defaultState:
        return OeTheme.of(context).brandNormalColor;
      case OeButtonStatus.active:
        return OeTheme.of(context).brandClickColor;
      case OeButtonStatus.disable:
        return OeTheme.of(context).brandDisabledColor;
    }
  }

  Color _getLightColor(BuildContext context, OeButtonStatus status) {
    switch (status) {
      case OeButtonStatus.defaultState:
      case OeButtonStatus.disable:
        return OeTheme.of(context).brandLightColor;
      case OeButtonStatus.active:
        return OeTheme.of(context).brandFocusColor;
    }
  }

  Color _getErrorColor(BuildContext context, OeButtonStatus status) {
    switch (status) {
      case OeButtonStatus.defaultState:
        return OeTheme.of(context).errorNormalColor;
      case OeButtonStatus.active:
        return OeTheme.of(context).errorClickColor;
      case OeButtonStatus.disable:
        return OeTheme.of(context).errorDisabledColor;
    }
  }

  Color _getDefaultBgColor(BuildContext context, OeButtonStatus status) {
    switch (status) {
      case OeButtonStatus.defaultState:
        return OeTheme.of(context).grayColor3;
      case OeButtonStatus.active:
        return OeTheme.of(context).grayColor5;
      case OeButtonStatus.disable:
        return OeTheme.of(context).grayColor2;
    }
  }

  Color _getDefaultTextColor(BuildContext context, OeButtonStatus status) {
    switch (status) {
      case OeButtonStatus.defaultState:
      case OeButtonStatus.active:
        return OeTheme.of(context).fontGyColor1;
      case OeButtonStatus.disable:
        return OeTheme.of(context).fontGyColor4;
    }
  }

  Color _getOutlineDefaultBgColor(BuildContext context, OeButtonStatus status) {
    switch (status) {
      case OeButtonStatus.defaultState:
        return OeTheme.of(context).whiteColor1;
      case OeButtonStatus.active:
        return OeTheme.of(context).grayColor3;
      case OeButtonStatus.disable:
        return OeTheme.of(context).grayColor2;
    }
  }
}
