import 'package:flutter/material.dart';
import '../pages/home/home_page.dart';
import '../pages/account/account_page.dart';
import '../pages/home/base_components/custom_button_page.dart';
import '../pages/home/base_components/divider_page.dart';
// import '../pages/home/input_components/input_component_page.dart';
// import '../pages/home/input_components/checkbox_page.dart';
import 'error_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => HomePage());
      case '/account':
        return MaterialPageRoute(builder: (context) => const AccountPage());
      // 基础组件路由
      case '/custom_button':
        return MaterialPageRoute(
            builder: (context) => const CustomButtonPage());
      case '/divider':
        return MaterialPageRoute(builder: (context) => const DividerPage());
      // 输入组件路由
      // case '/input_components/input_component':
      //   return MaterialPageRoute(
      //       builder: (context) => const InputComponentPage());
      // case '/input_components/checkbox':
      //   return MaterialPageRoute(builder: (context) => const CheckboxPage());
      default:
        return MaterialPageRoute(builder: (context) => const ErrorPage());
    }
  }
}
