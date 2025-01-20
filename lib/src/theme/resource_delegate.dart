import 'package:flutter/cupertino.dart';

import '../../my_component_library.dart';

typedef OeOeResourceBuilder = OeResourceDelegate? Function(
    BuildContext context);

/// 资源管理器
class OeResourceManager {
  /// 代理构建器
  OeOeResourceBuilder? _builder;

  /// 每次都调用build方法
  bool _needAlwaysBuild = false;

  OeResourceDelegate? _delegate;

  /// 获取资源
  OeResourceDelegate delegate(BuildContext context) {
    if (_builder == null) {
      return _defaultDelegate;
    }
    if (_needAlwaysBuild) {
      // 每次都调用,适用于全局有多个OeResourceDelegate的情况
      var delegate = _builder?.call(context);
      if (delegate != null) {
        return delegate;
      }
    }
    _delegate ??= _builder?.call(context);
    return _delegate ?? _defaultDelegate;
  }

  static OeResourceManager? _instance;

  /// 单例对象
  static OeResourceManager get instance {
    _instance ??= OeResourceManager();
    return _instance!;
  }

  /// 获取资源
  static final _defaultDelegate = _DefaultResourceDelegate();

  /// 设置资源代理
  void setResourceBuilder(OeOeResourceBuilder delegate, needAlwaysBuild) {
    _builder = delegate;
    _needAlwaysBuild = needAlwaysBuild;
  }
}

/// 资源管理器,允许外部重写,设计成抽象类,防止有新增字段时,用户没有感知
abstract class OeResourceDelegate {
  /// [OeSwitch]的打开状态文案
  String get open;

  /// [OeSwitch]的关闭状态文案
  String get close;

  /// [OeBadge]为0时的默认文案
  String get badgeZero;

  /// [OeAlertDialog]等 取消
  String get cancel;

  /// [OeAlertDialog]等 确认
  String get confirm;

  /// [OeDropdownMenu] 其他
  String get other;

  /// [OeDropdownMenu] 重置
  String get reset;

  /// [OeLoading] 加载中
  String get loading;

  /// [OeToast] 加载中...
  String get loadingWithPoint;

  /// [OeConfirmDialog] 知道了
  String get knew;

  /// [OeRefreshHeader] 正在刷新
  String get refreshing;

  /// [OeRefreshHeader] 松开刷新
  String get releaseRefresh;

  /// [OeTimeCounter] 天
  String get days;

  /// [OeTimeCounter] 时
  String get hours;

  /// [OeTimeCounter] 分
  String get minutes;

  /// [OeTimeCounter] 秒
  String get seconds;

  /// [OeTimeCounter] 毫秒
  String get milliseconds;

  /// [OeDatePicker]  年
  String get yearLabel;

  /// [OeDatePicker]  月
  String get monthLabel;

  /// [OeDatePicker] 日
  String get dateLabel;

  /// [OeDatePicker] 周
  String get weeksLabel;

  /// [OeCalendarHeader] 星期日
  String get sunday;

  /// [OeCalendarHeader] 星期一
  String get monday;

  /// [OeCalendarHeader] 星期二
  String get tuesday;

  /// [OeCalendarHeader] 星期三
  String get wednesday;

  /// [OeCalendarHeader] 星期四
  String get thursday;

  /// [OeCalendarHeader] 星期五
  String get friday;

  /// [OeCalendarHeader] 星期六
  String get saturday;

  /// [OeCalendarBody] 年
  String get year;

  /// [OeCalendarBody] 一月
  String get january;

  /// [OeCalendarBody] 二月
  String get february;

  /// [OeCalendarBody] 三月
  String get march;

  /// [OeCalendarBody] 四月
  String get april;

  /// [OeCalendarBody] 五月
  String get may;

  /// [OeCalendarBody] 六月
  String get june;

  /// [OeCalendarBody] 七月
  String get july;

  /// [OeCalendarBody] 八月
  String get august;

  /// [OeCalendarBody] 九月
  String get september;

  /// [OeCalendarBody] 十月
  String get october;

  /// [OeCalendarBody] 十一月
  String get november;

  /// [OeCalendarBody] 十二月
  String get december;

  /// [OeCalendar] 时间
  String get time;

  /// [OeCalendar] 开始
  String get start;

  /// [OeCalendar] 结束
  String get end;

  /// [OeRate] 未评分
  String get notRated;

  /// [OeRate] 选择选项
  String get cascadeLabel;
}

/// 如果用户要重写,就应该全部重写,不开放只重新部分资源
class _DefaultResourceDelegate extends OeResourceDelegate {
  @override
  String get open => '开';

  @override
  String get close => '关';

  @override
  String get badgeZero => '0';

  @override
  String get cancel => '取消';

  @override
  String get confirm => '确定';

  @override
  String get other => '其它';

  @override
  String get reset => '重置';

  @override
  String get loading => '加载中';

  @override
  String get loadingWithPoint => '加载中...';

  @override
  String get knew => '知道了';

  @override
  String get refreshing => '正在刷新';

  @override
  String get releaseRefresh => '松开刷新';

  @override
  String get days => '天';

  @override
  String get hours => '时';

  @override
  String get minutes => '分';

  @override
  String get seconds => '秒';

  @override
  String get milliseconds => '毫秒';

  @override
  String get selectDate => '选择时间';

  @override
  String get yearLabel => '年';

  @override
  String get monthLabel => '月';

  @override
  String get dateLabel => '日';

  @override
  String get weeksLabel => '周';

  String get sunday => '日';

  @override
  String get monday => '一';

  @override
  String get tuesday => '二';

  @override
  String get wednesday => '三';

  @override
  String get thursday => '四';

  @override
  String get friday => '五';

  @override
  String get saturday => '六';

  @override
  String get year => ' 年';

  @override
  String get january => '1 月';

  @override
  String get february => '2 月';

  @override
  String get march => '3 月';

  @override
  String get april => '4 月';

  @override
  String get may => '5 月';

  @override
  String get june => '6 月';

  @override
  String get july => '7 月';

  @override
  String get august => '8 月';

  @override
  String get september => '9 月';

  @override
  String get october => '10 月';

  @override
  String get november => '11 月';

  @override
  String get december => '12 月';

  @override
  String get time => '时间';

  @override
  String get start => '开始';

  @override
  String get end => '结束';

  @override
  String get notRated => '未评分';

  @override
  String get cascadeLabel => '选择选项';
}
