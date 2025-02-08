import 'package:flutter/material.dart';

import '../../../my_component_library.dart';

enum OeFabTheme { primary, defaultTheme, light, danger }

enum OeFabShape {
  circle, // 圆形
  square // 矩形
}

enum OeFabSize {
  large, // 大
  medium, // 中
  small, // 小
  extraSmall // 特小
}

class OeFab extends StatelessWidget {
  const OeFab(
      {Key? key,
      this.theme = OeFabTheme.defaultTheme,
      this.shape = OeFabShape.circle,
      this.size = OeFabSize.large,
      this.text,
      this.onClick,
      this.icon})
      : super(key: key);

  /// 主题
  final OeFabTheme theme;

  /// 形状
  final OeFabShape shape;

  /// 大小
  final OeFabSize size;

  /// 文本
  final String? text;

  /// 图标
  final Icon? icon;

  /// 点击事件
  final VoidCallback? onClick;

  bool get showText => text != null && text != '';

  EdgeInsets getPadding() {
    switch (size) {
      case OeFabSize.large:
        return showText
            ? const EdgeInsets.symmetric(horizontal: 20, vertical: 12)
            : const EdgeInsets.all(12);
      case OeFabSize.medium:
        return showText
            ? const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
            : const EdgeInsets.all(10);
      case OeFabSize.small:
        return showText
            ? const EdgeInsets.symmetric(horizontal: 12, vertical: 5)
            : const EdgeInsets.all(7);
      case OeFabSize.extraSmall:
        return showText
            ? const EdgeInsets.symmetric(horizontal: 8, vertical: 3)
            : const EdgeInsets.all(5);
      default:
        return showText
            ? const EdgeInsets.symmetric(horizontal: 20, vertical: 12)
            : const EdgeInsets.all(12);
    }
  }

  double getMinWidthOrHeight() {
    switch (size) {
      case OeFabSize.large:
        return 48.0;
      case OeFabSize.medium:
        return 40.0;
      case OeFabSize.small:
        return 32.0;
      case OeFabSize.extraSmall:
        return 28.0;
      default:
        return 48.0;
    }
  }

  Color getBackgroundColor(BuildContext context) {
    switch (theme) {
      case OeFabTheme.primary:
        return OeTheme.of(context).brandColor7;
      case OeFabTheme.defaultTheme:
        return OeTheme.of(context).grayColor3;
      case OeFabTheme.light:
        return OeTheme.of(context).brandColor1;
      case OeFabTheme.danger:
        return OeTheme.of(context).errorColor6;
      default:
        return OeTheme.of(context).grayColor3;
    }
  }

  Color getIconColor(BuildContext context) {
    switch (theme) {
      case OeFabTheme.primary:
        return Colors.white;
      case OeFabTheme.defaultTheme:
        return OeTheme.of(context).fontGyColor1.withOpacity(0.9);
      case OeFabTheme.light:
        return OeTheme.of(context).brandColor7;
      case OeFabTheme.danger:
        return Colors.white;
      default:
        return OeTheme.of(context).fontGyColor1.withOpacity(0.9);
    }
  }

  double getIconSize() {
    switch (size) {
      case OeFabSize.large:
        return 24.0;
      case OeFabSize.medium:
        return 20.0;
      case OeFabSize.small:
        return 18.0;
      case OeFabSize.extraSmall:
        return 18.0;
      default:
        return 24.0;
    }
  }

  double getFontSize() {
    switch (size) {
      case OeFabSize.large:
        return 16.0;
      case OeFabSize.medium:
        return 16.0;
      case OeFabSize.small:
        return 14.0;
      case OeFabSize.extraSmall:
        return 14.0;
      default:
        return 16.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onClick != null) {
          onClick!();
        }
      },
      child: InkWell(
        child: Container(
          padding: getPadding(),
          decoration: BoxDecoration(
              color: getBackgroundColor(context),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 5),
                    blurRadius: 2.5,
                    spreadRadius: -1.5,
                    color: Colors.black.withOpacity(0.1)),
                BoxShadow(
                    offset: const Offset(0, 8),
                    blurRadius: 5,
                    spreadRadius: 0.5,
                    color: Colors.black.withOpacity(0.06)),
                BoxShadow(
                    offset: const Offset(0, 3),
                    blurRadius: 7,
                    spreadRadius: 1,
                    color: Colors.black.withOpacity(0.05))
              ],
              borderRadius: shape == OeFabShape.circle
                  ? BorderRadius.circular(24)
                  : BorderRadius.circular(6)),
          height: getMinWidthOrHeight(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon ??
                  Icon(
                    OeIcons.add,
                    size: getIconSize(),
                    color: getIconColor(context),
                  ),
              Visibility(
                  visible: showText,
                  child: const SizedBox(
                    width: 4,
                  )),
              Visibility(
                  visible: showText,
                  child: OeText(
                    text ?? '',
                    style: TextStyle(
                        height: 1.5,
                        fontWeight: FontWeight.w600,
                        fontSize: getFontSize(),
                        color: getIconColor(context),
                        leadingDistribution: TextLeadingDistribution.even),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
