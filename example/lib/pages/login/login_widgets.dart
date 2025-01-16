import 'package:flutter/material.dart';

// 登录邮箱输入框组件
class LoginEmailInputWidget extends StatelessWidget {
  final TextEditingController controller;

  const LoginEmailInputWidget(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Email',
      ),
    );
  }
}

// 登录密码输入框组件
class LoginPasswordInputWidget extends StatelessWidget {
  final TextEditingController controller;

  const LoginPasswordInputWidget(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Password',
      ),
      obscureText: true,
    );
  }
}

// 登录按钮组件
class LoginButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButtonWidget(this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text('Login'),
    );
  }
}
