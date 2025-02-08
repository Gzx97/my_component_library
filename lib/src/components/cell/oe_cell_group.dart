import 'package:flutter/material.dart';

import '../../../my_component_library.dart';
import 'oe_cell_inherited.dart';

typedef CellBuilder = Widget Function(
    BuildContext context, OeCell cell, int index);

enum OeCellGroupTheme { defaultTheme, cardTheme }

/// 单元格组组件
class OeCellGroup extends StatefulWidget {
  const OeCellGroup({
    Key? key,
    this.bordered = false,
    this.theme = OeCellGroupTheme.defaultTheme,
    this.title,
    required this.cells,
    this.builder,
    this.style,
    this.titleWidget,
    this.scrollable = false,
    this.isShowLastBordered = false,
  }) : super(key: key);

  /// 是否显示组边框
  final bool? bordered;

  /// 单元格组风格。可选项：default/card
  final OeCellGroupTheme? theme;

  /// 单元格组标题
  final String? title;

  /// 单元格组标题组件
  final Widget? titleWidget;

  /// 单元格列表
  final List<OeCell> cells;

  /// cell构建器，可自定义cell父组件，如Dismissible
  final CellBuilder? builder;

  /// 自定义样式
  final OeCellStyle? style;

  /// 可滚动
  final bool? scrollable;

  /// 是否显示最后一个cell的下边框
  final bool? isShowLastBordered;

  @override
  _OeCellGroupState createState() => _OeCellGroupState();
}

class _OeCellGroupState extends State<OeCellGroup> {
  @override
  Widget build(BuildContext context) {
    var style = widget.style ?? OeCellStyle.cellStyle(context);
    var itemCount = widget.cells.length;
    var radius = _getBorderRadius(style);
    return OeCellInherited(
      style: style,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.title != null || widget.titleWidget != null)
            Container(
              width: double.infinity,
              color: style.backgroundColor,
              padding: style.titlePadding,
              child: widget.titleWidget ??
                  OeText(widget.title!, style: style.groupTitleStyle),
            ),
          Flexible(
            child: Container(
              padding: widget.theme == OeCellGroupTheme.cardTheme
                  ? style.cardPadding
                  : EdgeInsets.zero,
              decoration: BoxDecoration(
                  border: _getBordered(style), borderRadius: radius),
              child: ClipRRect(
                borderRadius: radius,
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: widget.scrollable == false, // 设置为true以避免无限制地增长
                  physics: widget.scrollable == false
                      ? const NeverScrollableScrollPhysics()
                      : null, // 禁用ListView的滚动
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    final item = widget.cells[index];
                    final cell = widget.builder == null
                        ? item
                        : widget.builder!(context, item, index);
                    if (itemCount - 1 == index &&
                        (widget.isShowLastBordered ?? false)) {
                      return Column(children: [cell, _borderWidget(style)]);
                    }
                    return cell;
                  },
                  separatorBuilder: (context, index) {
                    if (!(widget.cells[index].bordered ?? true)) {
                      return const SizedBox.shrink();
                    }
                    return _borderWidget(style);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxBorder? _getBordered(OeCellStyle style) {
    if (!(widget.bordered ?? false)) {
      return null;
    }
    var color = style.groupBorderedColor ?? OeTheme.of(context).grayColor3;
    return Border.all(
      color: color,
      width: 1,
    );
  }

  BorderRadiusGeometry _getBorderRadius(OeCellStyle style) {
    if (widget.theme == OeCellGroupTheme.cardTheme) {
      return style.cardBorderRadius ?? BorderRadius.zero;
    }
    return BorderRadius.zero;
  }

  Widget _borderWidget(OeCellStyle style) {
    return Row(
      children: [
        Container(
            height: 0.5,
            width: OeTheme.of(context).spacer16,
            color: style.backgroundColor),
        Expanded(
          child: Container(
              height: 0.5,
              color: style.borderedColor ?? OeTheme.of(context).grayColor3),
        ),
      ],
    );
  }
}
