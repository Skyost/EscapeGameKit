import 'package:flutter/material.dart';

/// Allows to tell whether two objects are equal based on some properties.
mixin PropertiesEquatable {
  /// The properties list.
  @protected
  List<Object?> get props;

  @override
  bool operator ==(Object other) => identical(this, other) || (other is PropertiesEquatable && runtimeType == other.runtimeType && _equal(props, other.props));

  @override
  int get hashCode => Object.hashAll(props);

  @override
  String toString() => '$runtimeType(${props.map((prop) => prop.toString()).join(', ')})';

  /// Returns whether the specified objects are equal.
  bool _equal(Object? a, Object? b) {
    if (a is List?) {
      if (b is List?) {
        if (a == null) {
          return b == null;
        }
        if (b == null || a.length != b.length) {
          return false;
        }
        if (identical(a, b)) {
          return true;
        }
        for (int index = 0; index < a.length; index++) {
          if (!_equal(a[index], b[index])) {
            return false;
          }
        }
        return true;
      }
      return false;
    }
    if (a is Set) {
      if (b is Set) {
        if (a.length != b.length) {
          return false;
        }
        if (identical(a, b)) {
          return true;
        }
        for (Object value in a) {
          for (Object other in b) {
            if (!_equal(value, other)) {
              return false;
            }
          }
        }
        return true;
      }
      return false;
    }
    return a == b;
  }
}
