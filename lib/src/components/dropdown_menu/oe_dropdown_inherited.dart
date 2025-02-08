import 'package:flutter/cupertino.dart';

import 'oe_dropdown_item.dart';
import 'oe_dropdown_menu.dart';
import 'oe_dropdown_popup.dart';

class OeDropdownInherited extends InheritedWidget {
  const OeDropdownInherited(
      {required Widget child,
      required this.popupState,
      required this.directionListenable,
      Key? key})
      : super(child: child, key: key);

  final OeDropdownPopup popupState;
  final ValueNotifier<OeDropdownMenuDirection> directionListenable;

  @override
  bool updateShouldNotify(covariant OeDropdownInherited oldWidget) {
    return true;
  }

  static OeDropdownInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<OeDropdownInherited>();
  }
}
