import 'package:flutter/material.dart';

import '../../../my_component_library.dart';

/// 单元格组件样式
class OeCellStyle {
  OeCellStyle({
    this.leftIconColor,
    this.rightIconColor,
    this.titleStyle,
    this.requiredStyle,
    this.descriptionStyle,
    this.noteStyle,
    this.arrowColor,
    this.borderedColor,
    this.groupBorderedColor,
    this.backgroundColor,
    this.padding,
    this.cardBorderRadius,
    this.cardPadding,
    this.titlePadding,
  });

  /// 左侧图标颜色
  Color? leftIconColor;

  /// 右侧图标颜色
  Color? rightIconColor;

  /// 标题文字样式
  TextStyle? titleStyle;

  /// 必填星号文字样式
  TextStyle? requiredStyle;

  /// 内容描述文字样式
  TextStyle? descriptionStyle;

  /// 说明文字样式
  TextStyle? noteStyle;

  /// 箭头颜色
  Color? arrowColor;

  /// 单元格边框颜色
  Color? borderedColor;

  /// 单元格组边框颜色
  Color? groupBorderedColor;

  /// 默认状态背景颜色
  Color? backgroundColor;

  /// 点击状态背景颜色
  Color? clickBackgroundColor;

  /// 单元组标题文字样式
  TextStyle? groupTitleStyle;

  /// 单元格内边距
  EdgeInsets? padding;

  /// 卡片模式边框圆角
  BorderRadius? cardBorderRadius;

  /// 卡片模式内边距
  EdgeInsets? cardPadding;

  /// 单元格组标题内边距
  EdgeInsets? titlePadding;

  /// 生成单元格默认样式
  OeCellStyle.cellStyle(BuildContext context) {
    backgroundColor = Colors.white;
    clickBackgroundColor = OeTheme.of(context).grayColor1;
    leftIconColor = OeTheme.of(context).brandColor7;
    rightIconColor = OeTheme.of(context).brandColor7;
    titleStyle = TextStyle(
      color: OeTheme.of(context).fontGyColor1,
      fontSize: OeTheme.of(context).fontBodyLarge?.size ?? 16,
      height: OeTheme.of(context).fontBodyLarge?.height ?? 24,
      fontWeight: FontWeight.w400,
    );
    requiredStyle =
        titleStyle!.copyWith(color: OeTheme.of(context).errorColor6);
    descriptionStyle = TextStyle(
      color: OeTheme.of(context).fontGyColor2,
      fontSize: OeTheme.of(context).fontBodyMedium?.size ?? 14,
      height: OeTheme.of(context).fontBodyMedium?.height ?? 22,
      fontWeight: FontWeight.w400,
    );
    noteStyle = titleStyle!.copyWith(color: OeTheme.of(context).fontGyColor3);
    arrowColor = OeTheme.of(context).fontGyColor3;

    groupBorderedColor = OeTheme.of(context).grayColor3;
    borderedColor = OeTheme.of(context).grayColor3;
    groupTitleStyle = TextStyle(
      color: OeTheme.of(context).fontGyColor1,
      fontSize: OeTheme.of(context).fontTitleLarge?.size ?? 18,
      height: OeTheme.of(context).fontTitleLarge?.height ?? 26,
      fontWeight:
          OeTheme.of(context).fontTitleLarge?.fontWeight ?? FontWeight.w600,
    );

    padding = EdgeInsets.all(OeTheme.of(context).spacer16);
    cardBorderRadius =
        BorderRadius.all(Radius.circular(OeTheme.of(context).radiusLarge));
    cardPadding = EdgeInsets.only(
        left: OeTheme.of(context).spacer16,
        right: OeTheme.of(context).spacer16);
    titlePadding = EdgeInsets.only(
      left: OeTheme.of(context).spacer16,
      right: OeTheme.of(context).spacer16,
      top: OeTheme.of(context).spacer24,
      bottom: OeTheme.of(context).spacer8,
    );
  }
}
