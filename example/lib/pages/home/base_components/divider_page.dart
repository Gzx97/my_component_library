import 'package:flutter/material.dart';

class DividerPage extends StatelessWidget {
  const DividerPage({Key? key}) : super(key: key);

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
