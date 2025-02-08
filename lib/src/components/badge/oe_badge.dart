import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../my_component_library.dart';
import '../../util/context_extension.dart';

enum OeBadgeType {
  /// 红点样式
  redPoint,

  /// 消息样式
  message,

  /// 气泡样式
  bubble,

  /// 方形样式
  square,

  /// 角标样式
  subscript
}

enum OeBadgeBorder {
  /// 大圆角 8px
  large,

  /// 小圆角 2px
  small
}

enum OeBadgeSize {
  /// 宽 20px
  large,

  /// 宽 16px
  small,
}

class OeBadge extends StatefulWidget {
  const OeBadge(this.type,
      {Key? key,
      this.count,
      this.border = OeBadgeBorder.large,
      this.size = OeBadgeSize.small,
      this.color,
      this.textColor,
      this.message,
      this.widthLarge = 32,
      this.widthSmall = 12,
      this.padding,
      this.showZero = true})
      : super(key: key);

  /// 红点数量
  final String? count;

  /// 红点样式
  final OeBadgeType type;

  /// 红点尺寸
  final OeBadgeSize size;

  /// 红点圆角大小
  final OeBadgeBorder border;

  /// 红点颜色
  final Color? color;

  /// 文字颜色
  final Color? textColor;

  /// 消息内容
  final String? message;

  /// 角标大三角形宽
  final double widthLarge;

  /// 角标小三角形宽
  final double widthSmall;

  /// 角标自定义padding
  final EdgeInsetsGeometry? padding;

  /// 值为0是否显示
  final bool showZero;

  @override
  State<StatefulWidget> createState() => _OeBadgeState();
}

class _OeBadgeState extends State<OeBadge> {
  String badgeNum = '';

  void updateBadgeNum(String? newCount) {
    if (newCount == null) {
      return;
    }
    setState(() {
      badgeNum = newCount;
    });
  }

  double getBadgeSize() {
    switch (widget.size) {
      case OeBadgeSize.large:
        return 20;
      case OeBadgeSize.small:
        return 16;
    }
  }

  Font? getBadgeFont(BuildContext context) {
    switch (widget.size) {
      case OeBadgeSize.large:
        return OeTheme.of(context).fontMarkSmall;
      case OeBadgeSize.small:
        return OeTheme.of(context).fontMarkExtraSmall;
    }
  }

  bool isVisible() {
    var value = getValue();
    try {
      return widget.showZero || double.parse(value) != 0;
    } catch (e) {
      return true;
    }
  }

  String getValue() {
    return ((widget.message ?? '').isNotEmpty
        ? widget.message
        : (widget.count ?? '').isNotEmpty
            ? widget.count
            : context.resource.badgeZero) as String;
  }

  @override
  Widget build(BuildContext context) {
    updateBadgeNum(widget.count);
    switch (widget.type) {
      case OeBadgeType.redPoint:
        return Container(
          alignment: Alignment.center,
          height: getBadgeSize() / 2,
          width: getBadgeSize() / 2,
          decoration: BoxDecoration(
              color: widget.color ?? OeTheme.of(context).errorColor6,
              borderRadius: BorderRadius.circular(getBadgeSize() / 4)),
        );
      case OeBadgeType.message:
        return Visibility(
            visible: isVisible(),
            child: badgeNum.length == 1
                ? Container(
                    height: getBadgeSize(),
                    width: getBadgeSize(),
                    decoration: BoxDecoration(
                      color: widget.color ?? OeTheme.of(context).errorColor6,
                      borderRadius: BorderRadius.circular(getBadgeSize() / 2),
                    ),
                    child: Center(
                      child: OeText(
                        widget.message ?? '$badgeNum',
                        forceVerticalCenter: true,
                        font: getBadgeFont(context),
                        fontWeight: FontWeight.w500,
                        textColor:
                            widget.textColor ?? OeTheme.of(context).whiteColor1,
                        textAlign: TextAlign.center,
                      ),
                    ))
                : Container(
                    height: getBadgeSize(),
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                      color: widget.color ?? OeTheme.of(context).errorColor6,
                      borderRadius: BorderRadius.circular(getBadgeSize() / 2),
                    ),
                    child: Center(
                      child: OeText(
                        widget.message ?? '$badgeNum',
                        forceVerticalCenter: true,
                        font: getBadgeFont(context),
                        fontWeight: FontWeight.w500,
                        textColor:
                            widget.textColor ?? OeTheme.of(context).whiteColor1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ));
      case OeBadgeType.subscript:
        return ClipPath(
          clipper: TrapezoidPath(widget.widthLarge, widget.widthSmall),
          child: Container(
            alignment: Alignment.topRight,
            color: widget.color ?? OeTheme.of(context).errorColor6,
            height: 32,
            width: 32,
            child: Transform.rotate(
                angle: pi / 4,
                child: Padding(
                  padding: widget.padding ??
                      const EdgeInsets.only(left: 4, bottom: 8),
                  child: OeText(
                    widget.message ?? '$badgeNum',
                    font: getBadgeFont(context),
                    fontWeight: FontWeight.w500,
                    textColor:
                        widget.textColor ?? OeTheme.of(context).whiteColor1,
                    textAlign: TextAlign.center,
                  ),
                )),
          ),
        );
      case OeBadgeType.bubble:
        return Visibility(
            visible: isVisible(),
            child: Container(
              height: 16,
              padding: const EdgeInsets.only(left: 4, right: 4),
              decoration: BoxDecoration(
                color: widget.color ?? OeTheme.of(context).errorColor6,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(1)),
              ),
              child: Center(
                child: OeText(
                  widget.message ?? '$badgeNum',
                  forceVerticalCenter: true,
                  font: getBadgeFont(context),
                  fontWeight: FontWeight.w500,
                  textColor:
                      widget.textColor ?? OeTheme.of(context).whiteColor1,
                  textAlign: TextAlign.center,
                ),
              ),
            ));
      case OeBadgeType.square:
        return Visibility(
            visible: isVisible(),
            child: Container(
              height: getBadgeSize(),
              width: getBadgeSize(),
              padding: const EdgeInsets.only(left: 5, right: 5),
              decoration: BoxDecoration(
                color: widget.color ?? OeTheme.of(context).errorColor6,
                borderRadius: widget.border == OeBadgeBorder.large
                    ? BorderRadius.circular(8)
                    : BorderRadius.circular(2),
              ),
              child: Center(
                child: OeText(
                  widget.message ?? '$badgeNum',
                  forceVerticalCenter: true,
                  font: getBadgeFont(context),
                  fontWeight: FontWeight.w500,
                  textColor:
                      widget.textColor ?? OeTheme.of(context).whiteColor1,
                  textAlign: TextAlign.center,
                ),
              ),
            ));
    }
  }
}

class TrapezoidPath extends CustomClipper<Path> {
  final double widthLarge;
  final double widthSmall;

  TrapezoidPath(this.widthLarge, this.widthSmall);

  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(widthLarge - widthSmall, 0);
    path.lineTo(widthLarge, widthSmall);
    path.lineTo(widthLarge, widthLarge);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
