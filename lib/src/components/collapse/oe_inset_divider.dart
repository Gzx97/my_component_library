import 'package:flutter/material.dart';

import '../../../my_component_library.dart';

class OeInsetDivider extends StatelessWidget {
  const OeInsetDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 1,
        child: Divider(
          color: OeTheme.of(context).grayColor3,
          indent: OeTheme.of(context).spacer16,
          endIndent: 0.0,
          height: 1,
          thickness: 0.5,
        ));
  }
}
