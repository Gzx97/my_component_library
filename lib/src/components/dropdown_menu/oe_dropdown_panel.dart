import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'oe_dropdown_menu.dart';
import 'oe_dropdown_popup.dart';

class OeDropdownPanel extends StatefulWidget {
  const OeDropdownPanel({
    Key? key,
    required this.initContentTop,
    required this.initContentBottom,
    required this.reverseHeight,
    required this.duration,
    required this.directionListenable,
    required this.colorAlphaListenable,
    required this.direction,
    required this.closeListenable,
    required this.onOpened,
    required this.child,
  }) : super(key: key);

  final double initContentTop;
  final double initContentBottom;
  final double reverseHeight;
  final Duration duration;
  final ValueNotifier<OeDropdownPopupDirection> directionListenable;
  final ValueNotifier<bool> colorAlphaListenable;
  final OeDropdownPopupDirection direction;
  final ValueNotifier<FutureCallback?> closeListenable;
  final VoidCallback onOpened;
  final Widget child;

  @override
  _OeDropdownPanelState createState() => _OeDropdownPanelState();
}

class _OeDropdownPanelState extends State<OeDropdownPanel>
    with SingleTickerProviderStateMixin {
  double? contentTop, contentBottom;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    widget.closeListenable.value = close;
  }

  @override
  void didUpdateWidget(OeDropdownPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.directionListenable != oldWidget.directionListenable) {
      widget.closeListenable.value = close;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PositionedTransition(
      rect: _getAnimation(),
      child: SingleChildScrollView(
        child: Builder(
          builder: (BuildContext context) {
            open(context);
            return widget.child;
          },
        ),
      ),
    );
  }

  void open(BuildContext itemContext) {
    if (contentBottom != null || contentTop != null) {
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var renderBox = itemContext.findRenderObject() as RenderBox;
      var size = renderBox.size;
      if (widget.directionListenable.value == OeDropdownPopupDirection.auto) {
        // 比较展开方向（down）的高度能不能放下item，能将方向更新为down
        // 否则比较反方向（up）的高度是否大于down的方向，大于则将方向更新为up，否则保持为down
        if (widget.direction == OeDropdownPopupDirection.down) {
          if (widget.initContentBottom >= size.height) {
            widget.directionListenable.value = OeDropdownPopupDirection.down;
          } else {
            if (widget.reverseHeight > widget.initContentBottom) {
              widget.directionListenable.value = OeDropdownPopupDirection.up;
            } else {
              widget.directionListenable.value = OeDropdownPopupDirection.down;
            }
          }
        } else {
          if (widget.initContentTop >= size.height) {
            widget.directionListenable.value = OeDropdownPopupDirection.up;
          } else {
            if (widget.reverseHeight > widget.initContentTop) {
              widget.directionListenable.value = OeDropdownPopupDirection.down;
            } else {
              widget.directionListenable.value = OeDropdownPopupDirection.up;
            }
          }
        }
        return;
      }
      if (widget.direction == OeDropdownPopupDirection.down) {
        contentBottom = widget.initContentBottom - size.height;
      } else {
        contentTop = widget.initContentTop - size.height;
      }
      setState(() {});
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_controller.status == AnimationStatus.dismissed) {
          widget.colorAlphaListenable.value = true;
          _controller.duration = widget.duration;
          _controller.forward().whenCompleteOrCancel(() {
            widget.onOpened();
          });
        }
      });
    });
  }

  Animation<RelativeRect> _getAnimation() {
    return RelativeRectTween(
      begin: RelativeRect.fromLTRB(
          0, widget.initContentTop, 0, widget.initContentBottom),
      end: RelativeRect.fromLTRB(0, contentTop ?? widget.initContentTop, 0,
          contentBottom ?? widget.initContentBottom),
    ).animate(_controller);
  }

  Future<void> close() {
    widget.colorAlphaListenable.value = false;
    _controller.duration = widget.duration ~/ 2;
    return _controller.reverse();
  }
}
