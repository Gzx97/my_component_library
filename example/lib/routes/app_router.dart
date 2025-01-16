import 'package:flutter/material.dart';
import '../page/account/account_page.dart';
import '../page/home/home_page.dart';
import '../page/login/login_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (context) => LoginPage());
      case '/home':
        return MaterialPageRoute(builder: (context) => HomePage());
      case '/account':
        return MaterialPageRoute(builder: (context) => AccountPage());
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  body: Center(
                    child: Text('Page not found'),
                  ),
                ));
    }
  }
}
