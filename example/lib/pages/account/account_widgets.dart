import 'package:flutter/material.dart';

class AccountButtonWidget extends StatelessWidget {
  const AccountButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // 按钮点击逻辑，可添加具体功能实现
      },
      child: Text('Account Button'),
    );
  }
}
