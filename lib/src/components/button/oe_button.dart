import 'package:flutter/material.dart';

import '../../../my_component_library.dart';

enum OeButtonSize { large, medium, small, extraSmall }

enum OeButtonType { fill, outline, text, ghost }

enum OeButtonShape { rectangle, round, square, circle, filled }

enum OeButtonTheme { defaultTheme, primary, danger, light }

enum OeButtonStatus { defaultState, active, disable }

typedef OeButtonEvent = void Function();

/// Oe常规按钮
class OeButton extends StatefulWidget {
  const OeButton(
      {Key? key,
      this.text,
      this.size = OeButtonSize.medium,
      this.type = OeButtonType.fill,
      this.shape = OeButtonShape.rectangle,
      this.theme,
      this.child,
      this.disabled = false,
      this.isBlock = false,
      this.style,
      this.activeStyle,
      this.disableStyle,
      this.textStyle,
      this.disableTextStyle,
      this.width,
      this.height,
      this.onTap,
      this.icon,
      this.iconWidget,
      this.iconTextSpacing,
      this.onLongPress,
      this.margin,
      this.padding})
      : super(key: key);

  /// 自控件
  final Widget? child;

  /// 文本内容
  final String? text;

  /// 禁止点击
  final bool disabled;

  /// 自定义宽度
  final double? width;

  /// 自定义高度
  final double? height;

  /// 尺寸
  final OeButtonSize size;

  /// 类型：填充，描边，文字
  final OeButtonType type;

  /// 形状：圆角，胶囊，方形，圆形，填充
  final OeButtonShape shape;

  /// 主题
  final OeButtonTheme? theme;

  /// 自定义样式，有则优先用它，没有则根据type和theme选取.如果设置了style,则activeStyle和disableStyle也应该设置
  final OeButtonStyle? style;

  /// 自定义点击样式，有则优先用它，没有则根据type和theme选取
  final OeButtonStyle? activeStyle;

  /// 自定义禁用样式，有则优先用它，没有则根据type和theme选取
  final OeButtonStyle? disableStyle;

  /// 自定义可点击状态文本样式
  final TextStyle? textStyle;

  /// 自定义不可点击状态文本样式
  final TextStyle? disableTextStyle;

  /// 点击事件
  final OeButtonEvent? onTap;

  /// 长按事件
  final OeButtonEvent? onLongPress;

  /// 图标icon
  final IconData? icon;

  /// 自定义图标icon控件
  final Widget? iconWidget;

  /// 自定义图标与文本之间距离
  final double? iconTextSpacing;

  /// 自定义padding
  final EdgeInsetsGeometry? padding;

  /// 自定义margin
  final EdgeInsetsGeometry? margin;

  /// 是否为通栏按钮
  final bool isBlock;

  @override
  State<StatefulWidget> createState() => _OeButtonState();
}

class _OeButtonState extends State<OeButton> {
  OeButtonStatus _buttonStatus = OeButtonStatus.defaultState;
  OeButtonStyle? _innerDefaultStyle;
  OeButtonStyle? _innerActiveStyle;
  OeButtonStyle? _innerDisableStyle;
  double? _width;
  double? _height;
  EdgeInsetsGeometry? _margin;
  Alignment? _alignment;
  TextStyle? _textStyle;
  double? _iconSize;

  _updateParams() async {
    _buttonStatus =
        widget.disabled ? OeButtonStatus.disable : OeButtonStatus.defaultState;
    _innerDefaultStyle = widget.style;
    _innerActiveStyle = widget.activeStyle;
    _innerDisableStyle = widget.disableStyle;
    _width = _getWidth();
    _height = _getHeight();
    _margin = _getMargin();
    _alignment = widget.shape == OeButtonShape.filled || widget.isBlock
        ? Alignment.center
        : null;
    if (widget.text != null) {
      _textStyle = widget.disabled ? widget.disableTextStyle : widget.textStyle;
    }
    if (widget.icon != null) {
      _iconSize = _getIconSize();
    }
  }

