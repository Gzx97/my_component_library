import 'package:flutter/material.dart';
import 'routes/app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Component Library Example',
      initialRoute: AppRouter.currentRoute, // 使用保存的路由信息作为初始路由
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
