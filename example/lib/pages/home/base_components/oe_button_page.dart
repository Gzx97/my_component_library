import 'package:flutter/material.dart';
import 'package:my_component_library/my_component_library.dart';

class OeButtonPage extends StatelessWidget {
  const OeButtonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Button Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // 普通使用，使用默认颜色
            OeButton(
              onPressed: () {
                print('Custom Button Pressed with default type');
              },
              label: 'Default Color Button',
              loading: true,
              loadingText: 'loading...',
            ),
            const SizedBox(height: 20),
            // 指定颜色的按钮
            OeButton(
              onPressed: () {
                print('Custom Button Pressed with red type');
              },
              label: 'Red Color Button',
              type: "danger",
            ),
          ],
        ),
      ),
    );
  }
}
