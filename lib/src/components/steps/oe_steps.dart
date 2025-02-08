import 'package:flutter/material.dart';
import '../../../my_component_library.dart';

/// Steps步骤条数据类型
class OeStepsItemData {
  OeStepsItemData({
    required this.title,
    required this.content,
    this.successIcon,
    this.errorIcon,
    this.customContent,
  });

  /// 标题
  final String title;

  /// 内容
  final String content;

  /// 成功图标
  final IconData? successIcon;

  /// 失败图标
  final IconData? errorIcon;

  /// 自定义内容
  final Widget? customContent;
}

/// Steps步骤条方向
enum OeStepsDirection {
  horizontal,
  vertical,
}

/// steps步骤条状态
enum OeStepsStatus {
  success,
  error,
}

/// Steps步骤条
class OeSteps extends StatefulWidget {
  const OeSteps({
    super.key,
    required this.steps,
    this.activeIndex = 0,
    this.direction = OeStepsDirection.horizontal,
    this.status = OeStepsStatus.success,
    this.simple = false,
    this.readOnly = false,
    this.verticalSelect = false,
  });

  /// 步骤条数据
  final List<OeStepsItemData> steps;

  /// 步骤条方向
  final OeStepsDirection direction;

  /// 步骤条当前激活的索引
  final int activeIndex;

  /// 步骤条状态
  final OeStepsStatus status;

  /// 步骤条simple模式
  final bool simple;

  /// 步骤条readOnly模式
  final bool readOnly;

  /// 步骤条垂直自定义步骤条选择模式
  final bool verticalSelect;

  @override
  _OeStepsState createState() => _OeStepsState();
}

class _OeStepsState extends State<OeSteps> {
  @override
  Widget build(BuildContext context) {
    /// 当前激活的step索引
    final currentActiveIndex = widget.activeIndex < 0
        ? 0
        : (widget.activeIndex >= widget.steps.length
            ? widget.steps.length - 1
            : widget.activeIndex);
    return widget.direction == OeStepsDirection.horizontal
        ? OeStepsHorizontal(
            steps: widget.steps,
            activeIndex: currentActiveIndex,
            status: widget.status,
            simple: widget.simple,
            readOnly: widget.readOnly)
        : OeStepsVertical(
            steps: widget.steps,
            activeIndex: currentActiveIndex,
            status: widget.status,
            simple: widget.simple,
            readOnly: widget.readOnly,
            verticalSelect: widget.verticalSelect,
          );
  }
}
