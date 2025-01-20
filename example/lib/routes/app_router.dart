import 'package:flutter/material.dart';
import '../pages/home/home_page.dart';
import '../pages/account/account_page.dart';
import '../pages/home/base_components/oe_button_page.dart';
import '../pages/home/base_components/oe_divider_page.dart';
// import '../pages/home/input_components/input_component_page.dart';
// import '../pages/home/input_components/checkbox_page.dart';
import '../pages/home/input_components/oe_input_page.dart';
import 'error_page.dart';

class AppRouter {
  // 保存当前路由信息
  static String currentRoute = '/';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // 更新当前路由信息
    currentRoute = settings.name!;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => HomePage());
      case '/account':
        return MaterialPageRoute(builder: (context) => const AccountPage());
      // 基础组件路由
      case '/oe_button':
        return MaterialPageRoute(builder: (context) => const OeButtonPage());
      case '/oe_divider':
        return MaterialPageRoute(builder: (context) => const OeDividerPage());
      // 输入组件路由
      case '/oe_input':
        return MaterialPageRoute(builder: (context) => OeInputPage());
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
