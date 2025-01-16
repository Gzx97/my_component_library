import 'package:flutter/material.dart';
import 'pages/home/base_components/custom_button_page.dart';
import 'pages/home/base_components/divider_page.dart';
// import 'pages/home/input_components/input_component_page.dart';
// import 'pages/home/input_components/checkbox_page.dart';

class ExampleMap {
  static final Map<String, Widget Function()> baseComponents = {
    'custom_button': () => const CustomButtonPage(),
    'divider': () => const DividerPage(),
  };

  static final Map<String, Widget Function()> inputComponents = {
    // 'Input Component': () => const InputComponentPage(),
    // 'Checkbox': () => const CheckboxPage(),
  };
}
