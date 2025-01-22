import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../my_component_library.dart';
import '../util/log.dart';
import '../util/string_util.dart';
import 'oe_default_theme.dart';

/// 主题控件
class OeTheme extends StatelessWidget {
  const OeTheme(
      {required this.data, required this.child, this.systemData, Key? key})
      : super(key: key);

  /// 仅使用Default主题，不需要切换主题功能
  static bool _needMultiTheme = false;

  /// 主题数据
  static OeThemeData? _singleData;

  /// 子控件
  final Widget child;

  /// 主题数据
  final OeThemeData data;

  /// Flutter系统主题数据
  final ThemeData? systemData;

  @override
  Widget build(BuildContext context) {
    if (!_needMultiTheme) {
      _singleData = data;
    }
    var extensions = [data];
    return Theme(
        data: systemData?.copyWith(extensions: extensions) ??
            ThemeData(extensions: extensions),
        child: child);
  }

  /// 开启多套主题功能
  static void needMultiTheme([bool value = true]) {
    _needMultiTheme = value;
  }

  /// 设置资源代理,
  /// needAlwaysBuild=true:每次都会走build方法;如果全局有多个Delegate,需要区分情况去获取,则可以设置needAlwaysBuild为true,业务自己判断返回哪个delegate
  /// needAlwaysBuild=false:返回delegate为null,则每次都会走build方法,返回了
  static void setResourceBuilder(OeOeResourceBuilder delegate,
      {bool needAlwaysBuild = false}) {
    OeResourceManager.instance.setResourceBuilder(delegate, needAlwaysBuild);
  }

  /// 获取默认主题数据，全局唯一
  static OeThemeData defaultData() {
    return OeThemeData.defaultData();
  }

  /// 获取主题数据，如果未传context则获取全局唯一的默认数据,
  /// 传了context，则获取最近的主题，取不到则会获取全局唯一默认数据
  static OeThemeData of([BuildContext? context]) {
    if (!_needMultiTheme || context == null) {
      // 如果context为null,则返回全局默认主题
      return _singleData ?? OeThemeData.defaultData();
    }
    // 如果传了context，则从其中获取最近主题
    try {
      var data = Theme.of(context).extensions[OeThemeData] as OeThemeData?;
      return data ?? OeThemeData.defaultData();
    } catch (e) {
      Log.w('OeTheme', 'OeTheme.of() error: $e');
      return OeThemeData.defaultData();
    }
  }

  /// 获取主题数据，取不到则可空
  /// 传了context，则获取最近的主题，取不到或未传context则返回null,
  static OeThemeData? ofNullable([BuildContext? context]) {
    if (context != null) {
      // 如果传了context，则从其中获取最近主题
      return Theme.of(context).extensions[OeThemeData] as OeThemeData?;
    } else {
      // 如果context为null,则返回null
      return null;
    }
  }
}

/// 主题数据
class OeThemeData extends ThemeExtension<OeThemeData> {
  static const String _defaultThemeName = 'default';
  static OeThemeData? _defaultThemeData;

  /// 名称
  late String name;

  /// 颜色
  late OeMap<String, Color> colorMap;

  /// 字体尺寸
  late OeMap<String, Font> fontMap;

  /// 圆角
  late OeMap<String, double> radiusMap;

  /// 字体样式
  late OeMap<String, FontFamily> fontFamilyMap;

  /// 阴影
  late OeMap<String, List<BoxShadow>> shadowMap;

  /// 间隔
  late OeMap<String, double> spacerMap;

  /// 映射关系
  late OeMap<String, String> refMap;

  /// 额外定义的结构
  late OeExtraThemeData? extraThemeData;

  OeThemeData({
    required this.name,
    required this.colorMap,
    required this.fontMap,
    required this.radiusMap,
    required this.fontFamilyMap,
    required this.shadowMap,
    required this.spacerMap,
    required this.refMap,
    this.extraThemeData,
  });

