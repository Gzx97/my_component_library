import 'package:flutter/cupertino.dart';

import 'oe_cell_style.dart';

class OeCellInherited extends InheritedWidget {
  const OeCellInherited({required Widget child, required this.style, Key? key})
      : super(child: child, key: key);

  final OeCellStyle style;

  @override
  bool updateShouldNotify(covariant OeCellInherited oldWidget) {
    return true;
  }

  static OeCellInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<OeCellInherited>();
  }
}
