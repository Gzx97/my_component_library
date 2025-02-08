import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../util/context_extension.dart';
import '../../../my_component_library.dart';

enum IconTextDirection {
  horizontal, //横向
  vertical //竖向
}

class OeToast {
  /// 普通文本Toast
  static void showText(String? text,
      {required BuildContext context,
      Duration duration = OeToast._defaultDisPlayDuration,
      int? maxLines,
      BoxConstraints? constraints,
      bool? preventTap,
      Color? backgroundColor}) {
    _showOverlay(
        _OeTextToast(text: text, maxLines: maxLines, constraints: constraints),
        context: context,
        duration: duration,
        preventTap: preventTap,
        backgroundColor: backgroundColor);
  }

  /// 带图标的Toast
  static void showIconText(String? text,
      {IconData? icon,
      IconTextDirection direction = IconTextDirection.horizontal,
      required BuildContext context,
      Duration duration = OeToast._defaultDisPlayDuration,
      bool? preventTap,
      Color? backgroundColor}) {
    _showOverlay(
        _OeIconTextToast(
          text: text,
          iconData: icon,
          iconTextDirection: direction,
        ),
        context: context,
        duration: duration,
        preventTap: preventTap,
        backgroundColor: backgroundColor);
  }

  /// 成功提示Toast
  static void showSuccess(String? text,
      {IconTextDirection direction = IconTextDirection.horizontal,
      required BuildContext context,
      Duration duration = OeToast._defaultDisPlayDuration,
      bool? preventTap,
      Color? backgroundColor}) {
    _showOverlay(
        _OeIconTextToast(
          text: text,
          iconData: OeIcons.check_circle,
          iconTextDirection: direction,
        ),
        context: context,
        duration: duration,
        preventTap: preventTap,
        backgroundColor: backgroundColor);
  }

  /// 警告Toast
  static void showWarning(String? text,
      {IconTextDirection direction = IconTextDirection.horizontal,
      required BuildContext context,
      Duration duration = OeToast._defaultDisPlayDuration,
      bool? preventTap,
      Color? backgroundColor}) {
    _showOverlay(
        _OeIconTextToast(
          text: text,
          iconData: OeIcons.error_circle,
          iconTextDirection: direction,
        ),
        context: context,
        duration: duration,
        preventTap: preventTap,
        backgroundColor: backgroundColor);
  }

  /// 失败提示Toast
  static void showFail(String? text,
      {IconTextDirection direction = IconTextDirection.horizontal,
      required BuildContext context,
      Duration duration = OeToast._defaultDisPlayDuration,
      bool? preventTap,
      Color? backgroundColor}) {
    _showOverlay(
        _OeIconTextToast(
          text: text,
          iconData: OeIcons.close_circle,
          iconTextDirection: direction,
        ),
        context: context,
        duration: duration,
        preventTap: preventTap,
        backgroundColor: backgroundColor);
  }

  /// 带文案的加载Toast
  static void showLoading(
      {required BuildContext context,
      String? text,
      Duration duration = OeToast._infiniteDuration,
      bool? preventTap,
      Color? backgroundColor}) {
    _showOverlay(
        _OeToastLoading(
          text: text,
        ),
        context: context,
        duration: duration,
        preventTap: preventTap,
        backgroundColor: backgroundColor);
  }

  /// 不带文案的加载Toast
  static void showLoadingWithoutText(
      {required BuildContext context,
      String? text,
      Duration duration = OeToast._infiniteDuration,
      bool? preventTap,
      Color? backgroundColor}) {
    _showOverlay(const _OeToastLoadingWithoutText(),
        context: context,
        duration: duration,
        preventTap: preventTap,
        backgroundColor: backgroundColor);
  }

  /// 关闭加载Toast
  static void dismissLoading() {
    _cancel();
  }

  static void _showOverlay(Widget? widget,
      {required BuildContext context,
      Duration duration = OeToast._defaultDisPlayDuration,
      bool? preventTap,
      Color? backgroundColor}) {
    _cancel();
    _showing = true;
    var overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Center(
              child: AnimatedOpacity(
                opacity: _showing ? 1.0 : 0.0,
                duration: _showing
                    ? const Duration(milliseconds: 100)
                    : const Duration(milliseconds: 200),
                child: widget,
              ),
            ));

