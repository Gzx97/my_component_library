import 'package:flutter/material.dart';
import 'oe_theme.dart';

/// 内置投影
extension OeBoxShadows on OeThemeData {
  /// 基础投影
  List<BoxShadow>? get shadowsBase => shadowMap['shadowsBase'];

  /// 中层投影
  List<BoxShadow>? get shadowsMiddle => shadowMap['shadowsMiddle'];

  /// 上层投影
  List<BoxShadow>? get shadowsTop => shadowMap['shadowsTop'];
}
