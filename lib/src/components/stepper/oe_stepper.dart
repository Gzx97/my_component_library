import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../my_component_library.dart';

enum OeStepperSize { small, medium, large }

enum OeStepperTheme { normal, filled, outline }

enum OeStepperIconType { remove, add }

enum OeStepperOverlimitType { minus, plus }

typedef OeStepperOverlimitFunction = void Function(OeStepperOverlimitType type);

class OeStepper extends StatefulWidget {
  const OeStepper({
    Key? key,
    this.disableInput = false,
    this.disabled = false,
    this.inputWidth,
    this.max = 100,
    this.min = 0,
    this.size = OeStepperSize.medium,
    this.step = 1,
    this.theme = OeStepperTheme.normal,
    this.value = 0,
    this.defaultValue = 0,
    this.onBlur,
    this.onChange,
    this.onOverlimit,
  }) : super(key: key);

  /// 禁用输入框
  final bool disableInput;

  /// 禁用全部操作
  final bool disabled;

  /// 禁用全部操作
  final double? inputWidth;

  /// 最大值
  final int max;

  /// 最小值
  final int min;

  /// 组件尺寸
  final OeStepperSize size;

  /// 步长
  final int step;

  /// 组件风格
  final OeStepperTheme theme;

  /// 值
  final int? value;

  /// 默认值
  final int? defaultValue;

  /// 输入框失去焦点时触发
  final VoidCallback? onBlur;

  /// 数值发生变更时触发
  final ValueChanged<int>? onChange;

  /// 数值超出限制时触发
  final OeStepperOverlimitFunction? onOverlimit;

  @override
  State<OeStepper> createState() => _OeStepperState();
}

class _OeStepperState extends State<OeStepper> {
  late int value;
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    value = widget.value ?? widget.defaultValue ?? 0;
    _controller = TextEditingController(text: value.toString());
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        if (widget.onBlur != null) {
          widget.onBlur!();
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  double _getWidth() {
    if (widget.inputWidth != null && widget.inputWidth! > 0) {
      return widget.inputWidth!;
    }

    switch (widget.size) {
      case OeStepperSize.small:
        return 34;
      case OeStepperSize.medium:
        return 38;
      case OeStepperSize.large:
        return 45;
      default:
        return 38;
    }
  }

  double _getTextWidth() {
    var textLength = value.toString().length;
    return textLength < 4 ? 0 : (textLength - 4) * _getFontSize();
  }

  double _getHeight() {
    switch (widget.size) {
      case OeStepperSize.small:
        return 20;
      case OeStepperSize.medium:
        return 24;
      case OeStepperSize.large:
        return 28;
      default:
        return 24;
    }
  }

  Color? _getBackgroundColor(BuildContext context) {
    switch (widget.theme) {
      case OeStepperTheme.filled:
        return widget.disabled
            ? OeTheme.of(context).grayColor2
            : OeTheme.of(context).grayColor1;
      case OeStepperTheme.outline:
        return OeTheme.of(context).whiteColor1;
      case OeStepperTheme.normal:
      default:
        return null;
    }
  }

  double _getFontSize() {
    switch (widget.size) {
      case OeStepperSize.small:
        return 10;
      case OeStepperSize.medium:
        return 12;
      case OeStepperSize.large:
        return 16;
      default:
        return 12;
    }
  }

  void onAdd() {
    if (value >= widget.max) {
      return;
    }

    if (value + widget.step > widget.max) {
      setState(() {
        value = widget.max;
      });

      if (widget.onOverlimit != null) {
        widget.onOverlimit!(OeStepperOverlimitType.plus);
      }

      renderNumber();
      return;
    }

    setState(() {
      value += widget.step;
    });

    renderNumber();
  }

  void onReduce() {
    if (value <= widget.min) {
      return;
    }

    if (value - widget.step < widget.min) {
      setState(() {
        value = widget.min;
      });

      if (widget.onOverlimit != null) {
        widget.onOverlimit!(OeStepperOverlimitType.minus);
      }

      renderNumber();
      return;
    }

    setState(() {
      value -= widget.step;
    });
    renderNumber();
  }

  void renderNumber() {
    _controller.value = TextEditingValue(
        text: value.toString(),
        selection: TextSelection.fromPosition(TextPosition(
          affinity: TextAffinity.downstream,
          offset: value.toString().length,
        )));
    _focusNode.unfocus();

    if (widget.onChange != null) {
      widget.onChange!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OeStepperIconButton(
          type: OeStepperIconType.remove,
          disabled: widget.disabled || value <= widget.min,
          theme: widget.theme,
          size: widget.size,
          onTap: onReduce,
        ),
        Container(
          decoration: BoxDecoration(
              border: widget.theme == OeStepperTheme.outline
                  ? Border(
                      top: BorderSide(
                        color: OeTheme.of(context).grayColor4,
                      ),
                      bottom: BorderSide(
                        color: OeTheme.of(context).grayColor4,
                      ))
                  : null),
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: widget.theme == OeStepperTheme.normal ? 0 : 4),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: _getWidth(),
                    maxWidth: _getWidth() + _getTextWidth()),
                child: Container(
                  height: _getHeight(),
                  alignment: Alignment.center,
                  decoration:
                      BoxDecoration(color: _getBackgroundColor(context)),
                  child: Container(
                    height: PlatformUtil.isWeb ? _getFontSize() : null,
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: TextField(
                      controller: _controller,
                      enabled: !widget.disabled && !widget.disableInput,
                      focusNode: _focusNode,
                      style: TextStyle(
                          fontSize: _getFontSize(),
                          color: widget.disabled
                              ? OeTheme.of(context).fontGyColor4
                              : OeTheme.of(context).fontGyColor1),
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          try {
                            if (newValue.text == '') {
                              setState(() {
                                value = widget.min;
                              });

                              if (widget.onOverlimit != null) {
                                widget
                                    .onOverlimit!(OeStepperOverlimitType.minus);
                              }

                              return newValue.copyWith(
                                  text: value.toString(),
                                  selection: TextSelection.collapsed(
                                      offset: value.toString().length));
                            }

                            final newNum = int.parse(newValue.text);
                            if (newNum < widget.min) {
                              setState(() {
                                value = widget.min;
                              });
                              if (widget.onOverlimit != null) {
                                widget
                                    .onOverlimit!(OeStepperOverlimitType.minus);
                              }
                            } else if (newNum > widget.max) {
                              setState(() {
                                value = widget.max;
                              });
                              if (widget.onOverlimit != null) {
                                widget
                                    .onOverlimit!(OeStepperOverlimitType.plus);
                              }
                            } else {
                              setState(() {
                                value = newNum;
                              });
                            }

                            return newValue.copyWith(
                                text: value.toString(),
                                selection: TextSelection.collapsed(
                                    offset: value.toString().length));
                          } catch (e) {
                            return oldValue;
                          }
                        })
                      ],
                      onChanged: (newValue) {
                        final result = int.parse(newValue);
                        if (widget.onChange != null) {
                          widget.onChange!(result);
                        }
                      },
                    ),
                  ),
                ),
              )),
        ),
        OeStepperIconButton(
          type: OeStepperIconType.add,
          disabled: widget.disabled || value >= widget.max,
          theme: widget.theme,
          size: widget.size,
          onTap: onAdd,
        )
      ],
    );
  }
}

