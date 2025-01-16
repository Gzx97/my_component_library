import 'package:flutter/material.dart';
import 'account_widgets.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is Account Page'),
            AccountButtonWidget(), // 假设在account_widgets.dart中有定义这个组件
          ],
        ),
      ),
    );
  }
}
