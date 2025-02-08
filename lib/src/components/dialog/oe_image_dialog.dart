/*
 * Created by haozhicao@tencent.com on 6/20/22.
 * td_image_dialog.dart
 * 
 */

import 'package:flutter/material.dart';

import '../../../my_component_library.dart';
import '../../util/context_extension.dart';
import 'oe_dialog_widget.dart';

enum OeDialogImagePosition {
  top,
  middle,
}

/// 带有图片的弹窗控件
class OeImageDialog extends StatelessWidget {
  const OeImageDialog({
    Key? key,
    required this.image,
    this.imagePosition = OeDialogImagePosition.top,
    this.backgroundColor = Colors.white,
    this.radius = 12.0,
    this.title,
    this.titleColor = const Color(0xE6000000),
    this.titleAlignment,
    this.contentWidget,
    this.content,
    this.contentColor,
    this.leftBtn,
    this.rightBtn,
    this.showCloseButton,
    this.padding,
    this.buttonWidget,
  }) : super(key: key);

  /// 背景颜色
  final Color backgroundColor;

  /// 圆角
  final double radius;

  /// 标题
  final String? title;

  /// 标题颜色
  final Color titleColor;

  /// 标题对齐模式
  final AlignmentGeometry? titleAlignment;

  /// 内容Widget
  final Widget? contentWidget;

  /// 内容
  final String? content;

  /// 内容颜色
  final Color? contentColor;

  /// 左侧按钮配置
  final OeDialogButtonOptions? leftBtn;

  /// 右侧按钮配置
  final OeDialogButtonOptions? rightBtn;

  /// 图片
  final Image image;

  /// 图片位置
  final OeDialogImagePosition? imagePosition;

  /// 显示右上角关闭按钮
  final bool? showCloseButton;

  /// 内容内边距
  final EdgeInsets? padding;

  /// 自定义按钮
  final Widget? buttonWidget;

  Widget _buildImage(BuildContext context) {
    return SizedBox(
      width: 311,
      height: 160,
      child: FittedBox(
        fit: BoxFit.cover,
        child: image,
      ),
    );
  }

  Widget _buildTopImage(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius),
            topRight: Radius.circular(radius)),
        child: _buildImage(context),
      ),
      OeDialogInfoWidget(
        title: title,
        padding: padding ?? const EdgeInsets.fromLTRB(24, 24, 24, 0),
        titleColor: titleColor,
        titleAlignment: titleAlignment,
        contentWidget: contentWidget,
        content: content,
        contentColor: contentColor,
      ),
      const OeDivider(height: 24, color: Colors.transparent),
      _horizontalButtons(context),
    ]);
  }

  Widget _buildMiddleImage(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      OeDialogInfoWidget(
        padding: padding ?? const EdgeInsets.fromLTRB(24, 24, 24, 0),
        title: title,
        titleColor: titleColor,
        titleAlignment: titleAlignment,
        contentWidget: contentWidget,
        content: content,
        contentColor: contentColor,
      ),
      Container(
        padding: const EdgeInsets.only(top: 24),
        child: ClipRRect(
          child: _buildImage(context),
        ),
      ),
      const OeDivider(height: 24, color: Colors.transparent),
      _horizontalButtons(context),
    ]);
  }

  Widget _buildOnlyImage(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius),
            topRight: Radius.circular(radius)),
        child: _buildImage(context),
      ),
      const OeDivider(height: 24, color: Colors.transparent),
      _horizontalButtons(context),
    ]);
  }

  Widget _buildBody(BuildContext context) {
    if (title == null && content == null) {
      return _buildOnlyImage(context);
    } else if (imagePosition == OeDialogImagePosition.middle) {
      return _buildMiddleImage(context);
    } else {
      return _buildTopImage(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OeDialogScaffold(
        showCloseButton: showCloseButton,
        backgroundColor: backgroundColor,
        radius: radius,
        body: _buildBody(context));
  }

  Widget _horizontalButtons(BuildContext context) {
    if (buttonWidget != null) {
      return buttonWidget!;
    }
    final left = leftBtn ??
        OeDialogButtonOptions(
            title: context.resource.cancel,
            theme: OeButtonTheme.light,
            action: null);
    final right = rightBtn ??
        OeDialogButtonOptions(
            title: context.resource.confirm,
            theme: OeButtonTheme.primary,
            action: null);
    return HorizontalNormalButtons(
      leftBtn: left,
      rightBtn: right,
    );
  }
}
