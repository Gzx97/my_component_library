import 'package:flutter/material.dart';
import 'home_widgets.dart';
import 'package:my_component_library/my_component_library.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          // 可以添加一些AppBar上的操作按钮等，示例省略具体功能
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is Home Page'),
            HomeCustomWidget(), // 假设在home_widgets.dart中有定义
            CustomButton(
              onPressed: () {
                print('Button Pressed');
              },
              label: 'Click Me',
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
