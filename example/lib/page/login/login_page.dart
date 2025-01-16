import 'package:flutter/material.dart';
import 'login_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoginEmailInputWidget(_emailController),
            LoginPasswordInputWidget(_passwordController),
            SizedBox(height: 20),
            LoginButtonWidget(() => _login()),
          ],
        ),
      ),
    );
  }

  void _login() {
    String email = _emailController.text;
    String password = _passwordController.text;
    // 这里可以添加实际的网络请求等验证逻辑，此处简单示例验证
    if (email == 'test@example.com' && password == '123456') {
      Navigator.pushReplacementNamed(context, '/home');
    } else {}
  }
}
