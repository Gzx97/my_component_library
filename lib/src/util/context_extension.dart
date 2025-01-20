import 'package:flutter/material.dart';

import '../theme/resource_delegate.dart';

/// Context的扩展,方便使用
extension ContextExtension on BuildContext {
  OeResourceDelegate get resource => OeResourceManager.instance.delegate(this);
}
