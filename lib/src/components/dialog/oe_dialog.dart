/*
 * Created by haozhicao@tencent.com on 6/17/22.
 * td_dialog.dart
 * 
 */

import 'package:flutter/material.dart';

import '../../../my_component_library.dart';

export 'oe_alert_dialog.dart';
export 'oe_confirm_dialog.dart';
export 'oe_image_dialog.dart';
export 'oe_input_dialog.dart';

/// Dialog按钮样式
///
/// 用于在Dialog层面配置按钮样式
/// Dialog内支持配置每个按钮的样式
enum OeDialogButtonStyle {
  normal,
  text,
}

/// 弹窗按钮配置
class OeDialogButtonOptions {
  OeDialogButtonOptions({
    required this.title,
    required this.action,
    this.titleColor,
    this.titleSize,
    this.style,
    this.type,
    this.theme,
    this.height,
    this.fontWeight,
  });

  /// 标题内容
  final String title;

  /// 标题颜色
  Color? titleColor;

  /// 字体大小
  final double? titleSize;

  /// 字体粗细
  final FontWeight? fontWeight;

  /// 按钮样式
  /// 设置单个按钮的样式会覆盖Dialog的默认样式
  final OeButtonStyle? style;

  /// 按钮类型
  final OeButtonType? type;

  /// 按钮类型
  final OeButtonTheme? theme;

  /// 按钮高度
  /// 建议使用默认高度
  final double? height;

  /// 点击操作
  final Function()? action;
}
