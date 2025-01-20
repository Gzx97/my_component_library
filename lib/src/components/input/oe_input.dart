import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum OeInputType { normal, password, number }

enum OeInputSize { large, medium, small }

enum OeInputSpacer {
  small,
  medium,
  large,
}

class OeCardStyle {
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final double? borderWidth;

  const OeCardStyle({
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
  });
}

typedef TapRegionCallback = void Function();

class OeInput extends StatefulWidget {
  final Key? key;
  final double? width;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Decoration? decoration;
  final Widget? leftIcon;
  final String? leftLabel;
  final TextStyle? leftLabelStyle;
  final double? leftLabelSpace;
  final bool? required;
  final bool readOnly;
  final bool autofocus;
  final bool obscureText;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final String? hintText;
  final TextInputType? inputType;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final InputDecoration? inputDecoration;
  final int maxLines;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final Color? cursorColor;
  final Widget? rightBtn;
  final TextStyle? hintTextStyle;
  final GestureTapCallback? onBtnTap;
  final Widget? labelWidget;
  final Color? textInputBackgroundColor;
  final EdgeInsetsGeometry? contentPadding;
  final OeInputType type;
  final OeInputSize size;
  final double? leftInfoWidth;
  final int? maxLength;
  final String? additionInfo;
  final Color? additionInfoColor;
  final TextAlign? textAlign;
  final double? clearIconSize;
  final GestureTapCallback? onClearTap;
  final bool needClear;
  final Color? clearBtnColor;
  final TextAlign contentAlignment;
  final Widget? rightWidget;
  final bool showBottomDivider;
  final OeCardStyle? cardStyle;
  final String? cardStyleTopText;
  final TextInputAction? inputAction;
  final OeInputSpacer? spacer;
  final String? cardStyleBottomText;
  final TapRegionCallback? onTapOutside;

  const OeInput({
    this.key,
    this.width,
    this.textStyle,
    this.backgroundColor,
    this.decoration,
    this.leftIcon,
    this.leftLabel,
    this.leftLabelStyle,
    this.leftLabelSpace,
    this.required,
    this.readOnly = false,
    this.autofocus = false,
    this.obscureText = false,
    this.onEditingComplete,
    this.onSubmitted,
    this.hintText,
    this.inputType,
    this.onChanged,
    this.inputFormatters,
    this.inputDecoration,
    this.maxLines = 1,
    this.focusNode,
    this.controller,
    this.cursorColor,
    this.rightBtn,
    this.hintTextStyle,
    this.onBtnTap,
    this.labelWidget,
    this.textInputBackgroundColor,
    this.contentPadding,
    this.type = OeInputType.normal,
    this.size = OeInputSize.large,
    this.leftInfoWidth,
    this.maxLength = 500,
    this.additionInfo = '',
    this.additionInfoColor,
    this.textAlign,
    this.clearIconSize,
    this.onClearTap,
    this.needClear = true,
    this.clearBtnColor,
    this.contentAlignment = TextAlign.start,
    this.rightWidget,
    this.showBottomDivider = true,
    this.cardStyle,
    this.cardStyleTopText,
    this.inputAction,
    this.spacer,
    this.cardStyleBottomText,
    this.onTapOutside,
  });

  @override
  _OeInputState createState() => _OeInputState();
}

class _OeInputState extends State<OeInput> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    if (widget.autofocus) {
      _focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 处理输入框样式
    InputDecoration effectiveDecoration = widget.inputDecoration ??
        InputDecoration(
          hintText: widget.hintText,
          hintStyle: widget.hintTextStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        );

    // 处理清除按钮
    Widget? clearButton;
    if (widget.needClear && widget.controller?.text.isNotEmpty == true) {
      clearButton = IconButton(
        icon: Icon(
          Icons.clear,
          size: widget.clearIconSize ?? 20.0,
          color: widget.clearBtnColor ?? Colors.grey,
        ),
        onPressed: widget.onClearTap,
      );
    }

    // 处理右侧按钮或组件
    Widget? rightWidget = widget.rightBtn ?? widget.rightWidget;
    if (rightWidget != null) {
      effectiveDecoration = effectiveDecoration.copyWith(
        suffixIcon: InkWell(
          onTap: widget.onBtnTap,
          child: rightWidget,
        ),
      );
    } else if (clearButton != null) {
      effectiveDecoration = effectiveDecoration.copyWith(
        suffixIcon: clearButton,
      );
    }

    // 处理左侧内容
    Widget? leftContent;
    if (widget.leftIcon != null) {
      leftContent = Padding(
        padding: EdgeInsets.only(right: widget.leftLabelSpace ?? 8.0),
        child: widget.leftIcon,
      );
    } else if (widget.leftLabel != null) {
      leftContent = Text(
        widget.leftLabel!,
        style: widget.leftLabelStyle,
      );
    }
    if (leftContent != null && widget.labelWidget != null) {
      leftContent = Row(
        children: [
          leftContent,
          SizedBox(width: 8.0),
          widget.labelWidget!,
        ],
      );
    }
    if (leftContent != null) {
      effectiveDecoration = effectiveDecoration.copyWith(
        prefix: Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: leftContent,
        ),
      );
    }

    final containerDecoration = widget.decoration ??
        (widget.backgroundColor != null
            ? BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(8.0),
              )
            : null);

    return Container(
      width: widget.width,
      decoration: containerDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.cardStyleTopText != null)
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(widget.cardStyleTopText!),
            ),
          TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            style: widget.textStyle,
            cursorColor: widget.cursorColor,
            readOnly: widget.readOnly,
            autofocus: widget.autofocus,
            obscureText: widget.obscureText,
            onEditingComplete: widget.onEditingComplete,
            onSubmitted: widget.onSubmitted,
            keyboardType: widget.inputType,
            onChanged: widget.onChanged,
            inputFormatters: widget.inputFormatters,
            maxLines: widget.maxLines,
            // decoration: effectiveDecoration,
            textAlign: widget.textAlign ?? widget.contentAlignment,
            maxLength: widget.maxLength,
            textInputAction: widget.inputAction,
            textAlignVertical: TextAlignVertical.center,
            decoration: effectiveDecoration.copyWith(
              contentPadding: widget.contentPadding ??
                  EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: widget.showBottomDivider
                      ? Colors.grey.shade300
                      : Colors.transparent,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: widget.showBottomDivider
                      ? Colors.blue
                      : Colors.transparent,
                ),
              ),
            ),
          ),
          if (widget.additionInfo != null && widget.additionInfo!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: Text(
                widget.additionInfo!,
                style: TextStyle(
                  color: widget.additionInfoColor ?? Colors.red,
                ),
              ),
            ),
          if (widget.cardStyleBottomText != null)
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(widget.cardStyleBottomText!),
            ),
        ],
      ),
    );
  }
}
