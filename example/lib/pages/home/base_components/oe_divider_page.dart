import 'package:flutter/material.dart';
import 'package:my_component_library/my_component_library.dart';

class OeDividerPage extends StatelessWidget {
  const OeDividerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Divider Example'),
      ),
      body: Center(
        child: Column(
          children: const [
            OeDivider(
              text: '文字信息',
              alignment: TextAlignment.left,
            ),
            SizedBox(
              height: 20,
            ),
            OeDivider(
              text: '文字信息',
              alignment: TextAlignment.center,
            ),
            SizedBox(
              height: 20,
            ),
            OeDivider(
              text: '文字信息',
              alignment: TextAlignment.right,
            ),
          ],
        ),
      ),
    );
  }
}
