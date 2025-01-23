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
            OeButton(
              text: '填充按钮',
              size: OeButtonSize.large,
              type: OeButtonType.fill,
              shape: OeButtonShape.round,
              theme: OeButtonTheme.primary,
              onTap: () => print('点击了填充按钮'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
