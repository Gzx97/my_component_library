import 'package:flutter/material.dart';

import '../../../my_component_library.dart';
import '../../util/context_extension.dart';

///
/// 搜索框的样式
///
enum OeSearchStyle {
  square, // 方形
  round, // 圆形
}

///
/// 搜索框对齐方式
///
enum OeSearchAlignment {
  left, // 默认头部对齐
  center, // 居中
}

typedef OeSearchBarEvent = void Function(String value);
typedef OeSearchBarClearEvent = bool? Function(String value);
typedef OeSearchBarCallBack = void Function();

class OeSearchBar extends StatefulWidget {
  const OeSearchBar({
    Key? key,
    this.placeHolder,
    this.style = OeSearchStyle.square,
    this.alignment = OeSearchAlignment.left,
    this.onTextChanged,
    this.onSubmitted,
    this.onEditComplete,
    this.onInputClick,
    this.autoHeight = false,
    this.padding = const EdgeInsets.fromLTRB(16, 8, 16, 8),
    this.autoFocus = false,
    this.mediumStyle = false,
    this.cursorHeight,
    this.needCancel = false,
    this.controller,
    this.backgroundColor = Colors.white,
    this.action = '',
    this.onActionClick,
    this.onClearClick,
    this.focusNode,
    this.inputAction,
    this.enabled,
    this.readOnly,
  }) : super(key: key);

  /// 预设文案
  final String? placeHolder;

  /// 样式
  final OeSearchStyle? style;

  /// 对齐方式，居中或这头部对齐
  final OeSearchAlignment? alignment;

  /// 背景颜色
  final Color? backgroundColor;

  /// 是否自动计算高度
  final bool autoHeight;

  /// 内部填充
  final EdgeInsets padding;

  /// 是否自动获取焦点
  final bool autoFocus;

  /// 是否在导航栏中的样式
  final bool mediumStyle;

  /// 光标的高
  final double? cursorHeight;

  /// 是否需要取消按钮
  final bool needCancel;

  /// 控制器
  final TextEditingController? controller;

  /// 文字改变回调
  final OeSearchBarEvent? onTextChanged;

  /// 提交回调
  final OeSearchBarEvent? onSubmitted;

  /// 编辑完成回调
  final OeSearchBarCallBack? onEditComplete;

  /// 自定义操作文字
  final String action;

  /// 输入框点击事件
  final GestureTapCallback? onInputClick;

  /// 自定义操作回调
  final OeSearchBarEvent? onActionClick;

  /// 自定义操作回调
  final OeSearchBarClearEvent? onClearClick;

  /// 自定义焦点
  final FocusNode? focusNode;

  /// 键盘动作类型
  final TextInputAction? inputAction;

  /// 是否禁用
  final bool? enabled;

  /// 是否只读
  final bool? readOnly;
  @override
  State<StatefulWidget> createState() => _OeSearchBarState();
}

