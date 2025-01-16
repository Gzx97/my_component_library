import 'package:example/page/account/account_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Home'),
              Tab(text: 'Account'),
            ],
          ),
          title: const Text('组件库示例'),
        ),
        body: const TabBarView(
          children: [
            HomeComponentsPage(),
            AccountPage(),
          ],
        ),
      ),
    );
  }
}

class HomeComponentsPage extends StatelessWidget {
  const HomeComponentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '基础组件分类',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // 基础组件展示
          ComponentButton(
            label: 'Button',
            onPressed: () {
              Navigator.pushNamed(context, '/base_components/custom_button');
            },
          ),
          ComponentButton(
            label: 'Divider',
            onPressed: () {
              Navigator.pushNamed(context, '/base_components/divider');
            },
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '输入组件分类',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // 输入组件展示
          ComponentButton(
            label: 'Input Component',
            onPressed: () {
              Navigator.pushNamed(context, '/input_component');
            },
          ),
          ComponentButton(
            label: 'Checkbox',
            onPressed: () {
              Navigator.pushNamed(context, '/checkbox');
            },
          ),
        ],
      ),
    );
  }
}

class ComponentButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const ComponentButton(
      {Key? key, required this.label, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
