import 'package:flutter/material.dart';
import 'package:my_component_library/my_component_library.dart';

class OeIconPage extends StatelessWidget {
  const OeIconPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Icon Example'),
      ),
      body: Center(
        child: Column(
          children: const [
            Icon(
              OeIcons.activity,
            )
          ],
        ),
      ),
    );
  }
}