class _OeSearchBarState extends State<OeSearchBar>
    with TickerProviderStateMixin {
  late FocusNode focusNode = FocusNode();
  final TextEditingController controller = TextEditingController();
  final GlobalKey _textFieldKey = GlobalKey();

  bool clearBtnHide = true;
  bool cancelBtnHide = true;
  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      controller.addListener(() {
        var clearVisible = controller.text.isNotEmpty;
        _updateClearBtnVisible(clearVisible);
      });
    } else {
      widget.controller?.addListener(() {
        var clearVisible = widget.controller?.text.isNotEmpty;
        _updateClearBtnVisible(clearVisible!);
      });
    }
    _updateFocusNode();
  }

  void _updateFocusNode() {
    focusNode = widget.focusNode ?? focusNode;
    focusNode.addListener(() {
      setState(() {
        cancelBtnHide = !focusNode.hasFocus;
      });
    });
  }

  @override
  void didUpdateWidget(covariant OeSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateFocusNode();
  }

  void _updateClearBtnVisible(bool visible) {
    setState(() {
      clearBtnHide = !visible;
    });
  }

  void _cleanInputText() {
    if (!(widget.onClearClick?.call(controller.text) ?? false)) {
      // 如果外部没处理,则走默认清除逻辑
      if (widget.controller == null) {
        controller.clear();
      } else {
        widget.controller?.clear();
      }
    }
  }

  Font? getSize(BuildContext context) {
    return widget.mediumStyle
        ? OeTheme.of(context).fontBodyMedium
        : OeTheme.of(context).fontBodyLarge;
  }

  Widget actionBtn(BuildContext context, String? text,
      {String? action, OeSearchBarEvent? onActionClick}) {
    return GestureDetector(
      onTap: () {
        onActionClick!(text ?? '');
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16),
        child: Text(action!,
            style: TextStyle(
                fontSize: getSize(context)?.size,
                color: OeTheme.of(context).brandNormalColor)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      height: widget.autoHeight ? double.infinity : 56,
      color: widget.backgroundColor,
      child: Stack(alignment: AlignmentDirectional.center, children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                    color: OeTheme.of(context).grayColor1,
                    borderRadius: BorderRadius.circular(
                        widget.style == OeSearchStyle.square ? 4 : 28)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 12,
                    ),
                    Icon(
                      OeIcons.search,
                      size: widget.mediumStyle ? 20 : 24,
                      color: OeTheme.of(context).fontGyColor3,
                    ),
                    const Padding(padding: EdgeInsets.only(left: 3)),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(
                            bottom: 1), // 为了适配TextField与Text的差异，后续需要做通用适配
                        child: TextField(
                          key: _textFieldKey,
                          controller: widget.controller ?? controller,
                          autofocus: widget.autoFocus,
                          cursorColor: OeTheme.of(context).brandNormalColor,
                          cursorWidth: 1,
                          cursorHeight: widget.cursorHeight,
                          textAlign:
                              widget.alignment == OeSearchAlignment.center
                                  ? TextAlign.center
                                  : TextAlign.left,
                          focusNode: focusNode,
                          onTap: widget.onInputClick,
                          onChanged: widget.onTextChanged,
                          onSubmitted: widget.onSubmitted,
                          onEditingComplete: widget.onEditComplete,
                          style: TextStyle(
                              textBaseline: TextBaseline.ideographic,
                              fontSize: getSize(context)?.size,
                              color: OeTheme.of(context).fontGyColor1),
                          decoration: InputDecoration(
                            hintText: widget.placeHolder,
                            hintStyle: TextStyle(
                              fontSize: getSize(context)?.size,
                              color: OeTheme.of(context).fontGyColor3,
                              textBaseline: TextBaseline.ideographic,
                              overflow: TextOverflow.ellipsis,
                            ),
                            hintMaxLines: 1,
                            border: InputBorder.none,
                            isCollapsed: true,
                            filled: true,
                            fillColor: OeTheme.of(context).grayColor1,
                          ),
                          maxLines: 1,
                          textInputAction: widget.inputAction,
                          readOnly: widget.readOnly ?? false,
                          enabled: widget.enabled,
                          cursorOpacityAnimates: false,
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(right: 9)),
                    Offstage(
                      offstage: clearBtnHide,
                      child: GestureDetector(
                          onTap: () {
                            _cleanInputText();
                            if (widget.onTextChanged != null) {
                              widget.onTextChanged!('');
                            }
                          },
                          child: Icon(
                            OeIcons.close_circle_filled,
                            size: widget.mediumStyle ? 17 : 21,
                            color: OeTheme.of(context).fontGyColor3,
                          )),
                    ),
                    const Padding(padding: EdgeInsets.only(right: 9)),
                  ],
                ),
              ),
            ),
            widget.action.isNotEmpty
                ? actionBtn(
                    context,
                    controller.text,
                    action: widget.action,
                    onActionClick: widget.onActionClick ?? (String text) {},
                  )
                : Offstage(
                    offstage: cancelBtnHide || !widget.needCancel,
                    child: GestureDetector(
                      onTap: () {
                        _cleanInputText();
                        if (widget.onTextChanged != null) {
                          widget.onTextChanged!('');
                        }
                        focusNode.unfocus();
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(context.resource.cancel,
                            style: TextStyle(
                                fontSize: getSize(context)?.size,
                                color: OeTheme.of(context).brandNormalColor)),
                      ),
                    ),
                  ),
          ],
        ),
      ]),
    );
  }
}
