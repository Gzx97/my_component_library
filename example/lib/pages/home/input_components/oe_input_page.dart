import 'package:flutter/material.dart';
import 'package:my_component_library/my_component_library.dart';

class OeInputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('OeInput Example'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('基本输入框示例'),
            OeInput(
              width: 300,
              hintText: '请输入内容',
              onChanged: (value) {
                print('输入内容: $value');
              },
              controller: _controller,
            ),
            SizedBox(height: 16),
            Text('带左侧图标和右侧清除按钮的输入框'),
            OeInput(
              width: 300,
              leftIcon: Icon(Icons.person),
              hintText: '请输入用户名',
              onChanged: (value) {
                print('输入用户名: $value');
              },
              needClear: true,
              onClearTap: () {
                _controller.clear();
              },
            ),
            SizedBox(height: 16),
            Text('密码输入框'),
            OeInput(
              width: 300,
              type: OeInputType.password,
              hintText: '请输入密码',
              obscureText: true,
              onChanged: (value) {
                print('输入密码: $value');
              },
            ),
            SizedBox(height: 16),
            Text('数字输入框'),
            OeInput(
              width: 300,
              type: OeInputType.number,
              hintText: '请输入数字',
              inputType: TextInputType.number,
              onChanged: (value) {
                print('输入数字: $value');
              },
            ),
          ],
        ),
      ),
    );
  }
}
