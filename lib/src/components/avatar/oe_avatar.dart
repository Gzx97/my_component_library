import 'package:flutter/material.dart';
import '../../../my_component_library.dart';

enum OeAvatarSize { large, medium, small }

enum OeAvatarType { icon, normal, customText, display, operation }

enum OeAvatarShape { circle, square }

/// 用于头像显示
class OeAvatar extends StatelessWidget {
  const OeAvatar({
    Key? key,
    this.size = OeAvatarSize.medium,
    this.type = OeAvatarType.normal,
    this.shape = OeAvatarShape.circle,
    this.text,
    this.radius,
    this.icon,
    this.avatarUrl,
    this.avatarSize,
    this.avatarDisplayList,
    this.displayText,
    this.onTap,
    this.defaultUrl = '',
    this.avatarDisplayWidget,
    this.avatarDisplayBorder = 2,
    this.avatarDisplayListAsset,
    this.backgroundColor,
  }) : super(key: key);

  /// 头像地址
  final String? avatarUrl;

  /// 头像尺寸
  final OeAvatarSize size;

  /// 头像类型
  final OeAvatarType type;

  /// 头像形状
  final OeAvatarShape shape;

  /// 自定义文字
  final String? text;

  /// 自定义圆角
  final double? radius;

  /// 自定义头像大小
  final double? avatarSize;

  /// 自定义图标
  final IconData? icon;

  /// 默认图片（本地）
  final String defaultUrl;

  /// 带操作\展示的头像列表
  final List<String>? avatarDisplayList;

  /// 带操作\展示的头像列表 (本地资源)
  final List<String>? avatarDisplayListAsset;

  /// 带操作\展示的头像描边宽度
  final double avatarDisplayBorder;

  /// 带操作头像自定义操作Widget
  final Widget? avatarDisplayWidget;

  /// 纯展示类型末尾文字
  final String? displayText;

  /// 操作点击事件
  final Function()? onTap;

  /// 自定义文案时背景色
  final Color? backgroundColor;

  double _getAvatarWidth() {
    double width;
    switch (size) {
      case OeAvatarSize.large:
        width = 64;
        break;
      case OeAvatarSize.medium:
        width = 48;
        break;
      case OeAvatarSize.small:
        width = 40;
        break;
    }
    return avatarSize ?? width;
  }

  Font? _getTextFont(BuildContext context) {
    Font? font;
    switch (size) {
      case OeAvatarSize.large:
        font = OeTheme.of(context).fontTitleExtraLarge;
        break;
      case OeAvatarSize.medium:
        font = OeTheme.of(context).fontTitleMedium;
        break;
      case OeAvatarSize.small:
        font = OeTheme.of(context).fontTitleSmall;
        break;
    }
    return font;
  }

  double _getIconWidth() {
    double width;
    switch (size) {
      case OeAvatarSize.large:
        width = 32;
        break;
      case OeAvatarSize.medium:
        width = 24;
        break;
      case OeAvatarSize.small:
        width = 20;
        break;
    }
    return width;
  }

