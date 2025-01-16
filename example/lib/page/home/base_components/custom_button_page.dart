import 'package:flutter/material.dart';
import 'package:my_component_library/my_component_library.dart';

class CustomButtonPage extends StatelessWidget {
  const CustomButtonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Button Example'),
      ),
      body: Center(
        child: CustomButton(
          onPressed: () {
            print('Custom Button Pressed');
          },
          label: 'Click Me',
          color: Colors.blue,
        ),
      ),
    );
  }
}
