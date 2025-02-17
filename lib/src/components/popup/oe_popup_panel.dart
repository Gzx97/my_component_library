import 'package:flutter/material.dart';

import '../../../my_component_library.dart';
import '../../util/context_extension.dart';

typedef PopupClick = Function();

/// 右上角带关闭的底部浮层面板
class OePopupBottomDisplayPanel extends StatelessWidget {
  const OePopupBottomDisplayPanel({
    required this.child,
    this.title,
    this.titleColor,
    this.titleLeft = false,
    this.hideClose = false,
    this.closeColor,
    this.closeClick,
    this.backgroundColor,
    this.radius,
    Key? key,
  }) : super(key: key);

  /// 子控件
  final Widget child;

  /// 标题
  final String? title;

  /// 标题颜色
  final Color? titleColor;

  /// 标题是否靠左
  final bool titleLeft;

  /// 是否隐藏关闭按钮
  final bool hideClose;

  /// 关闭按钮颜色
  final Color? closeColor;

  /// 关闭按钮点击回调
  final PopupClick? closeClick;

  /// 背景颜色
  final Color? backgroundColor;

  /// 圆角
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor ?? OeTheme.of(context).whiteColor1,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius ?? 12),
              topRight: Radius.circular(radius ?? 12))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [_buildTop(context), child],
      ),
    );
  }

  Widget _buildTop(BuildContext context) {
    Widget result = Container(
      alignment: titleLeft ? Alignment.centerLeft : Alignment.center,
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: OeText(
        title ?? '',
        textColor: titleColor ?? OeTheme.of(context).fontGyColor1,
        font: OeTheme.of(context).fontTitleLarge,
        fontWeight: FontWeight.w700,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
    if (!hideClose) {
      result = Stack(
        alignment: Alignment.centerLeft,
        children: [
          Padding(
              padding: EdgeInsets.only(right: 40, left: titleLeft ? 0 : 40),
              child: result),
          Positioned(
            right: 0,
            child: GestureDetector(
              child: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 16),
                child: Icon(
                  OeIcons.close,
                  color: closeColor,
                  size: 24,
                ),
              ),
              onTap: closeClick,
            ),
          ),
        ],
      );
    }
    return SizedBox(
      height: 58,
      child: result,
    );
  }
}

/// 带确认的底部浮层面板
class OePopupBottomConfirmPanel extends StatelessWidget {
  const OePopupBottomConfirmPanel({
    required this.child,
    this.title,
    this.titleColor,
    this.leftText,
    this.leftTextColor,
    this.leftClick,
    this.rightText,
    this.rightTextColor,
    this.rightClick,
    this.backgroundColor,
    this.radius,
    Key? key,
  }) : super(key: key);

  /// 子控件
  final Widget child;

  /// 标题
  final String? title;

  /// 标题颜色
  final Color? titleColor;

  /// 左边文本
  final String? leftText;

  /// 左边文本颜色
  final Color? leftTextColor;

  /// 左边文本点击回调
  final PopupClick? leftClick;

  /// 右边文本
  final String? rightText;

  /// 右边文本颜色
  final Color? rightTextColor;

  /// 右边文本点击回调
  final PopupClick? rightClick;

  /// 背景颜色
  final Color? backgroundColor;

  /// 圆角
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor ?? OeTheme.of(context).whiteColor1,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius ?? 12),
              topRight: Radius.circular(radius ?? 12))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [_buildTop(context), child],
      ),
    );
  }

  Widget _buildTop(BuildContext context) {
    return SizedBox(
      height: 58,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: OeText(
                leftText ?? context.resource.cancel,
                textColor: leftTextColor ?? OeTheme.of(context).fontGyColor2,
                font: OeTheme.of(context).fontBodyLarge,
                fontWeight: FontWeight.w400,
              ),
            ),
            onTap: leftClick,
          ),
          Expanded(
              child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: OeText(
              title ?? '',
              textColor: titleColor ?? OeTheme.of(context).fontGyColor1,
              font: OeTheme.of(context).fontTitleLarge,
              fontWeight: FontWeight.w700,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: OeText(
                rightText ?? context.resource.confirm,
                textColor:
                    rightTextColor ?? OeTheme.of(context).brandNormalColor,
                font: OeTheme.of(context).fontTitleMedium,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: rightClick,
          ),
        ],
      ),
    );
  }
}

/// 居中浮层面板
class OePopupCenterPanel extends StatelessWidget {
  const OePopupCenterPanel({
    required this.child,
    this.closeUnderBottom = false,
    this.closeColor,
    this.closeClick,
    this.backgroundColor,
    this.radius,
    Key? key,
  }) : super(key: key);

  /// 子控件
  final Widget child;

  /// 关闭按钮是否在视图框下方
  final bool closeUnderBottom;

  /// 关闭按钮颜色
  final Color? closeColor;

  /// 关闭按钮点击回调
  final PopupClick? closeClick;

  /// 背景颜色
  final Color? backgroundColor;

  /// 圆角
  final double? radius;

  @override
  Widget build(BuildContext context) {
    if (closeUnderBottom) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: OeTheme.of(context).spacer40,
          ),
          Container(
            margin: EdgeInsets.only(
                top: OeTheme.of(context).spacer24,
                bottom: OeTheme.of(context).spacer24),
            decoration: BoxDecoration(
                color: backgroundColor ?? OeTheme.of(context).whiteColor1,
                borderRadius: BorderRadius.all(Radius.circular(radius ?? 12))),
            child: child,
          ),
          GestureDetector(
            child: Icon(
              OeIcons.close_circle,
              color: closeColor ?? OeTheme.of(context).fontWhColor1,
              size: OeTheme.of(context).spacer40,
            ),
            onTap: closeClick,
          )
        ],
      );
    } else {
      return Container(
        decoration: BoxDecoration(
            color: backgroundColor ?? OeTheme.of(context).whiteColor1,
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 12))),
        child: Stack(
          children: [
            child,
            closeUnderBottom
                ? Container()
                : Positioned(
                    top: OeTheme.of(context).spacer16,
                    right: OeTheme.of(context).spacer16,
                    child: GestureDetector(
                      child: Icon(
                        OeIcons.close,
                        color: closeColor,
                        size: 24,
                      ),
                      onTap: closeClick,
                    ))
          ],
        ),
      );
    }
  }
}