typedef OeTapFunction = void Function();

class OeStepperIconButton extends StatelessWidget {
  const OeStepperIconButton(
      {Key? key,
      this.onTap,
      this.size = OeStepperSize.medium,
      this.disabled = false,
      this.theme = OeStepperTheme.normal,
      required this.type})
      : super(key: key);

  final OeTapFunction? onTap;
  final OeStepperSize size;
  final OeStepperIconType type;
  final bool disabled;
  final OeStepperTheme theme;

  double _getIconSize() {
    switch (size) {
      case OeStepperSize.large:
        return 20;
      case OeStepperSize.medium:
        return 16;
      case OeStepperSize.small:
        return 12;
      default:
        return 16;
    }
  }

  Icon _getIcon(context) {
    var iconType = type == OeStepperIconType.add ? Icons.add : Icons.remove;

    return Icon(iconType,
        size: _getIconSize(),
        color: disabled
            ? OeTheme.of(context).fontGyColor4
            : OeTheme.of(context).fontGyColor1);
  }

  Color? _getBackgroundColor(BuildContext context) {
    switch (theme) {
      case OeStepperTheme.filled:
        return disabled
            ? OeTheme.of(context).grayColor2
            : OeTheme.of(context).grayColor1;
      case OeStepperTheme.outline:
        return disabled ? OeTheme.of(context).grayColor2 : null;
      case OeStepperTheme.normal:
      default:
        return null;
    }
  }

  BorderRadiusGeometry? _getBorderRadius(BuildContext context) {
    if (theme == OeStepperTheme.normal) {
      return null;
    }

    return type == OeStepperIconType.remove
        ? const BorderRadius.only(
            topLeft: Radius.circular(3), bottomLeft: Radius.circular(3))
        : const BorderRadius.only(
            topRight: Radius.circular(3), bottomRight: Radius.circular(3));
  }

  BoxBorder? _getBoxBorder(BuildContext context) {
    if (theme == OeStepperTheme.outline) {
      return Border.all(
        color: OeTheme.of(context).grayColor4,
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: disabled ? null : onTap,
        child: Container(
          decoration: BoxDecoration(
            color: _getBackgroundColor(context),
            borderRadius: _getBorderRadius(context),
            border: _getBoxBorder(context),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: _getIcon(context),
          ),
        ));
  }
}
