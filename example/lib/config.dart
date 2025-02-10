import 'package:flutter/material.dart';
import 'pages/home/base_components/oe_button_page.dart';
import 'pages/home/base_components/oe_divider_page.dart';
import 'pages/home/base_components/oe_fab_page.dart';
import 'pages/home/base_components/oe_icon_page.dart';
import 'pages/home/data_display_components/oe_table_page.dart';
import 'pages/home/feedback_components/oe_dialog_page.dart';
import 'pages/home/input_components/oe_input_page.dart';
import 'pages/home/nav_components/oe_tabs_page.dart';

class ExampleMap {
  // 基础组件
  static final Map<String, Widget Function()> baseComponents = {
    'oe_button': () => const OeButtonPage(),
    'oe_divider': () => const OeDividerPage(),
    'oe_fab': () => const OeFabPage(),
    'oe_icon': () => const OeIconPage(),
  };
  // 输入组件
  static final Map<String, Widget Function()> inputComponents = {
    'oe_input': () => OeInputViewPage(),
    // 'Checkbox': () => const CheckboxPage(),
  };
  // 反馈组件
  static final Map<String, Widget Function()> feedbackComponents = {
    'oe_dialog': () => OeDialogViewPage(),
  };
  // 数据展示组件路由
  static final Map<String, Widget Function()> dataDisplayComponents = {
    'oe_table': () => OeTableViewPage(),
  };
  // 导航组件路由
  static final Map<String, Widget Function()> navComponents = {
    'oe_tabs': () => OeTabsViewPage(),
  };
}