  OeButtonStyle get style {
    switch (_buttonStatus) {
      case OeButtonStatus.defaultState:
        return _defaultStyle;
      case OeButtonStatus.active:
        return _activeStyle;
      case OeButtonStatus.disable:
        return _disableStyle;
    }
  }

  @override
  void initState() {
    super.initState();
    _updateParams();
  }

  @override
  Widget build(BuildContext context) {
    Widget display = Container(
      width: _width,
      height: _height,
      alignment: _alignment,
      padding: _getPadding(),
      margin: _margin,
      decoration: BoxDecoration(
        color: style.backgroundColor,
        border: _getBorder(context),
        borderRadius: style.radius ?? BorderRadius.all(_getRadius()),
      ),
      child: widget.child ?? _getChild(),
    );

    if (widget.disabled) {
      return display;
    }
    return GestureDetector(
      child: display,
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      onTapDown: (TapDownDetails details) {
        if (widget.disabled) {
          return;
        }
        setState(() {
          _buttonStatus = OeButtonStatus.active;
        });
      },
      onTapUp: (TapUpDetails details) {
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted && !widget.disabled) {
            setState(() {
              _buttonStatus = OeButtonStatus.defaultState;
            });
          }
        });
      },
      onTapCancel: () {
        if (widget.disabled) {
          return;
        }
        setState(() {
          _buttonStatus = OeButtonStatus.defaultState;
        });
      },
    );
  }

  Border? _getBorder(BuildContext context) {
    if (style.frameWidth != null && style.frameWidth != 0) {
      return Border.all(
        color: style.frameColor ?? OeTheme.of(context).grayColor3,
        width: style.frameWidth!,
      );
    }
    return null;
  }

  Widget _getChild() {
    var icon = getIcon();
    if (widget.text == null && icon == null) {
      return Container();
    }
    var children = <Widget>[];
    // 系统Icon会导致不居中，因此自绘icon指定height
    if (icon != null) {
      children.add(icon);
    }
    if (widget.text != null) {
      var text = OeText(
        widget.text!,
        font: _getTextFont(),
        textColor: style.textColor ?? OeTheme.of(context).fontGyColor1,
        style: _textStyle,
        forceVerticalCenter: true,
      );
      children.add(text);
    }

    if (children.length == 2) {
      children.insert(
        1,
        SizedBox(
          width: widget.iconTextSpacing ?? 8,
        ),
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  Widget? getIcon() {
    if (widget.iconWidget != null) {
      return widget.iconWidget;
    }
    if (widget.icon != null) {
      return RichText(
        overflow: TextOverflow.visible,
        text: TextSpan(
          text: String.fromCharCode(widget.icon!.codePoint),
          style: TextStyle(
            inherit: false,
            color: style.textColor,
            height: 1,
            fontSize: _iconSize,
            fontFamily: widget.icon!.fontFamily,
            package: widget.icon!.fontPackage,
          ),
        ),
      );
    }
    return null;
  }

  Font _getTextFont() {
    switch (widget.size) {
      case OeButtonSize.large:
        return OeTheme.of(context).fontMarkLarge ??
            Font(size: 16, lineHeight: 24);
      case OeButtonSize.medium:
        return OeTheme.of(context).fontMarkLarge ??
            Font(size: 16, lineHeight: 24);
      case OeButtonSize.small:
        return OeTheme.of(context).fontMarkMedium ??
            Font(size: 14, lineHeight: 22);
      case OeButtonSize.extraSmall:
        return OeTheme.of(context).fontMarkMedium ??
            Font(size: 14, lineHeight: 22);
    }
  }

  double? _getWidth() {
    if (widget.width != null) {
      return widget.width;
    }
    if (!widget.isBlock &&
        (widget.shape == OeButtonShape.square ||
            widget.shape == OeButtonShape.circle)) {
      switch (widget.size) {
        case OeButtonSize.large:
          return 48;
        case OeButtonSize.medium:
          return 40;
        case OeButtonSize.small:
          return 32;
        case OeButtonSize.extraSmall:
          return 28;
      }
    }
    return null;
  }

  double _getHeight() {
    if (widget.height != null) {
      return widget.height!;
    }
    switch (widget.size) {
      case OeButtonSize.large:
        return 48;
      case OeButtonSize.medium:
        return 40;
      case OeButtonSize.small:
        return 32;
      case OeButtonSize.extraSmall:
        return 28;
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case OeButtonSize.large:
        return 24;
      case OeButtonSize.medium:
        return 20;
      case OeButtonSize.small:
        return 18;
      case OeButtonSize.extraSmall:
        return 14;
    }
  }

  EdgeInsetsGeometry? _getMargin() {
    if (widget.margin != null) {
      return widget.margin;
    }
    return widget.isBlock ? const EdgeInsets.only(left: 16, right: 16) : null;
  }

  EdgeInsetsGeometry? _getPadding() {
    if (widget.padding != null) {
      return widget.padding;
    }
    var equalSide = widget.shape == OeButtonShape.square ||
        widget.shape == OeButtonShape.circle;

    double horizontalPadding;
    double verticalPadding;
    switch (widget.size) {
      case OeButtonSize.large:
        horizontalPadding = equalSide ? 12 : 20;
        verticalPadding = 12;
        break;
      case OeButtonSize.medium:
        horizontalPadding = equalSide ? 10 : 16;
        verticalPadding = equalSide ? 10 : 8;
        break;
      case OeButtonSize.small:
        horizontalPadding = equalSide ? 7 : 12;
        verticalPadding = equalSide ? 7 : 5;
        break;
      case OeButtonSize.extraSmall:
        horizontalPadding = equalSide ? 5 : 8;
        verticalPadding = equalSide ? 5 : 3;
        break;
    }
    if (style.frameWidth != null && style.frameWidth != 0) {
      horizontalPadding = horizontalPadding - style.frameWidth!;
      verticalPadding = verticalPadding - style.frameWidth!;
      if (horizontalPadding < 0) {
        horizontalPadding = 0;
      }
      if (verticalPadding < 0) {
        verticalPadding = 0;
      }
    }
    return EdgeInsets.only(
        left: horizontalPadding,
        right: horizontalPadding,
        bottom: verticalPadding,
        top: verticalPadding);
  }

  @override
  void didUpdateWidget(covariant OeButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateParams();
  }

  OeButtonStyle _generateInnerStyle() {
    switch (widget.type) {
      case OeButtonType.fill:
        return OeButtonStyle.generateFillStyleByTheme(
            context, widget.theme, _buttonStatus);
      case OeButtonType.outline:
        return OeButtonStyle.generateOutlineStyleByTheme(
            context, widget.theme, _buttonStatus);
      case OeButtonType.text:
        return OeButtonStyle.generateTextStyleByTheme(
            context, widget.theme, _buttonStatus);
      case OeButtonType.ghost:
        return OeButtonStyle.generateGhostStyleByTheme(
            context, widget.theme, _buttonStatus);
    }
  }

  Radius _getRadius() {
    switch (widget.shape) {
      case OeButtonShape.rectangle:
      case OeButtonShape.square:
        return Radius.circular(OeTheme.of(context).radiusDefault);
      case OeButtonShape.round:
      case OeButtonShape.circle:
        return Radius.circular(OeTheme.of(context).radiusRound);
      case OeButtonShape.filled:
        return Radius.zero;
    }
  }

  OeButtonStyle get _defaultStyle {
    if (_innerDefaultStyle != null) {
      return _innerDefaultStyle!;
    }
    _innerDefaultStyle = widget.style ?? _generateInnerStyle();
    return _innerDefaultStyle!;
  }

  OeButtonStyle get _activeStyle {
    if (_innerActiveStyle != null) {
      return _innerActiveStyle!;
    }
    _innerActiveStyle = widget.style ?? _generateInnerStyle();
    return _innerActiveStyle!;
  }

  OeButtonStyle get _disableStyle {
    if (_innerDisableStyle != null) {
      return _innerDisableStyle!;
    }
    _innerDisableStyle = widget.style ?? _generateInnerStyle();
    return _innerDisableStyle!;
  }
}
