/// An extension that allows to add a leading zero on numbers.
extension LeadingZero on num {
  /// Returns this number has a string, but with a leading zero (if necessary).
  String get withLeadingZero => (this < 10 ? '0' : '') + toString();
}
