import 'package:flutter/material.dart';
import '../pages/home/base_components/oe_fab_page.dart';
import '../pages/home/base_components/oe_icon_page.dart';
import '../pages/home/data_display_components/oe_table_page.dart';
import '../pages/home/feedback_components/oe_dialog_page.dart';
import '../pages/home/home_page.dart';
import '../pages/account/account_page.dart';
import '../pages/home/base_components/oe_button_page.dart';
import '../pages/home/base_components/oe_divider_page.dart';
// import '../pages/home/input_components/input_component_page.dart';
// import '../pages/home/input_components/checkbox_page.dart';
import '../pages/home/input_components/oe_input_page.dart';
import '../pages/home/nav_components/oe_tabs_page.dart';
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
      case '/oe_fab':
        return MaterialPageRoute(builder: (context) => const OeFabPage());
      case '/oe_icon':
        return MaterialPageRoute(builder: (context) => const OeIconPage());
      // 输入组件路由
      case '/oe_input':
        return MaterialPageRoute(builder: (context) => const OeInputViewPage());
      // 反馈组件路由
      case '/oe_dialog':
        return MaterialPageRoute(
            builder: (context) => const OeDialogViewPage());
      //数据展示组件路由
      case '/oe_table':
        return MaterialPageRoute(builder: (context) => const OeTableViewPage());
      //导航组件路由
      case '/oe_tabs':
        return MaterialPageRoute(builder: (context) => const OeTabsViewPage());
      default:
        return MaterialPageRoute(builder: (context) => const ErrorPage());
    }
  }
}
