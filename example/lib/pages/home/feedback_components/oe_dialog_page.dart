import 'package:flutter/material.dart';
import 'package:my_component_library/my_component_library.dart';

class OeDialogViewPage extends StatefulWidget {
  const OeDialogViewPage({Key? key}) : super(key: key);

  @override
  _OeDialogViewPageState createState() => _OeDialogViewPageState();
}

class _OeDialogViewPageState extends State<OeDialogViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OeDialog Example'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
      ),
    );
  }
}
