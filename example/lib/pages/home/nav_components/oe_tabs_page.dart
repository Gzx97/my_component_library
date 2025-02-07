import 'package:flutter/material.dart';
import 'package:my_component_library/my_component_library.dart';

class OeTabsViewPage extends StatefulWidget {
  const OeTabsViewPage({Key? key}) : super(key: key);

  @override
  _OeTabsViewPageState createState() => _OeTabsViewPageState();
}

class _OeTabsViewPageState extends State<OeTabsViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OeNav Example'),
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
