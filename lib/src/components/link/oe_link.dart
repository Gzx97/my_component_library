import 'package:flutter/material.dart';

import '../../../my_component_library.dart';

/// 限制Function类型，防止传递错误的Function，导致参数对不上
typedef LinkClick = Function(Uri? uri);

enum OeLinkType {
  basic,
  withUnderline,
  withPrefixIcon,
  withSuffixIcon,
}

enum OeLinkStyle {
  primary,
  defaultStyle,
  danger,
  warning,
  success,
}

enum OeLinkState {
  normal,
  active,
  disabled,
}

enum OeLinkSize {
  small,
  medium,
  large,
}

class OeLink extends StatelessWidget {
  const OeLink({
    Key? key,
    required this.label,
    this.uri,
    this.prefixIcon,
    this.suffixIcon,
    this.linkClick,
    this.type = OeLinkType.basic,
    this.style = OeLinkStyle.defaultStyle,
    this.state = OeLinkState.normal,
    this.size = OeLinkSize.medium,
    this.color,
    this.iconSize,
    this.fontSize,
    this.leftGapWithIcon,
    this.rightGapWithIcon,
  }) : super(key: key);

  /// link 展示的文本
  final String label;

  /// link 跳转的uri
  final Uri? uri;

  /// link 类型
  final OeLinkType type;

  /// link 风格
  final OeLinkStyle style;

  /// link 状态
  final OeLinkState state;

  /// link 大小
  final OeLinkSize size;

  /// 前置 icon
  final Icon? prefixIcon;

  /// 后置 icon
  final Icon? suffixIcon;

  /// link 文本的颜色，如果不设置则根据状态和风格进行计算
  final Color? color;

  /// link icon 大小，如果不设置则根据状态和风格进行计算
  final double? iconSize;

  /// link 文本的字体大小，如果不设置则根据状态和风格进行计算
  final double? fontSize;

  /// 前置icon和文本之间的间隔，如果不设置则根据状态和风格进行计算
  final double? leftGapWithIcon;

  /// 后置icon和文本之间的间隔，如果不设置则根据状态和风格进行计算
  final double? rightGapWithIcon;

  /// link 被点击之后所采取的动作，会将uri当做参数传入到该方法当中
  final LinkClick? linkClick;

  @override
  Widget build(BuildContext context) {
    if (type == OeLinkType.withPrefixIcon) {
      return Row(children: [
        prefixIcon == null ? _getDefaultIcon(context) : prefixIcon!,
        SizedBox(
          width: _getLeftGapSize(context),
        ),
        _buildLink(context),
      ]);
    } else if (type == OeLinkType.withSuffixIcon) {
      return Row(children: [
        _buildLink(context),
        SizedBox(
          width: _getRightGapSize(context),
        ),
        suffixIcon == null ? _getDefaultIcon(context) : suffixIcon!,
      ]);
    }

    return _buildLink(context);
  }

  /// 提取成方法，允许业务定义自己的OeLinkConfiguration
  OeLinkConfiguration? getConfiguration(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<OeLinkConfiguration>();
  }

  Color getColor(BuildContext context) {
    if (color != null) {
      return color!;
    }
    // to refactor: use map instead of multi level switch
    switch (state) {
      case OeLinkState.normal:
        switch (style) {
          case OeLinkStyle.primary:
            return OeTheme.of(context).brandNormalColor;
          case OeLinkStyle.danger:
            return OeTheme.of(context).errorColor6;
          case OeLinkStyle.warning:
            return OeTheme.of(context).warningColor5;
          case OeLinkStyle.success:
            return OeTheme.of(context).successColor5;
          case OeLinkStyle.defaultStyle:
            return OeTheme.of(context).fontGyColor1;
        }

      case OeLinkState.active:
        switch (style) {
          case OeLinkStyle.primary:
            return OeTheme.of(context).brandClickColor;
          case OeLinkStyle.danger:
            return OeTheme.of(context).errorColor7;
          case OeLinkStyle.warning:
            return OeTheme.of(context).warningColor6;
          case OeLinkStyle.success:
            return OeTheme.of(context).successColor6;
          case OeLinkStyle.defaultStyle:
            return OeTheme.of(context).brandClickColor;
        }
      case OeLinkState.disabled:
        switch (style) {
          case OeLinkStyle.primary:
            return OeTheme.of(context).brandDisabledColor;
          case OeLinkStyle.danger:
            return OeTheme.of(context).errorDisabledColor;
          case OeLinkStyle.warning:
            return OeTheme.of(context).warningDisabledColor;
          case OeLinkStyle.success:
            return OeTheme.of(context).successDisabledColor;
          case OeLinkStyle.defaultStyle:
            return OeTheme.of(context).fontGyColor4;
        }
    }
  }

  Widget _getDefaultIcon(BuildContext context) {
    return Icon(
      type == OeLinkType.withPrefixIcon ? OeIcons.link : OeIcons.jump,
      size: _getIconSize(context),
      color: getColor(context),
    );
  }

  Widget _buildLink(BuildContext context) {
    return InkWell(
        onTap: () {
          if (state == OeLinkState.disabled) {
            return;
          }
          if (linkClick != null) {
            linkClick!(uri);
          } else {
            var tdLinkConfig = getConfiguration(context);

            if (tdLinkConfig != null && tdLinkConfig.linkClick != null) {
              tdLinkConfig.linkClick!(uri);
            }
          }
        },
        child: OeText(
          label,
          style: TextStyle(
            fontSize: _getFontSize(context),
            color: getColor(context),
            decoration: type == OeLinkType.withUnderline
                ? TextDecoration.underline
                : null,
            decorationColor: getColor(context),
          ),
          forceVerticalCenter: true,
        ));
  }

  double _getIconSize(BuildContext context) {
    if (iconSize != null) {
      return iconSize!;
    }
    switch (size) {
      case OeLinkSize.large:
        return 18;
      case OeLinkSize.small:
        return 14;
      case OeLinkSize.medium:
        return 16;
    }
  }

  double _getFontSize(BuildContext context) {
    if (fontSize != null) {
      return fontSize!;
    }
    switch (size) {
      case OeLinkSize.large:
        return 16;
      case OeLinkSize.small:
        return 12;
      case OeLinkSize.medium:
        return 14;
    }
  }

  double _getLeftGapSize(BuildContext context) {
    if (leftGapWithIcon != null) {
      return leftGapWithIcon!;
    }
    switch (size) {
      case OeLinkSize.large:
        return 14.64;
      case OeLinkSize.small:
        return 6.05;
      case OeLinkSize.medium:
        return 6.34;
    }
  }

  double _getRightGapSize(BuildContext context) {
    if (rightGapWithIcon != null) {
      return rightGapWithIcon!;
    }
    switch (size) {
      case OeLinkSize.large:
        return 15.37;
      case OeLinkSize.small:
        return 6.63;
      case OeLinkSize.medium:
        return 7;
    }
  }
}

/// 存储可以自定义OeLink跳转算法的控件
class OeLinkConfiguration extends InheritedWidget {
  /// 统一跳转的函数
  final LinkClick? linkClick;

  const OeLinkConfiguration({this.linkClick, Key? key, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant OeLinkConfiguration oldWidget) {
    return linkClick != oldWidget.linkClick;
  }
}