  /// 获取默认Data，一个App里只有一个，用于没有context的地方
  static OeThemeData defaultData({OeExtraThemeData? extraThemeData}) {
    _defaultThemeData ??= fromJson(
            _defaultThemeName, OeDefaultTheme.defaultThemeConfig,
            extraThemeData: extraThemeData) ??
        _emptyData(_defaultThemeName, extraThemeData: extraThemeData);

    return _defaultThemeData!;
  }

  /// 从父类拷贝
  OeThemeData copyWithOeThemeData(
    String name, {
    Map<String, Color>? colorMap,
    Map<String, Font>? fontMap,
    Map<String, double>? radiusMap,
    Map<String, FontFamily>? fontFamilyMap,
    Map<String, List<BoxShadow>>? shadowMap,
    Map<String, double>? marginMap,
    OeExtraThemeData? extraThemeData,
  }) {
    return copyWith(
        name: name,
        colorMap: colorMap,
        fontMap: fontMap,
        radiusMap: radiusMap,
        fontFamilyMap: fontFamilyMap,
        shadowMap: shadowMap,
        marginMap: marginMap,
        extraThemeData: extraThemeData) as OeThemeData;
  }

  @override
  ThemeExtension<OeThemeData> copyWith({
    String? name,
    Map<String, Color>? colorMap,
    Map<String, Font>? fontMap,
    Map<String, double>? radiusMap,
    Map<String, FontFamily>? fontFamilyMap,
    Map<String, List<BoxShadow>>? shadowMap,
    Map<String, double>? marginMap,
    OeExtraThemeData? extraThemeData,
  }) {
    var result = OeThemeData(
        name: name ?? 'default',
        colorMap: _copyMap<Color>(this.colorMap, colorMap),
        fontMap: _copyMap<Font>(this.fontMap, fontMap),
        radiusMap: _copyMap<double>(this.radiusMap, radiusMap),
        fontFamilyMap: _copyMap<FontFamily>(this.fontFamilyMap, fontFamilyMap),
        shadowMap: _copyMap<List<BoxShadow>>(this.shadowMap, shadowMap),
        spacerMap: _copyMap<double>(spacerMap, marginMap),
        refMap: _copyMap<String>(refMap, refMap),
        extraThemeData: extraThemeData ?? this.extraThemeData);
    return result;
  }

  /// 拷贝Map,防止内层
  OeMap<String, T> _copyMap<T>(OeMap<String, T> src, Map<String, T>? add) {
    var map = OeMap<String, T>(factory: () => src);

    src.forEach((key, value) {
      map[key] = value;
    });
    if (add != null) {
      map.addAll(add);
    }
    return map;
  }

  /// 创建空对象
  static OeThemeData _emptyData(String name,
      {OeExtraThemeData? extraThemeData}) {
    var refMap = OeMap<String, String>();
    return OeThemeData(
        name: name,
        colorMap: OeMap(factory: () => defaultData().colorMap, refs: refMap),
        fontMap: OeMap(factory: () => defaultData().fontMap, refs: refMap),
        radiusMap: OeMap(factory: () => defaultData().radiusMap, refs: refMap),
        fontFamilyMap:
            OeMap(factory: () => defaultData().fontFamilyMap, refs: refMap),
        shadowMap: OeMap(factory: () => defaultData().shadowMap, refs: refMap),
        spacerMap: OeMap(factory: () => defaultData().spacerMap, refs: refMap),
        refMap: refMap);
  }

