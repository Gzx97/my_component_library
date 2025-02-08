import 'package:flutter/material.dart';

import '../../theme/oe_colors.dart';
import '../../theme/oe_theme.dart';
import '../popup/oe_popup_route.dart';
import 'oe_image_viewer_widget.dart';

/// 图片预览工具
class OeImageViewer {
  /// 显示图片预览
  static void showImageViewer({
    required BuildContext context,
    required List<dynamic> images,
    List<String>? labels,
    bool? closeBtn = true,
    bool? deleteBtn = false,
    bool? showIndex = false,
    int? defaultIndex,
    double? width,
    double? height,
    OnIndexChange? onIndexChange,
    OnClose? onClose,
    OnDelete? onDelete,
    OnLongPress? onLongPress,
  }) {
    var modalBarrierColor = OeTheme.of(context).fontGyColor1;
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: modalBarrierColor,
      useSafeArea: false,
      builder: (context) {
        return OeImageViewerWidget(
          images: images,
          labels: labels,
          closeBtn: closeBtn,
          deleteBtn: deleteBtn,
          showIndex: showIndex,
          defaultIndex: defaultIndex,
          onIndexChange: onIndexChange,
          width: width,
          height: height,
          onClose: onClose,
          onDelete: onDelete,
          onLongPress: onLongPress,
        );
      },
    );
  }
}
