import 'package:flutter/material.dart';
import '../../../my_component_library.dart';

/// Steps步骤条，垂直步骤
class OeStepsVertical extends StatelessWidget {
  final List<OeStepsItemData> steps;
  final int activeIndex;
  final OeStepsStatus status;
  final bool simple;
  final bool readOnly;
  final bool verticalSelect;
  const OeStepsVertical({
    super.key,
    required this.steps,
    required this.activeIndex,
    required this.status,
    required this.simple,
    required this.readOnly,
    required this.verticalSelect,
  });

  @override
  Widget build(BuildContext context) {
    final stepsCount = steps.length;
    List<Widget> stepsVerticalItem = steps.asMap().entries.map((item) {
      return OeStepsVerticalItem(
        index: item.key,
        data: item.value,
        stepsCount: stepsCount,
        activeIndex: activeIndex,
        status: status,
        simple: simple,
        readOnly: readOnly,
        verticalSelect: verticalSelect,
      );
    }).toList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: stepsVerticalItem,
    );
  }
}
