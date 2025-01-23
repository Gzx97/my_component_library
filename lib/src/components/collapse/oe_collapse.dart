import 'package:flutter/material.dart';

import '../../../my_component_library.dart';
import 'oe_collapse_panel.dart';
import 'oe_collapse_salted_key.dart';
import 'oe_inset_divider.dart';
import 'oe_nonanimated_expand_icon.dart';

/// 折叠面板的组件样式
enum OeCollapseStyle {
  /// Block 通栏风格
  block,

  /// Card 卡片风格
  card
}

/// 折叠面板列表组件，需配合 [OeCollapsePanel] 使用
class OeCollapse extends StatefulWidget {
  const OeCollapse({
    required this.children,
    this.style = OeCollapseStyle.block,
    this.expansionCallback,
    this.animationDuration = kThemeAnimationDuration,
    this.elevation = 0,
    Key? key,
  })  : _allowOnlyOnePanelOpen = false,
        initialOpenPanelValue = null,
        super(key: key);

  const OeCollapse.accordion({
    required this.children,
    this.style = OeCollapseStyle.block,
    this.expansionCallback,
    this.animationDuration = kThemeAnimationDuration,
    this.elevation = 0,
    this.initialOpenPanelValue,
    Key? key,
  })  : _allowOnlyOnePanelOpen = true,
        super(key: key);

  /// 折叠面板列表的样式
  /// - [OeCollapseStyle.block] 通栏风格
  /// - [OeCollapseStyle.card] 卡片风格
  final OeCollapseStyle style;

  /// 折叠面板列表的子组件
  final List<OeCollapsePanel> children;

  /// 折叠面板列表的回调函数；
  /// 回调时，入参为当前点击的折叠面板的索引 index 和是否展开的状态 isExpanded
  final ExpansionPanelCallback? expansionCallback;

  /// 折叠面板列表的动画时长
  final Duration animationDuration;

  /// 折叠面板列表的阴影
  final double elevation;

  /// 折叠面板列表的默认展开面板的值；
  /// 当使用 [OeCollapse.accordion] 时，此值生效
  final Object? initialOpenPanelValue;

  final bool _allowOnlyOnePanelOpen;

  @override
  State createState() => _OeCollapseState();
}

class _OeCollapseState extends State<OeCollapse> {
  OeCollapsePanel? _currentOpenPanel;

  @override
  void initState() {
    super.initState();

    if (!widget._allowOnlyOnePanelOpen) {
      return;
    }

    assert(_allPanelsHaveValue(),
        'When allowing only one panel to be open, every panel must have a value.');
    assert(_allPanelsHaveDistinctValues(),
        'When allowing only one panel to be open, every panel must have a distinct value.');

    if (widget.initialOpenPanelValue != null) {
      _currentOpenPanel = _searchPanelByValue(widget.initialOpenPanelValue);
    }
  }

  @override
  void didUpdateWidget(OeCollapse oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!widget._allowOnlyOnePanelOpen) {
      _currentOpenPanel = null;
      return;
    }

    assert(_allPanelsHaveValue(),
        'When allowing only one panel to be open, every panel must have a value.');
    assert(_allPanelsHaveDistinctValues(),
        'When allowing only one panel to be open, every panel must have a distinct value.');

    // when the widget is updated to accordion mode
    // we need to initialize the current open panel to defaultOpenPanelValue
    if (!oldWidget._allowOnlyOnePanelOpen) {
      _currentOpenPanel = _searchPanelByValue(widget.initialOpenPanelValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = <MergeableMaterialItem>[];

    for (var index = 0; index < widget.children.length; index += 1) {
      if (_isChildExpanded(index) &&
          index != 0 &&
          !_isChildExpanded(index - 1)) {
        items.add(_buildGap(context, index * 2 - 1));
      }

      final isLastChild = index == widget.children.length - 1;
      final child = widget.children[index];

      final titleWidget = _buildTitleWidget(context, child, index);
      final expandIconWidget = _buildExpandIconWidget(context, child, index);

      final borderRadius =
          _isCardStyle() ? _createRadius(index) : BorderRadius.zero;

      items.add(
        MaterialSlice(
            key: OeCollapseSaltedKey<BuildContext, int>(context, index * 2),
            color: child.backgroundColor,
            child: Column(
              // to prevent collapse state change when parent rebuild
              key: OeCollapseSaltedKey<BuildContext, int>(context, index * 2),
              children: [
                MergeSemantics(
                  child: InkWell(
                    borderRadius: borderRadius,
                    onTap: () => _handlePressed(index, _isChildExpanded(index)),
                    child: Row(
                      children: [
                        Expanded(
                          child: AnimatedContainer(
                            duration: widget.animationDuration,
                            curve: Curves.fastOutSlowIn,
                            margin: EdgeInsets.zero,
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                minHeight: kMinInteractiveDimension,
                              ),
                              child: titleWidget,
                            ),
                          ),
                        ),
                        expandIconWidget,
                      ],
                    ),
                  ),
                ),
                AnimatedCrossFade(
                  firstChild: Container(height: 0.0),
                  secondChild: Column(
                    children: [
                      const OeInsetDivider(),
                      Container(
                        padding: EdgeInsets.all(OeTheme.of(context).spacer16),
                        child: child.body,
                      ),
                    ],
                  ),
                  firstCurve:
                      const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
                  secondCurve:
                      const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
                  sizeCurve: Curves.fastOutSlowIn,
                  crossFadeState: _isChildExpanded(index)
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: widget.animationDuration,
                ),
                if (!isLastChild) const OeInsetDivider()
              ],
            )),
      );

      if (_isChildExpanded(index) && !isLastChild) {
        items.add(_buildGap(context, index * 2 + 1));
      }
    }

