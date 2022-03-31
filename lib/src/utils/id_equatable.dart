mixin IdEquatable<T> {
  T get id;

  @override
  bool operator ==(Object other) => other is IdEquatable ? id == other.id : super == other;

  @override
  int get hashCode => id.hashCode;
}