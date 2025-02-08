import 'package:flutter/material.dart';
import 'package:my_component_library/my_component_library.dart';

class OeTableViewPage extends StatefulWidget {
  const OeTableViewPage({Key? key}) : super(key: key);

  @override
  _OeTableViewPageState createState() => _OeTableViewPageState();
}

class _OeTableViewPageState extends State<OeTableViewPage> {
  List<dynamic> _getData(int index) {
    var data = <dynamic>[];
    for (var i = 0; i < 10; i++) {
      if (i == index) {
        data.add({
          'title1': '内容内容内容内容',
          'title2': '内容',
          'title3': '内容',
          'title4': '内容',
        });
      } else {
        data.add({
          'title1': '内容',
          'title2': '内容',
          'title3': '内容',
          'title4': '内容',
        });
      }
    }
    return data;
  }

  List<dynamic> _getData2() {
    var data = <dynamic>[];
    for (var i = 0; i < 10; i++) {
      if (i == 0) {
        data.add({
          'title1': '横向平铺内容不省略',
          'title2': '横向平铺内容不省略',
          'title3': '横向平铺内容不省略',
        });
      } else {
        data.add({
          'title1': '内容',
          'title2': '内容',
          'title3': '内容',
        });
      }
    }
    return data;
  }

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
          children: [_basicTable(context)],
        ),
      ),
    );
  }

  Widget _basicTable(BuildContext context) {
    return OeTable(
      columns: [
        OeTableCol(title: '标题', colKey: 'title1', ellipsis: true),
        OeTableCol(title: '标题', colKey: 'title2'),
        OeTableCol(title: '标题', colKey: 'title3'),
        OeTableCol(title: '标题', colKey: 'title4')
      ],
      data: _getData(9),
    );
  }
}