  double _getAvatarRadius(BuildContext context) {
    double _radius;
    switch (shape) {
      case OeAvatarShape.circle:
        _radius = _getAvatarWidth() / 2;
        break;
      case OeAvatarShape.square:
        _radius = OeTheme.of(context).radiusDefault;
        break;
    }
    return radius ?? _radius;
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case OeAvatarType.icon:
        return GestureDetector(
          child: Container(
            width: _getAvatarWidth(),
            height: _getAvatarWidth(),
            decoration: BoxDecoration(
              color: backgroundColor ?? OeTheme.of(context).brandColor2,
              borderRadius: BorderRadius.circular(_getAvatarRadius(context)),
            ),
            child: Center(
                child: Icon(icon ?? OeIcons.user,
                    size: _getIconWidth(),
                    color: OeTheme.of(context).brandNormalColor)),
          ),
          onTap: onTap,
        );
      case OeAvatarType.normal:
        return GestureDetector(
          child: Container(
            width: _getAvatarWidth(),
            height: _getAvatarWidth(),
            decoration: BoxDecoration(
                color: backgroundColor ?? OeTheme.of(context).brandColor2,
                borderRadius: BorderRadius.circular(_getAvatarRadius(context)),
                image: avatarUrl != null
                    ? DecorationImage(image: NetworkImage(avatarUrl!))
                    : defaultUrl != ''
                        ? DecorationImage(image: AssetImage(defaultUrl))
                        : null),
          ),
          onTap: onTap,
        );
      case OeAvatarType.customText:
        return GestureDetector(
          child: Container(
            width: _getAvatarWidth(),
            height: _getAvatarWidth(),
            decoration: BoxDecoration(
              color: backgroundColor ?? OeTheme.of(context).brandNormalColor,
              borderRadius: BorderRadius.circular(_getAvatarRadius(context)),
            ),
            child: Center(
              child: OeText(
                text,
                forceVerticalCenter: true,
                textAlign: TextAlign.center,
                font: _getTextFont(context),
                textColor: OeTheme.of(context).whiteColor1,
              ),
            ),
          ),
          onTap: onTap,
        );
      case OeAvatarType.display:
        return buildDisplayAvatar(context);
      case OeAvatarType.operation:
        return buildOperationAvatar(context);
    }
  }

  double _getDisplayPadding() {
    double padding;
    switch (size) {
      case OeAvatarSize.large:
        padding = 10;
        break;
      case OeAvatarSize.medium:
        padding = 8;
        break;
      case OeAvatarSize.small:
        padding = 6;
        break;
    }
    return padding;
  }

  Widget buildOperationAvatar(BuildContext context) {
    var list = <Widget>[];
    if ((avatarDisplayList == null || avatarDisplayList!.isEmpty) &&
        (avatarDisplayListAsset == null || avatarDisplayListAsset!.isEmpty)) {
      return Container();
    }

    var length = 0;

    if (avatarDisplayList != null) {
      length = avatarDisplayList!.length;
      for (var i = 0; i < avatarDisplayList!.length + 1; i++) {
        var left = (_getAvatarWidth() - _getDisplayPadding()) * i;
        if (i == avatarDisplayList!.length) {
          list.add(Positioned(
              left: left,
              child: GestureDetector(
                onTap: () {
                  if (onTap != null) {
                    onTap!();
                  }
                },
                child: Container(
                    child: Center(
                      child: Icon(OeIcons.user_add,
                          size: _getIconWidth(),
                          color: OeTheme.of(context).brandNormalColor),
                    ),
                    width: _getAvatarWidth(),
                    height: _getAvatarWidth(),
                    clipBehavior: Clip.hardEdge,
                    decoration: ShapeDecoration(
                      color: OeTheme.of(context).brandColor2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              _getAvatarWidth() - _getDisplayPadding()),
                          side: BorderSide(
                              color: Colors.white, width: avatarDisplayBorder)),
                    )),
              )));
        } else {
          list.add(Positioned(
              left: left,
              child: Container(
                  width: _getAvatarWidth(),
                  height: _getAvatarWidth(),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              _getAvatarWidth() - _getDisplayPadding()),
                          side: BorderSide(
                              color: Colors.white, width: avatarDisplayBorder)),
                      image: DecorationImage(
                          image: NetworkImage(avatarDisplayList![i]),
                          fit: BoxFit.cover)))));
        }
      }
    } else if (avatarDisplayListAsset != null) {
      length = avatarDisplayListAsset!.length;
      for (var i = 0; i < avatarDisplayListAsset!.length + 1; i++) {
        var left = (_getAvatarWidth() - _getDisplayPadding()) * i;
        if (i == avatarDisplayListAsset!.length) {
          list.add(Positioned(
              left: left,
              child: GestureDetector(
                onTap: () {
                  if (onTap != null) {
                    onTap!();
                  }
                },
                child: Container(
                    child: Center(
                      child: avatarDisplayWidget ??
                          Icon(OeIcons.user_add,
                              size: _getIconWidth(),
                              color: OeTheme.of(context).brandNormalColor),
                    ),
                    width: _getAvatarWidth(),
                    height: _getAvatarWidth(),
                    clipBehavior: Clip.hardEdge,
                    decoration: ShapeDecoration(
                      color: OeTheme.of(context).brandColor2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              _getAvatarWidth() - _getDisplayPadding()),
                          side: BorderSide(
                              color: Colors.white, width: avatarDisplayBorder)),
                    )),
              )));
        } else {
          list.add(Positioned(
              left: left,
              child: Container(
                  width: _getAvatarWidth(),
                  height: _getAvatarWidth(),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              _getAvatarWidth() - _getDisplayPadding()),
                          side: BorderSide(
                              color: Colors.white, width: avatarDisplayBorder)),
                      image: DecorationImage(
                          image: AssetImage(avatarDisplayListAsset![i]),
                          fit: BoxFit.fill)))));
        }
      }
    }

    return SizedBox(
      height: _getAvatarWidth(),
      width: _getAvatarWidth() * (length + 1) - length * _getDisplayPadding(),
      child: Stack(children: list),
    );
  }

  Widget buildDisplayAvatar(BuildContext context) {
    var list = <Widget>[];
    if ((avatarDisplayList == null || avatarDisplayList!.isEmpty) &&
        (avatarDisplayListAsset == null || avatarDisplayListAsset!.isEmpty)) {
      return Container();
    }

    var length = 0;

    if (avatarDisplayList != null) {
      length = avatarDisplayList!.length;
      for (var i = avatarDisplayList!.length; i >= 0; i--) {
        var left = (_getAvatarWidth() - _getDisplayPadding()) * i;
        if (i == avatarDisplayList!.length) {
          list.add(Positioned(
              left: left,
              child: Container(
                  child: Center(
                    child: OeText(
                      displayText,
                      fontWeight: FontWeight.w600,
                      forceVerticalCenter: true,
                      textAlign: TextAlign.center,
                      font: _getTextFont(context),
                      textColor: OeTheme.of(context).brandNormalColor,
                    ),
                  ),
                  width: _getAvatarWidth(),
                  height: _getAvatarWidth(),
                  clipBehavior: Clip.hardEdge,
                  decoration: ShapeDecoration(
                    color: OeTheme.of(context).brandColor2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            _getAvatarWidth() - _getDisplayPadding()),
                        side: BorderSide(
                            color: Colors.white, width: avatarDisplayBorder)),
                  ))));
        } else {
          list.add(Positioned(
              left: left,
              child: Container(
                  width: _getAvatarWidth(),
                  height: _getAvatarWidth(),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              _getAvatarWidth() - _getDisplayPadding()),
                          side: BorderSide(
                              color: Colors.white, width: avatarDisplayBorder)),
                      image: DecorationImage(
                          image: NetworkImage(avatarDisplayList![i]),
                          fit: BoxFit.cover)))));
        }
      }
    } else if (avatarDisplayListAsset != null) {
      length = avatarDisplayListAsset!.length;
      for (var i = avatarDisplayListAsset!.length; i >= 0; i--) {
        var left = (_getAvatarWidth() - _getDisplayPadding()) * i;
        if (i == avatarDisplayListAsset!.length) {
          list.add(Positioned(
              left: left,
              child: Container(
                  child: Center(
                    child: OeText(
                      displayText,
                      fontWeight: FontWeight.w600,
                      forceVerticalCenter: true,
                      textAlign: TextAlign.center,
                      font: _getTextFont(context),
                      textColor: OeTheme.of(context).brandNormalColor,
                    ),
                  ),
                  width: _getAvatarWidth(),
                  height: _getAvatarWidth(),
                  clipBehavior: Clip.hardEdge,
                  decoration: ShapeDecoration(
                    color: OeTheme.of(context).brandColor2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            _getAvatarWidth() - _getDisplayPadding()),
                        side: BorderSide(
                            color: Colors.white, width: avatarDisplayBorder)),
                  ))));
        } else {
          list.add(Positioned(
              left: left,
              child: Container(
                  width: _getAvatarWidth(),
                  height: _getAvatarWidth(),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              _getAvatarWidth() - _getDisplayPadding()),
                          side: BorderSide(
                              color: Colors.white, width: avatarDisplayBorder)),
                      image: DecorationImage(
                          image: AssetImage(avatarDisplayListAsset![i]),
                          fit: BoxFit.cover)))));
        }
      }
    }

    return SizedBox(
      height: _getAvatarWidth(),
      width: _getAvatarWidth() * (length + 1) - length * _getDisplayPadding(),
      child: Stack(children: list),
    );
  }
}
