import 'package:flutter/material.dart';

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
            Text('Above the Divider'),
            Divider(),
            Text('Below the Divider'),
          ],
        ),
      ),
    );
  }
}