    if (preventTap ?? false) {
      _overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Positioned(
          top: 0,
          right: 0,
          bottom: 0,
          left: 0,
          child: Container(
            color: backgroundColor,
            child: Align(
              alignment: Alignment.center,
              child: AnimatedOpacity(
                opacity: _showing ? 1.0 : 0.0,
                duration: _showing
                    ? const Duration(milliseconds: 100)
                    : const Duration(milliseconds: 200),
                child: widget,
              ),
            ),
          ),
        ),
      );
    }
    if (_overlayEntry != null) {
      overlayState?.insert(_overlayEntry!);
    }
    _startTimer(duration);
  }

  static void _cancel() {
    _timer?.cancel();
    _timer = null;
    _disposeTimer?.cancel();
    _disposeTimer = null;
    _overlayEntry?.remove();
    _overlayEntry = null;
    _showing = false;
  }

  static void _startTimer(Duration duration) {
    _timer?.cancel();
    _disposeTimer?.cancel();
    _timer = Timer(duration, () {
      _showing = false;
      _overlayEntry?.markNeedsBuild();
      _timer = null;
      _disposeTimer = Timer(const Duration(milliseconds: 200), () {
        _overlayEntry?.remove();
        _overlayEntry = null;
        _disposeTimer = null;
      });
    });
  }

  static OverlayEntry? _overlayEntry;
  static bool _showing = false;
  static Timer? _timer;
  static Timer? _disposeTimer;
  static const Duration _defaultDisPlayDuration = Duration(milliseconds: 3000);
  static const Duration _infiniteDuration = Duration(seconds: 99999999);
}

class _OeIconTextToast extends StatelessWidget {
  final String? text;
  final IconData? iconData;
  final IconTextDirection iconTextDirection;

  const _OeIconTextToast(
      {this.text,
      this.iconData,
      this.iconTextDirection = IconTextDirection.horizontal});

  Widget buildHorizontalWidgets(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 191, maxHeight: 94),
      child: Container(
          padding: const EdgeInsets.fromLTRB(24, 14, 24, 14),
          decoration: BoxDecoration(
            color: OeTheme.of(context).fontGyColor1,
            borderRadius:
                BorderRadius.circular(OeTheme.of(context).radiusDefault),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 24,
                color: OeTheme.of(context).whiteColor1,
              ),
              const SizedBox(
                width: 8,
              ),
              OeText(
                text ?? '',
                font: OeTheme.of(context).fontBodyMedium,
                fontWeight: FontWeight.w400,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textColor: OeTheme.of(context).whiteColor1,
              )
            ],
          )),
    );
  }

  Widget buildVerticalWidgets(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 136, maxHeight: 130),
        child: Container(
            height: 110,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: OeTheme.of(context).fontGyColor1,
              borderRadius:
                  BorderRadius.circular(OeTheme.of(context).radiusDefault),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  iconData,
                  size: 32,
                  color: OeTheme.of(context).whiteColor1,
                ),
                const SizedBox(
                  height: 8,
                ),
                OeText(
                  text ?? '',
                  font: OeTheme.of(context).fontBodyMedium,
                  fontWeight: FontWeight.w400,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textColor: OeTheme.of(context).whiteColor1,
                )
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return iconTextDirection == IconTextDirection.horizontal
        ? buildHorizontalWidgets(context)
        : buildVerticalWidgets(context);
  }
}

class _OeToastLoading extends StatelessWidget {
  final String? text;

  const _OeToastLoading({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 110,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: OeTheme.of(context).fontGyColor1,
          borderRadius:
              BorderRadius.circular(OeTheme.of(context).radiusDefault),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            OeCircleIndicator(
              color: OeTheme.of(context).whiteColor1,
              size: 26,
              lineWidth: 4,
            ),
            const SizedBox(
              height: 8,
            ),
            OeText(
              text ?? context.resource.loadingWithPoint,
              font: OeTheme.of(context).fontBodyMedium,
              fontWeight: FontWeight.w400,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textColor: OeTheme.of(context).whiteColor1,
            )
          ],
        ));
  }
}

class _OeToastLoadingWithoutText extends StatelessWidget {
  const _OeToastLoadingWithoutText();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 80,
        height: 80,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: OeTheme.of(context).fontGyColor1,
          borderRadius:
              BorderRadius.circular(OeTheme.of(context).radiusDefault),
        ),
        child: OeCircleIndicator(
          color: OeTheme.of(context).whiteColor1,
          size: 26,
          lineWidth: 4,
        ));
  }
}

class _OeTextToast extends StatelessWidget {
  final String? text;

  final int? maxLines;

  final BoxConstraints? constraints;

  const _OeTextToast({this.text, this.maxLines, this.constraints});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          constraints ?? const BoxConstraints(maxWidth: 191, maxHeight: 94),
      child: Container(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
          decoration: BoxDecoration(
            color: OeTheme.of(context).fontGyColor1,
            borderRadius:
                BorderRadius.circular(OeTheme.of(context).radiusDefault),
          ),
          child: OeText(
            text ?? '',
            font: OeTheme.of(context).fontBodyMedium,
            fontWeight: FontWeight.w400,
            maxLines: maxLines ?? 3,
            overflow: TextOverflow.ellipsis,
            textColor: OeTheme.of(context).whiteColor1,
          )),
    );
  }
}
