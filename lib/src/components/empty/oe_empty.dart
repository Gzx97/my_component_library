import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../my_component_library.dart';

typedef OeTapEvent = void Function();

enum OeEmptyType { plain, operation }

class OeEmpty extends StatelessWidget {
  const OeEmpty(
      {this.type = OeEmptyType.plain,
      this.image,
      this.emptyText,
      this.operationText,
      this.operationTheme,
      this.onTapEvent,
      this.emptyTextColor,
      this.emptyTextFont,
      Key? key})
      : super(key: key);

  /// 点击事件
  final OeTapEvent? onTapEvent;

  /// 展示图片
  final Widget? image;

  /// 描述文字
  final String? emptyText;

  /// 描述文字颜色
  final Color? emptyTextColor;

  /// 描述文字大小
  final Font? emptyTextFont;

  /// 操作按钮文案
  final String? operationText;

  /// 操作按钮文案主题色
  final OeButtonTheme? operationTheme;

  /// 类型，为operation有操作按钮，plain无按钮
  final OeEmptyType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          image ??
              Icon(
                OeIcons.info_circle_filled,
                size: 96,
                color: OeTheme.of(context).fontGyColor3,
              ),
          Padding(padding: EdgeInsets.only(top: image == null ? 22 : 16)),
          OeText(
            emptyText ?? '',
            fontWeight: FontWeight.w400,
            font: emptyTextFont ?? OeTheme.of(context).fontBodyMedium,
            textColor: emptyTextColor ??
                OeTheme.of(context).fontGyColor2.withOpacity(0.6),
          ),
          (type == OeEmptyType.operation)
              ? Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: OeButton(
                    text: operationText ?? '',
                    size: OeButtonSize.large,
                    theme: operationTheme ?? OeButtonTheme.primary,
                    width: 179,
                    onTap: () {
                      if (onTapEvent != null) {
                        onTapEvent!();
                      }
                    },
                  ))
              : Container()
        ],
      ),
    );
  }
}
