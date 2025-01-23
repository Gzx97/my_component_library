import 'package:flutter/cupertino.dart';

class OeCollapseSaltedKey<S, V> extends LocalKey {
  const OeCollapseSaltedKey(this.salt, this.value);

  final S salt;
  final V value;

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) return false;
    final OeCollapseSaltedKey<S, V> typedOther = other;
    return salt == typedOther.salt && value == typedOther.value;
  }

  @override
  int get hashCode => Object.hash(runtimeType, salt, value);

  @override
  String toString() {
    final saltString = S == String ? '<\'$salt\'>' : '<$salt>';
    final valueString = V == String ? '<\'$value\'>' : '<$value>';
    return '[$saltString $valueString]';
  }
}
