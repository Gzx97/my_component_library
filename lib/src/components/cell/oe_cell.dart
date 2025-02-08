import 'package:flutter/material.dart';

import '../../theme/oe_spacers.dart';
import '../../theme/oe_theme.dart';
import '../icon/oe_icons.dart';
import '../swipe_cell/oe_swipe_cell_inherited.dart';
import '../text/oe_text.dart';
import 'oe_cell_inherited.dart';
import 'oe_cell_style.dart';

typedef OeCellClick = void Function(OeCell cell);

enum OeCellAlign { top, middle, bottom }

/// 单元格组件
class OeCell extends StatefulWidget {
  const OeCell({
    Key? key,
    this.align = OeCellAlign.middle,
    this.arrow = false,
    this.bordered = true,
    this.description,
    this.descriptionWidget,
    this.hover = true,
    this.image,
    this.imageSize,
    this.imageWidget,
    this.leftIcon,
    this.leftIconWidget,
    this.note,
    this.noteWidget,
    this.required = false,
    this.title,
    this.titleWidget,
    this.onClick,
    this.onLongPress,
    this.style,
    this.rightIcon,
    this.rightIconWidget,
    this.disabled = false,
    this.imageCircle = 50,
  }) : super(key: key);

  /// 内容的对齐方式，默认居中对齐。可选项：top/middle/bottom
  final OeCellAlign? align;

  /// 是否显示右侧箭头
  final bool? arrow;

  /// 是否显示下边框，仅在OeCellGroup组件下起作用
  final bool? bordered;

  /// 下方内容描述文字
  final String? description;

  /// 下方内容描述组件
  final Widget? descriptionWidget;

  /// 是否开启点击反馈
  final bool? hover;

  /// 主图
  final ImageProvider? image;

  /// 主图尺寸
  final double? imageSize;

  /// 主图圆角，默认50（圆形）
  final double? imageCircle;

  /// 主图组件
  final Widget? imageWidget;

  /// 左侧图标，出现在单元格标题的左侧
  final IconData? leftIcon;

  /// 左侧图标组件
  final Widget? leftIconWidget;

  /// 和标题同行的说明文字
  final String? note;

  /// 说明文字组件
  final Widget? noteWidget;

  /// 是否显示表单必填星号
  final bool? required;

  /// 最右侧图标
  final IconData? rightIcon;

  /// 最右侧图标组件
  final Widget? rightIconWidget;

  /// 标题
  final String? title;

  /// 标题组件
  final Widget? titleWidget;

  /// 点击事件
  final OeCellClick? onClick;

  /// 长按事件
  final OeCellClick? onLongPress;

  /// 自定义样式
  final OeCellStyle? style;

  /// 禁用
  final bool? disabled;

  @override
  _OeCellState createState() => _OeCellState();
}

class _OeCellState extends State<OeCell> {
  var _status = 'default';

  @override
  Widget build(BuildContext context) {
    var style = widget.style ??
        OeCellInherited.of(context)?.style ??
        OeCellStyle.cellStyle(context);
    var crossAxisAlignment = _getAlign();
    return GestureDetector(
      onTap: () {
        if (widget.onClick != null && !(widget.disabled ?? false)) {
          widget.onClick!(widget);
        }
        OeSwipeCellInherited.of(context)?.cellClick();
      },
      onLongPress: widget.onLongPress != null
          ? () {
              if (!(widget.disabled ?? false)) {
                widget.onLongPress!(widget);
              }
            }
          : null,
      onTapDown: (details) {
        _setStatus('active', 0);
      },
      onTapUp: (details) {
        _setStatus('default', 100);
      },
      onTapCancel: () {
        _setStatus('default', 0);
      },
      child: Container(
        color: _status == 'default'
            ? style.backgroundColor
            : style.clickBackgroundColor,
        padding: style.padding,
        child: Row(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            ..._getImage(),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.leftIcon != null ||
                      widget.leftIconWidget != null) ...[
                    widget.leftIconWidget ??
                        Icon(widget.leftIcon,
                            size: 24, color: style.leftIconColor),
                    SizedBox(width: OeTheme.of(context).spacer12),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (widget.titleWidget != null)
                              Flexible(child: widget.titleWidget!)
                            else if (widget.title?.isNotEmpty == true)
                              Flexible(
                                  child: OeText(widget.title!,
                                      style: style.titleStyle)),
                            if (widget.required ?? false)
                              OeText(' *', style: style.requiredStyle),
                          ],
                        ),
                        if ((widget.titleWidget != null ||
                                widget.title != null) &&
                            (widget.descriptionWidget != null ||
                                widget.description?.isNotEmpty == true))
                          SizedBox(height: OeTheme.of(context).spacer4),
                        if (widget.descriptionWidget != null)
                          widget.descriptionWidget!
                        else if (widget.description?.isNotEmpty == true)
                          OeText(widget.description!,
                              style: style.descriptionStyle),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Wrap(
              spacing: OeTheme.of(context).spacer4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (widget.noteWidget != null)
                  widget.noteWidget!
                else if (widget.note?.isNotEmpty == true)
                  OeText(widget.note!, style: style.noteStyle),
                if (widget.rightIconWidget != null)
                  widget.rightIconWidget!
                else if (widget.rightIcon != null)
                  Icon(widget.rightIcon, size: 24, color: style.rightIconColor),
                if (widget.arrow ?? false)
                  Icon(OeIcons.chevron_right,
                      size: 24, color: style.arrowColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  CrossAxisAlignment _getAlign() {
    switch (widget.align) {
      case OeCellAlign.top:
        return CrossAxisAlignment.start;
      case OeCellAlign.middle:
        return CrossAxisAlignment.center;
      case OeCellAlign.bottom:
        return CrossAxisAlignment.end;
      default:
        return CrossAxisAlignment.center;
    }
  }

  void _setStatus(String status, int milliseconds) {
    if ((widget.disabled ?? false) || !(widget.hover ?? true)) {
      return;
    }
    if (milliseconds == 0) {
      setState(() {
        _status = status;
      });
      return;
    }
    Future.delayed(Duration(milliseconds: milliseconds), () {
      setState(() {
        _status = status;
      });
    });
  }

  List<Widget> _getImage() {
    var imageSize = widget.imageSize ?? 48;
    var list = <Widget>[];
    if (widget.imageWidget != null) {
      list.add(widget.imageWidget!);
    } else if (widget.image != null) {
      list.add(ClipRRect(
        borderRadius: BorderRadius.circular(widget.imageCircle ?? 50),
        child: Image(
          image: widget.image!,
          width: imageSize,
          height: imageSize,
          fit: BoxFit.cover,
        ),
      ));
    }
    if (list.isEmpty) {
      return list;
    }
    list.add(SizedBox(width: OeTheme.of(context).spacer12));
    return list;
  }
}
