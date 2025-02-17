import 'package:flutter/material.dart';

typedef OeCollapseIconTextBuilder = String Function(
    BuildContext context, bool isExpanded);

/// 折叠面板，需配合 [OeCollapse] 使用
class OeCollapsePanel extends ExpansionPanel {
  OeCollapsePanel({
    /// 折叠面板的头部组件构造函数
    required ExpansionPanelHeaderBuilder headerBuilder,

    /// 折叠面板的内容组件
    required Widget body,

    /// 折叠面板的展开状态
    isExpanded = false,

    /// 折叠按钮操作说明文案的构造函数
    this.expandIconTextBuilder,

    /// 折叠面板的值，当使用 [OeCollapse.accordion] 时，必须传入此值
    this.value,

    /// 折叠面板的背景色
    backgroundColor,
  }) : super(
          headerBuilder: headerBuilder,
          body: body,
          isExpanded: isExpanded,
          canTapOnHeader: true,
          backgroundColor: backgroundColor,
        );

  final Object? value;

  final OeCollapseIconTextBuilder? expandIconTextBuilder;
}
