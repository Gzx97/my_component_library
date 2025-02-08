import 'package:flutter/material.dart';

import '../../../my_component_library.dart';

typedef TapCallback = void Function(int index);

class OeCustomTab extends StatefulWidget {
  final List<String> tabs;
  final TapCallback? onTap;
  final int? initialIndex;
  const OeCustomTab(
      {super.key, required this.tabs, this.onTap, this.initialIndex});

  @override
  State<OeCustomTab> createState() => _OeCustomTabState();
}

class _OeCustomTabState extends State<OeCustomTab> {
  ScrollController _scrollController = ScrollController();
  int _currentTabIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentTabIndex = widget.initialIndex ?? 0;
  }

  @override
  void didUpdateWidget(OeCustomTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialIndex != oldWidget.initialIndex) {
      _currentTabIndex = widget.initialIndex!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(widget.tabs.length, (index) {
            return GestureDetector(
                onTap: () {
                  _onChangeTab(index);
                },
                child: Container(
                    width: 96,
                    height: 52,
                    child: Stack(
                      children: [
                        Center(
                          child: OeText(
                            widget.tabs[index],
                            style: TextStyle(
                                fontSize: 16,
                                color: _currentTabIndex == index
                                    ? OeTheme.of(context).brandNormalColor
                                    : Colors.black),
                            fontWeight: _currentTabIndex == index
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                        if (_currentTabIndex == index)
                          Positioned(
                            bottom: 0,
                            left: (96 - 20) / 2,
                            child: Center(
                              child: Container(
                                width: 20,
                                height: 1.5,
                                color: OeTheme.of(context).brandNormalColor,
                              ),
                            ),
                          ),
                      ],
                    )));
          })),
    );
  }

  void _onChangeTab(int index) {
    if (widget.onTap != null) {
      widget.onTap!(index);
    }
  }
}
