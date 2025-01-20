import 'package:flutter/material.dart';

class OeButton extends StatelessWidget {
  final String label;
  // 是否是块级元素
  final bool block;
  // 按钮的颜色
  final String type;
  // 是否禁用
  final bool disabled;
  // 填充模式
  final String fill;
  // 是否处于加载状态，'auto' 模式会监听 onPressed 的 Promise 状态自动更新 loading
  final dynamic loading;
  // 加载状态下的 icon 图标
  final Widget? loadingIcon;
  // 加载状态下额外展示的文字
  final String? loadingText;
  // 点击事件
  final VoidCallback? onPressed;
  // 按钮的形状
  final String shape;
  // 大小
  final String size;
  // 原生 button 元素的 type 属性
  // final String oldtype;

  const OeButton({
    Key? key,
    this.block = false,
    this.type = 'default',
    this.disabled = false,
    this.fill = 'solid',
    this.loading = false,
    this.loadingIcon,
    this.loadingText,
    this.onPressed,
    this.shape = 'default',
    this.size = 'middle',
    // this.oldtype = 'button',
    this.label = 'label',
  }) : super(key: key);

  Color _getButtonColor() {
    switch (type) {
      case 'primary':
        return Colors.blue;
      case 'success':
        return Colors.green;
      case 'warning':
        return Colors.yellow;
      case 'danger':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  BorderSide _getBorderSide() {
    if (fill == 'outline') {
      return BorderSide(color: _getButtonColor());
    }
    return BorderSide.none;
  }

  double _getButtonPadding() {
    switch (size) {
      case 'mini':
        return 4.0;
      case 'small':
        return 8.0;
      case 'large':
        return 16.0;
      default:
        return 12.0;
    }
  }

  RoundedRectangleBorder _getButtonShape() {
    switch (shape) {
      case 'rounded':
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: _getBorderSide(),
        );
      case 'rectangular':
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: _getBorderSide(),
        );
      default:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          side: _getBorderSide(),
        );
    }
  }

  Widget _buildButtonContent() {
    if (loading == true) {
      if (loadingText != null && loadingIcon != null) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            loadingIcon!,
            const SizedBox(width: 8.0),
            Text(loadingText!),
          ],
        );
      } else if (loadingIcon != null) {
        return loadingIcon!;
      } else if (loadingText != null) {
        return Text(loadingText!);
      }
    }
    return Text(label);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: block ? double.infinity : null,
      child: ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              fill == 'solid' ? _getButtonColor() : Colors.transparent,
          padding: EdgeInsets.all(_getButtonPadding()),
          shape: _getButtonShape(),
        ),
        child: _buildButtonContent(),
      ),
    );
  }
}
