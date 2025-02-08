import 'package:flutter/material.dart';
import '../../../my_component_library.dart';

/// Steps步骤条，水平步骤
class OeStepsHorizontal extends StatelessWidget {
  final List<OeStepsItemData> steps;
  final int activeIndex;
  final OeStepsStatus status;
  final bool simple;
  final bool readOnly;
  const OeStepsHorizontal({
    super.key,
    required this.steps,
    required this.activeIndex,
    required this.status,
    required this.simple,
    required this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    final stepsCount = steps.length;
    List<Widget> stepsHorizontalItem = steps.asMap().entries.map((item) {
      return Expanded(
        flex: 1,
        child: OeStepsHorizontalItem(
          index: item.key,
          data: item.value,
          stepsCount: stepsCount,
          activeIndex: activeIndex,
          status: status,
          simple: simple,
          readOnly: readOnly,
        ),
      );
    }).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: stepsHorizontalItem,
    );
  }
}
