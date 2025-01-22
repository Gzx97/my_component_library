import 'package:flutter/material.dart';
import 'pages/home/base_components/oe_button_page.dart';
import 'pages/home/base_components/oe_divider_page.dart';
import 'pages/home/input_components/oe_input_page.dart';
// import 'pages/home/input_components/checkbox_page.dart';

class ExampleMap {
  static final Map<String, Widget Function()> baseComponents = {
    'oe_button': () => const OeButtonPage(),
    'oe_divider': () => const OeDividerPage(),
  };

  static final Map<String, Widget Function()> inputComponents = {
    'oe_input': () => OeInputViewPage(),
    // 'Checkbox': () => const CheckboxPage(),
  };
}
