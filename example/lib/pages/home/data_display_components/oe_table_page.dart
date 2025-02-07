import 'package:flutter/material.dart';
import 'package:my_component_library/my_component_library.dart';

class OeTableViewPage extends StatefulWidget {
  const OeTableViewPage({Key? key}) : super(key: key);

  @override
  _OeTableViewPageState createState() => _OeTableViewPageState();
}

class _OeTableViewPageState extends State<OeTableViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OeTable Example'),
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