  /// 解析配置的json文件为主题数据
  static OeThemeData? fromJson(String name, String themeJson,
      {var recoverDefault = false, OeExtraThemeData? extraThemeData}) {
    if (themeJson.isEmpty) {
      Log.e('TTheme', 'parse themeJson is empty');
      return null;
    }
    try {
      /// 要求json配置必须正确
      final themeConfig = json.decode(themeJson);
      if (themeConfig.containsKey(name)) {
        var theme = _emptyData(name);
        Map<String, dynamic> curThemeMap = themeConfig['$name'];

        /// 设置颜色
        Map<String, dynamic>? colorsMap = curThemeMap['color'];
        colorsMap?.forEach((key, value) {
          var color = toColor(value);
          if (color != null) {
            theme.colorMap[key] = color;
          }
        });

        /// 设置颜色
        Map<String, dynamic>? refMap = curThemeMap['ref'];
        refMap?.forEach((key, value) {
          theme.refMap[key] = value;
        });

        /// 设置字体尺寸
        Map<String, dynamic>? fontsMap = curThemeMap['font'];
        fontsMap?.forEach((key, value) {
          theme.fontMap[key] = Font.fromJson(value);
        });

        /// 设置圆角
        Map<String, dynamic>? cornersMap = curThemeMap['radius'];
        cornersMap?.forEach((key, value) {
          theme.radiusMap[key] = value.toDouble();
        });

        /// 设置字体
        Map<String, dynamic>? fontFamilyMap = curThemeMap['fontFamily'];
        fontFamilyMap?.forEach((key, value) {
          theme.fontFamilyMap[key] = FontFamily.fromJson(value);
        });

        /// 设置阴影
        Map<String, dynamic>? shadowMap = curThemeMap['shadow'];
        shadowMap?.forEach((key, value) {
          var list = <BoxShadow>[];
          (value as List).forEach((element) {
            list.add(BoxShadow(
              color: toColor(element['color']) ?? Colors.black,
              blurRadius: element['blurRadius'].toDouble(),
              spreadRadius: element['spreadRadius'].toDouble(),
              offset: Offset(element['offset']?['x'].toDouble() ?? 0,
                  element['offset']?['y'].toDouble() ?? 0),
            ));
          });

          theme.shadowMap[key] = list;
        });

        /// 设置Margin
        Map<String, dynamic>? marginsMap = curThemeMap['margin'];
        marginsMap?.forEach((key, value) {
          theme.spacerMap[key] = value.toDouble();
        });

        if (extraThemeData != null) {
          extraThemeData.parse(name, curThemeMap);
          theme.extraThemeData = extraThemeData;
        }
        if (recoverDefault) {
          _defaultThemeData = theme;
        }
        return theme;
      } else {
        Log.e('TTheme',
            'load theme error ,not found the theme with name:${name}');
        return null;
      }
    } catch (e) {
      Log.e('TTheme', 'parse theme data error:${e}');
      return null;
    }
  }

  Color? ofColor(
    String? key,
  ) {
    return colorMap[key];
  }

  Font? ofFont(String? key) {
    return fontMap[key];
  }

  double? ofCorner(
    String? key,
  ) {
    return radiusMap[key];
  }

  FontFamily? ofFontFamily(
    String? key,
  ) {
    return fontFamilyMap[key];
  }

  List<BoxShadow>? ofShadow(
    String? key,
  ) {
    return shadowMap[key];
  }

  T? ofExtra<T extends OeExtraThemeData>() {
    try {
      return extraThemeData as T;
    } catch (e) {
      Log.e('OeThemeData ofExtra error: $e');
    }
    return null;
  }

  @override
  ThemeExtension<OeThemeData> lerp(
      ThemeExtension<OeThemeData>? other, double t) {
    if (other is! OeThemeData) {
      return this;
    }
    return OeThemeData(
        name: other.name,
        colorMap: other.colorMap,
        fontMap: other.fontMap,
        radiusMap: other.radiusMap,
        fontFamilyMap: other.fontFamilyMap,
        shadowMap: other.shadowMap,
        spacerMap: other.spacerMap,
        refMap: other.refMap);
  }
}

/// 扩展主题数据
abstract class OeExtraThemeData {
  /// 解析json
  void parse(String name, Map<String, dynamic> curThemeMap);
}

typedef DefaultMapFactory = OeMap? Function();

/// 自定义Map
class OeMap<K, V> extends DelegatingMap<K, V> {
  OeMap({this.factory, this.refs}) : super({});
  DefaultMapFactory? factory;
  OeMap? refs;

  @override
  V? operator [](Object? key) {
    // return super[key];
    key = refs?[key] ?? key;
    var value = super[key];
    if (value != null) {
      return value;
    }
    var defaultValue = factory?.call()?.get(key);
    if (defaultValue is V) {
      return defaultValue;
    }
    return null;
  }

  V? get(Object? key) {
    return super[key];
  }
}
