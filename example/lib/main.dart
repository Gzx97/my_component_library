import 'package:flutter/material.dart';
import 'routes/app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Component Library Example',
      initialRoute: '/',
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
