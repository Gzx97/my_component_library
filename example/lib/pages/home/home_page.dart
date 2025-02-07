import 'package:flutter/material.dart';
import '../../config.dart';
import '../account/account_page.dart';

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
          title: const Text('Component Library Example'),
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
          ...ExampleMap.baseComponents.entries.map((entry) => ComponentButton(
                label: entry.key,
                onPressed: () {
                  print('点击了${entry.key}');

                  Navigator.pushNamed(context, '/${entry.key}');
                },
              )),
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
          ...ExampleMap.inputComponents.entries.map((entry) => ComponentButton(
                label: entry.key,
                onPressed: () {
                  Navigator.pushNamed(context, '/${entry.key}');
                },
              )),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '反馈组件分类',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // 反馈组件展示
          ...ExampleMap.feedbackComponents.entries
              .map((entry) => ComponentButton(
                    label: entry.key,
                    onPressed: () {
                      Navigator.pushNamed(context, '/${entry.key}');
                    },
                  )),

          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '导航组件分类',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // 导航组件展示
          ...ExampleMap.navComponents.entries.map((entry) => ComponentButton(
                label: entry.key,
                onPressed: () {
                  Navigator.pushNamed(context, '/${entry.key}');
                },
              )),

          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '数据展示组件分类',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // 数据展示组件展示
          ...ExampleMap.dataDisplayComponents.entries
              .map((entry) => ComponentButton(
                    label: entry.key,
                    onPressed: () {
                      Navigator.pushNamed(context, '/${entry.key}');
                    },
                  )),
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
