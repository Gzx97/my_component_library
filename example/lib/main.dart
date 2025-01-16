import 'package:flutter/material.dart';
import 'routes/app_router.dart';
import 'page/home/home_page.dart';
import 'page/account/account_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: '/login',
      home: TabBarPage(), // 修改这里，使用TabBarPage作为首页（登录成功后显示）
    );
  }
}

class TabBarPage extends StatefulWidget {
  const TabBarPage({super.key});

  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          HomePage(),
          AccountPage(),
        ],
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        tabs: [
          Tab(icon: Icon(Icons.home), text: 'Home'),
          Tab(icon: Icon(Icons.person), text: 'Account'),
        ],
      ),
    );
  }
}
