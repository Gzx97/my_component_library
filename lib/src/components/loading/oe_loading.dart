/*
 * Created by haozhicao@tencent.com on 6/29/22.
 * td_loading.dart
 * 
 */

import 'package:flutter/material.dart';

import '../../../../my_component_library.dart';
import 'oe_activity_indicator.dart';
import 'td_point_indicator.dart';

/// Loading 尺寸
enum OeLoadingSize {
  small,
  medium,
  large,
}

/// Loading的图标
enum OeLoadingIcon {
  circle,
  point,
  activity,
}

class OeLoading extends StatelessWidget {
  const OeLoading({
    Key? key,
    required this.size,
    this.icon = OeLoadingIcon.circle,
    this.iconColor,
    this.axis = Axis.vertical,
    this.text,
    this.refreshWidget,
    this.customIcon,
    this.textColor = Colors.black,
    this.duration = 2000,
  }) : super(key: key);

  /// 尺寸
  final OeLoadingSize size;

  /// 图标，支持圆形、点状、菊花状
  final OeLoadingIcon? icon;

  /// 图标颜色
  final Color? iconColor;

  /// 文案
  final String? text;

  /// 失败刷新组件
  final Widget? refreshWidget;

  /// 文案颜色
  final Color textColor;

  /// 文案和图标相对方向
  final Axis axis;

  /// 自定义图标，优先级高于icon
  final Widget? customIcon;

  /// 一次刷新的时间，控制动画速度
  final int duration;

  int get _innerDuration => duration > 0 ? duration : 1;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [_contentWidget()],
    );
  }

  Widget _contentWidget() {
    if (icon == null) {
      return textWidget();
    } else {
      Widget? indicator;
      if (customIcon != null) {
        indicator = customIcon!;
      } else {
        switch (icon!) {
          case OeLoadingIcon.activity:
            indicator = OeCupertinoActivityIndicator(
              activeColor: iconColor,
              radius: size == OeLoadingSize.small
                  ? 10
                  : (size == OeLoadingSize.medium ? 11 : 13),
              duration: _innerDuration,
            );
            break;
          case OeLoadingIcon.circle:
            indicator = _getCircleIndicator();
            break;
          case OeLoadingIcon.point:
            indicator = OePointBounceIndicator(
              color: iconColor,
              size: size == OeLoadingSize.small
                  ? 12
                  : (size == OeLoadingSize.medium ? 16 : 20),
              duration: _innerDuration,
            );
            break;
          default:
            indicator = _getCircleIndicator();
            break;
        }
      }

      if (text == null) {
        return indicator;
      } else if (axis == Axis.vertical) {
        return Column(mainAxisSize: MainAxisSize.min, children: [
          indicator,
          SizedBox(
            height: _getPaddingWidth(),
          ),
          textWidget(),
        ]);
      } else {
        return Row(mainAxisSize: MainAxisSize.min, children: [
          indicator,
          SizedBox(
            width: _getPaddingWidth(),
          ),
          textWidget()
        ]);
      }
    }
  }

  Widget _getCircleIndicator() {
    switch (size) {
      case OeLoadingSize.large:
        return OeCircleIndicator(
          color: iconColor,
          size: 24,
          lineWidth: 3 * 4 / 3, // 根据small等等比缩放
          duration: _innerDuration,
        );
      case OeLoadingSize.medium:
        return OeCircleIndicator(
          color: iconColor,
          size: 21,
          lineWidth: 3 * 7 / 6, // 根据small等等比缩放
          duration: _innerDuration,
        );
      case OeLoadingSize.small:
        return OeCircleIndicator(
          color: iconColor,
          size: 18, // 设计稿框位24，图形宽位19.5,推导lineWidth为3时，size位18
          lineWidth: 3,
          duration: _innerDuration,
        );
    }
  }

  double _getPaddingWidth() {
    switch (size) {
      case OeLoadingSize.large:
        return 10;
      case OeLoadingSize.medium:
        return 8;
      case OeLoadingSize.small:
        return 6;
    }
  }

  Font fitFont() {
    switch (size) {
      case OeLoadingSize.large:
        return OeTheme.of().fontBodyLarge ?? Font(size: 16, lineHeight: 24);
      case OeLoadingSize.medium:
        return OeTheme.of().fontBodyMedium ?? Font(size: 14, lineHeight: 22);
      case OeLoadingSize.small:
        return OeTheme.of().fontBodySmall ?? Font(size: 12, lineHeight: 20);
    }
  }

  Widget textWidget() {
    Widget result = OeText(
      text,
      textColor: textColor,
      fontWeight: FontWeight.w400,
      font: fitFont(),
      textAlign: TextAlign.center,
    );
    if (refreshWidget != null) {
      result = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          result,
          const SizedBox(
            width: 8,
          ),
          refreshWidget!,
        ],
      );
    }
    return result;
  }
}
