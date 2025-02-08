import 'package:flutter/material.dart';

import '../../theme/oe_colors.dart';
import '../../theme/oe_theme.dart';
import 'oe_notice_bar.dart';

/// 公告栏类型
enum OeNoticeBarType {
  /// 静止（默认）
  none,

  /// 滚动
  scroll,

  /// 步进
  step
}

/// 公告栏主题
enum OeNoticeBarTheme {
  /// 默认
  info,

  /// 成功
  success,

  /// 警告
  warning,

  /// 错误
  error
}

/// 公告栏样式
class OeNoticeBarStyle {
  OeNoticeBarStyle(
      {this.context,
      this.backgroundColor,
      this.textStyle,
      this.leftIconColor,
      this.rightIconColor,
      this.padding});

  /// 上下文
  BuildContext? context;

  /// 公告栏背景色
  Color? backgroundColor;

  /// 公告栏左侧图标颜色
  Color? leftIconColor;

  /// 公告栏右侧图标颜色
  Color? rightIconColor;

  /// 公告栏内边距
  EdgeInsetsGeometry? padding;

  /// 公告栏内容样式
  TextStyle? textStyle;

  /// 公告栏内边距，用于获取默认值
  EdgeInsetsGeometry get getPadding =>
      padding ??
      const EdgeInsets.only(top: 13, bottom: 13, left: 16, right: 12);

  /// 公告栏内容样式，用于获取默认值
  TextStyle get getTextStyle =>
      textStyle ??
      TextStyle(
        color: OeTheme.of(context).fontGyColor1,
        fontSize: 14,
        height: 1,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
      );

  /// 根据主题生成样式
  OeNoticeBarStyle.generateTheme(BuildContext context,
      {OeNoticeBarTheme? theme = OeNoticeBarTheme.info}) {
    rightIconColor = OeTheme.of(context).grayColor7;
    switch (theme) {
      case OeNoticeBarTheme.warning:
        leftIconColor = OeTheme.of(context).warningNormalColor;
        backgroundColor = OeTheme.of(context).warningLightColor;
        break;
      case OeNoticeBarTheme.error:
        leftIconColor = OeTheme.of(context).errorNormalColor;
        backgroundColor = OeTheme.of(context).errorLightColor;
        break;
      case OeNoticeBarTheme.success:
        leftIconColor = OeTheme.of(context).successNormalColor;
        backgroundColor = OeTheme.of(context).successLightColor;
        break;
      default:
        leftIconColor = OeTheme.of(context).brandNormalColor;
        backgroundColor = OeTheme.of(context).brandLightColor;
        break;
    }
  }
}
