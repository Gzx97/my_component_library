import 'package:flutter/material.dart';
import 'package:my_component_library/my_component_library.dart';

class OeInputViewPage extends StatefulWidget {
  const OeInputViewPage({Key? key}) : super(key: key);

  @override
  _OeInputViewPageState createState() => _OeInputViewPageState();
}

class _OeInputViewPageState extends State<OeInputViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OeInput Example'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OeInput(
              leftLabel: '标签文字',
              backgroundColor: Colors.white,
              hintText: '请输入文字',
              onChanged: (text) {},
              onClearTap: () {},
            ),
            const SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}
