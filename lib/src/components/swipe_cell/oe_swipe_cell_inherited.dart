import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'oe_swipe_cell_action.dart';

class OeSwipeCellInherited extends InheritedWidget {
  const OeSwipeCellInherited({
    Key? key,
    required Widget child,
    required this.cellClick,
    required this.actionClick,
    required this.duration,
    required this.controller,
  }) : super(child: child, key: key);

  final Duration duration;
  final void Function() cellClick;
  final bool Function(OeSwipeCellAction action) actionClick;
  final SlidableController controller;

  @override
  bool updateShouldNotify(covariant OeSwipeCellInherited oldWidget) {
    return true;
  }

  static OeSwipeCellInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<OeSwipeCellInherited>();
  }
}
