import 'page/home/base_components/custom_button_page.dart';
import 'page/home/base_components/divider_page.dart';
import 'page/home/home_page.dart';
import 'package:flutter/material.dart';
import 'page/account/account_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '组件库示例',
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => HomePage());
          case '/account':
            return MaterialPageRoute(builder: (context) => const AccountPage());
          // 基础组件路由
          case '/base_components/custom_button':
            return MaterialPageRoute(
                builder: (context) => const CustomButtonPage());
          case '/base_components/divider':
            return MaterialPageRoute(builder: (context) => const DividerPage());
          // 输入组件路由
          // case '/input_components/input_component':
          //   return MaterialPageRoute(builder: (context) => const InputComponentPage());
          // case '/input_components/checkbox':
          //   return MaterialPageRoute(builder: (context) => const CheckboxPage());
          default:
            return MaterialPageRoute(builder: (context) => const ErrorPage());
        }
      },
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('404 - Page Not Found'),
      ),
    );
  }
}