    // FIXME: 非连续展开的 item 会导致 expanded 时动画丢失
    Widget collapse = MergeableMaterial(
      hasDividers: false,
      elevation: widget.elevation,
      children: items,
    );

    if (_isCardStyle()) {
      collapse = Container(
        child: ClipRRect(
          child: collapse,
          borderRadius: BorderRadius.circular(OeTheme.of(context).radiusLarge),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: OeTheme.of(context).spacer16,
        ),
      );
    }

    return collapse;
  }

  MergeableMaterialItem _buildGap(BuildContext context, int value) {
    return MaterialGap(
      size: 0.0,
      key: OeCollapseSaltedKey<BuildContext, int>(context, value),
    );
  }

  BorderRadius _createRadius(int index) {
    final radius = Radius.circular(OeTheme.of(context).radiusLarge);

    final isFirst = index == 0;
    if (isFirst) {
      return BorderRadius.only(topLeft: radius, topRight: radius);
    }

    final isLast = index == widget.children.length - 1;
    if (isLast) {
      return BorderRadius.only(bottomLeft: radius, bottomRight: radius);
    }

    return BorderRadius.zero;
  }

  bool _isCardStyle() {
    return widget.style == OeCollapseStyle.card;
  }

  bool _isChildExpanded(int index) {
    final child = widget.children[index];

    if (widget._allowOnlyOnePanelOpen) {
      return _currentOpenPanel?.value == child.value;
    }

    return child.isExpanded;
  }

  void _handlePressed(int index, bool isExpanded) {
    widget.expansionCallback?.call(index, isExpanded);

    if (!widget._allowOnlyOnePanelOpen) {
      return;
    }

    // collapse the current open panel by calling its expansion callback to false
    for (var childIndex = 0;
        childIndex < widget.children.length;
        childIndex += 1) {
      final curChild = widget.children[childIndex];
      if (widget.expansionCallback != null &&
          childIndex != index &&
          curChild.value == _currentOpenPanel?.value) {
        widget.expansionCallback!(childIndex, false);
      }
    }

    setState(() {
      _currentOpenPanel = isExpanded ? null : widget.children[index];
    });
  }

  Widget _buildTitleWidget(
      BuildContext context, OeCollapsePanel child, int index) {
    final titleWidget = child.headerBuilder(context, _isChildExpanded(index));
    return ListTile(
      title: titleWidget,
    );
  }

  Widget _buildExpandIconWidget(
      BuildContext context, OeCollapsePanel child, int index) {
    Widget expandedIcon = Container(
      key: OeCollapseSaltedKey<BuildContext, int>(context, index * 2),
      margin: const EdgeInsetsDirectional.all(0.0),
      child: TdNonAnimatedExpandIcon(
        isExpanded: _isChildExpanded(index),
        padding: child.expandIconTextBuilder != null
            ? EdgeInsets.only(
                right: OeTheme.of(context).spacer16,
                top: OeTheme.of(context).spacer16,
                bottom: OeTheme.of(context).spacer16,
                left: 0,
              )
            : EdgeInsets.all(OeTheme.of(context).spacer16),
      ),
    );

    return Row(
      children: [
        if (child.expandIconTextBuilder != null)
          Text(child.expandIconTextBuilder!(context, _isChildExpanded(index)),
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.black.withOpacity(0.4),
              )),
        expandedIcon,
      ],
    );
  }

  bool _allPanelsHaveValue() {
    return widget.children.every((OeCollapsePanel child) {
      return child.value != null;
    });
  }

  bool _allPanelsHaveDistinctValues() {
    final valueSet = <Object?>{};
    return widget.children.every((OeCollapsePanel child) {
      if (!valueSet.add(child.value)) {
        return false;
      }
      return true;
    });
  }

  OeCollapsePanel? _searchPanelByValue(Object? value) {
    for (var index = 0; index < widget.children.length; index += 1) {
      final child = widget.children[index];
      if (child.value == value) {
        return child;
      }
    }
    return null;
  }
}
